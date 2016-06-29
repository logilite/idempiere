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

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRole;
import org.compiere.model.X_C_ContactActivity;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * Show/Edit Contact Activity 
 * @author swiki - based on Elaine
 *
 */
public class ActivityWindow extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8188593824689379210L;
	private static final CLogger log=CLogger.getCLogger(ActivityWindow.class);
	
	private DatetimeBox dtBeginDate, dtEndDate;
	private Textbox txtDescription, txtComments, txtSalesMan;
	private ConfirmPanel confirmPanel;
	private Calendar calBegin,calEnd;

	private WTableDirEditor activityTypeField, salesRepField, opportunityField;
	private WSearchEditor userField;

	private int C_ContactActivity_ID = 0;

	private boolean m_readOnly;
	private Window parent;

	public ActivityWindow(Window parent) {

		super();

		this.parent = parent;

		Properties ctx = Env.getCtx();
		setTitle(Msg.getElement(ctx, "C_Activity_ID"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		setWidth("400px");
		//setHeight("400px");

		this.setSclass("popup-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);

		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), 
				X_C_ContactActivity.Table_ID, 0, false);

		Label lblDescription    = new Label(Msg.getMsg(ctx, "Subject"));
		Label lblActivityType   = new Label(Msg.getElement(ctx,X_C_ContactActivity.COLUMNNAME_ContactActivityType));
		Label lblBeginDate    	= new Label(Msg.getElement(ctx,X_C_ContactActivity.COLUMNNAME_StartDate));
		Label lblEndDate      	= new Label(Msg.getElement(ctx,X_C_ContactActivity.COLUMNNAME_EndDate));
		Label lblComments      	= new Label(Msg.getMsg(ctx, "Description"));
		Label lblsalesMan      	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_SalesRep_ID));
		Label lblUser      		= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_AD_User_ID));
		Label lblOpportunity	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID));

		int columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_ContactActivityType);
		MLookup lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		activityTypeField = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_ContactActivityType, true, false, true, lookup);

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_SalesRep_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), X_C_ContactActivity.COLUMNNAME_AD_User_ID, 0, true, " EXISTS (SELECT * FROM C_BPartner bp WHERE AD_User.C_BPartner_ID=bp.C_BPartner_ID AND bp.IsSalesRep='Y') ");
			salesRepField = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_SalesRep_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"SalesRepresentative not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_AD_User_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.Search);
			userField = new WSearchEditor(X_C_ContactActivity.COLUMNNAME_AD_User_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"User not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID, 0, true, " C_Opportunity.C_SalesStage_ID IN (SELECT ss.C_SalesStage_ID FROM C_SalesStage ss WHERE ss.Probability > 0 AND ss.Probability < 100) ");
			opportunityField = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"Opportunity field not found-"+e.getLocalizedMessage());
		}

		activityTypeField.setReadWrite(!m_readOnly);
		salesRepField.setReadWrite(!m_readOnly);
		userField.setReadWrite(!m_readOnly);
		opportunityField.setReadWrite(!m_readOnly);

		dtBeginDate = new DatetimeBox();
		dtBeginDate.setEnabled(!m_readOnly);

		dtEndDate = new DatetimeBox();
		dtEndDate.setEnabled(!m_readOnly);

		txtComments = new Textbox();
		txtComments.setRows(5);
		txtComments.setWidth("95%");
		txtComments.setHeight("100%");
		txtComments.setReadonly(m_readOnly);

		txtDescription = new Textbox();
		txtDescription.setWidth("95%");
		txtDescription.setReadonly(m_readOnly);

		txtSalesMan = new Textbox();
		txtSalesMan.setWidth("95%");
		txtSalesMan.setReadonly(!m_readOnly);

		confirmPanel = new ConfirmPanel(true, false, false, false, false, true);
		confirmPanel.addActionListener(this);


		Grid grid = GridFactory.newGridLayout();

		Columns columns = new Columns();
		grid.appendChild(columns);

		Column column = new Column();
		columns.appendChild(column);

		column = new Column();
		columns.appendChild(column);
		column.setWidth("250px");

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblActivityType.rightAlign());
		row.appendChild(activityTypeField.getComponent());

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDescription.rightAlign());
		row.appendChild(txtDescription);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblBeginDate.rightAlign());
		row.appendChild(dtBeginDate);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEndDate.rightAlign());
		row.appendChild(dtEndDate);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblComments.rightAlign());
		row.appendChild(txtComments);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblsalesMan.rightAlign());
		row.appendChild(salesRepField.getComponent());

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblUser.rightAlign());
		row.appendChild(userField.getComponent());

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblOpportunity.rightAlign());
		row.appendChild(opportunityField.getComponent());

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("min");

		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);

		northPane.appendChild(grid);
		//grid.setHeight("400px");
		grid.setVflex("1");
		grid.setHflex("1");

		South south = new South();
		south.setSclass("dialog-footer");
		borderlayout.appendChild(south);
		south.appendChild(confirmPanel);
	}

	public void setData(ADCalendarContactActivity event) {

		activityTypeField.setValue(event.getContactActivityType());
		salesRepField.setValue(event.getSalesRep_ID());

		if(event.getAD_User_ID()>0)
			userField.setValue(event.getAD_User_ID());

		if(event.getC_Opportunity_ID()>0)
			opportunityField.setValue(event.getC_Opportunity_ID());

		dtBeginDate.setValue(event.getBeginDate());
		dtEndDate.setValue(event.getEndDate());
		txtDescription.setText(event.getDescription());
		txtComments.setText(event.getComments());

		C_ContactActivity_ID = event.getC_ContactActivity_ID();
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setEnabled(C_ContactActivity_ID > 0);

		checkVisibility();
	}

	public void checkVisibility(){

		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()), 
				X_C_ContactActivity.Table_ID, 0, false);

		X_C_ContactActivity activity = new X_C_ContactActivity(Env.getCtx(), C_ContactActivity_ID, null);
		//System.out.println(!m_readOnly+" && "+!activity.isActive());
		if(!m_readOnly && !activity.isActive())
			m_readOnly=true;

		//System.out.println(!m_readOnly+" && "+activity.isComplete());
		if(!m_readOnly && activity.isComplete())
			m_readOnly=true;

		confirmPanel.getButton(ConfirmPanel.A_OK).setEnabled(!m_readOnly);
		activityTypeField.setReadWrite(!m_readOnly);
		salesRepField.setReadWrite(!m_readOnly);
		userField.setReadWrite(!m_readOnly);
		opportunityField.setReadWrite(!m_readOnly);
		dtBeginDate.setEnabled(!m_readOnly);
		dtEndDate.setEnabled(!m_readOnly);
		txtComments.setReadonly(m_readOnly);
		txtDescription.setReadonly(m_readOnly);
		txtSalesMan.setReadonly(!m_readOnly);
	}

	//Check, Start time is not  >=  End time
	private boolean checkTime()
	{
		if(dtBeginDate.getValue() == null)
			return false;

		calBegin = Calendar.getInstance();
		calBegin.setTime(dtBeginDate.getValue());
		Calendar cal1 = Calendar.getInstance();
		cal1.setTimeInMillis(dtBeginDate.getValue().getTime());
		calBegin.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
		calBegin.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
		calBegin.set(Calendar.SECOND, 0);
		calBegin.set(Calendar.MILLISECOND, 0);

		calEnd = Calendar.getInstance();
		calEnd.setTime(dtEndDate.getValue());
		Calendar cal2 = Calendar.getInstance();
		cal2.setTimeInMillis(dtEndDate.getValue().getTime());
		calEnd.set(Calendar.HOUR_OF_DAY, cal2.get(Calendar.HOUR_OF_DAY));
		calEnd.set(Calendar.MINUTE, cal2.get(Calendar.MINUTE));
		calEnd.set(Calendar.SECOND, 0);
		calEnd.set(Calendar.MILLISECOND, 0);

		if (calBegin.compareTo(calEnd) >= 0) {
			return true;
		} else {
			return false;
		}

	}

	public void onEvent(Event e) throws Exception {
		if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)){
			if(!m_readOnly && C_ContactActivity_ID>0){

				String fillMandatory = Msg.translate(Env.getCtx(), "FillMandatory");

				if (activityTypeField.getValue() == null || activityTypeField.getValue().equals(""))
					throw new WrongValueException(activityTypeField.getComponent(), fillMandatory);
				if (txtDescription.getText() == null || txtDescription.getText().equals(""))
					throw new WrongValueException(txtDescription, fillMandatory);
				if (dtBeginDate.getValue() == null) 
					throw new WrongValueException(dtBeginDate, Msg.translate(Env.getCtx(), fillMandatory));
				if (dtEndDate.getValue() == null) 
					throw new WrongValueException(dtEndDate, Msg.translate(Env.getCtx(), fillMandatory));
				if (checkTime()) 
					throw new WrongValueException(dtBeginDate, Msg.translate(Env.getCtx(), "CheckTime"));


				X_C_ContactActivity activity = new X_C_ContactActivity(Env.getCtx(), C_ContactActivity_ID, null);

				activity.setContactActivityType(activityTypeField.getValue().toString());
				if(salesRepField.getValue() != null)
					activity.setSalesRep_ID((Integer) salesRepField.getValue());
				if(userField.getValue() != null && !"".equals(userField.getValue()))
					activity.setAD_User_ID((Integer) userField.getValue());
				if(opportunityField.getValue() != null)
					activity.setC_Opportunity_ID((Integer) opportunityField.getValue());
				activity.setDescription(txtDescription.getValue());
				activity.setComments(txtComments.getValue());
				activity.setStartDate(new Timestamp(calBegin.getTimeInMillis()));
				activity.setIsComplete(false);
				if(calEnd != null)
					activity.setEndDate(new Timestamp(calEnd.getTimeInMillis()));

				if (activity.save())
				{
					Events.postEvent("onRefresh", parent, null);
				}
				else
				{
					FDialog.error(0, this, "Request Activity not saved");
					return;
				}
			}
			setVisible(false);
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)){
			setVisible(false);
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_ZOOM)) {
			if (C_ContactActivity_ID > 0){
				AEnv.zoom(X_C_ContactActivity.Table_ID, C_ContactActivity_ID);
			}
		}
	}
}
