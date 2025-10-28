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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.MultiSelectionBox;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WLocationEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.MClientInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MContactActivity_Attendees;
import org.compiere.model.MLocationLookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRole;
import org.compiere.model.MUser;
import org.compiere.model.X_AD_User;
import org.compiere.model.X_AD_Workflow;
import org.compiere.model.X_C_BPartner;
import org.compiere.model.X_C_ContactActivity;
import org.compiere.model.X_C_Opportunity;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * Create Contact Activities
 * @author swiki - based on Elaine
 *
 */
public class ContactActivityWindow extends Window implements EventListener<Event>, ValueChangeListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7757368164776005797L;

	private static CLogger log = CLogger.getCLogger(ContactActivityWindow.class);

	/** Read Only				*/
	private boolean m_readOnly = false;

	private WTableDirEditor activityTypeField, salesOpportunityField, leadField, jobField, leadSourceField, leadStatusField, activityRelatedTo;
	private WTableDirEditor activityTypeField2,  salesStageField, currencyField;
	private WSearchEditor contactField, bpartnerField;
	private WLocationEditor locationField;
	private WTableDirEditor		bpcontact;
	private MultiSelectionBox	salesRepField;
	private static final int	COLUMNID_AD_USER_ID	= 212;

	private ConfirmPanel confirmPanel;

	private Textbox txtDescription, txtComments, txtName, txtBPname, txtPhone, txtEMail;
	private Textbox txtDescription2, txtComments2, opportunityDesc;

	private Row specialRow, newLeadLabelRow, newLeadRow, nameRow, BPNameRow, locationRow, positionRow, sourceRow, statusRow, phoneRow;

	private Window parent;
	private Calendar calBegin,calEnd;
	private DatetimeBox dbxStartDate, dbxEndDate, dbxStartDate2;
	private Datebox dbxCloseDate;
	private Checkbox chbxCreateLead, chbxFollowActivity, chbxCreateOpportunity;
	private NumberBox opportunityAmt, nbxDuration;

	Label lblLeadName, lblLeadBPName, lblSalesOpportunity, lblLead, lblBPLocation, lblPhone, lblEMail, lblJob, lblLeadSource, lblLeadStatus, lblActivityRelatedTo;
	Label lblSalesRep, lblComments, lblActivityType2, lblDescription2, lblStartDate2, lblComments2, lblDuration, lblcontact;
	Label lblEMpty, lblEMpty2, lblEMpty3, lblEMpty4,lblOpportunityAmt, lblCloseDate, lblsalesStageField, lblOpportunityDesc, lblCurrency;

	public ContactActivityWindow(CalendarsEvent ce, Window parent) {

		super();

		this.parent = parent;

		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(ctx, "ActivityNew"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		ZKUpdateUtil.setWidth(this, "825px");

		this.setSclass("popup-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);

		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), 
				X_C_ContactActivity.Table_ID, 0, false);

		Label lblActivityType      	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_ContactActivityType));
		lblSalesOpportunity		 	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID));
		lblLead					 	= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_IsSalesLead));
		lblSalesRep		 			= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_SalesRep_ID));
		Label lblDescription        = new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_Description));
		lblComments      	     	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_Comments));
		Label lblStartDate          = new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_StartDate));
		Label lblEndDate            = new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_EndDate));
		lblLeadName      			= new Label(Msg.getMsg(ctx, "ContactPerson"));
		lblLeadBPName    			= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_BPName));
		lblBPLocation				= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_BP_Location_ID));
		lblPhone					= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_Phone));
		lblEMail					= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_EMail));
		lblJob						= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_C_Job_ID));
		lblLeadSource				= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_LeadSource));
		lblLeadStatus				= new Label(Msg.getElement(ctx, X_AD_User.COLUMNNAME_LeadStatus));
		lblActivityRelatedTo		= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_C_ContactActivityRelatedTo));
		//follow Acitivity
		lblActivityType2			= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_ContactActivityType));
		lblDescription2       		= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_Description));
		lblStartDate2		        = new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_StartDate));
		lblComments2      	     	= new Label(Msg.getElement(ctx, X_C_ContactActivity.COLUMNNAME_Comments));
		//tmp
		lblEMpty      				= new Label("");		lblEMpty3      				= new Label("");
		lblEMpty2      				= new Label("");		lblEMpty4      				= new Label("");
		lblOpportunityAmt			= new Label(Msg.getElement(ctx, X_C_Opportunity.COLUMNNAME_OpportunityAmt));
		lblCloseDate				= new Label(Msg.getElement(ctx, X_C_Opportunity.COLUMNNAME_ExpectedCloseDate));
		lblsalesStageField			= new Label(Msg.getElement(ctx, X_C_Opportunity.COLUMNNAME_C_SalesStage_ID));
		lblOpportunityDesc			= new Label(Msg.getMsg(ctx, "OpportunityName"));
		lblCurrency					= new Label(Msg.getElement(ctx, X_C_Opportunity.COLUMNNAME_C_Currency_ID));
		lblDuration					= new Label(Msg.getElement(ctx, X_AD_Workflow.COLUMNNAME_Duration));
		lblcontact 					= new Label(Msg.getMsg(ctx, "Contact"));
		
		ArrayList<X_AD_User> usersList = DPCalendar.getUserList(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
		ArrayList<ValueNamePair> supervisors = new ArrayList<ValueNamePair>();
		supervisors.add(DPCalendar.SALES_REPRESENTATIVE_ALL);
		for (X_AD_User uType : usersList)
			supervisors.add(new ValueNamePair(uType.getAD_User_ID() + "", uType.getName()));

		salesRepField = new MultiSelectionBox(supervisors, true);

		int columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_ContactActivityType);
		MLookup lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		activityTypeField = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_ContactActivityType, true, false, true, lookup);
		if(activityTypeField.getValue() == null || activityTypeField.getValue().equals(""))
			if(activityTypeField.getComponent().getItemCount() > 1)
				activityTypeField.setValue(activityTypeField.getComponent().getItemAtIndex(1).getValue());

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID, 0, true, " C_Opportunity.C_SalesStage_ID IN (SELECT ss.C_SalesStage_ID FROM C_SalesStage ss WHERE ss.Probability > 0 AND ss.Probability < 100) ");
			salesOpportunityField = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_C_Opportunity_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"Sales opprtunity not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_AD_User_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), X_AD_User.COLUMNNAME_AD_User_ID, 0, true, " (AD_User.IsSalesLead='Y' OR AD_User.leadstatus='C') ");
			leadField = new WTableDirEditor(X_AD_User.COLUMNNAME_AD_User_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"Lead field not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_AD_User_ID);
		try{
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.Search, Env.getLanguage(Env.getCtx()), X_AD_User.COLUMNNAME_AD_User_ID, 0, true, "");
			contactField = new WSearchEditor(X_AD_User.COLUMNNAME_AD_User_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"Contact not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_C_ContactActivityRelatedTo);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		activityRelatedTo = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_C_ContactActivityRelatedTo, false, false, true, lookup);
		activityRelatedTo.getComponent().setSelectedIndex(0);
		
		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_C_Job_ID);
		try{
			//lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.TableDir);
			lookup = MLookupFactory.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()), X_AD_User.COLUMNNAME_C_Job_ID, 0, true, " C_Job.IsEmployee='N' ");
			jobField = new WTableDirEditor(X_AD_User.COLUMNNAME_C_Job_ID, true, false, true, lookup);
		}
		catch (Exception e) {
			log.log(Level.SEVERE,"Job field not found-"+e.getLocalizedMessage());
		}

		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_LeadSource);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		leadSourceField = new WTableDirEditor(X_AD_User.COLUMNNAME_LeadSource, true, false, true, lookup);

		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_LeadStatus);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		leadStatusField = new WTableDirEditor(X_AD_User.COLUMNNAME_LeadStatus, true, false, true, lookup);
		if(leadStatusField.getValue() == null || leadStatusField.getValue().equals(""))
			if(leadStatusField.getComponent().getItemCount() > 1)
				leadStatusField.setValue(leadStatusField.getComponent().getItemAtIndex(2).getValue());

		columnID = MColumn.getColumn_ID(X_AD_User.Table_Name, X_AD_User.COLUMNNAME_BP_Location_ID);
		MLocationLookup locLookup = new MLocationLookup(ctx, 53153);
		locationField = new WLocationEditor(X_AD_User.COLUMNNAME_BP_Location_ID, true, false, true, locLookup);

		columnID = MColumn.getColumn_ID(X_C_ContactActivity.Table_Name, X_C_ContactActivity.COLUMNNAME_ContactActivityType);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		activityTypeField2 = new WTableDirEditor(X_C_ContactActivity.COLUMNNAME_ContactActivityType, true, false, true, lookup);
		if(activityTypeField2.getValue() == null || activityTypeField2.getValue().equals(""))
			if(activityTypeField2.getComponent().getItemCount() > 1)
				activityTypeField2.setValue(activityTypeField2.getComponent().getItemAtIndex(1).getValue());


		columnID = MColumn.getColumn_ID(X_C_Opportunity.Table_Name, X_C_Opportunity.COLUMNNAME_C_SalesStage_ID);
		lookup = MLookupFactory.get (ctx, 0, 0, columnID, DisplayType.TableDir);
		salesStageField = new WTableDirEditor(X_C_Opportunity.COLUMNNAME_C_SalesStage_ID, true, false, true, lookup);
		initSaleStages();
		//if(salesStageField.getValue() == null || salesStageField.getValue().equals(""))
			//if(salesStageField.getComponent().getItemCount() > 1)
				//salesStageField.setValue(salesStageField.getComponent().getItemAtIndex(0).getValue());

		columnID = MColumn.getColumn_ID(X_C_Opportunity.Table_Name, X_C_Opportunity.COLUMNNAME_C_Currency_ID);
		lookup = MLookupFactory.get (ctx, 0, 0, columnID, DisplayType.TableDir);
		currencyField = new WTableDirEditor(X_C_Opportunity.COLUMNNAME_C_Currency_ID, true, false, true, lookup);
		
		columnID = MColumn.getColumn_ID(X_C_BPartner.Table_Name, X_C_BPartner.COLUMNNAME_C_BPartner_ID);
		lookup = MLookupFactory.get(ctx, 9999, Env.TAB_INFO, columnID, DisplayType.TableDir);
		bpartnerField = new WSearchEditor("C_BPartner_ID", true, false, true, lookup);

		//init default schema
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()));
		currencyField.setValue(clientInfo.getC_AcctSchema1().getC_Currency_ID()); 

		chbxCreateLead = new Checkbox();
		chbxCreateLead.setSelected(false);
		chbxCreateLead.addActionListener(this);
		chbxCreateLead.setText(Msg.getMsg(ctx, "LeadNew"));

		chbxFollowActivity = new Checkbox();
		chbxFollowActivity.setSelected(false);
		chbxFollowActivity.addActionListener(this);
		chbxFollowActivity.setText(Msg.getMsg(ctx, "NextStep"));

		chbxCreateOpportunity = new Checkbox();
		chbxCreateOpportunity.setSelected(false);
		chbxCreateOpportunity.addActionListener(this);
		chbxCreateOpportunity.setText(Msg.getMsg(ctx, "OpportunityNew"));

		activityRelatedTo.addValueChangeListener(this);

		txtName = new Textbox();
		ZKUpdateUtil.setWidth(txtName, "100%");
		ZKUpdateUtil.setHeight(txtName, "100%");

		txtBPname = new Textbox();
		ZKUpdateUtil.setWidth(txtBPname, "100%");
		ZKUpdateUtil.setHeight(txtBPname, "100%");

		txtEMail = new Textbox();
		ZKUpdateUtil.setWidth(txtEMail, "100%");
		ZKUpdateUtil.setHeight(txtEMail, "100%");

		txtPhone = new Textbox();
		ZKUpdateUtil.setWidth(txtPhone, "100%");
		ZKUpdateUtil.setHeight(txtPhone, "100%");

		txtDescription = new Textbox();
		ZKUpdateUtil.setWidth(txtDescription, "100%");
		ZKUpdateUtil.setHeight(txtDescription, "100%");

		txtComments = new Textbox();
		txtComments.setMultiline(true);
		ZKUpdateUtil.setWidth(txtComments, "100%");
		ZKUpdateUtil.setHeight(txtComments, "100%");

		dbxStartDate = new DatetimeBox();
		dbxStartDate.addEventListener(Events.ON_CHANGE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				dbxEndDate.setValue(dbxStartDate.getValue());
			}
		});
		dbxEndDate = new DatetimeBox();
		dbxCloseDate = new Datebox();
		opportunityAmt = new NumberBox(true);

		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);

		//follow activity
		txtDescription2 = new Textbox();
		ZKUpdateUtil.setWidth(txtDescription2, "100%");
		ZKUpdateUtil.setHeight(txtDescription2, "100%");

		dbxStartDate2 = new DatetimeBox();

		txtComments2 = new Textbox();
		txtComments2.setMultiline(true);
		ZKUpdateUtil.setWidth(txtDescription2, "100%");
		ZKUpdateUtil.setHeight(txtDescription2, "100%");

		opportunityDesc = new Textbox();
		ZKUpdateUtil.setWidth(opportunityDesc, "88%");
		ZKUpdateUtil.setHeight(opportunityDesc, "100%");

		nbxDuration = new NumberBox(true);
		nbxDuration.setValue(60);

		Grid grid = GridFactory.newGridLayout();

		Columns columns = new Columns();
		grid.appendChild(columns);

		Column column = new Column();
		columns.appendChild(column);

		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "240px");

		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "230px");

		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "230px");

		Rows rows = new Rows();
		grid.appendChild(rows);

		/** generate rows **/
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblActivityType.rightAlign());
		ZKUpdateUtil.setWidth(activityTypeField.getComponent(), "100%");
		row.appendChild(activityTypeField.getComponent());
		row.appendChild(lblActivityRelatedTo);
		row.appendChild(lblEMpty);

		specialRow = new Row();
		rows.appendChild(specialRow);
		specialRow.appendChild(lblDescription.rightAlign());
		specialRow.appendChild(txtDescription);
		specialRow.appendChild(activityRelatedTo.getComponent());
		specialRow.appendChild(leadField.getComponent());
		leadField.setVisible(false);

		newLeadLabelRow = new Row();
		rows.appendChild(newLeadLabelRow);
		newLeadLabelRow.appendChild(lblStartDate.rightAlign());
		newLeadLabelRow.appendChild(dbxStartDate);
		//newLeadLabelRow.appendChild(lblnewLead);

		newLeadRow = new Row();
		rows.appendChild(newLeadRow);
		newLeadRow.appendChild(lblEndDate.rightAlign());
		newLeadRow.appendChild(dbxEndDate);
		newLeadRow.appendChild(chbxCreateLead);
		newLeadRow.appendChild(chbxCreateOpportunity);

		nameRow = new Row();
		rows.appendChild(nameRow);
		nameRow.appendChild(lblComments.rightAlign());
		nameRow.appendChild(txtComments);

		BPNameRow = new Row();
		rows.appendChild(BPNameRow);
		BPNameRow.appendChild(lblSalesRep.rightAlign());
		ZKUpdateUtil.setWidth(salesRepField, "200px");
		BPNameRow.appendChild(salesRepField);

		locationRow = new Row();
		rows.appendChild(locationRow);
		locationRow.appendChild(lblEMpty2);
		locationRow.appendChild(chbxFollowActivity);

		positionRow = new Row();
		rows.appendChild(positionRow);
		positionRow.appendChild(lblActivityType2.rightAlign());
		ZKUpdateUtil.setWidth(activityTypeField2.getComponent(), "100%");
		positionRow.appendChild(activityTypeField2.getComponent());
		lblActivityType2.setVisible(false);
		activityTypeField2.setVisible(false);

		sourceRow = new Row();
		rows.appendChild(sourceRow);
		sourceRow.appendChild(lblDescription2.rightAlign());
		sourceRow.appendChild(txtDescription2);
		lblDescription2.setVisible(false);
		txtDescription2.setVisible(false);

		statusRow = new Row();
		rows.appendChild(statusRow);
		statusRow.appendCellChild(lblStartDate2.rightAlign());
		statusRow.appendCellChild(dbxStartDate2);
		statusRow.appendChild(lblBPLocation);
		statusRow.appendChild(locationField.getComponent());
		lblBPLocation.setVisible(false);
		locationField.setVisible(false);
		lblStartDate2.setVisible(false);
		dbxStartDate2.setVisible(false);

		phoneRow = new Row();
		rows.appendChild(phoneRow);
		phoneRow.appendCellChild(lblDuration.rightAlign());
		phoneRow.appendChild(nbxDuration);
		phoneRow.appendCellChild(lblLeadSource);
		phoneRow.appendChild(leadSourceField.getComponent());
		lblLeadSource.setVisible(false);
		leadSourceField.setVisible(false);
		lblDuration.setVisible(false);
		nbxDuration.setVisible(false);

		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(lblComments2.rightAlign());
		row.appendCellChild(txtComments2);
		row.appendCellChild(lblLeadStatus);
		row.appendChild(leadStatusField.getComponent());
		lblComments2.setVisible(false);
		txtComments2.setVisible(false);
		lblLeadStatus.setVisible(false);
		leadStatusField.setVisible(false);

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "min");

		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);

		northPane.appendChild(grid);
