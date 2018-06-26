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
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

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
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRequest;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;

/**
 * 
 * @author Elaine
 *
 */
public class RequestWindow extends Window implements EventListener<Event> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7757368164776005797L;

	private static CLogger log = CLogger.getCLogger(RequestWindow.class);
	
	/** Read Only				*/
	private boolean m_readOnly = false;
	
	private WTableDirEditor requestTypeField, dueTypeField, priorityField, 
		confidentialField, salesRepField, entryConfidentialField;
	private WSearchEditor bpartnerField;
	private Textbox txtSummary;
	private DatetimeBox dbxStartPlan, dbxCompletePlan;
	private ConfirmPanel confirmPanel;
	
	private Window parent;
	private Calendar calBegin,calEnd;
	
	public RequestWindow(CalendarsEvent ce, Window parent) throws Exception {
		
		super();
		
		this.parent = parent;

		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(Env.getCtx(),"NewRequest"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		if (!ThemeManager.isUseCSSForWindowSize()) {
			ZKUpdateUtil.setWindowWidthX(this, 400);
			ZKUpdateUtil.setWindowHeightX(this, 550);
		} else {
			addCallback(AFTER_PAGE_ATTACHED, t -> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setSclass("popup-dialog request-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);
		
		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), 
				MRequest.Table_ID, 0, false);

		Label lblDueType           = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_DueType));
		Label lblRequestType       = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_R_RequestType_ID));
		Label lblPriority          = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_Priority));
		Label lblSummary           = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_Summary));
		Label lblConfidential      = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_ConfidentialType));
		Label lblSalesRep          = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_SalesRep_ID));
		Label lblEntryConfidential = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_ConfidentialTypeEntry));
		Label lblStartPlan         = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_DateStartPlan));
		Label lblCompletePlan      = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_DateCompletePlan));
		Label lblBPartner		   = new Label(Msg.getElement(ctx, MRequest.COLUMNNAME_C_BPartner_ID));

		int columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_DueType);
		MLookup lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		dueTypeField = new WTableDirEditor("DueType", true, false, true, lookup);
		dueTypeField.setValue(Env.getContext(ctx, "P232|DueType"));
		if(dueTypeField.getValue() == null || dueTypeField.getValue().equals(""))
			if(dueTypeField.getComponent().getItemCount() > 1)
				dueTypeField.setValue(dueTypeField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_C_BPartner_ID);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.TableDir);
		bpartnerField = new WSearchEditor("C_BPartner_ID", true, false, true, lookup);
		// if(bpartnerField.getValue() == null ||
		// bpartnerField.getValue().equals(""))
		// if(bpartnerField.getComponent().getText() != null)
		// bpartnerField.setValue(bpartnerField.getComponent().getText());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_R_RequestType_ID);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.TableDir);
		requestTypeField = new WTableDirEditor("R_RequestType_ID", true, false, true, lookup);
		requestTypeField.setValue(Env.getContext(ctx, "P232|R_RequestType_ID"));
		if(requestTypeField.getValue() == null || requestTypeField.getValue().equals(""))
			if(requestTypeField.getComponent().getItemCount() > 1)
				requestTypeField.setValue(requestTypeField.getComponent().getItemAtIndex(1).getValue());
				
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_Priority);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		priorityField = new WTableDirEditor("Priority", true, false, true, lookup);
		priorityField.setValue(Env.getContext(ctx, "P232|Priority"));
		if(priorityField.getValue() == null || priorityField.getValue().equals(""))
			if(priorityField.getComponent().getItemCount() > 1)
				priorityField.setValue(priorityField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_ConfidentialType);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		confidentialField = new WTableDirEditor("ConfidentialType", true, false, true, lookup);
		confidentialField.setValue(Env.getContext(ctx, "P232|ConfidentialType"));
		if(confidentialField.getValue() == null || confidentialField.getValue().equals(""))
			if(confidentialField.getComponent().getItemCount() > 1)
				confidentialField.setValue(confidentialField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_SalesRep_ID);
		lookup = MLookupFactory
				.get(ctx, 0, columnID, DisplayType.TableDir, Env.getLanguage(Env.getCtx()),
						MRequest.COLUMNNAME_AD_User_ID, 0, true,
						" EXISTS (SELECT * FROM C_BPartner bp WHERE AD_User.C_BPartner_ID=bp.C_BPartner_ID AND bp.IsSalesRep='Y') ");
		salesRepField = new WTableDirEditor(MRequest.COLUMNNAME_SalesRep_ID, true, false, true, lookup);
		salesRepField.setValue(Env.getContextAsInt(ctx, MRequest.COLUMNNAME_SalesRep_ID));
		if (salesRepField.getValue() == null || salesRepField.getValue().equals(0))
			if (salesRepField.getComponent().getItemCount() > 1)
				salesRepField.setValue(salesRepField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_ConfidentialTypeEntry);
		lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.List);
		entryConfidentialField = new WTableDirEditor("ConfidentialTypeEntry", true, false, true, lookup);
		entryConfidentialField.setValue(Env.getContext(ctx, "P232|ConfidentialTypeEntry"));
		if(entryConfidentialField.getValue() == null || entryConfidentialField.getValue().equals(""))
			if(entryConfidentialField.getComponent().getItemCount() > 1)
				entryConfidentialField.setValue(entryConfidentialField.getComponent().getItemAtIndex(1).getValue());
		
		txtSummary = new Textbox();
		txtSummary.setMultiline(true);
		ZKUpdateUtil.setWidth(txtSummary, "95%");
		ZKUpdateUtil.setHeight(txtSummary, "100%");
		txtSummary.setRows(3);
		
		dbxStartPlan = new DatetimeBox();
		dbxCompletePlan = new DatetimeBox();
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		
		
		Grid grid = GridFactory.newGridLayout();
		
		Columns columns = new Columns();
		grid.appendChild(columns);
		columns.setVflex("1");
		
		Column column = new Column();
		column.setWidth("35%");
		columns.appendChild(column);
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("65%");
		
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblBPartner.rightAlign());
		row.appendChild(bpartnerField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDueType.rightAlign());
		row.appendChild(dueTypeField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblRequestType.rightAlign());
		row.appendChild(requestTypeField.getComponent());
		
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblPriority.rightAlign());
		row.appendChild(priorityField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblSummary.rightAlign());
		row.appendChild(txtSummary);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblConfidential.rightAlign());
		row.appendChild(confidentialField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblSalesRep.rightAlign());
		row.appendChild(salesRepField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEntryConfidential.rightAlign());
		row.appendChild(entryConfidentialField.getComponent());
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblStartPlan.rightAlign());
		row.appendChild(dbxStartPlan);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblCompletePlan.rightAlign());
		row.appendChild(dbxCompletePlan);
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		
		centerPane.appendChild(grid);
		ZKUpdateUtil.setVflex(grid, "min");
		ZKUpdateUtil.setHflex(grid, "1");
		ZKUpdateUtil.setVflex(centerPane, "min");
		grid.setHeight("400px");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		dbxStartPlan.getTimebox().setFormat(DPCalendar.getTimeFormat());
		dbxCompletePlan.getTimebox().setFormat(DPCalendar.getTimeFormat());

		dbxStartPlan.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getStartTimeHour()));
		dbxCompletePlan.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getEndTimeHour()));
	}
	
	public void onEvent(Event e) throws Exception {
		if (m_readOnly)
			this.detach();
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			// Check Mandatory fields
			String fillMandatory = Msg.translate(Env.getCtx(), "FillMandatory");
			fillMandatory = fillMandatory.replaceAll(":", "");
			if (bpartnerField.getValue() == null || bpartnerField.getValue().equals(""))
				throw new WrongValueException(bpartnerField.getComponent(), fillMandatory);
			if (dueTypeField.getValue() == null || dueTypeField.getValue().equals(""))
				throw new WrongValueException(dueTypeField.getComponent(), fillMandatory);
			if (requestTypeField.getValue() == null || requestTypeField.getValue().equals(0))
				throw new WrongValueException(requestTypeField.getComponent(), fillMandatory);
			if (priorityField.getValue() == null || priorityField.getValue().equals(""))
				throw new WrongValueException(priorityField.getComponent(), fillMandatory);
			if (txtSummary.getText() == null || txtSummary.getText().equals(""))
				throw new WrongValueException(txtSummary, fillMandatory);
			if (confidentialField.getValue() == null || confidentialField.getValue().equals(""))
				throw new WrongValueException(confidentialField.getComponent(), fillMandatory);
			if (salesRepField.getValue() == null || salesRepField.getValue().equals(0))
				throw new WrongValueException(salesRepField.getComponent(), fillMandatory);
			if (entryConfidentialField.getValue() == null || entryConfidentialField.getValue().equals(""))
				throw new WrongValueException(entryConfidentialField.getComponent(), fillMandatory);
			if (dbxStartPlan.getValue().compareTo(dbxCompletePlan.getValue()) > 0) 
				throw new WrongValueException(dbxCompletePlan, Msg.translate(Env.getCtx(), "DateCompletePlan"));	
			
			calBegin = Calendar.getInstance();
			calBegin.setTime(dbxStartPlan.getValue());
			calBegin.set(Calendar.SECOND, 0);
			calBegin.set(Calendar.MILLISECOND, 0);

			calEnd = Calendar.getInstance();
			calEnd.setTime(dbxCompletePlan.getValue());
			calEnd.set(Calendar.SECOND, 0);
			calEnd.set(Calendar.MILLISECOND, 0);
			
			MRequest request = (MRequest) MTable.get(Env.getCtx(), MRequest.Table_ID).getPO(0, null);
			request.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
			request.setDueType((String) dueTypeField.getValue());
			request.setR_RequestType_ID((Integer) requestTypeField.getValue());
			request.setPriority((String) priorityField.getValue());
			request.setSummary(txtSummary.getText());
			request.setConfidentialType((String) confidentialField.getValue());
			request.setSalesRep_ID((Integer) salesRepField.getValue());
			request.setConfidentialTypeEntry((String) entryConfidentialField.getValue());
			request.setDateStartPlan(new Timestamp(calBegin.getTimeInMillis()));
			request.setDateCompletePlan(new Timestamp(calEnd.getTimeInMillis()));
			
			if (bpartnerField.getValue() != null && !Util.isEmpty(bpartnerField.getValue().toString(), true))
				request.setC_BPartner_ID((Integer) bpartnerField.getValue());
			
			if (request.save())
			{
				if (log.isLoggable(Level.FINE)) log.fine("R_Request_ID=" + request.getR_Request_ID());
				//Events.postEvent("onRefresh", parent, null);
//				Events.echoEvent("onRefresh", parent, null);
			}
			else
			{
				FDialog.error(0, this, "Request record not saved");
				return;
			}
			
			this.detach();
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
			this.detach();
	}
	

}
