/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.dashboard;

import java.lang.ref.WeakReference;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.UserPreference;
import org.compiere.model.I_R_Request;
import org.compiere.model.MRefList;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.X_AD_User;
import org.compiere.model.X_C_ContactActivity;
import org.compiere.model.X_R_RequestType;
import org.compiere.model.X_S_Resource;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.TrxEventListener;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.distributed.IMessageService;
import org.idempiere.distributed.ITopic;
import org.idempiere.distributed.ITopicSubscriber;
import org.osgi.service.event.EventHandler;
import org.zkoss.calendar.Calendars;
import org.zkoss.calendar.api.CalendarEvent;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarModel;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.Label;
import org.zkoss.zul.impl.LabelImageElement;

/**
 * Dashboard gadget: Zk Calendar. <br/>
 * Content created from "zul/calendar/calendar_mini.zul".
 * 
 * @author Elaine
 * @date November 20, 2008
 */
public class DPCalendar extends DashboardPanel implements EventListener<Event>, EventHandler {		
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -224914882522997787L;
	private static final String ON_MOBILE_SET_SELECTED_TAB_ECHO = "onMobileSetSelectedTabEcho";
	private static final String ON_EVENT_EDIT_EVENT = "onEventEdit";
	private static final String ON_EVENT_CREATE_EVENT = "onEventCreate";
	private static final String ON_MOVE_DATE_EVENT = "onMoveDate";
	private static final String ON_REQUEST_CHANGED_TOPIC = "onRequestChanged";
	
	/** Zk Calendar instance */
	private Calendars calendars;
	/** Model for {@link #calendars} */
	private SimpleCalendarModel scm;
	/** Button to open Calendar window, to Refresh Calendar */
	private LabelImageElement btnCal, btnRefresh;	

	private LabelImageElement btnCurrentDate;
	/** Label for start and end date of current Calendar view */
	private Label lblDate;
	/** button to move Calendar to previous or next page */
	private Component divArrowLeft, divArrowRight;
	
	/** Window for event */
	private EventWindow eventWin;
	private ActivityWindow activityWin;
	private AssignmentWindow assignmentWin;
	private WeakReference<Desktop> desktop;
	/** List of Calendar (Request) events */
	private ArrayList<ADCalendarEvent> events;
	private ArrayList<ADCalendarContactActivity> activities;
	private ArrayList<ADCalendarResourceAssignment> assignments;
	/** Desktop cleanup listener to call {@link #cleanup()} */
	private DesktopCleanup listener;
	/** Event handler for R_Request model */
	private static RequestEventHandler eventHandler;
	/** Subscriber to {@link IMessageService} for "onRequestChanged" topic */
	private static TopicSubscriber subscriber;
	public static ValueNamePair SALES_REPRESENTATIVE_ALL = new ValueNamePair("0", "All");
	
	private static final CLogger log = CLogger.getCLogger(DPCalendar.class);
	