//		grid.setHeight("450px");
		ZKUpdateUtil.setVflex(grid, "1");
		ZKUpdateUtil.setHflex(grid, "1");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);

		dbxStartDate.getTimebox().setFormat(DPCalendar.getTimeFormat());
		dbxEndDate.getTimebox().setFormat(DPCalendar.getTimeFormat());

		dbxStartDate.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getStartTimeHour()));
		dbxEndDate.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getEndTimeHour()));
	}

	public void initSaleStages(){
		String sql = "SELECT Name,C_SalesStage_ID FROM C_SalesStage WHERE isActive='Y' AND AD_Client_ID="+Env.getAD_Client_ID(Env.getCtx())+
				" AND AD_Org_ID IN (0,"+Env.getAD_Org_ID(Env.getCtx())+") ORDER BY probability";

		PreparedStatement ps = null;
		ResultSet rs = null;

		salesStageField.getComponent().removeAllItems();

		try {
			ps = DB.prepareStatement(sql, null);
			rs = ps.executeQuery();

			while (rs.next()) {
				salesStageField.getComponent().appendItem(rs.getString(1), rs.getInt(2));
			}

		}catch (Exception e) {
			log.log(Level.SEVERE,"InitsaleStages not found-"+e.getLocalizedMessage());
		}
		finally {
			DB.close(rs, ps);
		}
	}

	public void onEvent(Event e) throws Exception {
		if (m_readOnly){
			this.detach();
		}
		if(e.getTarget() == chbxCreateLead){
			if(chbxCreateLead.isChecked())
				chbxCreateOpportunity.setChecked(false);

			createOpportunityChanged();
			createLeadChanged();

		}
		else if (e.getTarget() == chbxCreateOpportunity){
			if(chbxCreateOpportunity.isChecked())
				chbxCreateLead.setChecked(false);

			createLeadChanged();
			createOpportunityChanged();

		}
		if(e.getTarget() == chbxFollowActivity){
			lblDescription2.setVisible(chbxFollowActivity.isSelected());		txtDescription2.setVisible(chbxFollowActivity.isSelected());
			lblActivityType2.setVisible(chbxFollowActivity.isSelected());		activityTypeField2.setVisible(chbxFollowActivity.isSelected());
			dbxStartDate2.setVisible(chbxFollowActivity.isSelected());			lblStartDate2.setVisible(chbxFollowActivity.isSelected());
			txtComments2.setVisible(chbxFollowActivity.isSelected());			lblComments2.setVisible(chbxFollowActivity.isSelected());
			lblDuration.setVisible(chbxFollowActivity.isSelected());			nbxDuration.setVisible(chbxFollowActivity.isSelected());
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			// Check Mandatory fields
			String fillMandatory = Msg.translate(Env.getCtx(), "FillMandatory");
			fillMandatory = fillMandatory.replaceAll(":", "");
			String selectLead = Msg.translate(Env.getCtx(), "SelectLead");

			// check new Activity fields
			if (activityTypeField.getValue() == null || activityTypeField.getValue().equals(""))
				throw new WrongValueException(activityTypeField.getComponent(), fillMandatory);
			if (txtDescription.getText() == null || txtDescription.getText().equals(""))
				throw new WrongValueException(txtDescription, fillMandatory);
			if (dbxStartDate.getValue() == null) 
				throw new WrongValueException(dbxStartDate, Msg.translate(Env.getCtx(), fillMandatory));
			if (dbxEndDate.getValue() == null) 
				throw new WrongValueException(dbxEndDate, Msg.translate(Env.getCtx(), fillMandatory));
			if (checkTime()) 
				throw new WrongValueException(dbxStartDate, Msg.translate(Env.getCtx(), "CheckTime"));
			if(activityRelatedTo.getComponent().getSelectedIndex()!=-1 && activityRelatedTo.getComponent().getSelectedIndex()!=0) 
				if (!chbxCreateLead.isSelected() && (leadField.getValue() == null || leadField.getValue().equals(""))
					&& (salesOpportunityField.getValue() == null || salesOpportunityField.getValue().equals(""))
					&& (contactField.getValue() == null || contactField.getValue().equals(""))
					&& (bpartnerField.getValue() == null || bpartnerField.getValue().equals("")))
				throw new WrongValueException(activityRelatedTo.getComponent(), fillMandatory);

			boolean createLead = chbxCreateLead.isSelected();
			boolean followActivity = chbxFollowActivity.isSelected();
			boolean convertLead = chbxCreateOpportunity.isSelected();

			//check new Lead Fields
			if (createLead && (txtName.getText() == null || txtName.getText().equals("")))
				throw new WrongValueException(txtName, fillMandatory);
			if (createLead && (txtBPname.getText() == null || txtBPname.getText().equals("")))
				throw new WrongValueException(txtBPname, fillMandatory);
			if (createLead && (locationField.getValue() == null || locationField.getValue().equals("")))
				throw new WrongValueException(locationField.getComponent(), fillMandatory);
			if (createLead && (jobField.getValue() == null || jobField.getValue().equals("")))
				throw new WrongValueException(jobField.getComponent(), fillMandatory);
			if (createLead && (leadSourceField.getValue() == null || leadSourceField.getValue().equals("")))
				throw new WrongValueException(leadSourceField.getComponent(), fillMandatory);
			if (createLead && (leadStatusField.getValue() == null || leadStatusField.getValue().equals("")))
				throw new WrongValueException(leadStatusField.getComponent(), fillMandatory);
			if (createLead && (txtPhone.getText() == null || txtPhone.getText().equals("")))
				throw new WrongValueException(txtPhone, fillMandatory);
			if (createLead && !validateEmail(txtEMail.getText()))
				throw new WrongValueException(txtEMail, Msg.translate(Env.getCtx(), "InvalidEmail"));

			if(followActivity && (activityTypeField2.getValue() == null || activityTypeField2.getValue().equals("")))
					throw new WrongValueException(activityTypeField2.getComponent(), fillMandatory);
			if(followActivity && (txtDescription2.getValue() == null || txtDescription2.getValue().equals("")))
				throw new WrongValueException(txtDescription2, fillMandatory);
			if(followActivity && dbxStartDate2.getValue() == null)
				throw new WrongValueException(dbxStartDate2, fillMandatory);
			if(followActivity && nbxDuration.getValue() == null)
				throw new WrongValueException(nbxDuration, fillMandatory);

			if(convertLead && (activityRelatedTo.getValue() == null 
					|| activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_SalesOpportunity)
					|| activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_Contact)))
				throw new WrongValueException(activityRelatedTo.getComponent(), selectLead);
			if(convertLead && (opportunityDesc.getText() == null || opportunityDesc.getText().equals("")))
				throw new WrongValueException(opportunityDesc, fillMandatory);
			if(convertLead && (dbxCloseDate.getValue() == null || dbxCloseDate.getValue().equals("")))
				throw new WrongValueException(dbxCloseDate, fillMandatory);
			if(convertLead && (salesStageField.getValue() == null || salesStageField.getValue().equals("")))
				throw new WrongValueException(salesStageField.getComponent(), fillMandatory);
			if(convertLead && (currencyField.getValue() == null || currencyField.getValue().equals("")))
				throw new WrongValueException(currencyField.getComponent(), fillMandatory);

			int lead_id = 0;
			//Create new Lead
			if(chbxCreateLead.isSelected()){
				MUser lead = new MUser(Env.getCtx(), 0, null);
				lead.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
				lead.setName(txtName.getText());
				String value = txtName.getText().replaceAll(" ", ""); 
				lead.setValue(value.toLowerCase());
				lead.setBPName(txtBPname.getText());
				lead.setSalesRep_ID(Env.getAD_User_ID(Env.getCtx()));
				lead.setIsSalesLead(true);

				if(txtEMail.getValue() != null && txtEMail.getValue().length() > 0)
					lead.setEMail(txtEMail.getText());
				lead.setPhone(txtPhone.getText());

				lead.setC_Job_ID((Integer)jobField.getValue());
				lead.setLeadSource((String)leadSourceField.getValue());
				lead.setLeadStatus((String)leadStatusField.getValue());
				lead.setBP_Location_ID((Integer)locationField.getValue());

				if (lead.save())
				{
					if (log.isLoggable(Level.FINE)) 
						log.fine("AD_User_ID=" + lead.get_ID());
					lead_id = lead.get_ID();
				}
				else
				{
					Dialog.error(0, "Request Lead not saved");
					return;
				}
			}

			X_C_ContactActivity activity = new X_C_ContactActivity(Env.getCtx(), 0, null);
			activity.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
			activity.setContactActivityType((String) activityTypeField.getValue());
			activity.setDescription(txtDescription.getText());
			activity.setStartDate(new Timestamp(calBegin.getTimeInMillis()));
			activity.setComments(txtComments.getText());
			activity.setIsComplete(false);
			
			if (bpcontact != null)
			{
				if (bpcontact.getValue() != null && !"".equals(bpcontact.getValue()))
					activity.setAD_User_ID((Integer) bpcontact.getValue());
			}

			// already create lead
			if(lead_id > 0)
				activity.setAD_User_ID(lead_id);
			// or existing lead or contact
			else{ 
				if(leadField.getValue() != null )
					activity.setAD_User_ID((Integer) leadField.getValue());
				else if(contactField.getValue() != null && !"".equals(contactField.getValue()))
					activity.setAD_User_ID((Integer) contactField.getValue());
				if (salesOpportunityField.getValue() != null)
					activity.setC_Opportunity_ID((Integer) salesOpportunityField.getValue());
				if (bpartnerField.getValue() != null && !"".equals(bpartnerField.getValue()))
					activity.setC_BPartner_ID((Integer) bpartnerField.getValue());
			}

			if (salesOpportunityField.getValue() != null)
				activity.setC_Opportunity_ID((Integer) salesOpportunityField.getValue());

			if (calEnd != null)
				activity.setEndDate(new Timestamp(calEnd.getTimeInMillis()));

			if (activity.save())
			{
				if (log.isLoggable(Level.FINE))
				{
					log.fine("C_ContactActivity_ID=" + activity.getC_ContactActivity_ID());
				}
				Events.postEvent("onRefresh", parent, null);
			}
			else
			{
				Dialog.error(0, "Request Activity not saved");
				return;
			}
		
		if (salesRepField.getValues().size() > 0)
			markSalesRep(activity.getC_ContactActivity_ID(),activity.getAD_User_ID(), salesRepField.getValues());
		
			if(followActivity){
				X_C_ContactActivity activity2 =  new X_C_ContactActivity(Env.getCtx(), 0, null);
				activity2.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
				activity2.setContactActivityType((String) activityTypeField2.getValue());
				activity2.setDescription(txtDescription2.getText());
				activity2.setIsComplete(false);

				activity2.setStartDate(new Timestamp(dbxStartDate2.getValue().getTime()));
				Integer duration = nbxDuration.getValue().intValue();
				Timestamp time = new Timestamp( dbxStartDate2.getValue().getTime() + duration*60000 );
				activity2.setEndDate(time);
				activity2.setComments(txtComments2.getText());
				
				if (bpcontact != null)
				{
					if (bpcontact.getValue() != null)
						activity2.setAD_User_ID((Integer) bpcontact.getValue());
				}
				
				// already create lead
				if(lead_id > 0)
					activity2.setAD_User_ID(lead_id);
				// or existing lead or contact
				else{ 
					if(leadField.getValue() != null)
						activity2.setAD_User_ID((Integer) leadField.getValue());
					else if(contactField.getValue() != null && !"".equals(contactField.getValue()))
						activity2.setAD_User_ID((Integer) contactField.getValue());
					if(salesOpportunityField.getValue() != null)
						activity2.setC_Opportunity_ID((Integer) salesOpportunityField.getValue());
					if (bpartnerField.getValue() != null && !"".equals(bpartnerField.getValue()))
						activity2.setC_BPartner_ID((Integer) bpartnerField.getValue());
				}
				if (activity2.save())
				{
					log.fine("C_ContactActivity_ID=" + activity2.getC_ContactActivity_ID());
				}
				else
				{
					Dialog.error(0,  "Request Follow Activity not saved");
					return;
				}
				
				if (salesRepField.getValues().size() > 0)
					markSalesRep(activity2.getC_ContactActivity_ID(), activity2.getAD_User_ID(),
							salesRepField.getValues());
			}

			if (convertLead)
			{
				Timestamp time = new Timestamp(dbxCloseDate.getValue().getTime());
				ArrayList<ValueNamePair> salesreps = salesRepField.getValues();

				for (ValueNamePair salesrep : salesreps)
				{
					convertLead((Integer) leadField.getValue(), Integer.parseInt(salesrep.getID()),
							(Integer) salesStageField.getValue(), opportunityAmt.getValue(), time,
							opportunityDesc.getValue(), (Integer) currencyField.getValue());
				}
			}

			this.detach();
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
			this.detach();

	}

	public void createOpportunityChanged(){
		if(chbxCreateOpportunity.isSelected()){
			nameRow.appendChild(lblOpportunityDesc);
			nameRow.appendChild(opportunityDesc);
			BPNameRow.appendChild(lblsalesStageField);
			BPNameRow.appendChild(salesStageField.getComponent());
			locationRow.appendChild(lblOpportunityAmt);
			locationRow.appendChild(opportunityAmt);
			positionRow.appendChild(lblCloseDate);
			positionRow.appendChild(dbxCloseDate);
			sourceRow.appendChild(lblCurrency);
			sourceRow.appendChild(currencyField.getComponent());
			specialRow.removeChild(bpartnerField.getComponent());
		}
		else{
			nameRow.removeChild(lblOpportunityDesc);
			nameRow.removeChild(opportunityDesc);
			BPNameRow.removeChild(lblsalesStageField);
			BPNameRow.removeChild(salesStageField.getComponent());
			locationRow.removeChild(lblOpportunityAmt);
			locationRow.removeChild(opportunityAmt);
			positionRow.removeChild(lblCloseDate);
			positionRow.removeChild(dbxCloseDate);
			sourceRow.removeChild(lblCurrency);
			sourceRow.removeChild(currencyField.getComponent());
			specialRow.removeChild(bpartnerField.getComponent());
		}
	}

	public void createLeadChanged(){
		if(chbxCreateLead.isSelected()){
			nameRow.appendChild(lblLeadName);
			nameRow.appendChild(txtName);
			BPNameRow.appendChild(lblJob);
			BPNameRow.appendChild(jobField.getComponent());
			locationRow.appendChild(lblPhone);
			locationRow.appendChild(txtPhone);
			positionRow.appendChild(lblEMail);
			positionRow.appendChild(txtEMail);
			sourceRow.appendChild(lblLeadBPName);
			sourceRow.appendChild(txtBPname);
			specialRow.removeChild(bpartnerField.getComponent());
		}
		else{
			nameRow.removeChild(lblLeadName);
			nameRow.removeChild(txtName);
			BPNameRow.removeChild(lblJob);
			BPNameRow.removeChild(jobField.getComponent());
			locationRow.removeChild(lblPhone);
			locationRow.removeChild(txtPhone);
			positionRow.removeChild(lblEMail);
			positionRow.removeChild(txtEMail);
			sourceRow.removeChild(lblLeadBPName);
			sourceRow.removeChild(txtBPname);
			specialRow.removeChild(bpartnerField.getComponent());
		}

		lblLeadBPName.setVisible(chbxCreateLead.isSelected());			txtBPname.setVisible(chbxCreateLead.isSelected());
		lblLeadName.setVisible(chbxCreateLead.isSelected());			txtName.setVisible(chbxCreateLead.isSelected());
		lblSalesOpportunity.setVisible(!chbxCreateLead.isSelected()); 	salesOpportunityField.setVisible(!chbxCreateLead.isSelected());
		lblLead.setVisible(!chbxCreateLead.isSelected());				leadField.setVisible(!chbxCreateLead.isSelected());
		lblEMail.setVisible(chbxCreateLead.isSelected());				txtEMail.setVisible(chbxCreateLead.isSelected());
		lblPhone.setVisible(chbxCreateLead.isSelected());				txtPhone.setVisible(chbxCreateLead.isSelected());
		lblBPLocation.setVisible(chbxCreateLead.isSelected());			locationField.setVisible(chbxCreateLead.isSelected());
		lblJob.setVisible(chbxCreateLead.isSelected());					jobField.setVisible(chbxCreateLead.isSelected());
		lblLeadSource.setVisible(chbxCreateLead.isSelected());			leadSourceField.setVisible(chbxCreateLead.isSelected());
		lblLeadStatus.setVisible(chbxCreateLead.isSelected());			leadStatusField.setVisible(chbxCreateLead.isSelected());

		if(!chbxCreateLead.isSelected())
			if (activityRelatedTo.getComponent().getSelectedIndex() == 0)
			{
				salesOpportunityField.setValue("");
				contactField.setValue("");
				leadField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(leadField.getComponent());
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				leadField.setVisible(false);
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_SalesOpportunity)){
				specialRow.removeChild(leadField.getComponent());
				leadField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				contactField.setValue("");
				specialRow.appendChild(salesOpportunityField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_Contact)){
				specialRow.removeChild(leadField.getComponent());
				leadField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(salesOpportunityField.getComponent());
				salesOpportunityField.setValue("");
				specialRow.appendChild(contactField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_Lead)){
				salesOpportunityField.setValue("");
				specialRow.removeChild(salesOpportunityField.getComponent());
				contactField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				specialRow.appendChild(leadField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_BusinessPartner))
			{
				salesOpportunityField.setValue("");
				contactField.setValue("");
				leadField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(leadField.getComponent());
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.appendChild(bpartnerField.getComponent());
				bpartnerField.addValueChangeListener(this);
			}
			else
			{
				salesOpportunityField.setValue("");
				contactField.setValue("");
				leadField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(leadField.getComponent());
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				bpartnerField.addValueChangeListener(this);
			}
	}

	public boolean validateEmail(String email){
		// should be null
		if(email == null || email.length()<=0)
			return true;

		String EMAIL_PATTERN = 
				"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
		return email.matches(EMAIL_PATTERN);
	}

	//Check, Start time is not  >=  End time
	private boolean checkTime()
	{
		if(dbxEndDate.getValue() == null)
			return false;

		calBegin = Calendar.getInstance();
		calBegin.setTime(dbxStartDate.getValue());
		Calendar cal1 = Calendar.getInstance();
		cal1.setTimeInMillis(dbxStartDate.getValue().getTime());
		calBegin.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
		calBegin.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
		calBegin.set(Calendar.SECOND, 0);
		calBegin.set(Calendar.MILLISECOND, 0);

		calEnd = Calendar.getInstance();
		calEnd.setTime(dbxEndDate.getValue());
		Calendar cal2 = Calendar.getInstance();
		cal2.setTimeInMillis(dbxEndDate.getValue().getTime());
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


	public boolean convertLead(int Lead_ID, int salesRep_ID, int C_SalesStage_ID, BigDecimal amt, 
			Timestamp ExpectedCloseDate, String desc, int C_Currency_ID){
		// Create instance parameters. I e the parameters you want to send to the process.
		ProcessInfoParameter pi1 = new ProcessInfoParameter("CreateOpportunity", true, "", "", "");
		ProcessInfoParameter pi2 = new ProcessInfoParameter("SalesRep_ID", salesRep_ID, "", "", "");
		ProcessInfoParameter pi3 = new ProcessInfoParameter("C_SalesStage_ID", C_SalesStage_ID, "", "", "");
		ProcessInfoParameter pi4 = new ProcessInfoParameter("OpportunityAmt", amt, "", "", "");
		ProcessInfoParameter pi5 = new ProcessInfoParameter("ExpectedCloseDate", ExpectedCloseDate, "", "", "");
		ProcessInfoParameter pi6 = new ProcessInfoParameter("Description", desc, "", "", "");
		ProcessInfoParameter pi7 = new ProcessInfoParameter("C_Currency_ID", C_Currency_ID, "", "", "");

		// Lookup process in the AD, in this case by value
		MProcess pr = new MProcess(Env.getCtx(), 53276, null);
		
		// Create a process info instance. This is a composite class containing the parameters.
		ProcessInfo pi = new ProcessInfo("", pr.getAD_Process_ID(), MUser.Table_ID, Lead_ID);
		pi.setParameter(new ProcessInfoParameter[] { pi1, pi2, pi3, pi4, pi5, pi6, pi7 });

		// Create process instance (mainly for logging/sync purpose)
		MPInstance mpi = new MPInstance(Env.getCtx(), 0, null);
		mpi.setAD_Process_ID(pr.get_ID()); 
		mpi.setRecord_ID(0);
		mpi.save();

		// Connect the process to the process instance.
		pi.setAD_PInstance_ID(mpi.get_ID());

		log.info("Starting process " + pr.getName());
		if (ServerProcessCtl.process(pi, null) != null)
			return true;
		else
			return false;
	}


	@Override
	public void valueChange(ValueChangeEvent e) {
		if(e.getSource() == activityRelatedTo) {
			if (activityRelatedTo.getComponent().getSelectedIndex() == 0)
			{
				salesOpportunityField.setValue("");
				contactField.setValue("");
				leadField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(leadField.getComponent());
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				leadField.setVisible(false);
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_SalesOpportunity)){
				leadField.setValue("");
				specialRow.removeChild(leadField.getComponent());
				contactField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				specialRow.appendChild(salesOpportunityField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_Contact)){
				leadField.setValue("");
				specialRow.removeChild(leadField.getComponent());
				salesOpportunityField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.removeChild(bpartnerField.getComponent());
				specialRow.appendChild(contactField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_Lead)){
				leadField.setVisible(true);
				salesOpportunityField.setValue("");
				specialRow.removeChild(salesOpportunityField.getComponent());
				contactField.setValue("");
				bpartnerField.setValue("");
				specialRow.removeChild(bpartnerField.getComponent());
				specialRow.removeChild(contactField.getComponent());
				specialRow.appendChild(leadField.getComponent());
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
				{
					bpcontact.setValue("");
					newLeadLabelRow.removeChild(bpcontact.getComponent());
				}
			}
			else if(activityRelatedTo.getValue().equals(X_C_ContactActivity.C_CONTACTACTIVITYRELATEDTO_BusinessPartner))
			{
				salesOpportunityField.setValue("");
				contactField.setValue("");
				leadField.setValue("");
				specialRow.removeChild(contactField.getComponent());
				specialRow.removeChild(leadField.getComponent());
				specialRow.removeChild(salesOpportunityField.getComponent());
				specialRow.appendChild(bpartnerField.getComponent());
				bpartnerField.addValueChangeListener(this);
			}

		}
		else if (e.getSource() == bpartnerField)
		{
			if ((Integer) e.getNewValue() != null)
			{
				if (lblcontact != null)
					newLeadLabelRow.removeChild(lblcontact);
				if (bpcontact != null)
					newLeadLabelRow.removeChild(bpcontact.getComponent());

				try
				{
					int ad_user_id = Env.getContextAsInt(Env.getCtx(), 9999, Env.TAB_INFO, "AD_User_ID");
					if (ad_user_id == 0)
					{
						ad_user_id = DB.getSQLValue(null, "SELECT AD_User_ID FROM AD_USER WHERE C_Bpartner_ID="
								+ (Integer) e.getNewValue());
					}
					MUser user = new MUser(Env.getCtx(), ad_user_id, null);

					MLookup lookup = MLookupFactory.get(Env.getCtx(), 0, COLUMNID_AD_USER_ID, DisplayType.TableDir,
							Env.getLanguage(Env.getCtx()), X_AD_User.COLUMNNAME_AD_User_ID, 0, true, " C_Bpartner_ID="
									+ (Integer) e.getNewValue());
					bpcontact = new WTableDirEditor(X_AD_User.COLUMNNAME_AD_User_ID, false, false, true, lookup);
					for (int i = 0; i < bpcontact.getComponent().getItemCount(); i++)
					{
						if ((Integer) bpcontact.getComponent().getItemAtIndex(i).getValue() == user.getAD_User_ID())
						{
							bpcontact.getComponent().setSelectedIndex(i);
							break;
						}
					}
					newLeadLabelRow.appendChild(lblcontact);
					newLeadLabelRow.appendChild(bpcontact.getComponent());
				}
				catch (Exception ex)
				{
					log.log(Level.SEVERE, "BP Contact not found.");
				}
			}

		}

	}
	
	public void markSalesRep(int C_ContactActivity_ID,int AD_User_ID,ArrayList<ValueNamePair> SalesReps)
	{
		if (SalesReps.size() > 0)
		{
			for (ValueNamePair i : SalesReps)
			{

				if (i.getName().equals("All"))
				{
					ArrayList<X_AD_User> usersList = DPCalendar.getUserList(Env.getCtx(),
							Env.getAD_User_ID(Env.getCtx()));
					for (X_AD_User uType : usersList)
					{
						MContactActivity_Attendees salesrep = new MContactActivity_Attendees(Env.getCtx(), 0, null);
						salesrep.setC_ContactActivity_ID(C_ContactActivity_ID);
						salesrep.setSalesRep_ID(uType.getAD_User_ID());
						try
						{
							salesrep.save();
						}
						catch (Exception e)
						{
							log.log(Level.SEVERE, "Attendees is not saved");
						}
					}

				}
				else
				{
					MContactActivity_Attendees salesrep = new MContactActivity_Attendees(Env.getCtx(), 0, null);
					salesrep.setC_ContactActivity_ID(C_ContactActivity_ID);
					salesrep.setSalesRep_ID(Integer.parseInt(i.getID()));
					try
					{
						salesrep.save();
					}
					catch (Exception e)
					{
						log.log(Level.SEVERE, "Attendees is not saved");
					}
				}
			}
		}
	}
}
