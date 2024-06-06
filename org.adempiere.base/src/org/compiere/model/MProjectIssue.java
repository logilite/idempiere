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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.NegativeInventoryDisallowedException;
import org.adempiere.util.ProjectIssueUtil;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 	Project Issue Model
 *
 *	@author Jorg Janke
 *	@version $Id: MProjectIssue.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MProjectIssue extends X_C_ProjectIssue
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4714411434615096132L;

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
		{
		//	setC_Project_ID (0);
		//	setLine (0);
		//	setM_Locator_ID (0);
		//	setM_Product_ID (0);
		//	setMovementDate (new Timestamp(System.currentTimeMillis()));
			setMovementQty (Env.ZERO);
			setPosted (false);
			setProcessed (false);
		}
	}	//	MProjectIssue

	/**
	 * 	Load Constructor
	 * 	@param ctx context
	 * 	@param rs result set
	 *	@param trxName transaction
	 */
	public MProjectIssue (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
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
	//	setM_Locator_ID (0);
	//	setM_Product_ID (0);
		//
		setMovementDate (new Timestamp(System.currentTimeMillis()));
		setMovementQty (Env.ZERO);
		setPosted (false);
		setProcessed (false);
	}	//	MProjectIssue

	/**	Parent				*/
	private MProject	m_parent = null;
	
	/**
	 *	Get the next Line No
	 * 	@return next line no
	 */
	private int getNextLine()
	{
		return DB.getSQLValue(get_TrxName(), 
			"SELECT COALESCE(MAX(Line),0)+10 FROM C_ProjectIssue WHERE C_Project_ID=?", getC_Project_ID());
	}	//	getLineFromProject

	/**
	 * 	Set Mandatory Values
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
		if (getM_Product_ID() <= 0 && getC_Charge_ID() <= 0)
		{
			log.saveError("Error", "Product or Charge is not present in Invoice :"	+ getC_InvoiceLine().getC_Invoice().getDocumentNo()
									+ " Invoice Line No.: " + getC_InvoiceLine().getLine());
			return false;
		}
		if (getM_Product_ID() > 0 && getM_Locator_ID() <= 0)
		{
			log.saveError("Error", "Locator is not present in Invoice :"	+ getC_InvoiceLine().getC_Invoice().getDocumentNo()
									+ " Invoice Line No.: " + getC_InvoiceLine().getLine());
			return false;
		}
		return super.beforeSave(newRecord);
	}

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
	
	/**************************************************************************
	 * 	Process Issue
	 *	@return true if processed
	 */
	public boolean process()
	{
		if (!save())
			return false;
		
		int productID = getM_Product_ID();
		int chargeID = getC_Charge_ID();
		if (productID <= 0 && chargeID <= 0)
		{
			log.log(Level.SEVERE, "Product Or Charge is not Present");
			return false;
		}

		/** @todo Transaction */

		MTransaction mTrx = null;
		
		if (productID > 0)
		{
			MProduct product = MProduct.get (getCtx(), productID);
			
			//	If not a stocked Item nothing to do
			if (!product.isStocked())
			{
				setProcessed(true);
				updateBalanceAmt();
				return save();
			}
			
			//	**	Create Material Transactions **
			mTrx = new MTransaction (getCtx(), getAD_Org_ID(), 
				MTransaction.MOVEMENTTYPE_WorkOrderPlus,
				getM_Locator_ID(), productID, getM_AttributeSetInstance_ID(),
				getMovementQty().negate(), getMovementDate(), get_TrxName());
			mTrx.setC_ProjectIssue_ID(getC_ProjectIssue_ID());
			//
			MLocator loc = MLocator.get(getCtx(), getM_Locator_ID());
			
			Timestamp dateMPolicy = getMovementDate();
			
			if(getM_AttributeSetInstance_ID()>0){
				Timestamp t = MStorageOnHand.getDateMaterialPolicy(productID, getM_AttributeSetInstance_ID(), get_TrxName());
				if (t != null)
					dateMPolicy = t;
			}
			
			boolean ok = true;
			try
			{
				if (getMovementQty().negate().signum() < 0)
				{
					String MMPolicy = product.getMMPolicy();
					Timestamp minGuaranteeDate = getMovementDate();
					int M_Warehouse_ID = getM_Locator_ID() > 0 ? getM_Locator().getM_Warehouse_ID() : getC_Project().getM_Warehouse_ID();
					MStorageOnHand[] storages = MStorageOnHand.getWarehouse(getCtx(), M_Warehouse_ID, productID, getM_AttributeSetInstance_ID(),
							minGuaranteeDate, MClient.MMPOLICY_FiFo.equals(MMPolicy), true, getM_Locator_ID(), get_TrxName(), true);
					BigDecimal qtyToIssue = getMovementQty();
					for (MStorageOnHand storage: storages)
					{
						if (storage.getQtyOnHand().compareTo(qtyToIssue) >= 0)
						{
							storage.addQtyOnHand(qtyToIssue.negate());
							qtyToIssue = BigDecimal.ZERO;
						}
						else
						{
							qtyToIssue = qtyToIssue.subtract(storage.getQtyOnHand());
							storage.addQtyOnHand(storage.getQtyOnHand().negate());
						}
	
						if (qtyToIssue.signum() == 0)
							break;
					}
					if (qtyToIssue.signum() > 0)
					{
						ok = MStorageOnHand.add(getCtx(), loc.getM_Warehouse_ID(), getM_Locator_ID(), 
								productID, getM_AttributeSetInstance_ID(),
								qtyToIssue.negate(),dateMPolicy, get_TrxName());
					}
				} 
				else 
				{
					ok = MStorageOnHand.add(getCtx(), loc.getM_Warehouse_ID(), getM_Locator_ID(), 
							productID, getM_AttributeSetInstance_ID(),
							getMovementQty().negate(),dateMPolicy, get_TrxName());				
				}
			}
			catch (NegativeInventoryDisallowedException e)
			{
				log.severe(e.getMessage());
				StringBuilder error = new StringBuilder();
				error.append(Msg.getElement(getCtx(), "Line")).append(" ").append(getLine()).append(": ");
				error.append(e.getMessage()).append("\n");
				throw new AdempiereException(error.toString());
			}
		
			if (ok)
			{
				if (mTrx != null && mTrx.save(get_TrxName()))
				{
					setProcessed(true);
					updateBalanceAmt();
					if (save())
						return true;
					else
						log.log(Level.SEVERE, "Issue not saved");
				}
				else
					log.log(Level.SEVERE, "Transaction not saved"); // requires trx !!
			}
			else
				log.log(Level.SEVERE, "Storage not updated");			//	OK
		}
		else if (chargeID > 0)
		{
			setProcessed(true);
			updateBalanceAmt();
			if (save())
				return true;
			else
				log.log(Level.SEVERE, "Issue not saved"); // requires trx !!
		}
		//
		return false;
	}	//	process

	/**
	 * Update Project Balance on Project issue posted
	 */
	private void updateBalanceAmt()
	{
		MProject proj = (MProject) getC_Project();
		BigDecimal cost = Env.ZERO;
		if (getM_InOutLine_ID() > 0)
		{
			cost = ProjectIssueUtil.getPOCost(MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID(), get_TrxName())[0], getM_InOutLine_ID(), getMovementQty());
		}
		else if (getS_TimeExpenseLine_ID() > 0)
		{
			cost = ProjectIssueUtil.getLaborCost(MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID(), get_TrxName())[0], getS_TimeExpenseLine_ID());
		}
		else if (getC_InvoiceLine_ID()>0)
		{
			cost = getAmt(); 
		}
		else
		{
			cost = ProjectIssueUtil.getProductCosts(MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID(), get_TrxName())[0], (MProduct) getM_Product(),
													getM_AttributeSetInstance_ID(), getAD_Org_ID(), getMovementQty(), true);
		}
		if(cost!=null)
		{
			proj.setProjectBalanceAmt(proj.getProjectBalanceAmt().add(cost));
			proj.saveEx(get_TrxName());
		}
	} // updateBalanceAmt

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
}	//	MProjectIssue
