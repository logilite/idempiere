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

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TimeZone;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.MultiSelectionBox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MRefList;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_User;
import org.compiere.model.X_R_RequestType;
import org.compiere.model.X_S_Resource;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.encoders.EncoderUtil;
import org.jfree.chart.encoders.ImageFormat;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;
import org.zkoss.calendar.Calendars;
import org.zkoss.calendar.api.CalendarEvent;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.calendar.impl.SimpleCalendarEvent;
import org.zkoss.calendar.impl.SimpleCalendarModel;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Button;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Image;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Row;
import org.zkoss.zul.Rows;
import org.zkoss.zul.Span;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Timer;
import org.zkoss.zul.Toolbarbutton;

/**
 * 
 * @author Elaine
 *
 */
public class CalendarWindow extends Window implements EventListener<Event>, ITabOnCloseHandler, ValueChangeListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1576992746053720647L;
	private static final String ON_MOBILE_SET_SELECTED_TAB_ECHO = "onMobileSetSelectedTabEcho";
	private static CLogger log = CLogger.getCLogger(CalendarWindow.class);

	private UserPreference userPreference;
	private Calendars calendars;
	private SimpleCalendarModel scm;
	private Toolbarbutton btnRefresh;
	private Listbox lbxRequestTypes;
	private Listbox lbxContactActivityTypes;
	private Listbox lbxResources;
	private Image myChart;
	private Button btnCurrentDate, btnSwitchTimeZone;
	private Label lblDate;
	private Label lblRes;
	private Component divArrowLeft, divArrowRight;
	private Span FDOW;
	private Listbox lbxFDOW;
	private Component divTabDay, divTabWeek, divTabWeekdays, divTabMonth;
	private Popup updateMsg;
	private	Label popupLabel;
	private Timer timer;
	private Checkbox showRes;
	int R_RequestType_ID = 0;
	String ContactActivityType = "";
	int S_Resource_ID = 0;
	int old_Request_ID=0;
	int old_Resource_ID=0;
	String old_ContactActivityType="";

	private MultiSelectionBox lbxUserHeirarchy;
	private ActivityWindow activityWin;
	private AssignmentWindow assignmentWin;
	
	private EventWindow eventWin;
	
	public CalendarWindow(SimpleCalendarModel scm) {

		super();
		
		this.scm = scm;
		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(ctx,"Calendar"));
		setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		
		Component component = Executions.createComponents(ThemeManager.getThemeResource("zul/calendar/calendar.zul"), this, null);

		Borderlayout borderlayout = (Borderlayout) component.getFellow("main");
		borderlayout.setStyle("position: absolute");
		ZKUpdateUtil.setWidth(borderlayout, "100%");
		ZKUpdateUtil.setHeight(borderlayout, "100%");
		
		Grid grid = new Grid();
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		ArrayList<X_AD_User> usersList = DPCalendar.getUserList(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
		ArrayList<ValueNamePair> supervisors = new ArrayList<ValueNamePair>();
		supervisors.add(DPCalendar.SALES_REPRESENTATIVE_ALL);
		for (X_AD_User uType : usersList)
			supervisors.add(new ValueNamePair(uType.getAD_User_ID() + "", uType.getName()));

		lbxUserHeirarchy = new MultiSelectionBox(supervisors, true);
		

		Row row = new Row();
		Cell cell = new Cell();
		cell.appendChild(new Label("Sales Representative :"));
		ZKUpdateUtil.setWidth(cell, "10%");
		row.appendChild(cell);

		cell = new Cell();
		cell.appendChild(lbxUserHeirarchy);
		lbxUserHeirarchy.addValueChangeListener(this);
		ZKUpdateUtil.setWidth(cell, "75%");
		row.appendChild(cell);

		rows.appendChild(row);

		North north = new North();
		north.appendChild(grid);
		borderlayout.appendChild(north);

		calendars = (Calendars) component.getFellow("cal");
		calendars.setModel(scm);
		if (calendars.getCurrentDate() != null)
			calendars.setCurrentDate(calendars.getCurrentDate());
		setTimeZone();

		btnRefresh = (Toolbarbutton) component.getFellow("btnRefresh");
		btnRefresh.addEventListener(Events.ON_CLICK, this);
		
		lbxRequestTypes = (Listbox) component.getFellow("lbxRequestTypes");
		lbxRequestTypes.addEventListener(Events.ON_SELECT, this);
		
		lbxRequestTypes.appendItem(Msg.getMsg(ctx,"ShowAll"), "0");
		ArrayList<X_R_RequestType> types = DPCalendar.getRequestTypes(Env.getCtx());
		for(X_R_RequestType type : types)
			lbxRequestTypes.appendItem(type.getName(), type.getR_RequestType_ID() + "");
		lbxRequestTypes.setSelectedIndex(0);
		
		lbxContactActivityTypes = (Listbox) component.getFellow("lbxContactActivityTypes");
		lbxContactActivityTypes.addEventListener(Events.ON_SELECT, this);

		lbxContactActivityTypes.appendItem(Msg.getMsg(ctx, "ShowAll"), "");
		ArrayList<MRefList> ActivityTypes = DPCalendar.getContactActivityTypes(Env.getCtx());
		for (MRefList type : ActivityTypes)
		{
			String name = MRefList.getListName(Env.getCtx(), type.getAD_Reference_ID(), type.getValue());
			lbxContactActivityTypes.appendItem(name, type.getValue() + "");
		}
		lblRes=(Label)component.getFellow("Resourcelbl");
		lblRes.setValue("Resource:");
		lbxContactActivityTypes.setSelectedIndex(0);

		lbxResources = (Listbox) component.getFellow("lbxResources");
		lbxResources.addEventListener(Events.ON_SELECT, this);

		lbxResources.appendItem(Msg.getMsg(ctx, "ShowAll"), "0");
		ArrayList<X_S_Resource> resources = DPCalendar.getResources(Env.getCtx());
		for (X_S_Resource r : resources)
			lbxResources.appendItem(r.getName(), r.getS_Resource_ID() + "");
		lbxResources.setSelectedIndex(0);
		
		showRes=(Checkbox) component.getFellow("showRes");
		showRes.addEventListener(Events.ON_CHECK, this);
		
		userPreference=new UserPreference();
		userPreference.loadPreference(Env.getAD_User_ID(Env.getCtx()));
		
		if(userPreference.getProperty(UserPreference.P_SHOWRESOURCES).equalsIgnoreCase("Y"))
		{
			lblRes.setVisible(true);
			lbxResources.setVisible(true);
			showRes.setChecked(true);
		}
		else
		{
			lblRes.setVisible(false);
			lbxResources.setVisible(false);
			showRes.setChecked(false);
		}
		
		myChart = (Image) component.getFellow("mychart");
		myChart.addEventListener(Events.ON_CREATE, this);
		
		btnCurrentDate = (Button) component.getFellow("btnCurrentDate");
		btnCurrentDate.addEventListener(Events.ON_CLICK, this);
		
		btnSwitchTimeZone = (Button) component.getFellow("btnSwitchTimeZone");
		btnSwitchTimeZone.addEventListener(Events.ON_CLICK, this);
		
		lblDate = (Label) component.getFellow("lblDate");
		lblDate.addEventListener(Events.ON_CREATE, this);
		
		divArrowLeft = component.getFellow("divArrowLeft");
		divArrowLeft.addEventListener("onMoveDate", this);
		
		divArrowRight = component.getFellow("divArrowRight");
		divArrowRight.addEventListener("onMoveDate", this);
		
		FDOW = (Span) component.getFellow("FDOW");
		FDOW.addEventListener(Events.ON_CREATE, this);

		lbxFDOW = (Listbox) component.getFellow("lbxFDOW");
		lbxFDOW.addEventListener(Events.ON_SELECT, this);
		lbxFDOW.addEventListener(Events.ON_CREATE, this);
		
		String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"};
		for (String day : days) {
			lbxFDOW.appendItem(Msg.getMsg(Env.getCtx(),day), day);
		}
		
		divTabDay = component.getFellow("divTabDay");
		divTabDay.addEventListener("onUpdateView", this);
		
		divTabWeek = component.getFellow("divTabWeek");
		divTabWeek.addEventListener("onUpdateView", this);
		
		divTabWeekdays = component.getFellow("divTabWeekdays");
		divTabWeekdays.addEventListener("onUpdateView", this);
		
		divTabMonth = component.getFellow("divTabMonth");
		divTabMonth.addEventListener("onUpdateView", this);
		
		updateMsg = (Popup) component.getFellow("updateMsg");
		
		popupLabel = (Label) component.getFellow("popupLabel");
		
		timer = (Timer) component.getFellow("timer");
		
		this.appendChild(component);

		calendars.addEventListener("onEventCreate", this);
		calendars.addEventListener("onEventEdit", this);
		calendars.addEventListener("onEventUpdate", this);
		calendars.addEventListener("onMouseOver", this);

		if (ClientInfo.isMobile()) {
			addCallback(AFTER_PAGE_ATTACHED, t -> afterPageAttached());
			addEventListener(ON_MOBILE_SET_SELECTED_TAB_ECHO, evt -> calendars.invalidate());
		}
		
		SessionManager.getAppDesktop().showWindow(this);

		// IDEMPIERE-1457: when show this window on tab, handle event close to remove calendars away scm
		Component parentTab = this.getParent();
		if (parentTab != null && parentTab.getClass().equals(Tabpanel.class)) {
			((Tabpanel)parentTab).setOnCloseHandler(this);
		}				
		renderCalenderEvent();
		divTabClicked(7);
		}
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

	private void onMobileSelected() {
		Events.echoEvent(ON_MOBILE_SET_SELECTED_TAB_ECHO, this, null);
	}

	public void onClose(Tabpanel tabPanel){
		//IDEMPIERE-1457: On close, remove calendars away scm			
		calendars.setModel(null);
		Tab tab = tabPanel.getLinkedTab();
		tab.close();
	}

	public void onEvent(Event e) throws Exception {
		String type = e.getName();

		if (type.equals(Events.ON_CLICK)) {
			if (e.getTarget() == btnRefresh)
				renderCalenderEvent();
			else if (e.getTarget() == btnCurrentDate)
				btnCurrentDateClicked();
			else if (e.getTarget() == btnSwitchTimeZone)
				btnSwitchTimeZoneClicked();
		}
		else if (type.equals(Events.ON_CHECK)) 
		{
			if(e.getTarget()==showRes)
			{
					if(showRes.isChecked())
					{
						lblRes.setVisible(true);
						lbxResources.setVisible(true);
						userPreference.setProperty(UserPreference.P_SHOWRESOURCES, "Y");
					}
					else
					{
						lblRes.setVisible(false);
						lbxResources.setVisible(false);
						userPreference.setProperty(UserPreference.P_SHOWRESOURCES, "N");
					}
					
					userPreference.savePreference();
					renderCalenderEvent();
			}
		}
		else if (type.equals(Events.ON_CREATE)) {
			if (e.getTarget() == lblDate)
				updateDateLabel();
			else if (e.getTarget() == FDOW)
				FDOW.setVisible("month".equals(calendars.getMold()) || calendars.getDays() == 7);
			else if (e.getTarget() == myChart)
				syncModel();
			else if (e.getTarget() == lbxFDOW)
				lbxFDOW.setSelectedIndex(0);
		}
		else if (type.equals("onMoveDate")) {
			if (e.getTarget() == divArrowLeft)
				divArrowClicked(false);
			else if (e.getTarget() == divArrowRight)
				divArrowClicked(true);
		}
		else if (type.equals("onUpdateView")) {
			String text = String.valueOf(e.getData());
			int days = Msg.getMsg(Env.getCtx(),"Day").equals(text) ? 1: Msg.getMsg(Env.getCtx(),"5Days").equals(text) ? 5: Msg.getMsg(Env.getCtx(),"Week").equals(text) ? 7: 0;
			divTabClicked(days);
		}
		else if (type.equals(Events.ON_SELECT))
		{
			if (e.getTarget() == lbxRequestTypes)
			{
				renderCalenderEvent();
			}
			else if (e.getTarget() == lbxFDOW)
			{
				calendars.setFirstDayOfWeek(lbxFDOW.getSelectedItem().getValue().toString());
				syncModel();
			}
			else if (e.getTarget() == lbxContactActivityTypes)
			{
				renderCalenderEvent();
			}
			else if (e.getTarget() == lbxResources)
			{
				renderCalenderEvent();
			}
		}
		else if (type.equals("onEventCreate")) {
			CalendarsEvent calendarsEvent = (CalendarsEvent) e;
			DecisionWindow decisionWin = new DecisionWindow(calendarsEvent, this);
			SessionManager.getAppDesktop().showWindow(decisionWin);
		}	
		else if (type.equals("onEventEdit")) {
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
		else if (type.equals("onEventUpdate")) {
			if (e instanceof CalendarsEvent)
			{
				CalendarsEvent evt = (CalendarsEvent) e;
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/d");
				sdf1.setTimeZone(calendars.getDefaultTimeZone());
				StringBuilder sb = new StringBuilder("Update... from ");
				sb.append(sdf1.format(evt.getCalendarEvent().getBeginDate()));
				sb.append(" to ");
				sb.append(sdf1.format(evt.getBeginDate()));
				popupLabel.setValue(sb.toString());
				int left = evt.getX();
				int top = evt.getY();
				if (top + 100 > evt.getDesktopHeight())
					top = evt.getDesktopHeight() - 100;
				if (left + 330 > evt.getDesktopWidth())
					left = evt.getDesktopWidth() - 330;
				updateMsg.open(left, top);
				timer.start();
				org.zkoss.calendar.Calendars cal = (org.zkoss.calendar.Calendars) evt.getTarget();
				SimpleCalendarModel m = (SimpleCalendarModel) cal.getModel();
				SimpleCalendarEvent sce = (SimpleCalendarEvent) evt.getCalendarEvent();
				sce.setBeginDate(evt.getBeginDate());
				sce.setEndDate(evt.getEndDate());
				m.update(sce);
			}
		}
	}
	
	private void syncModel() {
		Hashtable<String,BigDecimal> ht = new Hashtable<String,BigDecimal>();
		
		List<?> list = calendars.getModel().get(calendars.getBeginDate(), calendars.getEndDate(), null);
		int size = list.size();
		for (int i = 0; i < size ; i++) {
			String key;

			if (list.get(i).getClass().equals(ADCalendarEvent.class))
				key = ((ADCalendarEvent) list.get(i)).getR_RequestType_ID() + "";
			else if (list.get(i).getClass().equals(ADCalendarContactActivity.class))
				key = ((ADCalendarContactActivity) list.get(i)).getContactActivityType() + "";
			else if (list.get(i).getClass().equals(ADCalendarResourceAssignment.class))
				key = ((ADCalendarResourceAssignment) list.get(i)).getS_Resource_ID() + "";

			else
				continue;

					
			if (!ht.containsKey(key))
				ht.put(key, BigDecimal.ONE);
			else {
				BigDecimal value = ht.get(key);
				ht.put(key, value.add(BigDecimal.ONE));
			}
		}
		
		Hashtable<Object, String> htTypes = new Hashtable<Object, String>();
		for(int i = 0; i < lbxRequestTypes.getItemCount(); i++)
		{
			Listitem li = lbxRequestTypes.getItemAtIndex(i);
			if(li != null && li.getValue() != null)
				htTypes.put(li.getValue(), li.getLabel());
		}
		
		DefaultPieDataset pieDataset = new DefaultPieDataset();
		Enumeration<?> keys = ht.keys();
		while(keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			BigDecimal value = ht.get(key);
			String name = (String) htTypes.get(key);
			pieDataset.setValue(name == null ? "" : name, Double.valueOf(size > 0 ? value.doubleValue()/size*100 : 0));
		}
		
		JFreeChart chart = ChartFactory.createPieChart(Msg.getMsg(Env.getCtx(),"EventsAnalysis"), pieDataset, true, true, true);
		PiePlot plot = (PiePlot) chart.getPlot(); 
		plot.setForegroundAlpha(0.5f);
		BufferedImage bi = chart.createBufferedImage(600, 250);
		try {
			byte[] bytes = EncoderUtil.encode(bi, ImageFormat.PNG, true);
			AImage image = new AImage("Pie Chart", bytes);
			myChart.setContent(image);
		} catch (IOException e) {
			log.log(Level.SEVERE,"Chart is not rendered-"+e.getLocalizedMessage());
		}		
		htTypes = null;
		ht = null;
	}
	
	public void onRefresh()
	{
		renderCalenderEvent();
	}
	
	private void setTimeZone()
	{
		String alternateTimeZone = MSysConfig.getValue(MSysConfig.CALENDAR_ALTERNATE_TIMEZONE, "Pacific Time=PST", Env.getAD_Client_ID(Env.getCtx()));
		TimeZone defaultTimeZone = TimeZone.getDefault();
		calendars.addTimeZone (defaultTimeZone.getDisplayName(), defaultTimeZone);
		if (!Util.isEmpty(alternateTimeZone, true)) {
			if (!alternateTimeZone.equalsIgnoreCase(defaultTimeZone.getDisplayName())) {
				String[] pair = alternateTimeZone.split("=");
				calendars.addTimeZone(pair[0].trim(), pair[1].trim());
			}
		}
	}
	
	private void updateDateLabel() {
		Date b = calendars.getBeginDate();
		Date e = calendars.getEndDate();
		SimpleDateFormat sdfV = DisplayType.getDateFormat();
		sdfV.setTimeZone(calendars.getDefaultTimeZone());
		lblDate.setValue(sdfV.format(b) + " - " + sdfV.format(e));
	}
	
	private void btnCurrentDateClicked() {
		calendars.setCurrentDate(Calendar.getInstance(calendars.getDefaultTimeZone()).getTime());
		updateDateLabel();
		syncModel();
	}
	
	private void btnSwitchTimeZoneClicked() {
		Map<?, ?> zone = calendars.getTimeZones();
		if (!zone.isEmpty()) {
			@SuppressWarnings("unchecked")
			Map.Entry<TimeZone, String> me = (Map.Entry<TimeZone, String>) zone.entrySet().iterator().next();
			calendars.removeTimeZone((TimeZone) me.getKey());
			calendars.addTimeZone((String) me.getValue(), (TimeZone) me.getKey());
		}
		syncModel();
	}

	private void divArrowClicked(boolean isNext) {
		if (isNext)
			calendars.nextPage();
		else
			calendars.previousPage();
		updateDateLabel();
		syncModel();
	}
	
	private void divTabClicked(int days) {		
		if (days > 0) {
			calendars.setMold("default");
			calendars.setDays(days);
		} else calendars.setMold("month");
		updateDateLabel();
		FDOW.setVisible("month".equals(calendars.getMold()) || calendars.getDays() == 7);
	}

	@Override
	public void valueChange(ValueChangeEvent e)
	{
		if (e.getSource() == lbxUserHeirarchy)
		{
			Listitem li = lbxRequestTypes.getSelectedItem();
			if (li == null)
				return;
			if (li.getValue() == null)
				return;
			int R_RequestType_ID = Integer.parseInt(li.getValue().toString());

			scm.clear();
			ArrayList<ADCalendarEvent> events = DPCalendar.getEvents(R_RequestType_ID, Env.getCtx(),
					lbxUserHeirarchy.getValues());
			for (ADCalendarEvent event : events)
			{
				scm.add(event);
			}
			ArrayList<ADCalendarContactActivity> activities = DPCalendar.getContactActivities(ContactActivityType,
					Env.getCtx(),lbxUserHeirarchy.getValues());
			for (ADCalendarContactActivity activity : activities)
				scm.add(activity);

			userPreference.loadPreference(Env.getAD_User_ID(Env.getCtx()));
			String showres=userPreference.getProperty(UserPreference.P_SHOWRESOURCES);
			if(showres.equalsIgnoreCase("Y"))
			{
				ArrayList<ADCalendarResourceAssignment> resourceAssignments = DPCalendar.getResourceAssignments(
						S_Resource_ID, Env.getCtx());
				for (ADCalendarResourceAssignment resource : resourceAssignments)
					scm.add(resource);
			}
			calendars.invalidate();
			syncModel();
		}
	}
	
	public void renderCalenderEvent()
	{
		scm.clear();

		// Fetch Requests
		Listitem li = lbxRequestTypes.getSelectedItem();
		if (li == null)
			return;

		if (li.getValue() == null)
			return;
		int R_RequestType_ID = Integer.parseInt(li.getValue().toString());

		ArrayList<ADCalendarEvent> events = DPCalendar.getEvents(R_RequestType_ID, Env.getCtx(),
				lbxUserHeirarchy.getValues());
		for (ADCalendarEvent event : events)
			scm.add(event);

		// Fetch Contact Activities
		li = lbxContactActivityTypes.getSelectedItem();
		if (li == null)
			return;

		if (li.getValue() == null)
			return;
		ContactActivityType = li.getValue();

		ArrayList<ADCalendarContactActivity> activities = DPCalendar.getContactActivities(ContactActivityType,
				Env.getCtx(), lbxUserHeirarchy.getValues());
		for (ADCalendarContactActivity activity : activities)
			scm.add(activity);

		// Fetch Resources

		userPreference.loadPreference(Env.getAD_User_ID(Env.getCtx()));
		String showres = userPreference.getProperty(UserPreference.P_SHOWRESOURCES);

		if (showres.equals("Y"))
		{
			lblRes.setVisible(true);
			lbxResources.setVisible(true);
			li = lbxResources.getSelectedItem();
			if (li == null)
				return;

			if (li.getValue() == null)
				return;
			S_Resource_ID = Integer.parseInt(li.getValue().toString());

			ArrayList<ADCalendarResourceAssignment> resourceAssignments = DPCalendar.getResourceAssignments(
					S_Resource_ID, Env.getCtx());
			for (ADCalendarResourceAssignment resource : resourceAssignments)
				scm.add(resource);
		}

		calendars.invalidate();
		syncModel();
	}
}