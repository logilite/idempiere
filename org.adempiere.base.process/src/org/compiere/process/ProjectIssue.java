/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProcessPara;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MProjectLine;
import org.compiere.model.MTable;
import org.compiere.model.MTimeExpense;
import org.compiere.model.MTimeExpenseLine;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;

/**
 *  Issue to Project.
 *
 *	@author Jorg Janke
 *	@version $Id: ProjectIssue.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class ProjectIssue extends SvrProcess
{
	/**	Project - Mandatory Parameter		*/
	private int 		m_C_Project_ID = 0;
	/**	Receipt - Option 1					*/
	private int 		m_M_InOut_ID = 0;
	/**	Expenses - Option 2					*/
	private int 		m_S_TimeExpense_ID = 0;
	/** Invoice Line - Option 3 			*/
	private int			m_C_InvoiceLine_ID = 0;
	/** Locator - Option 4,5				*/
	private int			m_M_Locator_ID = 0;
	/** Project Line - Option 4				*/
	private int 		m_C_ProjectLine_ID = 0;
	/** Product - Option 5					*/
	private int 		m_M_Product_ID = 0;
	/** Attribute - Option 5				*/
	@SuppressWarnings("unused")
	private int 		m_M_AttributeSetInstance_ID = 0;
	/** Qty - Option 5						*/
	private BigDecimal	m_MovementQty = null;
	/** Date - Option						*/
	private Timestamp	m_MovementDate = null;
	/** Description - Option				*/
	private String		m_Description = null;

	/**	The Project to be received			*/
	private MProject		m_project = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("C_Project_ID"))
				m_C_Project_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_InOut_ID"))
				m_M_InOut_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("S_TimeExpense_ID"))
				m_S_TimeExpense_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_InvoiceLine_ID"))
				m_C_InvoiceLine_ID = ((BigDecimal) para[i].getParameter()).intValue();
			else if (name.equals("M_Locator_ID"))
				m_M_Locator_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_ProjectLine_ID"))
				m_C_ProjectLine_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_Product_ID"))
				m_M_Product_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_AttributeSetInstance_ID"))
				m_M_AttributeSetInstance_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("MovementQty"))
				m_MovementQty = (BigDecimal)para[i].getParameter();
			else if (name.equals("MovementDate"))
				m_MovementDate = (Timestamp)para[i].getParameter();
			else if (name.equals("Description"))
				m_Description = (String)para[i].getParameter();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		  }
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (clear text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		//	Check Parameter
		m_project = (MProject) MTable.get(getCtx(), MProject.Table_ID).getPO(m_C_Project_ID, get_TrxName());

		if (!(MProject.PROJECTCATEGORY_WorkOrderJob.equals(m_project.getProjectCategory())
			|| MProject.PROJECTCATEGORY_AssetProject.equals(m_project.getProjectCategory())))
			throw new IllegalArgumentException("Project not Work Order or Asset =" + m_project.getProjectCategory());
		if (log.isLoggable(Level.INFO)) log.info(m_project.toString());
		//
		if (m_M_InOut_ID != 0)
			return issueReceipt();
		if (m_S_TimeExpense_ID != 0)
			return issueExpense();
		if (m_C_InvoiceLine_ID != 0)
			return issueInvoiceLine();
		if (m_M_Locator_ID == 0)
			throw new IllegalArgumentException("Locator missing");
		if (m_C_ProjectLine_ID != 0)
			return issueProjectLine();
		return issueInventory();
	}	//	doIt

	/**
	 *	Issue Receipt
	 *	@return Message (clear text)
	 */
	private String issueReceipt()
	{
		MInOut inOut = (MInOut) MTable.get(getCtx(), MInOut.Table_ID).getPO(m_M_InOut_ID, null);
		
		if (inOut.isSOTrx() || !inOut.isProcessed()
			|| !(MInOut.DOCSTATUS_Completed.equals(inOut.getDocStatus()) || MInOut.DOCSTATUS_Closed.equals(inOut.getDocStatus())))
			throw new IllegalArgumentException ("Receipt not valid - " + inOut);
		
		if (log.isLoggable(Level.INFO)) log.info(inOut.toString());
		
		MInOutLine[] inOutLines = inOut.getLines(false);
		int counter = 0;
		for (int i = 0; i < inOutLines.length; i++)
		{
			//	Need to have a Product
			if (inOutLines[i].getM_Product_ID() == 0)
				continue;
			//	Need to have Quantity
			if (inOutLines[i].getMovementQty() == null || inOutLines[i].getMovementQty().signum() == 0)
				continue;
			//	not issued yet
			if (MProjectIssue.projectIssueHasReceipt(inOutLines[i].getM_InOutLine_ID(), get_TrxName()))
				continue;
			
			//	Create Issue
			MProjectIssue pi = new MProjectIssue (m_project);

			pi.setMandatory(inOutLines[i].getM_Locator_ID(), inOutLines[i].getM_Product_ID(), inOutLines[i].getMovementQty());
			if (m_MovementDate != null)		//	default today
				pi.setMovementDate(m_MovementDate);
			
			if (!Util.isEmpty(m_Description, true))
				pi.setDescription(m_Description);
			else
				pi.setDescription(MProjectIssue.getInOutLineDesc(inOutLines[i]));

			pi.setM_AttributeSetInstance_ID(inOutLines[i].getM_AttributeSetInstance_ID());
			pi.setM_InOutLine_ID(inOutLines[i].getM_InOutLine_ID());
			
			// Additional Dimensions
			pi.setC_CostCenter_ID(inOutLines[i].getC_CostCenter_ID());
			pi.setC_Department_ID(inOutLines[i].getC_Department_ID());
			pi.setM_Warehouse_ID(inOutLines[i].getM_Warehouse_ID());

			pi.saveEx(get_TrxName());
			ProcessInfo processInfo = MWorkflow.runDocumentActionWorkflow(pi, DocAction.ACTION_Complete);
			if (processInfo.isError())
			{
				getProcessInfo().setLogList(null);
				throw new RuntimeException(processInfo.getSummary());
			}
			pi.saveEx(get_TrxName());

			addLog(pi.getLine(), pi.getMovementDate(), pi.getMovementQty(), null);
			counter++;
		} // all InOutLines

		StringBuilder msgreturn = new StringBuilder("@Created@ ").append(counter);
		return msgreturn.toString();
	}	//	issueReceipt

	/**
	 *	Issue Expense Report
	 *	@return Message (clear text)
	 */
	private String issueExpense()
	{
		//	Get Expense Report
		MTimeExpense expense = new MTimeExpense (getCtx(), m_S_TimeExpense_ID, get_TrxName());
		if (!expense.isProcessed())
		  throw new IllegalArgumentException ("Time + Expense is not processed - " + expense);

		//	for all expense lines
		MTimeExpenseLine[] expenseLines = expense.getLines(false);
		int counter = 0;
		for (int i = 0; i < expenseLines.length; i++)
		{
			//	Need to have a Product
			if (expenseLines[i].getM_Product_ID() == 0)
				continue;
			//	Need to have Quantity
			if (expenseLines[i].getQty() == null || expenseLines[i].getQty().signum() == 0)
				continue;
			//	Need to the same project
			if (expenseLines[i].getC_Project_ID() > 0 && expenseLines[i].getC_Project_ID() != m_project.getC_Project_ID())
				continue;
			//	not issued yet
			if (MProjectIssue.projectIssueHasExpense(expenseLines[i].getS_TimeExpenseLine_ID(), get_TrxName()))
				continue;

			//	Create Issue
			MProjectIssue pi = new MProjectIssue (m_project);
			
			pi.setMandatory (MProjectIssue.getExpenseLineLocator(expenseLines[i]), expenseLines[i].getM_Product_ID(), expenseLines[i].getQty());
			
			if (m_MovementDate != null)		//	default today
				pi.setMovementDate(m_MovementDate);
			
			if (m_Description != null && m_Description.length() > 0)
				pi.setDescription(m_Description);
			else if (expenseLines[i].getDescription() != null)
				pi.setDescription(expenseLines[i].getDescription());
			
			pi.setS_TimeExpenseLine_ID(expenseLines[i].getS_TimeExpenseLine_ID());
			pi.saveEx();
			
			ProcessInfo processInfo = MWorkflow.runDocumentActionWorkflow(pi, DocAction.ACTION_Complete);
			if (processInfo.isError())
				throw new RuntimeException(processInfo.getSummary());
			pi.saveEx();
			
			addLog(pi.getLine(), pi.getMovementDate(), pi.getMovementQty(), null);
			counter++;
		}	//	allExpenseLines

		if (counter > 0)
		{
			StringBuilder msgreturn = new StringBuilder("@Created@ ").append(counter);
			return msgreturn.toString();
		}
		else
		{
			return "@Error@ The product is missing in the Expense Line for Expense #" + m_S_TimeExpense_ID;
		}
	}	//	issueExpense

	/**
	 * Issue Invoice Line
	 * @return Message (clear text)
	 */
	private String issueInvoiceLine()
	{
		MInvoiceLine invLine = (MInvoiceLine) MTable.get(getCtx(), MInvoiceLine.Table_ID).getPO(m_C_InvoiceLine_ID, get_TrxName());

		// Project Issue
		MProjectIssue pi = new MProjectIssue(m_project);
		pi.setMandatory(invLine.getC_Charge_ID(), invLine.getQtyInvoiced());

		if (m_MovementDate != null) // default today
			pi.setMovementDate(m_MovementDate);
		if (!Util.isEmpty(m_Description))
			pi.setDescription(m_Description);
		else
			pi.setDescription(MProjectIssue.getInvDescription(invLine));

		pi.setC_InvoiceLine_ID(m_C_InvoiceLine_ID);
		pi.saveEx();

		ProcessInfo processInfo = MWorkflow.runDocumentActionWorkflow(pi, DocAction.ACTION_Complete);
		if (processInfo.isError())
			throw new RuntimeException(processInfo.getSummary());
		pi.saveEx();

		addLog(pi.getLine(), pi.getMovementDate(), pi.getMovementQty(), "Created Project Issue Line: " + pi.getLine());
		return "@Created@ 1";
	} 	// 	issueInvoiceLine
	
	/**
	 *	Issue Project Line
	 *	@return Message (clear text)
	 */
	private String issueProjectLine()
	{
		MProjectLine pl = new MProjectLine(getCtx(), m_C_ProjectLine_ID, get_TrxName());
		if (pl.getM_Product_ID() == 0)
			throw new IllegalArgumentException("Project Line has no Product");
		if (pl.getC_ProjectIssue_ID() != 0)
			throw new IllegalArgumentException("Project Line already been issued");
		if (m_M_Locator_ID == 0)
			throw new IllegalArgumentException("No Locator");

		//
		MProjectIssue pi = new MProjectIssue (m_project);
		pi.setMandatory (m_M_Locator_ID, pl.getM_Product_ID(), pl.getPlannedQty());
		if (m_MovementDate != null)		//	default today
			pi.setMovementDate(m_MovementDate);
		if (m_Description != null && m_Description.length() > 0)
			pi.setDescription(m_Description);
		else if (pl.getDescription() != null)
			pi.setDescription(pl.getDescription());
		pi.setAmt(pl.getPlannedAmt());
		pi.setC_ProjectLine_ID(m_C_ProjectLine_ID);
		pi.saveEx();
		
		ProcessInfo processInfo = MWorkflow.runDocumentActionWorkflow(pi, DocAction.ACTION_Complete);
		if (processInfo.isError())
			throw new RuntimeException(processInfo.getSummary());
		pi.saveEx();

		//	Update Line
		pl.setMProjectIssue(pi);
		pl.saveEx();
		addLog(pi.getLine(), pi.getMovementDate(), pi.getMovementQty(), null);
		return "@Created@ 1";
	}	//	issueProjectLine


	/**
	 *	Issue from Inventory
	 *	@return Message (clear text)
	 */
	private String issueInventory()
	{
		if (m_M_Locator_ID == 0)
			throw new IllegalArgumentException("No Locator");
		if (m_M_Product_ID == 0)
			throw new IllegalArgumentException("No Product");
		
		//	Set to Qty 1
		if (m_MovementQty == null || m_MovementQty.signum() == 0)
			m_MovementQty = Env.ONE;
		//
		MProjectIssue pi = new MProjectIssue (m_project);
		pi.setMandatory (m_M_Locator_ID, m_M_Product_ID, m_MovementQty);
		if (m_MovementDate != null)		//	default today
			pi.setMovementDate(m_MovementDate);
		if (m_Description != null && m_Description.length() > 0)
			pi.setDescription(m_Description);
		pi.saveEx();
		
		ProcessInfo processInfo = MWorkflow.runDocumentActionWorkflow(pi, DocAction.ACTION_Complete);
		if (processInfo.isError())
			throw new RuntimeException(processInfo.getSummary());
		pi.saveEx();

		addLog(pi.getLine(), pi.getMovementDate(), pi.getMovementQty(), null);
		return "@Created@ 1";
	}	//	issueInventory
}	//	ProjectIssue
