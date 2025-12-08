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
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.concurrent.Future;
import java.util.logging.Level;
import java.util.stream.Collectors;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.WFNodeVarForm;
import org.adempiere.webui.apps.DesktopRunnable;
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
import org.adempiere.webui.util.ZkContextRunnable;
import org.adempiere.webui.window.Dialog;
import org.compiere.Adempiere;
import org.compiere.model.GridTab;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MClientInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPeriod;
import org.compiere.model.MProcess;
import org.compiere.model.MRefList;
import org.compiere.model.MTable;
import org.compiere.model.MWFActivityApprover;
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
import org.compiere.util.ValueNamePair;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeVar;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWFResponsible;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 * Document action dialog
 */
public class WDocActionPanel extends Window implements EventListener<Event>, DialogEvents
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3218367479851088526L;

	/** Event to fire on complete of execution of doc action **/
	private static final String		ON_COMPLETE_EVENT	= "onComplete";

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
	
	/** Current process */
	private int						m_Process_ID		= 0;

	/** Current Workflow Responsible */
	private MWFResponsible resp = null;

	/** Set Column */
	private MColumn m_column = null;

	/** Current Role */
	private int m_AD_Role_ID = 0;

	/** Reference to docAction thread/task **/
	private Future <?>				future;
	
	private WFNodeVarForm			nodeVarForm;
	
	private Map <Integer, String>	valMap;

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(WDocActionPanel.class);
    }

    /**
     * @param mgridTab
     */
	public WDocActionPanel(GridTab mgridTab)
	{
		this(mgridTab, false, 0);
	}

	/**
	 * @param mgridTab
	 * @param fromMenu
	 */
	public WDocActionPanel(GridTab mgridTab, boolean fromMenu)
	{
		this(mgridTab, fromMenu, 0);
	}

    /**
     * @param mgridTab
     * @param process_ID 
     */
	public WDocActionPanel(GridTab mgridTab, int process_ID)
	{
		this(mgridTab, false, process_ID);
	}

	/**
	 * @param mgridTab
	 * @param fromMenu
	 */
	public WDocActionPanel(GridTab mgridTab, boolean fromMenu, int process_ID)
	{
		gridTab = mgridTab;
		DocStatus = (String)gridTab.getValue("DocStatus");
		DocAction = (String)gridTab.getValue("DocAction");
		m_Process_ID = process_ID;
		m_AD_Table_ID = mgridTab.getAD_Table_ID();

		m_AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		m_AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());

		loadActivity();
		if (!isValidApprover()) {
			
			StringBuilder msg = new StringBuilder(Msg.getMsg(Env.getCtx(), "AssignedToState", new Object[] { m_activity.getWFStateText(), m_activity.getNode().getName() }));
			if (resp.isRole())
			{
				msg.append(resp.getRole().getName());
			}
			else if (resp.isManual())
			{
				MWFActivityApprover[] approvers = MWFActivityApprover.getOfActivity(m_activity.getCtx(), m_activity.getAD_WF_Activity_ID(), m_activity.get_TrxName());
				String approverNames = Arrays.stream(approvers).map(a -> a.getAD_User().getName()).collect(Collectors.joining(", "));
				msg.append(approverNames);
			}
			// if activity has use then he as priority then responsible user
			else if(m_activity.getAD_User_ID() > 0 )
			{
				msg.append(m_activity.getAD_User().getName());
			}
			else if (resp.isHuman())
			{
				msg.append(resp.getAD_User().getName());
			}
			// If Activity already suspended then show error
			Dialog.error(gridTab.getWindowNo(), msg.toString(), m_activity.toStringX());
			return;
		}
		readReference();
		initComponents();
		dynInit(fromMenu);

		init();
	}

	/**
	 * Dynamic Init - determine valid DocActions based on DocStatus for the different documents.
	 * @param fromMenu 
	 */
	private void dynInit(boolean fromMenu)
	{
		//
		Object Processing = gridTab.getValue("Processing");
		String OrderType = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "OrderType");
		String IsSOTrx = Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx");

		if (DocStatus == null)
		{
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
			if (! fromMenu)
				Dialog.error(gridTab.getWindowNo(), "WFActiveForRecord", wfStatus);
			return;
		}

		//	Status Change
		if (!checkStatus(gridTab.getTableName(), gridTab.getRecord_ID(), DocStatus))
		{
			Dialog.error(gridTab.getWindowNo(), "DocumentStatusChanged");
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

	/**
	 * @return available document action items
	 */
	public List<Listitem> getDocActionItems() {
		return lstDocAction == null ? new ArrayList <Listitem>()  : (List<Listitem>)lstDocAction.getItems();
	}
	
	/**
	 * @param TableName
	 * @param Record_ID
	 * @param DocStatus
	 * @return true if DocStatus match DocStatus from DB
	 */
	private boolean checkStatus (String TableName, int Record_ID, String DocStatus)
	{
		String sql = "SELECT 2 FROM " + TableName
			+ " WHERE " + TableName + "_ID=" + Record_ID
			+ " AND DocStatus='" + DocStatus + "'";
		int result = DB.getSQLValue(null, sql);
		return result == 2;
	}

	/**
	 * Create components
	 */
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
		lstAnswer.setVisible(false);
		lblAnswer.setVisible(false);
		ZKUpdateUtil.setWidth(lstAnswer, "100%");
//		lstAnswer.appendItem("", "");
//		lstAnswer.appendItem("Yes", "Y");
//		lstAnswer.appendItem("No", "N");
//		lstAnswer.addEventListener(Events.ON_SELECT, this);
		
		if (m_activity != null && (m_activity.isUserApproval() || m_activity.isUserTask()))
		{
			MWFNode node = m_activity.getNode();
			int ApprovalColumn_ID = 0;

			if (node.getAD_Column_ID() == 0)
				ApprovalColumn_ID = node.getApprovalColumn_ID();
			else
				ApprovalColumn_ID = node.getAD_Column_ID();

			

			if (ApprovalColumn_ID >0)
			{
				MColumn column = MColumn.get(Env.getCtx(), ApprovalColumn_ID);
				int dt = column.getAD_Reference_ID();

				if (dt == DisplayType.YesNo)
				{
					ValueNamePair[] values = MRefList.getList(Env.getCtx(), 319, false);
					for (int i = 0; i < values.length; i++)
					{
						lstAnswer.appendItem(values[i].getName(), values[i].getValue());
					}
					lstAnswer.setVisible(true);
					lblAnswer.setVisible(true);
				}
				else if (dt == DisplayType.List)
				{
					ValueNamePair[] values = MRefList.getList(Env.getCtx(), column.getAD_Reference_Value_ID(), false);
					for (int i = 0; i < values.length; i++)
					{
						lstAnswer.appendItem(values[i].getName(), values[i].getValue());
					}
					lstAnswer.setVisible(true);
					lblAnswer.setVisible(true);
				}
			}
		}
		lstAnswer.addEventListener(Events.ON_SELECT, this);

		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		ZKUpdateUtil.setVflex(confirmPanel, "true");
	}

	/**
	 * Layout dialog
	 */
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
		
		Row nodeVarRow = new Row();
		Div nodeVarDiv = new Div();
		MWFNode node = null;
		nodeVarForm = null;
		if (m_activity != null)
		{
			node = m_activity.getNode();
		}
		else if(org.compiere.process.DocAction.STATUS_Drafted.equals(DocStatus) && m_Process_ID > 0)
		{
			// Currently it only works for the DR state, because when the activity isn’t created yet, we don’t know which node will run.
			MProcess pr = new MProcess(Env.getCtx(), m_Process_ID, null);
			node = (MWFNode) pr.getAD_Workflow().getAD_WF_Node();
		}
		
		int colSpan = 1;
		if (node != null)
		{
			List <MColumn> colms = MWFNodeVar.getNodeVarsColumns(node.getCtx(), node.getAD_WF_Node_ID());
			if (colms != null && !colms.isEmpty())
			{
				PO po = m_activity == null ? MTable.get(gridTab.getAD_Table_ID()).getPO(gridTab.getRecord_ID(), null) : m_activity.getPO();
				nodeVarForm = new WFNodeVarForm(node, colms, po, gridTab);
				nodeVarForm.setHeight(nodeVarForm.getHeight());
				nodeVarDiv.setHeight(nodeVarForm.getHeight());
				nodeVarDiv.appendChild(nodeVarForm);
				ZKUpdateUtil.setWidth(nodeVarDiv, "100%");
				colSpan = 3;
			}
		}
		nodeVarRow.appendCellChild(nodeVarDiv, colSpan);

		Panel pnlDocAction = new Panel();
		pnlDocAction.appendChild(lblDocAction);
		pnlDocAction.appendChild(new Space());
		pnlDocAction.appendChild(lstDocAction);

		rowDocAction.appendCellChild(pnlDocAction, colSpan);
		
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

		rowDateAcct.appendCellChild(pnlDateAcct);

		rowLabel.appendCellChild(label, colSpan);
		rowSpacer.appendCellChild(new Space(), colSpan);

		if (m_activity != null && (m_activity.isUserApproval() || m_activity.isUserTask()))
		{
			rows.appendChild(rowAnswer);
			rows.appendChild(rowTxtMsg);
		}
		else
		{
			rows.appendChild(rowDocAction);
			rows.appendChild(rowDateAcct);
			rows.appendChild(rowLabel);
			rows.appendChild(rowSpacer);
		}

		if (nodeVarForm != null)
		{
			rows.appendChild(nodeVarRow);
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

	@Override
	public void onEvent(Event event) throws Exception
	{
		String eventName = event.getName();
		if (Events.ON_CLICK.equals(eventName))
		{
			if (confirmPanel.getButton("Ok").equals(event.getTarget()))
			{
				valMap = null;
				if (nodeVarForm != null)
				{
					String errorMsg = nodeVarForm.validateMandatory();
					if (!Util.isEmpty(errorMsg, true))
					{
						Dialog.error(m_WindowNo, "Error", errorMsg);
						return;
					}
					valMap = nodeVarForm.getValuesMap();
				}
	
				if (isWFActivity())
				{
					Trx trx = Trx.get(Trx.createTrxName("FWFA"), true);
					try
					{
						m_activity.set_TrxName(trx.getTrxName());
						setNodeVarValue();
					}
					catch (Exception e)
					{
						// Ensure leaked transaction is cleaned up
						if (trx != null)
						{
							trx.rollback();
							trx.close();
						}
						Throwable error = e.getCause();
						logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
						Dialog.error(m_WindowNo, "Error", error != null ? error.getLocalizedMessage() : e.getLocalizedMessage());
						return;
					}

					future = Adempiere.getThreadPoolExecutor().submit(new DesktopRunnable(new DocActionDialogRunnable(), getDesktop()));
				}
				else
					onOk(null);
			}
			else if (confirmPanel.getButton("Cancel").equals(event.getTarget()))
			{
				m_OKpressed = false;
				this.detach();
			}
		}
		else if (ON_COMPLETE_EVENT.equals(eventName))
		{
			if (future != null)
			{
				try
				{
					future.get();
				}
				catch (Exception e)
				{
					Throwable error = e.getCause();
					Dialog.error(m_WindowNo, "Error", error != null ? error.getLocalizedMessage() : e.getLocalizedMessage());
					logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
				}
			}
			future = null;
			this.detach();
			gridTab.dataRefresh();
		}
		else if (Events.ON_SELECT.equals(eventName))
		{

			if (lstDocAction.equals(event.getTarget()))
			{
				label.setValue(s_description[getSelectedIndex()]);
				setDateAcctVisible(s_value[getSelectedIndex()].equals(DocumentEngine.ACTION_Reverse_Accrual) && isAllowSetDateAcct);
			}
			else if (lstAnswer.equals(event.getTarget()))
			{
				if (nodeVarForm != null && m_activity != null)
				{
					MWFNode node = m_activity.getNode();
					int ApprovalColumn_ID = 0;

					if (node.getAD_Column_ID() == 0)
						ApprovalColumn_ID = node.getApprovalColumn_ID();
					else
						ApprovalColumn_ID = node.getAD_Column_ID();

					if (ApprovalColumn_ID > 0)
					{
						MColumn column = MColumn.get(Env.getCtx(), ApprovalColumn_ID);
						String value = lstAnswer.getSelectedItem().getValue();
						Env.setContext(Env.getCtx(), nodeVarForm.getWindowNo(), column.getColumnName(), value);
					}
					nodeVarForm.dynamicDisplay();
				}
			}
		}
	}

	/**
	 * Set selected document action item by value
	 * @param value
	 */
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

	/**
	 * Runs the workflow activity in a background transaction.  
	 * Handles different node actions (User Choice, User Task)  
	 * by capturing user input, validating it, and updating the activity state.  
	 * Commits on success, or rolls back and throws an exception on failure.  
	 */
	public void runBackgroundJob( )
	{
		Trx trx = null;
		try
		{
			trx = Trx.get((m_activity.get_TrxName() == null ? Trx.createTrxName("FWFA") : m_activity.get_TrxName()), true);
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
					throw new AdempiereException("FillMandatory" + Msg.getMsg(Env.getCtx(), "Answer"));

				//
				if (logger.isLoggable(Level.CONFIG))
					logger.config("Answer=" + value + " - " + textMsg);

				boolean ok = m_activity.setUserChoice(m_AD_User_ID, value, dt, textMsg);

				if (!ok || !Util.isEmpty(m_activity.getProcessMsg()))
				{
					String error = Util.isEmpty(m_activity.getM_ErrorMsg()) ? m_activity.getProcessMsg() : m_activity.getM_ErrorMsg();

					if (!Util.isEmpty(error, true))
						throw new AdempiereException(error);
				}
			}
			else
			{
				if (logger.isLoggable(Level.CONFIG))
					logger.config("Action=" + node.getAction() + " - " + textMsg);

				if (node.isUserTask())
				{

					boolean ok = false;
					if (node.getAD_Column_ID() > 0)
					{
						MColumn column = MColumn.get(Env.getCtx(), node.getAD_Column_ID());
						String value = null;

						Listitem li = lstAnswer.getSelectedItem();

						if (li != null)
							value = li.getValue().toString();

						if (value == null || value.length() == 0)
							throw new AdempiereException("FillMandatory" + Msg.getMsg(Env.getCtx(), "Answer"));

						ok = m_activity.setUserTask(m_AD_User_ID, value, column.getAD_Reference_ID(), textMsg);

					}
					else
					{
						ok = m_activity.setUserTask(m_AD_User_ID, null, -1, textMsg);
					}

					if (!ok || !Util.isEmpty(m_activity.getProcessMsg()))
					{
						String error = Util.isEmpty(m_activity.getM_ErrorMsg()) ? m_activity.getProcessMsg() : m_activity.getM_ErrorMsg();

						if (!Util.isEmpty(error, true))
							throw new AdempiereException(error);
					}
				}
				else
				{
					// ensure activity is ran within a transaction
					m_activity.setUserConfirmation(m_AD_User_ID, textMsg);
				}
			}
			trx.commit();
		}
		catch (Exception e)
		{
			trx.rollback();
			trx.close();
			throw new AdempiereException(e.getLocalizedMessage(), e);
		}
		finally
		{
			if (trx != null)
				trx.close();
		}
	}

	/**
	 * Checks if the workflow activity is valid for processing.  
	 * Returns true if a user answer is selected with a value,  
	 * or if the current activity exists and is a user task.  
	 */
	private boolean isWFActivity( )
	{
		return (lstAnswer.getSelectedItem() != null && lstAnswer.getSelectedItem().getValue() != null) || (m_activity != null && m_activity.isUserTask());
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
				Dialog.ask(gridTab.getWindowNo(), "", mf.format(arguments), new Callback<Boolean>() {
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

	/**
	 * Validate DocStatus not change by other, update GridTab and close dialog
	 */
	private void setValueAndClose() {
		String statusSql = "SELECT DocStatus FROM " + gridTab.getTableName() 
				+ " WHERE " + gridTab.getKeyColumnName() + " = ? ";
		String currentStatus = DB.getSQLValueString((String)null, statusSql, gridTab.getKeyID(gridTab.getCurrentRow()));
		if (DocStatus != null && !DocStatus.equals(currentStatus)) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "DocStatusChanged"));
		}
		m_OKpressed = true;
		setNodeVarValue();
		setValue();
		detach();
	}

	/**
	 * Sets workflow node variables based on the values provided in valMap.
	 * Resolves context, transaction, PO, and workflow node, then assigns variables using MWFActivity.
	 * Throws AdempiereException if any variable assignment fails.
	 */
	private void setNodeVarValue( )
	{
		if (valMap != null)
		{
			// Iterate through each column-value pair to be set
			for (Entry <Integer, String> colValue : valMap.entrySet())
			{
				// transaction: use activity's trx or create a new one
				String trxName = m_activity != null ? m_activity.get_TrxName() : null;// Trx.get(Trx.createTrxName("FWFA"), true);

				// context: activity context or default context
				Properties ctx = m_activity != null ? m_activity.getCtx() : Env.getCtx();

				// PO object: from activity or table record
				PO po = m_activity != null ? m_activity.getPO(Trx.get(trxName, true)) : MTable.get(Env.getCtx(), m_AD_Table_ID).getPO(gridTab.getRecord_ID(), trxName);

				MWFNode node = null;
				// workflow node: from activity or process workflow
				if (m_activity != null)
					node = m_activity.getNode();
				else if (m_Process_ID > 0)
				{
					MProcess pr = new MProcess(Env.getCtx(), m_Process_ID, trxName);
					node = (MWFNode) pr.getAD_Workflow().getAD_WF_Node();
				}

				if(node != null)
				{
					try
					{
						// Get column based on ID
						MColumn col = MColumn.get(ctx, colValue.getKey());
						// Assign workflow variable using column ID, value, reference type, PO, and node
						MWFActivity.setVariable(
										colValue.getKey(), // Column ID
										colValue.getValue(), // Value to set
										col.getAD_Reference_ID(), // Column reference type
										po, // Target PO
										node, // Workflow node
										trxName // Transaction
						);
					}
					catch (Exception e)
					{
						throw new AdempiereException(e.getMessage(), e);
					}
				}
			}

			if (gridTab != null)
				gridTab.dataRefresh();
		}
	}

	/**
	 * Update GridTab with selected DocAction value
	 */
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

	/**
	 * Load document action list from AD_Ref_List  
	 */
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

	/**
	 * @return selected index
	 */
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

	 /**
	  * @return number of document action items
	  */
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

			resp = m_activity.getResponsible();
			// first priority to suspended activity responsible
			if (resp == null)
			{
				MWFResponsible ovrResp = MWFResponsible.getClientWFResp(Env.getCtx(), AD_WF_Resp_ID);
				if (ovrResp != null)
					resp = ovrResp;
			}
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
				MWFActivityApprover[] approvers = MWFActivityApprover.getOfActivity(m_activity.getCtx(), m_activity.getAD_WF_Activity_ID(), m_activity.get_TrxName());
				if ((approvers == null || approvers.length == 0) && m_activity.getAD_User_ID() <= 0 && m_WFProcess.getAD_User_ID() != m_AD_User_ID)
				{
					return false;
				}

				// If Approver is assign then check current user is not Approver
				if (m_activity.getAD_User_ID() > 0 && m_AD_User_ID != m_activity.getAD_User_ID())
				{
					return false;
				}
				
				if (approvers != null && approvers.length > 0)
				{
					boolean isApprover = false;
					for (int i = 0; i < approvers.length; i++)
					{
						if (approvers[i].getAD_User_ID() == Env.getAD_User_ID(m_activity.getCtx()))
						{
							isApprover = true;
							break;
						}
					}
					return isApprover;
				}

				return true;
			}
			else if (MWFResponsible.RESPONSIBLETYPE_Initiator.equals(respType))
			{
				if (m_activity.getAD_User_ID() != m_AD_User_ID)
				{
					return false;
				}
			}
			else if (MWFResponsible.RESPONSIBLETYPE_SupervisorOfInitiator.equals(respType) || MWFResponsible.RESPONSIBLETYPE_SupervisorOfCurrentUser.equals(respType))
			{
				if (m_activity.getAD_User_ID() != m_AD_User_ID)
				{
					return false;
				}
			}
			else if (MWFResponsible.RESPONSIBLETYPE_Human.equals(respType) && resp.getAD_User_ID() > 0)
			{
				if (m_activity.getAD_User_ID() != 0 && m_activity.getAD_User_ID() == m_AD_User_ID)
				{
					return true;
				}
				else if (resp.getAD_User_ID() != m_AD_User_ID)
				{
					return false;
				}
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
	
	/**
	 * Runnable to run process in background thread.
	 * Notify process dialog with {@link WDocActionPanel#ON_COMPLETE_EVENT} event.
	 */
	private class DocActionDialogRunnable extends ZkContextRunnable
	{
		private DocActionDialogRunnable() 
		{
			super();			
		}
		
		protected void doRun() 
		{
			try {
				runBackgroundJob();
			} catch (Exception ex) {
				logger.log(Level.SEVERE, ex.getLocalizedMessage(), ex);
				throw new AdempiereException(ex.getLocalizedMessage(), ex);
			} finally {
				Executions.schedule(getDesktop(), WDocActionPanel.this, new Event(ON_COMPLETE_EVENT, WDocActionPanel.this, null));
			}		
		}
	}// DocActionDialogRunnable
}
