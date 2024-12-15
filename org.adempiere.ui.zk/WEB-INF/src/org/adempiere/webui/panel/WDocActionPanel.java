/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.sql.Timestamp;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MBankStatement;
import org.compiere.model.MClientInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPeriod;
import org.compiere.model.MProduction;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWFResponsible;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;



public class WDocActionPanel extends Window implements EventListener<Event>, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2166149559040327486L;

	private Label lblDocAction;
	private Label label;
	private Label lblDateAcct;

	/** Window No */
	private int m_WindowNo = 0;

	private WSearchEditor fApprover = null;
	private Label lblUser;

	private Label lblAnswer;
	private Listbox lstAnswer;
	private Label lTextMsg = new Label(Msg.getMsg(Env.getCtx(), "Messages"));
	private Textbox fTextMsg = new Textbox();
	
	private Listbox lstDocAction;
	private Datebox dbDateAcct;
	private Row rowDateAcct = new Row();

	private GridTab gridTab;
	private String[]		s_value = null;
	private String[]		s_name;
	private String[]		s_description;
	private String DocStatus;
	private String DocAction;
	private int m_AD_Table_ID;
	private boolean m_OKpressed;
	private boolean isAllowSetDateAcct;
    private ConfirmPanel confirmPanel;

	/** Current Activity */
	private MWFActivity m_activity = null;

	/** Current WF Process */
	private MWFProcess m_WFProcess = null;

	/** Current User */
	private int m_AD_User_ID = 0;

	/** Current Workflow Responsible */
	private MWFResponsible resp = null;

	/** Set Column */
	private MColumn m_column = null;

	/** Current Role */
	private int m_AD_Role_ID = 0;

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(WDocActionPanel.class);
    }

	public WDocActionPanel(GridTab mgridTab)
	{
		gridTab = mgridTab;
		DocStatus = (String)gridTab.getValue("DocStatus");
		DocAction = (String)gridTab.getValue("DocAction");

		m_AD_Table_ID = mgridTab.getAD_Table_ID();

		m_AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		m_AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());

		loadActivity();
		if (!isValidApprover()) {
			
			StringBuilder msg = new StringBuilder("Assigned to "); //TODO use Message to support translation

			if (resp.isRole())
			{
				msg.append(resp.getRole().getName());
			}
			else if (resp.isHuman())
			{
				msg.append(resp.getAD_User().getName());
			}
			else
			{
				msg.append(m_activity.getAD_User().getName());
			}
			
			// If Activity already suspended then show error
			FDialog.error(gridTab.getWindowNo(), this, msg.toString(), m_activity.toStringX());
			return;
		}
		readReference();
		initComponents();
		dynInit();

		init();
	}

	/**
	 *	Dynamic Init - determine valid DocActions based on DocStatus for the different documents.
	 */
	private void dynInit()
	{

		//
		Object Processing = gridTab.getValue("Processing");
		String OrderType = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "OrderType");
		String IsSOTrx = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx");

		if (DocStatus == null)
		{
			//message.setText("*** ERROR ***");
			return;
		}

		if (logger.isLoggable(Level.FINE)) logger.fine("DocStatus=" + DocStatus
			+ ", DocAction=" + DocAction + ", OrderType=" + OrderType
			+ ", IsSOTrx=" + IsSOTrx + ", Processing=" + Processing
			+ ", AD_Table_ID=" +gridTab.getAD_Table_ID() + ", Record_ID=" + gridTab.getRecord_ID());
        int index = 0;
        if(lstDocAction!=null && lstDocAction.getSelectedItem() != null)
        {
            String selected = (lstDocAction.getSelectedItem().getValue()).toString();

            for(int i = 0; i < s_value.length && index == 0; i++)
            {
                if(s_value[i].equals(selected))
                {
                    index = i;
                }
            }
        }

		String[] options = new String[s_value.length];
		/**
		 * 	Check Existence of Workflow Acrivities
		 */
		String wfStatus = MWFActivity.getActiveInfo(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID());
		if (wfStatus != null)
		{
			FDialog.error(gridTab.getWindowNo(), this, "WFActiveForRecord", wfStatus);
			return;
		}

		//	Status Change
		if (!checkStatus(gridTab.getTableName(), gridTab.getRecord_ID(), DocStatus))
		{
			FDialog.error(gridTab.getWindowNo(), this, "DocumentStatusChanged");
			return;
		}
		/*******************
		 *  General Actions
		 */

		MTable table = MTable.get(Env.getCtx(), m_AD_Table_ID);
		PO po = table.getPO(gridTab.getRecord_ID(), null);
		boolean periodOpen = true;
		if (po instanceof DocAction)
			periodOpen = MPeriod.isOpen(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), null);

		String[] docActionHolder = new String[]{DocAction};
		index = DocumentEngine.getValidActions(DocStatus, Processing, OrderType, IsSOTrx,
				m_AD_Table_ID, docActionHolder, options, periodOpen, po);

		Integer doctypeId = (Integer)gridTab.getValue("C_DocTypeTarget_ID");
		if(doctypeId==null || doctypeId.intValue()==0){
			doctypeId = (Integer)gridTab.getValue("C_DocType_ID");
		}
		if (doctypeId == null && MAllocationHdr.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_PaymentAllocation);
		}
		if (doctypeId == null && MBankStatement.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_BankStatement);
		}
		if (doctypeId == null && MProduction.Table_ID == m_AD_Table_ID) {
			doctypeId = MDocType.getDocType(MDocType.DOCBASETYPE_MaterialProduction);
		}
		if (logger.isLoggable(Level.FINE)) logger.fine("get doctype: " + doctypeId);
		if (doctypeId != null && (m_activity==null || !m_activity.getNode().isUserApproval())) {
			index = DocumentEngine.checkActionAccess(Env.getAD_Client_ID(Env.getCtx()),
					Env.getAD_Role_ID(Env.getCtx()),
					doctypeId, options, index);
		}

		DocAction = docActionHolder[0];

		/**
		 *	Fill actionCombo
		 */

		boolean firstadded = true;
		for (int i = 0; i < index; i++)
		{
			//	Search for option and add it
			boolean added = false;

			for (int j = 0; j < s_value.length && !added; j++)
			{
				if (options[i].equals(s_value[j]))
				{
					Listitem newitem = lstDocAction.appendItem(s_name[j],s_value[j]);
					if (firstadded) {
						// select by default the first added item - can be changed below
						lstDocAction.setSelectedItem(newitem);
						firstadded = false;
					}
					added = true;
				}
			}
		}
		// look if the current DocAction is within the list and assign it as selected if it exists
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst)
		{
			String value = item.getValue().toString();

			if(DocAction.equals(value))
			{
				lstDocAction.setSelectedItem(item);
				label.setValue(s_description[getSelectedIndex()]);
			}
		}
		//	setDefault
		if (DocAction.equals("--"))		//	If None, suggest closing
			DocAction = DocumentEngine.ACTION_Close;

		int C_DocType_ID = po.get_ValueAsInt("C_DocType_ID");
		if (C_DocType_ID > 0)
			isAllowSetDateAcct = MDocType.get(po.getCtx(), C_DocType_ID).isRADateSelectable();

		//
		setDateAcctVisible(DocAction.equals(DocumentEngine.ACTION_Reverse_Accrual) && isAllowSetDateAcct);
	}

	public List<Listitem> getDocActionItems() {
		return (List<Listitem>)lstDocAction.getItems();
	}
	
	private boolean checkStatus (String TableName, int Record_ID, String DocStatus)
	{
		String sql = "SELECT 2 FROM " + TableName
			+ " WHERE " + TableName + "_ID=" + Record_ID
			+ " AND DocStatus='" + DocStatus + "'";
		int result = DB.getSQLValue(null, sql);
		return result == 2;
	}

	private void initComponents()
	{
		lblDocAction = new Label();
		lblDocAction.setValue(Msg.translate(Env.getCtx(), "DocAction"));

		lblDateAcct = new Label();
		lblDateAcct.setValue(Msg.translate(Env.getCtx(), "DateAcct"));

		label = new Label();

		lstDocAction  = new Listbox();
		lstDocAction.setId("lstDocAction");
		lstDocAction.setRows(0);
		lstDocAction.setMold("select");
		ZKUpdateUtil.setWidth(lstDocAction, "200px");
		lstDocAction.addEventListener(Events.ON_SELECT, this);

		dbDateAcct = new Datebox();
		dbDateAcct.setId("dbDateAcct");
		dbDateAcct.setValue(Env.getContextAsDate(Env.getCtx(), "#Date"));

		lblUser = new Label("Approver");
		MLookup lookup = MLookupFactory.get(Env.getCtx(), m_WindowNo, 0, 10443,
				DisplayType.Search);
		fApprover = new WSearchEditor(lookup,
				Msg.translate(Env.getCtx(), "AD_User_ID"), "", true, false,
				true);

		lblAnswer = new Label(Msg.getMsg(Env.getCtx(), "Answer"));
		lstAnswer = new Listbox();
		lstAnswer.setRows(0);
		lstAnswer.setMold("select");
		ZKUpdateUtil.setWidth(lstAnswer, "100%");
		lstAnswer.appendItem("", "");
		lstAnswer.appendItem("Yes", "Y");
		lstAnswer.appendItem("No", "N");
		lstAnswer.addEventListener(Events.ON_SELECT, this);

		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		ZKUpdateUtil.setVflex(confirmPanel, "true");
	}

	private void init()
	{
		setSclass("popup-dialog doc-action-dialog");
		Vlayout vlayout = new Vlayout();
		ZKUpdateUtil.setHflex(vlayout, "1");
		this.appendChild(vlayout);
		
		setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "documentAction");
		Grid grid = GridFactory.newGridLayout();
        grid.setStyle("background-image: none;");
        LayoutUtils.addSclass("dialog-content", grid);
        vlayout.appendChild(grid);

        Rows rows = new Rows();
        grid.appendChild(rows);

		Row rowDocAction = new Row();
		Row rowLabel = new Row();
		Row rowSpacer = new Row();
		Row rowUser = new Row();
		Row rowAnswer = new Row();
		Row rowTxtMsg = new Row();

		Panel pnlDocAction = new Panel();
		pnlDocAction.appendChild(lblDocAction);
		pnlDocAction.appendChild(new Space());
		pnlDocAction.appendChild(lstDocAction);

		rowDocAction.appendChild(pnlDocAction);
		
		// Approver User
		rowUser.appendCellChild(lblUser, 1);
		rowUser.appendChild(fApprover.getComponent());
		rowUser.appendCellChild(new Space());

		// Answer
		rowAnswer.appendCellChild(lblAnswer);
		rowAnswer.appendCellChild(lstAnswer);
		rowAnswer.appendCellChild(new Space());
		
		//Text Msg
		rowTxtMsg.appendCellChild(lTextMsg);
		rowTxtMsg.appendCellChild(fTextMsg);
		rowTxtMsg.appendCellChild(new Space());
		ZKUpdateUtil.setHflex(fTextMsg, "true");
		fTextMsg.setMultiline(true);
		ZKUpdateUtil.setWidth(fTextMsg, "100%");
		
		Space space = new Space();
		space.setSpacing("30px");
		
		Panel pnlDateAcct = new Panel();
		pnlDateAcct.appendChild(lblDateAcct);
		pnlDateAcct.appendChild(space);
		pnlDateAcct.appendChild(dbDateAcct);

		rowDateAcct.appendChild(pnlDateAcct);

		rowLabel.appendChild(label);
		rowSpacer.appendChild(new Space());

		rows.appendChild(rowDocAction);
		rows.appendChild(rowDateAcct);
		rows.appendChild(rowLabel);
		rows.appendChild(rowSpacer);

		if (m_activity != null && (m_activity.isUserApproval() || m_activity.isUserTask())) {
			if (m_activity.isUserApproval()) {
				rows.appendChild(rowAnswer);
			}
			rows.appendChild(rowTxtMsg);
			
			// Removing Document Action if Activity found
			rows.removeChild(rowDocAction);
			rows.removeChild(rowDateAcct);
			rows.removeChild(rowLabel);
			rows.removeChild(rowSpacer);
		}

		Div footer = new Div();
		footer.setSclass("dialog-footer");
		vlayout.appendChild(footer);
		footer.appendChild(confirmPanel);
		ZKUpdateUtil.setVflex(confirmPanel, "min");

		this.setTitle(Msg.translate(Env.getCtx(), "DocAction"));
		if (!ThemeManager.isUseCSSForWindowSize())
			ZKUpdateUtil.setWindowWidthX(this, 410);
		this.setBorder("normal");
		this.setZindex(1000);
	}

	/**
	 *	Should the process be started?
	 *  @return OK pressed
	 */
	public boolean isStartProcess()
	{
		return m_OKpressed;
	}	//	isStartProcess

	public void onEvent(Event event)
	{

		String eventName = event.getName();

		if (Events.ON_CLICK.equals(eventName))
		{
			if (confirmPanel.getButton("Ok").equals(event.getTarget()))
			{
				onOk(event, null);
			}
			else if (confirmPanel.getButton("Cancel").equals(event.getTarget()))
			{
				m_OKpressed = false;
				this.detach();
			}
		}
		else if (Events.ON_SELECT.equals(eventName))
		{

			if (lstDocAction.equals(event.getTarget()))
			{
				label.setValue(s_description[getSelectedIndex()]);
				setDateAcctVisible(s_value[getSelectedIndex()].equals(DocumentEngine.ACTION_Reverse_Accrual) && isAllowSetDateAcct);
			}
		}
	}

	public void setSelectedItem(String value) {
		lstDocAction.setSelectedIndex(-1);
		List<Listitem> lst = (List<Listitem>)lstDocAction.getItems();
		for(Listitem item: lst) {
			if (value.equals(item.getValue())) {
				item.setSelected(true);
				break;
			}
		}
	}

	public void onOk(Event event, final Callback<Boolean> callback)
	{
		if ((lstAnswer.getSelectedItem() != null && lstAnswer.getSelectedItem().getValue() != null) || (m_activity != null && m_activity.isUserTask()))
		{
			Trx trx = null;
			try
			{
				trx = Trx.get(Trx.createTrxName("FWFA"), true);
				trx.setDisplayName(getClass().getName() + "_onOK");
				m_activity.set_TrxName(trx.getTrxName());

				MWFNode node = m_activity.getNode();
				String textMsg = fTextMsg.getValue();
				
				if (MWFNode.ACTION_UserChoice.equals(node.getAction()))
				{
					// getting Approval column for User Choice node
					if (m_column == null)
						m_column = (MColumn) node.getApprovalColumn();

					if (m_column == null || node.getApprovalColumn_ID() <= 0)
						m_column = node.getColumn();

					int dt = m_column.getAD_Reference_ID();

					String value = null;

					if (dt == DisplayType.YesNo || dt == DisplayType.List)
					{
						Listitem li = lstAnswer.getSelectedItem();

						if (li != null)
							value = li.getValue().toString();
					}

					if (value == null || value.length() == 0)
					{
						trx.rollback();
						trx.close();
						FDialog.error(m_WindowNo, this, "FillMandatory", Msg.getMsg(Env.getCtx(), "Answer"));
						if (callback != null)
							callback.onCallback(false);
						return;
					}
					
					//
					if (logger.isLoggable(Level.CONFIG))
						logger.config("Answer=" + value + " - " + textMsg);

					try
					{
						m_activity.setUserChoice(m_AD_User_ID, value, dt, textMsg);

						String error = m_activity.getAD_WF_Process().getTextMsg();

						if (error != null && !Util.isEmpty(error))
						{
							FDialog.error(0, error);
						}
					}
					catch (Exception e)
					{
						logger.log(Level.SEVERE, node.getName(), e);
						FDialog.error(m_WindowNo, this, "Error", e.toString());
						trx.rollback();
						trx.close();
						if (callback != null)
							callback.onCallback(false);
						return;
					}
				}else {
					if (logger.isLoggable(Level.CONFIG)) logger.config("Action=" + node.getAction() + " - " + textMsg);
					try
					{
						// ensure activity is ran within a transaction
						m_activity.setUserConfirmation(m_AD_User_ID, textMsg);
					}
					catch (Exception e)
					{
						logger.log(Level.SEVERE, node.getName(), e);
						FDialog.error(m_WindowNo, this, "Error", e.toString());
						trx.rollback();
						trx.close();
						return;
					}
				}
				trx.commit();
				if(callback!=null)
					callback.onCallback(true);

			}
			finally
			{
				Clients.clearBusy();
				if (trx != null)
					trx.close();
			}

			detach();
			gridTab.dataRefresh();
		}
		else
		{
			onOk(null);
		}

	}

	public void onOk(final Callback<Boolean> callback)
	{
		MClientInfo clientInfo = MClientInfo.get(Env.getCtx());
		if((clientInfo.isConfirmOnDocClose() || clientInfo.isConfirmOnDocVoid()) && lstDocAction.getSelectedItem() != null)
		{
			String selected = lstDocAction.getSelectedItem().getValue().toString();
			if((selected.equals(org.compiere.process.DocAction.ACTION_Close) && clientInfo.isConfirmOnDocClose())  
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Void) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Accrual) && clientInfo.isConfirmOnDocVoid())
				|| (selected.equals(org.compiere.process.DocAction.ACTION_Reverse_Correct) && clientInfo.isConfirmOnDocVoid()))
			{
				String docAction = lstDocAction.getSelectedItem().getLabel();
				MessageFormat mf = new MessageFormat(Msg.getMsg(Env.getAD_Language(Env.getCtx()), "ConfirmOnDocAction"));
				Object[] arguments = new Object[]{docAction};
				FDialog.ask(0, this, mf.format(arguments), new Callback<Boolean>() {
					@Override
					public void onCallback(Boolean result) {
						if(result)
						{
							setValueAndClose();
							if (callback != null)
								callback.onCallback(Boolean.TRUE);
						}
						else
						{
							if (callback != null)
								callback.onCallback(Boolean.FALSE);
							return;
						}
					}
				});
			}
			else
			{
				setValueAndClose();
				if (callback != null)
					callback.onCallback(Boolean.TRUE);
			}
		}
		else
		{
			setValueAndClose();
			if (callback != null)
				callback.onCallback(Boolean.TRUE);
		}		
	}

	private void setValueAndClose() {
		String statusSql = "SELECT DocStatus FROM " + gridTab.getTableName() 
				+ " WHERE " + gridTab.getKeyColumnName() + " = ? ";
		String currentStatus = DB.getSQLValueString((String)null, statusSql, gridTab.getKeyID(gridTab.getCurrentRow()));
		if (DocStatus != null && !DocStatus.equals(currentStatus)) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "DocStatusChanged"));
		}
		m_OKpressed = true;
		setValue();
		detach();
	}

	private void setValue()
	{
		int index = getSelectedIndex();
		//	Save Selection
		if (logger.isLoggable(Level.CONFIG)) logger.config("DocAction=" + s_value[index]);
		gridTab.setValue("DocAction", s_value[index]);

		if (s_value[index].equals(DocumentEngine.ACTION_Reverse_Accrual) && isAllowSetDateAcct)
		{
			// User selectable accounting date based on DocType set to global context
			Env.setContext(Env.getCtx(), "#RA_DateAcct_" + gridTab.getAD_Table_ID() + "_" + gridTab.getRecord_ID(), new Timestamp(dbDateAcct.getValue().getTime()));
		}
	}	//	save

	 private void readReference()
	 {
	        ArrayList<String> v_value = new ArrayList<String>();
    		ArrayList<String> v_name = new ArrayList<String>();
    		ArrayList<String> v_description = new ArrayList<String>();

    		DocumentEngine.readReferenceList(v_value, v_name, v_description);

	    	int size = v_value.size();
			s_value = new String[size];
			s_name = new String[size];
			s_description = new String[size];

			for (int i = 0; i < size; i++)
			{
				s_value[i] = (String)v_value.get(i);
				s_name[i] = (String)v_name.get(i);
				s_description[i] = (String)v_description.get(i);
			}
	 }   //  readReference

	 public int getSelectedIndex()
	 {
		int index = 0;
		if(lstDocAction.getSelectedItem() != null)
		{
			String selected = (lstDocAction.getSelectedItem().getValue()).toString();

			for(int i = 0; i < s_value.length && index == 0; i++)
			{
				if(s_value[i].equals(selected))
				{
					index = i;
                    break;
				}
			}
		}
		return index;
	}	//	getSelectedIndex

	public int getNumberOfOptions() {
		return lstDocAction != null ? lstDocAction.getItemCount() : 0;
	}

	private void setDateAcctVisible(boolean isVisible)
	{
		rowDateAcct.setVisible(isVisible);
		dbDateAcct.setVisible(isVisible);
		lblDateAcct.setVisible(isVisible);
	} // setDateAcctVisibile

	private void loadActivity()
	{
		MWFActivity[] acts = MWFActivity.get(Env.getCtx(), m_AD_Table_ID, gridTab.getRecord_ID(), true);
		//TODO what if multiple activities
		for (int i = 0; i < acts.length; i++)
		{
			m_activity = acts[i];
		}

		if (m_activity != null && MWFActivity.WFSTATE_Suspended.equals(m_activity.getWFState()))
		{
			m_WFProcess = (MWFProcess) m_activity.getAD_WF_Process();
			
			int AD_WF_Resp_ID = m_activity.getAD_WF_Responsible_ID();

			MWFResponsible ovrResp = MWFResponsible.getClientWFResp(Env.getCtx(), AD_WF_Resp_ID);
			
			if (ovrResp != null)
				resp = ovrResp;
			else
				resp = m_activity.getResponsible();
		}
	}

	private boolean isValidApprover()
	{
		if (resp != null && m_activity != null)
		{
			String respType = resp.getResponsibleType();

			// Current User is not Approver and Approval type is manual
			if (MWFResponsible.RESPONSIBLETYPE_Manual.equals(respType))
			{
				// If Approver is not assign then check current user is invoker
				if (m_activity.getAD_User_ID() <= 0 && m_WFProcess.getAD_User_ID() != m_AD_User_ID)
				{
					return false;
				}

				// If Approver is assign then check current user is not Approver
				if (m_activity.getAD_User_ID() > 0 && m_AD_User_ID != m_activity.getAD_User_ID())
				{
					return false;
				}

				return true;
			}
			else
			{
				// Current User Role is not Approval Role
				if (MWFResponsible.RESPONSIBLETYPE_Role.equals(respType) && m_AD_Role_ID != resp.getAD_Role_ID())
				{
					return false;
				}
			}
		}
		return true;
	}

	public boolean isApprover()
	{
		return (m_activity != null && m_AD_User_ID == m_activity.getAD_User_ID())
				|| (resp != null && m_AD_Role_ID == resp.getAD_Role_ID())
				|| (resp != null && resp.isHuman() && resp.getAD_User_ID()==0);
	}
}