	/**
	 * Default constructor
	 */
	public DPCalendar() {
		super();


		String zulPath = "zul/calendar/calendar_mini.zul";
		Component component = Executions.createComponents(ThemeManager.getThemeResource(zulPath), this, null);

		calendars = (Calendars) component.getFellow("cal");

		btnCal = (LabelImageElement) component.getFellow("btnCal");
		btnCal.addEventListener(Events.ON_CLICK, this);
		
		btnRefresh = (LabelImageElement) component.getFellow("btnRefresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);
		
		btnCurrentDate = (LabelImageElement) component.getFellow("btnCurrentDate");
		btnCurrentDate.addEventListener(Events.ON_CLICK, this);
		
		lblDate = (Label) component.getFellow("lblDate");
		lblDate.addEventListener(Events.ON_CREATE, this);
		
		divArrowLeft = component.getFellow("divArrowLeft");
		divArrowLeft.addEventListener(ON_MOVE_DATE_EVENT, this);
		
		divArrowRight = component.getFellow("divArrowRight");
		divArrowRight.addEventListener(ON_MOVE_DATE_EVENT, this);
		
		this.appendChild(component);

		calendars.addEventListener(ON_EVENT_CREATE_EVENT, this);
		calendars.addEventListener(ON_EVENT_EDIT_EVENT, this);	
				
		createStaticListeners();
		
		listener = new DesktopCleanup() {			
			@Override
			public void cleanup(Desktop desktop) throws Exception {
				DPCalendar.this.cleanup();
			}
		};
		
		if (ClientInfo.isMobile()) {
			addCallback(AFTER_PAGE_ATTACHED, t -> afterPageAttached());
			addEventListener(ON_MOBILE_SET_SELECTED_TAB_ECHO, evt -> calendars.invalidate());
		}

		//
		Extensions.doZulCustomAction(component, zulPath);
	}

	/**
	 * After page attached callback for mobile client. <br/>
	 * Setup listener for {@link WindowContainer#ON_MOBILE_SET_SELECTED_TAB} event.
	 */
	private void afterPageAttached() {
		Component p = getParent();
		while (p != null) {
			if (p instanceof Tabpanel) {
				p.addEventListener(WindowContainer.ON_MOBILE_SET_SELECTED_TAB, evt -> onMobileSelected());
				break;
			}
			p = p.getParent();
		}
	}

	/**
	 * {@link WindowContainer#ON_MOBILE_SET_SELECTED_TAB} event.<br/>
	 * Echo {@link #ON_MOBILE_SET_SELECTED_TAB_ECHO} event to redraw {@link #calendars}.
	 */
	private void onMobileSelected() {
		Events.echoEvent(ON_MOBILE_SET_SELECTED_TAB_ECHO, this, null);
	}

	/**
	 * Setup {@link #eventHandler} and {@link #subscriber}
	 */
	private synchronized void createStaticListeners() {
		if (eventHandler == null) {
			eventHandler = new RequestEventHandler();
			eventHandler.bindEventManager(EventManager.getInstance());
		}
		
		if (subscriber == null) {
			subscriber = new TopicSubscriber();
			IMessageService service = Core.getMessageService();			
			if (service != null) {
				ITopic<Map<String,String>> topic = service.getTopic("onRequestChanged");
				topic.subscribe(subscriber);
			}
		}
	}

	@Override
	public void onEvent(Event e) throws Exception {
		String type = e.getName();

		if (type.equals(Events.ON_CLICK)) {
			if (e.getTarget() == btnCal)
				new CalendarWindow(scm);
			else if (e.getTarget() == btnRefresh)
				btnRefreshClicked();
			else if (e.getTarget() == btnCurrentDate)
				btnCurrentDateClicked();
		}
		else if (type.equals(Events.ON_CREATE)) {
			if (e.getTarget() == lblDate)
				updateDateLabel();
		}
		else if (type.equals(ON_MOVE_DATE_EVENT)) {
			if (e.getTarget() == divArrowLeft)
				divArrowClicked(false);
			else if (e.getTarget() == divArrowRight)
				divArrowClicked(true);
		}
		else if (type.equals(ON_EVENT_CREATE_EVENT) && ! Env.isReadOnlySession()) {
				CalendarsEvent calendarsEvent = (CalendarsEvent) e;
				DecisionWindow decisionWin = new DecisionWindow(calendarsEvent, this);
				SessionManager.getAppDesktop().showWindow(decisionWin);
		}	
		else if (type.equals(ON_EVENT_EDIT_EVENT)) {
			if (e instanceof CalendarsEvent) {
				CalendarsEvent calendarsEvent = (CalendarsEvent) e;
				CalendarEvent calendarEvent = calendarsEvent.getCalendarEvent();

				if (calendarEvent instanceof ADCalendarEvent) {
					ADCalendarEvent ce = (ADCalendarEvent) calendarEvent;
					
					if(eventWin == null)
						eventWin = new EventWindow();
					eventWin.setData(ce);
					SessionManager.getAppDesktop().showWindow(eventWin);
				}
				else if (calendarEvent instanceof ADCalendarContactActivity)
				{
					ADCalendarContactActivity ce = (ADCalendarContactActivity) calendarEvent;

					if (activityWin == null)
						activityWin = new ActivityWindow(this);
					activityWin.setData(ce);
					SessionManager.getAppDesktop().showWindow(activityWin);
				}
				else if (calendarEvent instanceof ADCalendarResourceAssignment)
				{
					ADCalendarResourceAssignment ce = (ADCalendarResourceAssignment) calendarEvent;

					if (assignmentWin == null)
						assignmentWin = new AssignmentWindow();
					assignmentWin.setData(ce);
					SessionManager.getAppDesktop().showWindow(assignmentWin);
				}
			}
		}		
	}
	
	/**
	 * TODO move this and ADCalendarEvent to org.adempiere.ui and create unit test for it
	 * Retrieve events (request) from DB
	 * @param RequestTypeID
	 * @param ctx
	 * @return ADCalendarEvent list
	 */
	public static ArrayList<ADCalendarEvent> getEvents(int RequestTypeID, Properties ctx, ArrayList<ValueNamePair> users) {
		String mode = MSysConfig.getValue(MSysConfig.ZK_DASHBOARD_CALENDAR_REQUEST_DISPLAY_MODE, "CSU", Env.getAD_Client_ID(ctx));
		
		String modeCondition = "";
		if (mode.indexOf('C') >= 0)
			modeCondition += "r.CreatedBy = ?";		
		if (mode.indexOf('S') >= 0)
		{
			if (modeCondition.length() > 0)
				modeCondition += " OR ";
			modeCondition += "r.SalesRep_ID = ?";
		}		
		if (mode.indexOf('U') >= 0)
		{
			if (modeCondition.length() > 0)
				modeCondition += " OR ";
			modeCondition += "r.AD_User_ID = ?";
		}
		
		ArrayList<ADCalendarEvent> events = new ArrayList<ADCalendarEvent>();
		String userStr = "";
		if (users == null || users.size() == 0)
			userStr += Env.getAD_User_ID(ctx);
		else
		{
			for (ValueNamePair i : users)
				userStr += Integer.parseInt(i.getID()) + ",";
			userStr = userStr.substring(0, userStr.length() - 1);
		}
		
		String sql = "SELECT DISTINCT r.R_Request_ID, r.DateNextAction, "
				+ "r.DateStartPlan, r.DateCompletePlan, "
				+ "u.Name || '-' || r.Summary AS Summary, rt.HeaderColor, rt.ContentColor, rt.R_RequestType_ID "
				+ "FROM R_Request r "
				+ "INNER JOIN R_RequestType rt ON rt.R_RequestType_ID=r.R_RequestType_ID "
				+ "INNER JOIN AD_User u ON u.AD_User_ID=r.SalesRep_ID "
				+ "WHERE r.R_RequestType_ID = rt.R_RequestType_ID "
				+ "AND (" + modeCondition + ") ";
		
		if (users == null || !users.contains(SALES_REPRESENTATIVE_ALL))
			sql += "AND (r.SalesRep_ID IN (" + userStr + ")) ";
		sql += "AND r.AD_Client_ID = ? AND r.IsActive = 'Y' "
				+ "AND (r.R_Status_ID IS NULL OR r.R_Status_ID IN (SELECT R_Status_ID FROM R_Status WHERE IsClosed='N')) ";
		
		if(RequestTypeID > 0)
			sql += "AND rt.R_RequestType_ID = ? ";

		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 1;

		try {
			ps = DB.prepareStatement(sql, null);

			if (mode.indexOf('C') >= 0)
				ps.setInt(count++, Env.getAD_User_ID(ctx));
			if (mode.indexOf('S') >= 0)
				ps.setInt(count++, Env.getAD_User_ID(ctx));
			if (mode.indexOf('U') >= 0)
				ps.setInt(count++, Env.getAD_User_ID(ctx));
			
			ps.setInt(count++, Env.getAD_Client_ID(ctx));
			if(RequestTypeID > 0)
				ps.setInt(count++, RequestTypeID);

			rs = ps.executeQuery();

			while (rs.next()) {
				int R_Request_ID = rs.getInt("R_Request_ID");
				Date dateNextAction = rs.getDate("DateNextAction");
				Timestamp dateStartPlan = rs.getTimestamp("DateStartPlan");
				Timestamp dateCompletePlan = rs.getTimestamp("DateCompletePlan");
				String summary = rs.getString("Summary");
				String headerColor = rs.getString("HeaderColor");
				String contentColor = rs.getString("ContentColor");
				int R_RequestType_ID = rs.getInt("R_RequestType_ID");

				if (dateNextAction != null) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(dateNextAction);

					ADCalendarEvent event = new ADCalendarEvent();
					event.setR_Request_ID(R_Request_ID);

					cal.set(Calendar.HOUR_OF_DAY, 0);
					cal.set(Calendar.MINUTE, 0);
					cal.set(Calendar.SECOND, 0);
					cal.set(Calendar.MILLISECOND, 0);
					event.setBeginDate(cal.getTime());
					
					cal.add(Calendar.HOUR_OF_DAY, 24);
					event.setEndDate(cal.getTime());

					event.setContent(summary);
					event.setHeaderColor(headerColor);
					event.setContentColor(contentColor);
					event.setR_RequestType_ID(R_RequestType_ID);
					event.setLocked(true);
					events.add(event);
				}

				if (dateStartPlan != null && dateCompletePlan != null) {
							
					ADCalendarEvent event = new ADCalendarEvent();
					event.setR_Request_ID(R_Request_ID);
					
					event.setBeginDate(dateStartPlan);
					event.setEndDate(dateCompletePlan);
					
					if(event.getBeginDate().compareTo(event.getEndDate()) >= 0)
						continue;

					event.setContent(summary);
					event.setHeaderColor(headerColor);
					event.setContentColor(contentColor);
					event.setR_RequestType_ID(R_RequestType_ID);
					event.setLocked(true);
					events.add(event);
				}
			}
		} catch (Exception e) {
			log.log(Level.SEVERE,"Request not saved-"+e.getLocalizedMessage());
			e.printStackTrace();
		} finally {
			DB.close(rs, ps);
		}

		return events;
	}

