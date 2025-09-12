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
package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.logging.Level;

import org.compiere.model.ICostInfo;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MDocType;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MInventoryLineMA;
import org.compiere.model.MProduct;
import org.compiere.model.ProductCost;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Post Inventory Documents.
 *  <pre>
 *  Table:              M_Inventory (321)
 *  Document Types:     MMI
 *  </pre>
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs
 * 	@author red1
 * 			<li>BF [ 2982994 ]  Internal Use Inventory does not reverse Accts
 *  @version  $Id: Doc_Inventory.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_Inventory extends Doc
{
	protected int				m_Reversal_ID = 0;
	protected String			m_DocStatus = "";
	protected String parentDocSubTypeInv;

	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_Inventory (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MInventory.class, rs, DOCTYPE_MatInventory, trxName);
	}   //  Doc_Inventory

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	@Override
	protected String loadDocumentDetails()
	{		
		MInventory inventory = (MInventory)getPO();
		setDateDoc (inventory.getMovementDate());
		setDateAcct(inventory.getMovementDate());
		m_Reversal_ID = inventory.getReversal_ID();//store original (voided/reversed) document
		m_DocStatus = inventory.getDocStatus();
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		parentDocSubTypeInv = dt.getDocSubTypeInv();
		
		// IDEMPIERE-3046 Add Currency Field to Cost Adjustment Window 
		if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(parentDocSubTypeInv))
		{
			if (inventory.getC_Currency_ID() == 0)
				setC_Currency_ID(MClient.get(getCtx()).getAcctSchema().getC_Currency_ID()); 
		} else 
		{
			setC_Currency_ID (NO_CURRENCY);	
		}
		
		//	Contained Objects
		p_lines = loadLines(inventory);
		if (log.isLoggable(Level.FINE)) log.fine("Lines=" + p_lines.length);
		return null;
	}   //  loadDocumentDetails

	/**
	 *	Load inventory lines
	 *	@param inventory inventory
	 *  @return DocLine Array
	 */
	protected DocLine[] loadLines(MInventory inventory)
	{		
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		MInventoryLine[] lines = inventory.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInventoryLine line = lines[i];
			if (!line.isActive())
				continue;

			String docSubTypeInv;
			if (Util.isEmpty(parentDocSubTypeInv)) {
				// IDEMPIERE-675: for backward compatibility - to post old
				// documents that could have subtypeinv empty
				if (line.getQtyInternalUse().signum() != 0) {
					docSubTypeInv = MDocType.DOCSUBTYPEINV_InternalUseInventory;
				} else {
					docSubTypeInv = MDocType.DOCSUBTYPEINV_PhysicalInventory;
				}
			} else {
				docSubTypeInv = parentDocSubTypeInv;
			}

			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(line.getProduct().getCostingLevel(m_as))
					&& line.getM_AttributeSetInstance_ID() <= 0
					&& (MDocType.DOCSUBTYPEINV_InternalUseInventory.equals(docSubTypeInv) || MDocType.DOCSUBTYPEINV_PhysicalInventory
							.equals(docSubTypeInv)))
			{
				MInventoryLineMA[] lineMAs = MInventoryLineMA.get(getCtx(), line.get_ID(), getTrxName());
				HashMap<Integer, DocLine> map = new HashMap<Integer, DocLine>();

				for (MInventoryLineMA lineMA : lineMAs)
				{
					if (lineMA.getMovementQty() == null || lineMA.getMovementQty().signum() == 0)
					{
						continue;
					}
					
					if (!map.containsKey(lineMA.getM_AttributeSetInstance_ID()))
					{
						DocLine docLine = new DocLine(line, this, lineMA);
						docLine.setM_AttributeSetInstance_ID(lineMA.getM_AttributeSetInstance_ID());
						docLine.setQty(lineMA.getMovementQty().negate(), false);
						docLine.setReversalLine_ID(line.getReversalLine_ID());
						if (log.isLoggable(Level.FINE))
							log.fine(docLine.toString());
						map.put(lineMA.getM_AttributeSetInstance_ID(), docLine);
					}
					else
					{
						DocLine docLine = map.get(lineMA.getM_AttributeSetInstance_ID());
						BigDecimal qty = docLine.getQty();
						qty = qty == null ? Env.ZERO : qty;
						docLine.setQty(qty.add(lineMA.getMovementQty().negate()), false);
						if (docLine.getQty().compareTo(Env.ZERO) == 0)
						{
							map.remove(lineMA.getM_AttributeSetInstance_ID());
						}
					}
				}
				list.addAll(map.values());
			}
			else
			{
				BigDecimal qtyDiff = Env.ZERO;
				BigDecimal amtDiff = Env.ZERO;
				if (MDocType.DOCSUBTYPEINV_InternalUseInventory.equals(docSubTypeInv))
					qtyDiff = line.getQtyInternalUse().negate();
				else if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
					qtyDiff = line.getQtyCount().subtract(line.getQtyBook());
				else if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docSubTypeInv))
					amtDiff = line.getNewCostPrice().subtract(line.getCurrentCostPrice());
				// nothing to post
				if (qtyDiff.signum() == 0 && amtDiff.signum() == 0)
					continue;
				//
				DocLine docLine = new DocLine(line, this);
				docLine.setM_AttributeSetInstance_ID(line.getM_AttributeSetInstance_ID());
				docLine.setQty(qtyDiff, false); // -5 => -5
				if (amtDiff.signum() != 0)
				{
					docLine.setAmount(amtDiff);
				}
				docLine.setReversalLine_ID(line.getReversalLine_ID());
				if (log.isLoggable(Level.FINE)) log.fine(docLine.toString());
				list.add(docLine);
			}
		}
		
		// Sort lines in the decreasing order of MovementQty
		Collections.sort(list, new Comparator<DocLine>() {
			@Override
			public int compare(DocLine line1, DocLine line2)
			{
				return line1.getQty().compareTo(line2.getQty()) * (-1);
			}
		});

		//	Return Array
		DocLine[] dls = new DocLine[list.size()];
		list.toArray(dls);
		return dls;
	}	//	loadLines

	/**
	 *  Get Balance
	 *  @return Zero (always balanced)
	 */
	@Override
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  MMI.
	 *  <pre>
	 *  Inventory
	 *      Inventory       DR      CR
	 *      InventoryDiff   DR      CR   (or Charge)
	 *  </pre>
	 *  @param as account schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);

		if (!MDocType.DOCSUBTYPEINV_CostAdjustment.equals(parentDocSubTypeInv))
			setC_Currency_ID(as.getC_Currency_ID());

		//  Line pointers
		FactLine dr = null;
		FactLine cr = null;

		MInventory inventory = (MInventory) getPO();
		boolean costAdjustment = MDocType.DOCSUBTYPEINV_CostAdjustment.equals(parentDocSubTypeInv);
		String docCostingMethod = inventory.getCostingMethod();
		
		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			
			boolean doPosting = true;
			String costingLevel = null;
			MProduct product = line.getProduct();;
			if (costAdjustment)
			{				
				if (!product.isStocked())
				{
					doPosting = false;
				}
				else
				{
					String productCostingMethod = product.getCostingMethod(as);
					costingLevel = product.getCostingLevel(as);
					if (!docCostingMethod.equals(productCostingMethod))
					{
						doPosting = false;
					}
				}
			}
			
			BigDecimal costs = null;
			BigDecimal adjustmentDiff = null;
			if (costAdjustment)
			{
				int orgId = line.getAD_Org_ID();
				int asiId = line.getM_AttributeSetInstance_ID();
				if (MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel))
				{
					orgId = 0;
					asiId = 0;
				}
				else if (MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel))
					asiId = 0;
				else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
					orgId = 0;
				MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), docCostingMethod, orgId);
				MCostDetail cd = MCostDetail.getInventory(as, product.getM_Product_ID(), asiId, get_ID(), ce.getM_CostElement_ID(), getTrxName());
				ICostInfo cost = MCost.getCostInfo(product, asiId, as, 
						orgId, ce.getM_CostElement_ID(), 
						getDateAcct(), cd, getTrxName());
				BigDecimal currentQty = cost.getCurrentQty();
				adjustmentDiff = costs;
				costs = costs.multiply(currentQty);
			}
			else 
			{
				//if product type expense and stocked, then no needs to do posting
                if(MProduct.PRODUCTTYPE_ExpenseType.equals(product.getProductType()) && product.isStocked()) {
                    continue;
                }
                
				if (!isReversal(line))
				{
					// MZ Goodwill
					// if Physical Inventory CostDetail is exist then get Cost from Cost Detail
					costs = line.getProductCosts(as, line.getAD_Org_ID(), true, "M_InventoryLine_ID=?");
					// end MZ	
					if (costs == null || costs.signum() == 0)
					{
						if (product.isStocked())
						{
							//ok if we have purchased zero cost item from vendor before
							String sql="SELECT Count(*) FROM M_CostDetail WHERE M_Product_ID=? AND Processed='Y' AND Amt=0.00 AND ((Qty > 0 AND (C_OrderLine_ID > 0 OR C_InvoiceLine_ID > 0)) OR M_InventoryLine_ID > 0)"
									+ " AND AD_Client_ID = ? ";
							ArrayList<Integer> list = new ArrayList<Integer>();
							list.add(product.getM_Product_ID());
							list.add(getAD_Client_ID());
							
							if(MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
							{
								sql = "SELECT Count(*) FROM M_CostDetail WHERE M_Product_ID=? AND Processed='Y' AND Amt=0.00 AND ((Qty > 0 AND (C_OrderLine_ID > 0 OR C_InvoiceLine_ID > 0)) OR M_InventoryLine_ID > 0)"
									+ " AND AD_Client_ID = ? AND M_AttributeSetInstance_ID=?";
								list.add(line.getM_AttributeSetInstance_ID());
							}
							
							int count = DB.getSQLValue(null,sql,list.toArray());
							if (count > 0)
							{
								costs = BigDecimal.ZERO;
							}
							else
							{
								p_Error = "No Costs for line " + line.getLine() +"-"+ line.getProduct().getName() ;
								log.log(Level.WARNING, p_Error);
								return null;
							}
						}
						else	//	ignore service
							doPosting = false;
					}
				}
				else
				{
					//updated below
					costs = Env.ONE;
				}
			}
			
			if (doPosting)
			{		
				int C_Currency_ID = getC_Currency_ID() > 0 ? getC_Currency_ID() : as.getC_Currency_ID();
				//  Inventory       DR      CR
				dr = fact.createLine(line,
					line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
					C_Currency_ID, costs);
				//  may be zero difference - no line created.
				if (dr != null)
				{
					dr.setM_Locator_ID(line.getM_Locator_ID());
					if (isReversal(line))
					{
						//	Set AmtAcctDr from Original Phys.Inventory
						if (!dr.updateReverseLine (MInventory.Table_ID,
								m_Reversal_ID, line.getReversalLine_ID(),Env.ONE))
						{
							p_Error = "Original Physical Inventory not posted yet";
							return null;
						}
						costs = dr.getAcctBalance(); //get original cost
					}
		
					//  InventoryDiff   DR      CR
					//	or Charge
					MAccount invDiff = null;
					if (isReversal(line)
							&& line.getC_Charge_ID() != 0) {
						invDiff = line.getChargeAccount(as, costs);
					} else {
						invDiff = line.getChargeAccount(as, costs.negate());
					}
		
					if (invDiff == null)
					{
						if (costAdjustment)
						{
							invDiff = line.getProductCost().getAccount(ProductCost.ACCTTYPE_P_CostAdjustment, as);
						}
						else
						{
							invDiff = getAccount(Doc.ACCTTYPE_InvDifferences, as);
						}
					}
					cr = fact.createLine(line, invDiff,
							C_Currency_ID, costs.negate());
					if (cr != null)
					{
						cr.setM_Locator_ID(line.getM_Locator_ID());
						cr.setQty(line.getQty().negate());
						if (line.getC_Charge_ID() != 0)	//	explicit overwrite for charge
							cr.setAD_Org_ID(line.getAD_Org_ID());
			
						if (isReversal(line))
						{
							//	Set AmtAcctCr from Original Phys.Inventory
							if (!cr.updateReverseLine (MInventory.Table_ID,
									m_Reversal_ID, line.getReversalLine_ID(),Env.ONE, dr))
							{
								p_Error = "Original Physical Inventory not posted yet";
								return null;
							}							
						}
					}
				}
			}

			if (doPosting || costAdjustment)
			{
				BigDecimal costDetailAmt = costAdjustment ? adjustmentDiff : costs;
				if (costAdjustment && getC_Currency_ID() > 0 && getC_Currency_ID() != as.getC_Currency_ID()) 
				{
					costDetailAmt = MConversionRate.convert (getCtx(),
							costDetailAmt, getC_Currency_ID(), as.getC_Currency_ID(),
							getDateAcct(), 0, getAD_Client_ID(), getAD_Org_ID(), true);
				}
				if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(product.getCostingLevel(as)) ) 
				{
					if (line.getM_AttributeSetInstance_ID() == 0 ) 
					{
						MInventoryLine invLine = (MInventoryLine) line.getPO();
						MInventoryLineMA mas[] = MInventoryLineMA.get(getCtx(), invLine.get_ID(), getTrxName());
						if (mas != null && mas.length > 0 )
						{
							costs  = BigDecimal.ZERO;
							for (int j = 0; j < mas.length; j++)
							{
								MInventoryLineMA ma = mas[j];				
								BigDecimal maCost = costMap.get(line.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID());		
								BigDecimal qty = ma.getMovementQty();
								if (qty.signum() != line.getQty().signum())
									qty = qty.negate();
								if (maCost.signum() != costDetailAmt.signum())
									maCost = maCost.negate();
								int Ref_CostDetail_ID = 0;
								if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
								{
									MCostDetail cd = MCostDetail.getInventory(as, line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
											line.getReversalLine_ID(), 0, getTrxName());
									if (cd != null)
										Ref_CostDetail_ID = cd.getM_CostDetail_ID();
								}
								if (!MCostDetail.createInventory(as, line.getAD_Org_ID(),
										line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
										line.get_ID(), 0,
										maCost, qty,
										line.getDescription(), line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
								{
									p_Error = "Failed to create cost detail record";
									return null;
								}
							}						
						}
					} 
					else
					{
						BigDecimal amt = costDetailAmt;
						int Ref_CostDetail_ID = 0;
						if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
						{
							MCostDetail cd = MCostDetail.getInventory(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
									line.getReversalLine_ID(), 0, getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						if (!MCostDetail.createInventory(as, line.getAD_Org_ID(),
								line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.get_ID(), 0,
								amt, line.getQty(),
								line.getDescription(), line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
						{
							p_Error = "Failed to create cost detail record";
							return null;
						}
					}
				} 
				else
				{
					//	Cost Detail
					BigDecimal amt = costDetailAmt;
					int Ref_CostDetail_ID = 0;
					if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
					{
						MCostDetail cd = MCostDetail.getInventory(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.getReversalLine_ID(), 0, getTrxName());
						if (cd != null)
							Ref_CostDetail_ID = cd.getM_CostDetail_ID();
					}
					if (!MCostDetail.createInventory(as, line.getAD_Org_ID(),
						line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
						line.get_ID(), 0,
						amt, line.getQty(),
						line.getDescription(), line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						p_Error = "Failed to create cost detail record";
						return null;
					}
				}
			}
		}
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact

	/**
	 * @param line
	 * @return true if line is for reversal
	 */
	private boolean isReversal(DocLine line) {
		return m_Reversal_ID !=0 && line.getReversalLine_ID() != 0;
	}

	@Override
	public boolean isNoPostingRequired()
	{
		return super.isNoPostingRequired() || isReversalAlsoNotPosted();
	}

	/**
	 * Checks if the reversal document is also not posted.
	 * If the reverse correction posting is marked for deletion and the document
	 * has a reversal entry, it retrieves the reversal document, checks its
	 * posting status, and updates it to "No Posting Required" if necessary.
	 * 
	 * @return {@code true} if the reversal document was not posted and is now updated;
	 *         {@code false} otherwise.
	 */
	public boolean isReversalAlsoNotPosted()
	{
		if (m_as.isDeleteReverseCorrectPosting() && m_Reversal_ID > 0)
		{
			MInventory inventory = (MInventory) getPO();
			MInventory rev_inventory = (MInventory) inventory.getReversal();
			if (Util.compareDate(inventory.getMovementDate(), rev_inventory.getMovementDate()) == 0 && isNoCostDetailCreated(inventory, rev_inventory))
			{
				String revpostedsql = "SELECT Posted FROM M_Inventory WHERE M_Inventory_ID=?";
				String posted = DB.getSQLValueStringEx(getTrxName(), revpostedsql, rev_inventory.get_ID());
				if (!STATUS_Posted.equalsIgnoreCase(posted) && !STATUS_NoPostingRequired.equalsIgnoreCase(posted))
				{
					DocManager.save(getTrxName(), MInventory.Table_ID, inventory.getReversal_ID(), STATUS_NoPostingRequired);
					return true;
				}
			}
		}
		return false;
	}// isReversalAlsoNotPosted

	/**
	 * Checks if no cost detail has been created for the given Inventory records.
	 * 
	 * @param  inventory    The Inventory document.
	 * @param  revInventory The reverse Inventory document.
	 * @return              true if no cost detail exists for any line in both documents, false
	 *                      otherwise.
	 */
	public boolean isNoCostDetailCreated(MInventory inventory, MInventory revInventory)
	{
		String sql = "SELECT COUNT(1) "
						+ "FROM M_CostDetail cd "
							+ " WHERE cd.M_InventoryLine_ID IN ( "
							+ "     SELECT il.M_InventoryLine_ID FROM M_InventoryLine il WHERE il.M_Inventory_ID IN (?, ?) "
							+ " ) "
							+ " AND cd.C_AcctSchema_ID = ? AND cd.IsActive = 'Y' ";
	       int count = DB.getSQLValue(getTrxName(), sql, inventory.getM_Inventory_ID(), revInventory.getM_Inventory_ID(), m_as.getC_AcctSchema_ID());
	       return count <= 0;
	}// isNoCostDetailCreated

}   //  Doc_Inventory
