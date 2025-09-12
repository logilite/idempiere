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
package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.NegativeInventoryDisallowedException;
import org.adempiere.exceptions.PeriodClosedException;
import org.adempiere.model.DocActionDelegate;
import org.adempiere.util.ProjectIssueUtil;
import org.compiere.process.DocAction;
import org.compiere.process.DocOptions;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * 	Project Issue Model
 *
 *	@author Jorg Janke
 *	@version $Id: MProjectIssue.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MProjectIssue extends X_C_ProjectIssue implements DocAction, DocOptions
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -3899186445864400047L;
	
	private DocActionDelegate<MProjectIssue> docActionDelegate = null;
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_ProjectIssue_UU  UUID key
     * @param trxName Transaction
     */
    public MProjectIssue(Properties ctx, String C_ProjectIssue_UU, String trxName) {
        super(ctx, C_ProjectIssue_UU, trxName);
		if (Util.isEmpty(C_ProjectIssue_UU))
			setInitialDefaults();
		init();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_ProjectIssue_ID id
	 *	@param trxName transaction
	 */
	public MProjectIssue (Properties ctx, int C_ProjectIssue_ID, String trxName)
	{
		super (ctx, C_ProjectIssue_ID, trxName);
		if (C_ProjectIssue_ID == 0)
			setInitialDefaults();
		init();
	}	//	MProjectIssue

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setMovementQty (Env.ZERO);
		setPosted (false);
		setProcessed (false);
	}

	/**
	 * 	Load Constructor
	 * 	@param ctx context
	 * 	@param rs result set
	 *	@param trxName transaction
	 */
	public MProjectIssue (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		init();
	}	//	MProjectIssue

	/**
	 * 	New Parent Constructor
	 *	@param project parent
	 */
	public MProjectIssue (MProject project)
	{
		this (project.getCtx(), 0, project.get_TrxName());
		setClientOrg(project.getAD_Client_ID(), project.getAD_Org_ID());
		setC_Project_ID (project.getC_Project_ID());	//	Parent
		setLine (getNextLine());
		m_parent = project;
		//
		setMovementDate (new Timestamp(System.currentTimeMillis()));
		setMovementQty (Env.ZERO);
		setPosted (false);
		setProcessed (false);
		init();
	}	//	MProjectIssue

	/**
	 * Initialize document action delegate ({@link DocActionDelegate}) for this model class
	 */
	private void init() {
		docActionDelegate = new DocActionDelegate<>(this);
		docActionDelegate.setActionCallable(DocAction.ACTION_Complete, () -> { return doComplete(); });
		docActionDelegate.setActionCallable(DocAction.ACTION_Reverse_Correct, () -> { return doReverse(false); });
		docActionDelegate.setActionCallable(DocAction.ACTION_Reverse_Accrual, () -> { return doReverse(true); });
	} // init

	/**	Parent				*/
	private MProject	m_parent = null;
	
	/**
	 *	Get next Line No
	 * 	@return next line no
	 */
	private int getNextLine()
	{
		return DB.getSQLValue(get_TrxName(), 
			"SELECT COALESCE(MAX(Line),0)+10 FROM C_ProjectIssue WHERE C_Project_ID=?", getC_Project_ID());
	}	//	getLineFromProject

	/**
	 * 	Set value of mandatory fields
	 *	@param M_Locator_ID locator
	 *	@param M_Product_ID product
	 *	@param MovementQty qty
	 */
	public void setMandatory (int M_Locator_ID, int M_Product_ID, BigDecimal MovementQty)
	{
		setM_Locator_ID (M_Locator_ID);
		setM_Product_ID (M_Product_ID);
		setMovementQty (MovementQty);
	}	//	setMandatory

	/**
	 * 	Set Mandatory Values
	 *	@param C_Charge_ID Charged
	 *	@param MovementQty qty
	 */
	public void setMandatory (int C_Charge_ID, BigDecimal MovementQty)
	{
		setC_Charge_ID(C_Charge_ID);
		setMovementQty (MovementQty);
	}	//	setMandatory

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		// Check Product or Charge is Present
		if (getM_Product_ID() <= 0 && getC_Charge_ID() <= 0)
		{
			log.saveError("Error", "Product or Charge is not present in Invoice :"	+ getC_InvoiceLine().getC_Invoice().getDocumentNo()
									+ " Invoice Line No.: " + getC_InvoiceLine().getLine());
			return false;
		}

		String costingLevel = MClientInfo.get(getCtx(), getC_Project().getAD_Client_ID()).getC_AcctSchema1().getCostingLevel();
		// check validation for non Reversed Record
		if (getReversal_ID() <= 0)
		{
			// Set to Qty 1 if null or 0
			if (getMovementQty() == null || getMovementQty().signum() == 0)
				setMovementQty(Env.ONE);

			// Check movement Qty is more than Zero
			if (getMovementQty().signum() < 0)
			{
				log.saveError("Error", "The movement quantity must be greater than zero.");
				return false;
			}

			// Validate InOutLine
			if (getM_InOutLine_ID() > 0 && is_ValueChanged(COLUMNNAME_M_InOutLine_ID))
			{
				MInOutLine inOutLine = (MInOutLine) getM_InOutLine();

				// Manage Multiple Attributes on Shipment Line
				BigDecimal qty = Env.ZERO;
				if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel)	&&
					(getM_AttributeSetInstance_ID() <= 0 && inOutLine.getM_AttributeSetInstance_ID() <= 0))
				{
					// Retrieve Multiple Attribute from In-out Line
					MInOutLineMA[] inOutLineMAs = MInOutLineMA.get(getCtx(), inOutLine.get_ID(), get_TrxName());
					for (MInOutLineMA inOutLineMA : inOutLineMAs)
					{
						if (qty.signum() > 0)
						{
							// Create a new Project Issue when Project Issue movement Qty is more
							// than Zero
							ProjectIssueUtil.createProjetIssue(	inOutLine.getM_Locator_ID(), this, inOutLineMA.getM_AttributeSetInstance_ID(),
																inOutLineMA.getMovementQty(), get_TrxName());
						}
						else
						{
							// Set Project Issue Locator and movement Qty from First retrieval multiple Attribute
							qty = inOutLineMA.getMovementQty();
							setM_AttributeSetInstance_ID(inOutLineMA.getM_AttributeSetInstance_ID());
							setMovementQty(qty);
						}
					}
				}
				/**
				 * Executive When Costing Level
				 * 1. Client
				 * 2. Organization
				 * 3. Batch / Lot and In Out Line present ASI ID (For, Single ASI ID)
				 */
				else
				{
					if (inOutLine.getM_InOut().isSOTrx()	|| !inOutLine.isProcessed()
						|| !(MInOut.DOCSTATUS_Completed.equals(inOutLine.getM_InOut().getDocStatus())
								|| MInOut.DOCSTATUS_Closed.equals(inOutLine.getM_InOut().getDocStatus())))
					{
						log.saveError("Error", "Receipt Line is not valid - " + inOutLine);
						return false;
					}

					// Need to the same project
					if (inOutLine.getC_Project_ID() > 0 && inOutLine.getC_Project_ID() != getC_Project_ID())
					{
						log.saveError("Error", "Receipt Line is not valid - " + inOutLine + ", Receipt already present for another Project");
						return false;
					}

					if (projectIssueHasReceipt(inOutLine.get_ID(), null))
					{
						log.saveError("Error", "Receipt Line is not valid - ( " + inOutLine + " ) Project Issue already created for this Recipt");
						return false;
					}

					// Check QTY available or not for In Out Line
					if (inOutLine.getMovementQty().compareTo(getMovementQty()) <= 0)
					{
						setMovementQty(ProjectIssueUtil.getInOutLineQTY(	inOutLine, inOutLine.getMovementQty(),
																					inOutLine.getM_AttributeSetInstance_ID() == 0	? getM_AttributeSetInstance_ID()
																																	: inOutLine.getM_AttributeSetInstance_ID()));

						if (inOutLine.getMovementQty().compareTo(getMovementQty()) > 0)
						{
							ProjectIssueUtil.checkRemainInOutLineQty(	inOutLine, this, costingLevel, getMovementQty(),
																				inOutLine.getM_AttributeSetInstance_ID() == 0	? getM_AttributeSetInstance_ID()
																																: inOutLine.getM_AttributeSetInstance_ID());
						}
						if (getMovementQty().signum() <= 0)
						{
							log.saveError("Error", "Receipt Line- ( " + inOutLine + " ) is not valid, Product is not present at Locator");
							return false;
						}
					}
				}
			}
			else if (getS_TimeExpenseLine_ID() > 0 && is_ValueChanged(COLUMNNAME_S_TimeExpenseLine_ID))
			{  
				// validate Time Expense Line
				MTimeExpenseLine expenseLines = (MTimeExpenseLine) getS_TimeExpenseLine();
				if (expenseLines.getM_Product_ID() == 0)
				{
					log.saveError("Error", "Time Expense Line is not valid - " + expenseLines + ", has no resouce set");
					return false;
				}	
				//	Need to have Quantity
				if (expenseLines.getQty() == null || expenseLines.getQty().signum() == 0)
				{
					log.saveError("Error", "Time Expense Line is not valid - " + expenseLines + ", Time Expense must have qty");
					return false;
				}
				
				// Need to the same project
				if (expenseLines.getC_Project_ID() > 0 && expenseLines.getC_Project_ID() != getC_Project_ID())
				{
					log.saveError("Error", "Time Expense Line is not valid - " + expenseLines + ", Time Expense Already present for another Project");
					return false;
				}

				// check Time Expense Line already used or not for project issue
				if (projectIssueHasExpense(getS_TimeExpenseLine_ID(), get_TrxName()))
				{
					log.saveError("Error", "Expense Line is not valid - " + getS_TimeExpenseLine_ID());
					return false;
				}
				
				if(getM_Locator_ID()==0) {
					setM_Locator_ID(getExpenseLineLocator((MTimeExpenseLine)getS_TimeExpenseLine()));
				}
			}
			else if (getC_InvoiceLine_ID() > 0 && is_ValueChanged(COLUMNNAME_C_InvoiceLine_ID))
			{ // Check Invoice Line validation
				MInvoiceLine invLine = (MInvoiceLine) getC_InvoiceLine();

				if (invLine.getC_Invoice().isSOTrx())
				{
					log.saveError("Error","Invoice Line is invalid - " + invLine);	
					return false;
				}

				if (!(MInvoice.DOCSTATUS_Completed.equals(invLine.getC_Invoice().getDocStatus())
						|| MInvoice.DOCSTATUS_Closed.equals(invLine.getC_Invoice().getDocStatus())))
				{
					log.saveError("Error", "Invoice Line is invalid (" + invLine + ") Invoice Line Must be Closed or Completed");
					return false;
				}

				// Need to have Charge
				if (invLine.getC_Charge_ID() <= 0)
				{
					log.saveError("Error", "Invoice line (" + invLine + ") missing charge.");
					return false;
				}

				// Checked Using this invoice Line any issue present or not yet
				if (projectIssueHasInvoiceLine(getC_InvoiceLine_ID(), get_TrxName()))
				{
					log.saveError("Error", "Project Issue is already created for this Invoice Line");
					return false;
				}

				setAmt(getInvLineAmt(invLine));
			}
			else if (getC_ProjectLine_ID() > 0 && is_ValueChanged(COLUMNNAME_C_ProjectLine_ID))
			{
				MProjectLine projLine = (MProjectLine) getC_ProjectLine();

				if (projLine.getM_Product_ID() == 0)
				{
					log.saveError("Error", "Project Line is not valid - " + projLine + ", has no resource set");
					return false;
				}
				// Need to have Quantity
				if (projLine.getPlannedQty() == null || projLine.getPlannedQty().signum() == 0)
				{
					log.saveError("Error", "Project Line is not valid - " + projLine + ", Project Line must have planned qty");
					return false;
				}

				if (projLine.isProcessed())
				{
					log.saveError("Error", "Project Line already attached with Project Issue");
				}
			}
			
			if (getM_Product_ID() > 0)
			{ // Check if Product is present than must be Locator is available
				if(getM_Locator_ID() <= 0)
				{
					log.saveError("Error","Missing Locator field");
					return false;
				}
				
				if (getMovementQty() == null || getMovementQty().signum() <= 0)
				{
					log.saveError("Error","Qty is mandatory when issue from inventory");
					return false;
				}

				if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel) && getM_AttributeSetInstance_ID() < 0)
				{
					log.saveError("Error", "ASI is not Present for Product");
					return false;
				}
			}
		}
		
		return super.beforeSave(newRecord);
	} // beforeSave

	/**
	 * 	Get Parent
	 *	@return project
	 */
	public MProject getParent()
	{
		if (m_parent == null && getC_Project_ID() != 0)
			m_parent = (MProject) MTable.get(getCtx(), MProject.Table_ID).getPO(getC_Project_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	/**
	 * 	Process Issue
	 *  @deprecated
	 *	@return true if processed
	 */
	@Deprecated
	public boolean process()
	{
		saveEx();
		
		return doComplete() == null;
	}	//	process

	/**
	 * Handle CompleteIt document action
	 * @return error message or null
	 */
	private String doComplete() 
	{
		int productID = getM_Product_ID();
		int chargeID = getC_Charge_ID();
		if (productID <= 0 && chargeID <= 0)
		{
			log.log(Level.SEVERE, "Product Or Charge is not Present");
			return "No Product or Charge";
		}
		
		if (!isReversal())
		{
			try {
				periodClosedCheckForBackDateTrx(null);
			} catch (PeriodClosedException e) {
				return e.getLocalizedMessage();
			}
		}

		/** @todo Transaction */

		MTransaction mTrx = null;
		
		String p_msg = setProject(get_TrxName());
		if (!Util.isEmpty(p_msg, true))
		{
			log.log(Level.SEVERE, p_msg);
			return p_msg;
		}
		
		/**
		 * When a transaction is completed, update the project's balance amount, create a project
		 * line, and set the project ID based on the creation of the project issue
		 */
		if (productID > 0)
		{
			MProduct product = MProduct.get(getCtx(), productID);

			// If not a stocked Item nothing to do
			if (!product.isStocked()) {
				setProcessed(true);
				setAmt(updateBalanceAmt());
				saveEx();
				return null;
			}

			String costingLevel = MClientInfo.get(getCtx(), getC_Project().getAD_Client_ID()).getC_AcctSchema1().getCostingLevel();
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel) && getM_AttributeSetInstance_ID() < 0)
			{
				log.saveError("Error", "ASI must be present for Product");
				return "ASI must be present for Product";
			}

			// ** Create Material Transactions **
			mTrx = new MTransaction(getCtx(), getAD_Org_ID(), MTransaction.MOVEMENTTYPE_WorkOrderPlus,
					getM_Locator_ID(), productID, getM_AttributeSetInstance_ID(), getMovementQty().negate(),
					getMovementDate(), get_TrxName());
			mTrx.setC_ProjectIssue_ID(getC_ProjectIssue_ID());

			Timestamp dateMPolicy = getMovementDate();

			if (getM_AttributeSetInstance_ID() > 0) {
				Timestamp t = MStorageOnHand.getDateMaterialPolicy(productID, getM_AttributeSetInstance_ID(),
						get_TrxName());
				if (t != null)
					dateMPolicy = t;
			}

			boolean ok = true;
			try {
				if (getMovementQty().negate().signum() < 0) {
					String MMPolicy = product.getMMPolicy();
					Timestamp minGuaranteeDate = getMovementDate();
					int M_Warehouse_ID = getM_Locator_ID() > 0 ? getM_Locator().getM_Warehouse_ID()
							: getC_Project().getM_Warehouse_ID();
					MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), M_Warehouse_ID, productID,
							getM_AttributeSetInstance_ID(), minGuaranteeDate, MClient.MMPOLICY_FiFo.equals(MMPolicy),
							true, getM_Locator_ID(), get_TrxName(), true);
					BigDecimal qtyToIssue = getMovementQty();
					for (MStorageOnHand storage : storages) {
						if (storage.getQtyOnHand().compareTo(qtyToIssue) >= 0) {
							storage.addQtyOnHand(qtyToIssue.negate());
							qtyToIssue = BigDecimal.ZERO;
						} else {
							qtyToIssue = qtyToIssue.subtract(storage.getQtyOnHand());
							storage.addQtyOnHand(storage.getQtyOnHand().negate());
						}

						if (qtyToIssue.signum() == 0)
							break;
					}
					if (qtyToIssue.signum() > 0) {
						ok = MStorageOnHand.add(getCtx(), getM_Locator_ID(), productID, getM_AttributeSetInstance_ID(),
								qtyToIssue.negate(), dateMPolicy, get_TrxName());
					}
				} else {
					ok = MStorageOnHand.add(getCtx(), getM_Locator_ID(), productID, getM_AttributeSetInstance_ID(),
							getMovementQty().negate(), dateMPolicy, get_TrxName());
				}
			} catch (NegativeInventoryDisallowedException e) {
				log.severe(e.getMessage());
				StringBuilder error = new StringBuilder();
				error.append(Msg.getElement(getCtx(), "Line")).append(" ").append(getLine()).append(": ");
				error.append(e.getMessage()).append("\n");
				throw new AdempiereException(error.toString());
			}

			if (ok) {
				if (mTrx != null && mTrx.save(get_TrxName())) {
					setAmt(updateBalanceAmt());
					createProjetLine();
					if (save())
					{
						return null;
					}
					else
					{
						log.log(Level.SEVERE, "Issue not saved"); // Update Balance
						return "Issue not saved";
					}
				}
				else
				{
					log.log(Level.SEVERE, "Transaction not saved"); // requires trx !!
					return "Transaction not saved";
				}
			}
			else
			{
				log.log(Level.SEVERE, "Storage not updated"); 		// OK
				return "Storage not updated";
			}
		}
		else if (chargeID > 0)
		{
			setAmt(updateBalanceAmt());
			createProjetLine();

			if (save())
				return null;
			else
				log.log(Level.SEVERE, "Issue not saved"); // requires trx !!
		}
		//
		log.log(Level.SEVERE, "Product Or Charge is not Present");
		return "Product or Charge is not present";
	}	//	doComplete

	/**
	 * Create a Project Line for Project Issue Complete Event
	 */
	private void createProjetLine()
	{
		// Check Project Issue is Reversal or not.
		if (getReversal_ID() > 0)
			return;

		MProjectLine pl = null;
		// For In Out Line
		if (getM_InOutLine_ID() > 0)
		{
			MProject proj = (MProject) getC_Project();
			MProjectLine[] pls = proj.getLines();
			for (int ii = 0; ii < pls.length; ii++)
			{
				// The Order we generated is the same as the Order of the receipt
				if (pls[ii].getC_OrderPO_ID() == getM_InOutLine().getM_InOut().getC_Order_ID()
					&& pls[ii].getM_Product_ID() == getM_InOutLine().getM_Product_ID()
					&& pls[ii].getC_ProjectIssue_ID() == 0) // not issued
				{
					pl = pls[ii];
					break;
				}
			}
			if (pl == null)
				pl = new MProjectLine(proj);
			pl.setMProjectIssue(this); // setIssue
			pl.saveEx(get_TrxName());
			return;
		}

		// Check Issue create from Project Line or not
		if (getC_ProjectLine_ID() > 0)
		{
			pl = (MProjectLine) getC_ProjectLine();
			pl.setC_ProjectIssue_ID(getC_ProjectIssue_ID());
			pl.saveEx(get_TrxName());
			return;
		}
		else
		{
			// Create Project Line
			pl = new MProjectLine((MProject) getC_Project());
			pl.setC_ProjectIssue_ID(get_ID());
			pl.saveEx(get_TrxName());
		}
	} // createProjetLine

	/**
	 * Handle reverse accrual and reverse correct document action
	 * @param accrual true to use current date, false to use this record's movement date
	 * @return error message or null
	 */
	private String doReverse(boolean accrual) {
		Timestamp reversalDate = accrual ? new Timestamp(System.currentTimeMillis()) : getMovementDate();
		try {
			periodClosedCheckForBackDateTrx(reversalDate);
		} catch (PeriodClosedException e) {
			return "Reversal ERROR: " + e.getLocalizedMessage();
		}
		
		MProject project = getParent();
		MProjectIssue reversal = new MProjectIssue (project);
		reversal.set_TrxName(get_TrxName());
		reversal.setM_Locator_ID(getM_Locator_ID());
		reversal.setM_Product_ID(getM_Product_ID());
		reversal.setC_Charge_ID(getC_Charge_ID());
		if (getC_Charge_ID() > 0)
			reversal.setAmt(getAmt().negate());
		reversal.setM_AttributeSetInstance_ID(getM_AttributeSetInstance_ID());
		reversal.setMovementQty(getMovementQty().negate());

		if (getM_InOutLine_ID() > 0)
			reversal.setM_InOutLine_ID(getM_InOutLine_ID());
		else if (getS_TimeExpenseLine_ID() > 0)
			reversal.setS_TimeExpenseLine_ID(getS_TimeExpenseLine_ID());
		else if (getC_InvoiceLine_ID() > 0)
			reversal.setC_InvoiceLine_ID(getC_InvoiceLine_ID());
		else if (getC_ProjectLine_ID() > 0)
			reversal.setC_ProjectLine_ID(getC_ProjectLine_ID());

		reversal.setMovementDate(reversalDate);
		reversal.setDescription("Reversal for Line No " + getLine() + "<"+getC_ProjectIssue_ID()+">");

		// Additional Dimensions
		reversal.setA_Asset_ID(getA_Asset_ID());
		reversal.setC_CostCenter_ID(getC_CostCenter_ID());
		reversal.setC_Department_ID(getC_Department_ID());
		reversal.setC_Employee_ID(getC_Employee_ID());
		reversal.setM_Warehouse_ID(getM_Warehouse_ID());

		reversal.setReversal_ID(getC_ProjectIssue_ID());
		reversal.saveEx(get_TrxName());
		//
		try {
			if (!reversal.processIt(DocAction.ACTION_Complete))
			{
				return "Reversal ERROR: " + reversal.getProcessMsg();
			}
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new AdempiereException(e);
		}

		reversal.closeIt();
		reversal.setProcessing (false);
		reversal.setDocStatus(DocAction.STATUS_Reversed);
		reversal.setDocAction(DocAction.ACTION_None);
		reversal.saveEx(get_TrxName());
		
		setReversal_ID(reversal.getC_ProjectIssue_ID());
		setDocStatus(DOCSTATUS_Reversed);
		setDocAction(DOCACTION_None);
		
		return null;
	} // doReverse
	
	/**
	 * @return true if this is a reversal document created to reverse another document
	 */
	public boolean isReversal() {
		return getReversal_ID() > 0 && (getC_ProjectIssue_ID() > getReversal_ID() || getC_ProjectIssue_ID() == 0);
	}
	
	@Override
	public void setDocStatus(String newStatus) {
		docActionDelegate.setDocStatus(newStatus);
	}

	@Override
	public String getDocStatus() {
		return docActionDelegate.getDocStatus();
	}

	@Override
	public boolean processIt(String action) throws Exception {
		return docActionDelegate.processIt(action);
	}

	@Override
	public boolean unlockIt() {
		return docActionDelegate.unlockIt();
	}

	@Override
	public boolean invalidateIt() {
		return docActionDelegate.invalidateIt();
	}

	@Override
	public String prepareIt() {
		return docActionDelegate.prepareIt();
	}

	@Override
	public boolean approveIt() {
		return docActionDelegate.approveIt();
	}

	@Override
	public boolean rejectIt() {
		return docActionDelegate.rejectIt();
	}

	@Override
	public String completeIt() {
		return docActionDelegate.completeIt();
	}

	@Override
	public boolean voidIt() {
		return docActionDelegate.voidIt();
	}

	@Override
	public boolean closeIt() {
		return docActionDelegate.closeIt();
	}

	@Override
	public boolean reverseCorrectIt()
	{
		if (!docActionDelegate.reverseCorrectIt())
			return false;
		deleteProjectLine();
		if (getC_InvoiceLine_ID() > 0)
			getC_InvoiceLine().setC_Project_ID(0);
		return true;
	}

	@Override
	public boolean reverseAccrualIt()
	{
		if (!docActionDelegate.reverseAccrualIt())
			return false;
		deleteProjectLine();
		if (getC_InvoiceLine_ID() > 0)
			getC_InvoiceLine().setC_Project_ID(0);
		return true;
	}

	/**
	 * Not implemented, always return false
	 */
	@Override
	public boolean reActivateIt() {
		return false;
	}

	/**
	 * Filter project issues by matching invoice line and project
	 *
	 * @param  invLineID - Invoice Line ID
	 * @param  trxName   - Trx Name
	 * @return           {@link MProjectIssue} class {@link PO}
	 */
	public static MProjectIssue getInvLineIssue(int invLineID, String trxName)
	{
		String whereClause = " AD_Client_ID = ? And C_InvoiceLine_ID = ? And IsActive='Y'";
		Query query = new Query(Env.getCtx(), Table_Name, whereClause, trxName);
		MProjectIssue issuePrj = query.setParameters(Env.getAD_Client_ID(Env.getCtx()), invLineID).first();
		return issuePrj;
	} // getInvLineIssue

	@Override
	public String getSummary() {
		String summary = getDocumentInfo();
		if (getM_Product_ID() > 0) {
			summary = summary + "|" + MProduct.get(Env.getCtx(), getM_Product_ID()).getValue() + "|" + getMovementQty().toPlainString(); 
		}
		return summary;
	}

	@Override
	public String getDocumentNo() {
		return getParent().getValue()+"|"+getLine();
	}

	@Override
	public String getDocumentInfo() {
		return getParent().getValue()+"|"+getParent().getName()+"|"+getLine();
	}

	@Override
	public File createPDF() {
		return docActionDelegate.createPDF();
	}

	@Override
	public String getProcessMsg() {
		return docActionDelegate.getProcessMsg();
	}

	@Override
	public int getDoc_User_ID() {
		return getParent().getSalesRep_ID();
	}

	@Override
	public int getC_Currency_ID() {
		return docActionDelegate.getC_Currency_ID();
	}

	@Override
	public BigDecimal getApprovalAmt() {
		return docActionDelegate.getApprovalAmt();
	}

	@Override
	public String getDocAction() {
		return docActionDelegate.getDocAction();
	}

	@Override
	public int customizeValidActions(String docStatus, Object processing, String orderType, String isSOTrx,
			int AD_Table_ID, String[] docAction, String[] options, int index) {		
		// Complete                    ..  CO
		if (AD_Table_ID == get_Table_ID() && docStatus.equals(DocumentEngine.STATUS_Completed)) {
			boolean periodOpen = MPeriod.isOpen(Env.getCtx(), getMovementDate(), MDocType.DOCBASETYPE_ProjectIssue, getAD_Org_ID());
			boolean isBackDateTrxAllowed = MAcctSchema.isBackDateTrxAllowed(Env.getCtx(), getMovementDate(), get_TrxName());
			if (periodOpen && isBackDateTrxAllowed) {
				options[index++] = DocumentEngine.ACTION_Reverse_Correct;
			}
			options[index++] = DocumentEngine.ACTION_Reverse_Accrual;
		}
		return index;
	}

	/**
	 * Period Closed Check for Back-Date Transaction
	 * @param reversalDate reversal date - null when it is not a reversal
	 * @return false when failed the period closed check
	 */
	private boolean periodClosedCheckForBackDateTrx(Timestamp reversalDate)
	{
		MClientInfo info = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName()); 
		MAcctSchema as = info.getMAcctSchema1();
		if (!MAcctSchema.COSTINGMETHOD_AveragePO.equals(as.getCostingMethod()) 
				&& !MAcctSchema.COSTINGMETHOD_AverageInvoice.equals(as.getCostingMethod()))
			return true;
		
		if (as.getBackDateDay() == 0)
			return true;
		
		Timestamp dateAcct = reversalDate != null ? reversalDate : getMovementDate();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) FROM M_CostDetail ");
		sql.append("WHERE M_Product_ID IN (SELECT M_Product_ID FROM C_ProjectIssue WHERE C_ProjectIssue_ID=?) ");
		sql.append("AND Processed='Y' ");
		sql.append(reversalDate != null ? "AND DateAcct>=? " : "AND DateAcct>? ");
		int no = DB.getSQLValueEx(get_TrxName(), sql.toString(), get_ID(), dateAcct);
		if (no <= 0)
			return true;
		
		int AD_Org_ID = getAD_Org_ID();
		int M_AttributeSetInstance_ID = getM_AttributeSetInstance_ID();

		if (MAcctSchema.COSTINGLEVEL_Client.equals(as.getCostingLevel()))
		{
			AD_Org_ID = 0;
			M_AttributeSetInstance_ID = 0;
		}
		else if (MAcctSchema.COSTINGLEVEL_Organization.equals(as.getCostingLevel()))
			M_AttributeSetInstance_ID = 0;
		else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(as.getCostingLevel()))
			AD_Org_ID = 0;
		
		MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), as.getCostingMethod(), AD_Org_ID);
		
		int M_CostDetail_ID = 0;
		int C_ProjectIssue_ID = getC_ProjectIssue_ID();
		if (getReversal_ID() > 0 && get_ID() > getReversal_ID())
			C_ProjectIssue_ID = getReversal_ID();
		
		MCostDetail cd = MCostDetail.getProjectIssue(as, getM_Product_ID(), M_AttributeSetInstance_ID, 
				C_ProjectIssue_ID, 0, get_TrxName());
		if (cd != null)
			M_CostDetail_ID = cd.getM_CostDetail_ID();
		else {
			MCostHistory history = MCostHistory.get(getCtx(), getAD_Client_ID(), AD_Org_ID, getM_Product_ID(), 
					as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getCostingMethod(), ce.getM_CostElement_ID(),
					M_AttributeSetInstance_ID, dateAcct, get_TrxName());
			if (history != null)
				M_CostDetail_ID = history.getM_CostDetail_ID();
		}
		
		if (M_CostDetail_ID > 0) {
			MCostDetail.periodClosedCheckForDocsAfterBackDateTrx(getAD_Client_ID(), as.getC_AcctSchema_ID(), 
					getM_Product_ID(), M_CostDetail_ID, dateAcct, get_TrxName());
		}
		return true;
	}

	/**
	 * Update Project Balance on Project issue posted
	 * 
	 * @param isCreaditAmt true than Reduce Project Balance Amt otherwise Project Balance Amt is Add
	 *                     cost of Project Issue
	 */
	private BigDecimal updateBalanceAmt()
	{
		MProject proj = (MProject) getC_Project();
		BigDecimal cost = Env.ZERO;
		MAcctSchema as = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID(), get_TrxName())[0];
		if (getM_InOutLine_ID() > 0)
		{
			cost = ProjectIssueUtil.getPOCost(as, getM_InOutLine_ID(), getMovementQty());
		}
		else if (getS_TimeExpenseLine_ID() > 0)
		{
			cost = ProjectIssueUtil.getLaborCost(as, getS_TimeExpenseLine_ID());
		}
		else if (getC_InvoiceLine_ID() > 0)
		{
			cost = getInvLineAmt((MInvoiceLine) getC_InvoiceLine());
		}
		else if(getC_Charge_ID() > 0) {
			cost = getAmt();
		}
		else
		{
			cost = ProjectIssueUtil.getProductCosts(as, (MProduct) getM_Product(), getM_AttributeSetInstance_ID(), getAD_Org_ID(), getMovementQty(), true);
		}

		if (cost == null && getM_Product_ID() > 0) // standard Product Costs
		{
			cost = ProjectIssueUtil.getProductStdCost(as, getAD_Org_ID(), getM_Product_ID(), getM_AttributeSetInstance_ID(), get_TrxName(), getMovementQty());
		}

		if (cost != null)
		{
			proj.setProjectBalanceAmt(proj.getProjectBalanceAmt().add(cost));
			proj.saveEx(get_TrxName());
		}
		if (getReversal_ID() < 0 && (cost == null || cost.signum() <= 0))
		{
			throw new IllegalArgumentException(	"Product: ("	+ getM_Product().getName() + ") is not present at Locator: (" +
												getM_Locator().getM_Warehouse().getValue() + ") for ASI: (" + getM_AttributeSetInstance().getDescription()
												+ ")");
		}
		return cost;
	} // updateBalanceAmt
	
	 /* Line On Invoice line set Project
	 * @param trxName
	 */
	private String setProject(String trxName)
	{
		if (getM_InOutLine_ID() > 0)
		{
			MInOutLine intOutLine = (MInOutLine) getM_InOutLine();

			if (intOutLine.getC_Project_ID() <= 0)
			{
				intOutLine.setC_Project_ID(getC_Project_ID());
				intOutLine.save(trxName);
			}
			else if (intOutLine.getC_Project_ID() > 0 && intOutLine.getC_Project_ID() != getC_Project_ID())
				return "Time Expense Line(" + intOutLine.getLine() + ") is created for another Project ( Project ID: " + intOutLine.getC_Project_ID() + " )";
		}
		else if (getS_TimeExpenseLine_ID() > 0)
		{
			MTimeExpenseLine expLine = (MTimeExpenseLine) getS_TimeExpenseLine();

			if (expLine.getC_Project_ID() > 0)
			{
				expLine.setC_Project_ID(getC_Project_ID());
				expLine.save(trxName);
			}
			else if (expLine.getC_Project_ID() > 0 && expLine.getC_Project_ID() != getC_Project_ID())
				return "Time Expense Line(" + expLine.getLine() + ") is created for another Project ( Project ID: " + expLine.getC_Project_ID() + " )";
		}
		else if (getC_InvoiceLine_ID() > 0)
		{
			MInvoiceLine invLine = (MInvoiceLine) getC_InvoiceLine();
			if (invLine.getC_Project_ID() <= 0)
			{
				invLine.setC_Project_ID(getC_Project_ID());
				invLine.saveEx(get_TrxName());
			}
			else if (invLine.getC_Project_ID() > 0 && invLine.getC_Project_ID() != getC_Project_ID())
				return "Invoice Line(" + invLine.getLine() + ") is created for another Project ( Project ID: " + invLine.getC_Project_ID() + " )";
		}
		return null;
	} // setProjectOnInvLine

	/**
	 * Delete Project Line related to Project Issue
	 */
	private void deleteProjectLine()
	{
		DB.executeUpdate("Delete From C_ProjectLine Where C_ProjectIssue_ID = ?", get_ID(), get_TrxName());
	} // deleteProjectLine

	/**
	 * Get Project Issue Description from Invoice Line
	 */
	public static String getInvDescription(MInvoiceLine invLine)
	{
		if (!Util.isEmpty(invLine.getDescription()))
			return invLine.getDescription();
		else if (!Util.isEmpty(invLine.getC_Invoice().getDescription()))
			return invLine.getC_Invoice().getDescription();
		return null;
	} // getInvDescription

	/**
	 * Get Project Issue Description from In Out Line
	 */
	public static String getInOutLineDesc(MInOutLine inOutLine)
	{
		if (inOutLine.getDescription() != null)
			return inOutLine.getDescription();
		else if (inOutLine.getM_InOut().getDescription() != null)
			return inOutLine.getM_InOut().getDescription();
		return null;
	} // getInOutLineDesc

	/**
	 * Get Amt from Invoice Line 
	 * @return	If Doc. Base Type is APCredit Memo than AMT is negate else positive
	 */
	public static BigDecimal getInvLineAmt(MInvoiceLine invLine)
	{
		if (MDocType.DOCBASETYPE_APCreditMemo.equals((invLine.getC_Invoice().getC_DocType().getDocBaseType())))
			return invLine.getLineNetAmt().negate();
		else
			return invLine.getLineNetAmt();
	} // getInvLineAmt

	/**
	 * Get locator form Time Expense Line
	 * @param expenseLine
	 */
	public static int getExpenseLineLocator(MTimeExpenseLine expenseLine)
	{
		int M_Locator_ID = 0;

		M_Locator_ID = MStorageOnHand.getM_Locator_ID(	expenseLine.getS_TimeExpense().getM_Warehouse_ID(),
														expenseLine.getM_Product_ID(), 0, // no ASI
														expenseLine.getQty(), null);

		if (M_Locator_ID == 0) // Service/Expense - get default (and fallback)
			M_Locator_ID = ((MTimeExpense) expenseLine.getS_TimeExpense()).getM_Locator_ID();
		return M_Locator_ID;
	} // getExpenseLineLocator

	/**
	 * Check Project Issue already has Invoice Line reference present
	 * 
	 * @return true if exists
	 */
	public static boolean projectIssueHasInvoiceLine(int invoiceLineID, String trxName)
	{
		List<MProjectIssue> list = new Query(Env.getCtx(), MProjectIssue.Table_Name, "C_InvoiceLine_ID= ? AND DocStatus NOT IN ('VO', 'RE') ", trxName)
									.setParameters(invoiceLineID)
									.list();

		return list.size() > 0;
	} // projectIssueHasInvoiceLine

	/**
	 * Check if Project Issue already has Expense
	 * 
	 * @param  S_TimeExpenseLine_ID line
	 * @return                      true if exists
	 */
	public static boolean projectIssueHasExpense(int S_TimeExpenseLine_ID, String trxName)
	{
		List<MProjectIssue> list = new Query(Env.getCtx(), MProjectIssue.Table_Name, "S_TimeExpenseLine_ID= ? AND DocStatus NOT IN ('VO', 'RE') ", trxName)
									.setParameters(S_TimeExpenseLine_ID)
									.list();

		return list.size() > 0;
	} // projectIssueHasExpense

	/**
	 * Check if Project Issue already has Receipt
	 * 
	 * @param  M_InOutLine_ID line
	 * @return                true if exists
	 */
	public static boolean projectIssueHasReceipt(int M_InOutLine_ID, String trxName)
	{
		List<MProjectIssue> list = new Query(Env.getCtx(), MProjectIssue.Table_Name, "M_InOutLine_ID= ? AND DocStatus NOT IN ('VO', 'RE') ", trxName)
									.setParameters(M_InOutLine_ID)
									.list();

		return list.size() > 0;
	} // projectIssueHasReceipt

}	//	MProjectIssue