	public static ArrayList<X_AD_User> getUserList(Properties ctx, int AD_User_ID)
	{
		ArrayList<X_AD_User> types = new ArrayList<X_AD_User>();
		String sql = "SELECT u.* FROM AD_USER u "
				+ " INNER JOIN C_BPartner bp ON u.C_BPartner_ID=bp.C_BPartner_ID AND bp.IsSalesRep='Y' "
				+ " WHERE u.IsActive='Y' AND bp.AD_Client_ID = ?";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try
		{
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, Env.getAD_Client_ID(Env.getCtx()));

			rs = ps.executeQuery();

			while (rs.next())
			{
				types.add(new X_AD_User(ctx, rs, null));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "No Sales Representative Found");
		}
		finally
		{
			DB.close(rs, ps);
		}

		return types;
	}

	
	public static ArrayList<ADCalendarContactActivity> getContactActivities(String ContactActivityType, Properties ctx,ArrayList<ValueNamePair> users)
	{
		String userIDs = "";
		ArrayList<ADCalendarContactActivity> events = new ArrayList<ADCalendarContactActivity>();
		StringBuilder where = new StringBuilder(" WHERE ca.IsActive = 'Y' AND ca.AD_Client_ID = ? ");

		if (users == null || users.size() == 0)
		{
			userIDs += Env.getAD_User_ID(ctx);
			where.append(" AND (ca.SalesRep_ID = ").append(userIDs);
			where.append(" OR au.AD_User_ID = ").append(userIDs);
			where.append(" OR ca.CreatedBy = ").append(userIDs).append(")");
		}
		else
		{
			for (ValueNamePair i : users)
			{
				userIDs += Integer.parseInt(i.getID()) + ",";
			}
			userIDs = userIDs.substring(0, userIDs.length() - 1);
		}
		
		if (users != null && !users.contains(SALES_REPRESENTATIVE_ALL))
			where.append(" AND au.AD_USER_ID IN (").append(userIDs).append(") ");

		if (ContactActivityType.length() > 0)
			where.append(" AND ca.ContactActivityType = '").append(ContactActivityType).append("' ");

		
		String sql = "WITH ContactActivityAttendess AS "
				+ "( "
				+ " SELECT ca.C_ContactActivity_ID, STRING_AGG(DISTINCT au.name,',') AS UserNameList "
				+ " FROM C_ContactActivity ca "
				+ " LEFT JOIN C_ContactActivity_Attendees cca ON (cca.C_ContactActivity_ID = ca.C_ContactActivity_ID) "
				+ " LEFT JOIN AD_USER au ON (au.AD_USER_ID = cca.salesRep_ID OR au.AD_User_ID = ca.SalesRep_ID) "
				+ where.toString()
				+ " GROUP BY ca.C_ContactActivity_ID "
				+ ") "
				+ "SELECT c.C_ContactActivity_ID, c.StartDate, c.EndDate, c.Comments, c.ContactActivityType, c.Description, rl.Name AS Type, "
				+ "		COALESCE(c.C_BPartner_ID, 0) AS C_BPartner_ID, c.C_Opportunity_ID, "
				+ "		UserNameList ||'-'|| rl.Name AS Name, c.SalesRep_ID AS SalesRep_ID, COALESCE(c.AD_User_ID, 0) AS AD_User_ID, "
				+ "		COALESCE(rlt.Name, rl.Name) AS ActivityTypeName " 
				+ "FROM C_ContactActivity c "
				+ "INNER JOIN ContactActivityAttendess caa ON (caa.C_ContactActivity_ID = c.C_ContactActivity_ID) "
				+ "INNER JOIN AD_Ref_List rl ON (rl.Value = c.ContactActivityType AND rl.AD_Reference_ID = ? ) "
				+ "LEFT JOIN AD_Ref_List_Trl rlt ON (rlt.AD_Ref_List_ID = rl.AD_Ref_List_ID AND AD_Language = ? ) ";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try
		{
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, Env.getAD_Client_ID(ctx));
			ps.setInt(2, X_C_ContactActivity.CONTACTACTIVITYTYPE_AD_Reference_ID);
			ps.setString(3, Env.getAD_Language(Env.getCtx()));


			rs = ps.executeQuery();

			while (rs.next())
			{
				int C_ContactActivity_ID = rs.getInt("C_ContactActivity_ID");

				String activityTypeName = rs.getString("ActivityTypeName");
				Timestamp startTime = rs.getTimestamp("StartDate");
				Timestamp endTime = rs.getTimestamp("EndDate");
				String description = rs.getString("Description");
				String comments = rs.getString("Comments");
				String activityType = rs.getString("ContactActivityType");
				int salesRep_ID = rs.getInt("SalesRep_ID");
				int AD_User_ID = rs.getInt("AD_User_ID");
				int C_Opportunity_ID = rs.getInt("C_Opportunity_ID");

				ADCalendarContactActivity event = new ADCalendarContactActivity();
				event.setC_ContactActivity_ID(C_ContactActivity_ID);
				event.setSalesRep_ID(salesRep_ID);
				event.setAD_User_ID(AD_User_ID);
				event.setC_Opportunity_ID(C_Opportunity_ID);

				MUser salesRep = MUser.get(ctx, salesRep_ID);
				if (salesRep != null)
					event.setSalesRepName(salesRep.getName());

				if (endTime == null)
				{
					Calendar calEnd = Calendar.getInstance();
					calEnd.setTimeInMillis(startTime.getTime());
					calEnd.set(Calendar.HOUR_OF_DAY, 23);
					calEnd.set(Calendar.MINUTE, 59);
					calEnd.set(Calendar.SECOND, 0);
					calEnd.set(Calendar.MILLISECOND, 0);
					endTime = new Timestamp(calEnd.getTimeInMillis());
				}

				event.setBeginDate(startTime);
				event.setEndDate(endTime);

				if (event.getBeginDate().compareTo(event.getEndDate()) >= 0)
					continue;

				if (activityType.equals(X_C_ContactActivity.CONTACTACTIVITYTYPE_Email))
				{
					event.setHeaderColor(CalendarColor.DPCALENDAR_HDR_EMAIL);
					event.setContentColor(CalendarColor.DPCALENDAR_CNT_EMAIL);
				}
				else if (activityType.equals(X_C_ContactActivity.CONTACTACTIVITYTYPE_PhoneCall))
				{
					event.setHeaderColor(CalendarColor.DPCALENDAR_HDR_PHONECALL);
					event.setContentColor(CalendarColor.DPCALENDAR_CNT_PHONECALL);
				}
				else if (activityType.equals(X_C_ContactActivity.CONTACTACTIVITYTYPE_Meeting))
				{
					event.setHeaderColor(CalendarColor.DPCALENDAR_HDR_MEETING);
					event.setContentColor(CalendarColor.DPCALENDAR_CNT_MEETING);
				}
				else if (activityType.equals(X_C_ContactActivity.CONTACTACTIVITYTYPE_Task))
				{
					event.setHeaderColor(CalendarColor.DPCALENDAR_HDR_TASK);
					event.setContentColor(CalendarColor.DPCALENDAR_CNT_TASK);
				}
				if (!(Util.isEmpty(rs.getString("name"))))
					event.setContent(rs.getString("name"));
				else
					event.setContent(rs.getString("type"));

				event.setContent(activityTypeName + ": " + description);
				event.setContactActivityType(activityType);
				event.setDescription(description);
				event.setComments(comments);
				event.setContactActivityTypeName(activityTypeName);
				event.setLocked(true);
				events.add(event);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Activity not sync with calendar - " + e);
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, ps);
			rs = null;
			ps = null;
		}

		return events;
	}

	public static ArrayList<ADCalendarResourceAssignment> getResourceAssignments(int p_S_Resource_ID, Properties ctx) 
	{
		UserPreference userPreference=new UserPreference();
		userPreference.loadPreference(Env.getAD_User_ID(Env.getCtx()));
		String showres=userPreference.getProperty(UserPreference.P_SHOWRESOURCES);

		if(showres.equalsIgnoreCase("Y"))
		{
			ArrayList<ADCalendarResourceAssignment> events = new ArrayList<ADCalendarResourceAssignment>();
			String sql = "SELECT DISTINCT sa.S_ResourceAssignment_ID, sa.S_Resource_ID, sa.AssignDateFrom, sa.AssignDateTo, "
					+ "(s.Name || ': ' ||sa.Name) AS Name, tt.ContentColor, tt.HeaderColor "
					+ "FROM S_ResourceAssignment sa "
					+ "JOIN S_Resource s ON s.S_Resource_ID=sa.S_Resource_ID "
					+ "LEFT JOIN S_TimeExpenseLine tl ON sa.S_ResourceAssignment_ID=tl.S_ResourceAssignment_ID "
					+ "LEFT JOIN S_TimeType tt ON tt.S_TimeType_ID=tl.S_TimeType_ID "
					+ "WHERE sa.isActive='Y' "
					+ "AND sa.AD_Client_ID = ? ";
			if (p_S_Resource_ID > 0)
				sql += "AND sa.S_Resource_ID = ? ";

			PreparedStatement ps = null;
			ResultSet rs = null;

			try
			{
				ps = DB.prepareStatement(sql, null);
				ps.setInt(1, Env.getAD_Client_ID(ctx));

				if (p_S_Resource_ID > 0)
					ps.setInt(2, p_S_Resource_ID);

				rs = ps.executeQuery();
				while (rs.next())
				{
					int S_ResourceAssignment_ID = rs.getInt("S_ResourceAssignment_ID");
					int S_Resource_ID = rs.getInt("S_Resource_ID");
					Timestamp startTime = rs.getTimestamp("AssignDateFrom");
					Timestamp endTime = rs.getTimestamp("AssignDateTo");
					String name = rs.getString("Name");
					String contentColor = rs.getString("ContentColor");
					String headerColor = rs.getString("HeaderColor");

					ADCalendarResourceAssignment event = new ADCalendarResourceAssignment();
					event.setS_ResourceAssignment_ID(S_ResourceAssignment_ID);
					event.setS_Resource_ID(S_Resource_ID);

					if (endTime == null)
					{
						Calendar calEnd = Calendar.getInstance();
						calEnd.setTimeInMillis(startTime.getTime());
						calEnd.set(Calendar.HOUR_OF_DAY, 23);
						calEnd.set(Calendar.MINUTE, 59);
						calEnd.set(Calendar.SECOND, 0);
						calEnd.set(Calendar.MILLISECOND, 0);
						endTime = new Timestamp(calEnd.getTimeInMillis());
					}

					event.setContent(name);
					event.setBeginDate(startTime);
					event.setEndDate(endTime);

					if (headerColor != null && headerColor.length() > 0)
						event.setHeaderColor(headerColor);

					if (contentColor != null && contentColor.length() > 0)
						event.setContentColor(contentColor);

					if (event.getBeginDate().compareTo(event.getEndDate()) >= 0)
						continue;

					event.setLocked(true);
					events.add(event);
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "Resource not saved-" + e.getLocalizedMessage());
			}
			finally
			{
				DB.close(rs, ps);
			}

			return events;
		}
		return null;
}

	
	public static ArrayList<X_R_RequestType> getRequestTypes(Properties ctx) {
		ArrayList<X_R_RequestType> types = new ArrayList<X_R_RequestType>();
		String sql = "SELECT * "
				+ "FROM R_RequestType "
				+ "WHERE AD_Client_ID = ? AND IsActive = 'Y' "
				+ "ORDER BY Name";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, Env.getAD_Client_ID(ctx));

			rs = ps.executeQuery();

			while (rs.next()) {
				types.add(new X_R_RequestType(ctx, rs, null));
			}
		} catch (Exception e) {
			log.log(Level.SEVERE,"Request type not saved-"+e.getLocalizedMessage());
		} finally {
			DB.close(rs, ps);
		}
		
		return types;
	}
	
	public static ArrayList<X_S_Resource> getResources(Properties ctx)
	{
		ArrayList<X_S_Resource> resources = new ArrayList<X_S_Resource>();
		String sql = "SELECT * " + "FROM S_Resource " + "WHERE AD_Client_ID = ? AND IsActive = 'Y' " + "ORDER BY Name";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try
		{
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, Env.getAD_Client_ID(ctx));

			rs = ps.executeQuery();

			while (rs.next())
			{
				resources.add(new X_S_Resource(ctx, rs, null));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE,"Resource not found-"+e.getLocalizedMessage());
		}
		finally
		{
			DB.close(rs, ps);
		}

		return resources;
	}
	
	public static ArrayList<MRefList> getContactActivityTypes(Properties ctx)
	{

		ArrayList<MRefList> types = new ArrayList<MRefList>();
		String sql = "SELECT * " + "FROM AD_Ref_List " + "WHERE IsActive = 'Y' AND AD_Reference_ID = ? "
				+ "ORDER BY Name";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try
		{
			ps = DB.prepareStatement(sql, null);
			ps.setInt(1, X_C_ContactActivity.CONTACTACTIVITYTYPE_AD_Reference_ID);

			rs = ps.executeQuery();

			while (rs.next())
			{
				types.add(new MRefList(ctx, rs, null));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE,"Contact activity not found-"+e.getLocalizedMessage());
		}
		return types;
	}
	
	/**
	 * Refresh model and UI
	 */
	public void onRefresh() {
		btnRefreshClicked();
	}
	
	@Override
	public void refresh(ServerPushTemplate template) {
		refreshModel();
		template.executeAsync(this);
		if (desktop != null && desktop.get() != null) {
			if (desktop.get() != getDesktop()) {
				desktop.get().removeListener(listener);
				desktop = new WeakReference<Desktop>(getDesktop());
				desktop.get().addListener(listener);
			}
		} else {
			desktop = new WeakReference<Desktop>(getDesktop());
			if (desktop.get() != null)
				desktop.get().addListener(listener);
		}
		
	}

	@Override
	public void updateUI() {
		if (scm == null) {
			scm = new SimpleCalendarModel();
			calendars.setModel(scm);
		}

		scm.clear();
		for (ADCalendarEvent event : events)
			scm.add(event);
		
		for (ADCalendarContactActivity activity : activities)
			scm.add(activity);
		if (assignments != null)
			for (ADCalendarResourceAssignment resource : assignments)
				scm.add(resource);
		// calendars.setModel(scm);

		calendars.invalidate();
	}

	/**
	 * Refresh model and UI
	 */
	private void btnRefreshClicked() {
		refreshModel();
		updateUI();
	}

	/**
	 * Refresh model
	 */
	private void refreshModel() {		
		events = getEvents(0, Env.getCtx(), null);
		activities = getContactActivities("", Env.getCtx(), null);
		assignments = getResourceAssignments(0, Env.getCtx());
	}
	
	/**
	 * Update {@link #lblDate}
	 */
	private void updateDateLabel() {
		Date b = calendars.getBeginDate();
		Date e = calendars.getEndDate();
		SimpleDateFormat sdfV = DisplayType.getDateFormat();
		sdfV.setTimeZone(calendars.getDefaultTimeZone());
		lblDate.setValue(sdfV.format(b) + " - " + sdfV.format(e));
		log.info("DPCALENDAR VALIDATOR IS NOW INITIALIZED");
	}
	
	/**
	 * Set {@link #calendars} to current date
	 */
	private void btnCurrentDateClicked() {
		calendars.setCurrentDate(Calendar.getInstance(calendars.getDefaultTimeZone()).getTime());
		updateDateLabel();
		updateUI();
	}

	/**
	 * Move {@link #calendars} to next or previous page
	 * @param isNext true for next page, false for previous page
	 */
	private void divArrowClicked(boolean isNext) {
		if (isNext)
			calendars.nextPage();
		else
			calendars.previousPage();
		updateDateLabel();
		updateUI();
	}
	
	@Override
	public void handleEvent(org.osgi.service.event.Event event) {
		if (event.getTopic().equals(ON_REQUEST_CHANGED_TOPIC)) {
			String clientId = (String) event.getProperty(I_R_Request.COLUMNNAME_AD_Client_ID);
			String salesRepId = (String) event.getProperty(I_R_Request.COLUMNNAME_SalesRep_ID);
			String userId = (String) event.getProperty(I_R_Request.COLUMNNAME_AD_User_ID);
			String createdBy = (String) event.getProperty(I_R_Request.COLUMNNAME_CreatedBy);
			
			String AD_Client_ID = Integer.toString(Env.getAD_Client_ID(Env.getCtx()));
			String AD_User_ID = Integer.toString(Env.getAD_User_ID(Env.getCtx()));
			if (clientId.equals(AD_Client_ID) && !"0".equals(AD_User_ID)) {
				if (salesRepId.equals(AD_User_ID) || userId.equals(AD_User_ID) || createdBy.equals(AD_User_ID)) {
					try {
						if (desktop != null && desktop.get() != null && desktop.get().isAlive()) {
							ServerPushTemplate template = new ServerPushTemplate(desktop.get());
							refresh(template);
						} else {
							EventManager.getInstance().unregister(this);
						}
					} catch (Exception e) {
						log.log(Level.SEVERE, e.getLocalizedMessage(), e);
					}
				}
			}
		}
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			EventManager.getInstance().register(ON_REQUEST_CHANGED_TOPIC, this);
			if (desktop != null && desktop.get() != null) {
				desktop.get().removeListener(listener);
			}
			desktop = new WeakReference<Desktop>(getDesktop());
			desktop.get().addListener(listener);
		}
	}
	
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		cleanup();
	}

	/**
	 * Perform clean up
	 */
	protected void cleanup() {
		EventManager.getInstance().unregister(this);
		desktop = null;
	}
	
	/**
	 * ITopicSubscriber to post OSGi event from "onRequestChanged" topic
	 */
	static class TopicSubscriber implements ITopicSubscriber<Map<String, String>> {		

		@Override
		public void onMessage(Map<String, String> message) {
			org.osgi.service.event.Event requestChangedEvent = EventManager.newEvent(ON_REQUEST_CHANGED_TOPIC, message, true);
			EventManager.getInstance().postEvent(requestChangedEvent);
		}
		
	}
	
	/**
	 * Event handler for R_Request model  
	 */
	static class RequestEventHandler extends AbstractEventHandler {
		@Override
		protected void doHandleEvent(org.osgi.service.event.Event event) {
			PO po = getPO(event);
			I_R_Request request = (I_R_Request)po; 
			Map<String, String> message = new HashMap<String, String>();
			message.put(I_R_Request.COLUMNNAME_SalesRep_ID, Integer.toString(request.getSalesRep_ID()));
			message.put(I_R_Request.COLUMNNAME_AD_User_ID, Integer.toString(request.getAD_User_ID()));
			message.put(I_R_Request.COLUMNNAME_CreatedBy, Integer.toString(request.getCreatedBy()));
			message.put(I_R_Request.COLUMNNAME_AD_Client_ID, Integer.toString(request.getAD_Client_ID()));
			RequestRunnable runnable = new RequestRunnable(message);	
			Trx trx = po.get_TrxName() != null ? Trx.get(po.get_TrxName(), false) : null;
			if (trx != null && trx.isActive()) {
				trx.addTrxEventListener(new TrxListener(runnable));
			} else {
				runnable.run();
			}
		}

		@Override
		protected void initialize() {
			registerTableEvent(IEventTopics.PO_AFTER_NEW, I_R_Request.Table_Name);
			registerTableEvent(IEventTopics.PO_AFTER_CHANGE, I_R_Request.Table_Name);
			registerTableEvent(IEventTopics.PO_AFTER_DELETE, I_R_Request.Table_Name);
		}		
	}
	
	/**
	 * Runnable to post "onRequestChanged" message ({@link IMessageService}) or OSGi event (if {@link IMessageService} not available)
	 */
	static class RequestRunnable implements Runnable {
		
		private Map<String, String> message;

		protected RequestRunnable(Map<String, String> message) {
			this.message = message;
		}
		
		@Override
		public void run() {
			IMessageService service = Core.getMessageService();			
			if (service != null) {
				ITopic<Map<String,String>> topic = service.getTopic(ON_REQUEST_CHANGED_TOPIC);				
				topic.publish(message);
			} else {
				org.osgi.service.event.Event requestChangedEvent = EventManager.newEvent(ON_REQUEST_CHANGED_TOPIC, message, true);
				EventManager.getInstance().postEvent(requestChangedEvent);
			}
		}	
	}
	
	/**
	 * TrxEventListener to call a {@link Runnable} after successful commit of transaction.
	 */
	static class TrxListener implements TrxEventListener {

		private Runnable runnable;

		/**
		 * @param runnable
		 */
		protected TrxListener(Runnable runnable) {
			this.runnable = runnable;
		}
		
		@Override
		public void afterRollback(Trx trx, boolean success) {
		}
		
		@Override
		public void afterCommit(Trx trx, boolean success) {
			if (success) {
				runnable.run();
			}
		}
		
		@Override
		public void afterClose(Trx trx) {
			trx.removeTrxEventListener(this);
		}		
	}

	@Override
	public boolean isLazy() {
		return true;
	}
	public static String getTimeFormat()
	{
		return MSysConfig.getValue("CALENDAR_TIME_FORMAT", "HH:mm", Env.getAD_Client_ID(Env.getCtx()));
	}

	public static int getStartTimeHour()
	{
		return (int) (MSysConfig.getDoubleValue("CALENDAR_START_TIME_HOUR", 0, Env.getAD_Client_ID(Env.getCtx())) * 60 * 60 * 1000);
	}

	public static int getEndTimeHour()
	{
		return (int) (MSysConfig.getDoubleValue("CALENDAR_END_TIME_HOUR", 24, Env.getAD_Client_ID(Env.getCtx())) * 60 * 60 * 1000);
	}
}
