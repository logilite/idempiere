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
import java.util.HashMap;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCostDetail;
import org.compiere.model.MMovement;
import org.compiere.model.MMovementLine;
import org.compiere.model.MMovementLineMA;
import org.compiere.model.MProduct;
import org.compiere.model.ProductCost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *  Post Invoice Documents.
 *  <pre>
 *  Table:              M_Movement (323)
 *  Document Types:     MMM
 *  </pre>
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs
 *  @version  $Id: Doc_Movement.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_Movement extends Doc
{
	protected int				m_Reversal_ID = 0;
	protected String			m_DocStatus = "";

	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_Movement (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MMovement.class, rs, DOCTYPE_MatMovement, trxName);
	}   //  Doc_Movement

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	protected String loadDocumentDetails()
	{
		setC_Currency_ID(NO_CURRENCY);
		MMovement move = (MMovement)getPO();
		setDateDoc (move.getMovementDate());
		setDateAcct(move.getMovementDate());
		m_Reversal_ID = move.getReversal_ID();//store original (voided/reversed) document
		m_DocStatus = move.getDocStatus();
		//	Contained Objects
		p_lines = loadLines(move);
		if (log.isLoggable(Level.FINE)) log.fine("Lines=" + p_lines.length);
		return null;
	}   //  loadDocumentDetails

	/**
	 *	Load Invoice Line
	 *	@param move move
	 *  @return document lines (DocLine_Material)
	 */
	protected DocLine[] loadLines(MMovement move)
	{
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		MMovementLine[] lines = move.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MMovementLine line = lines[i];
			if(!line.isActive())
				continue;
			
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(line.getProduct().getCostingLevel(m_as))
					&& line.getM_AttributeSetInstance_ID() <= 0)
			{
				MMovementLineMA[] lineMAs = MMovementLineMA.get(getCtx(), line.get_ID(), getTrxName());

				HashMap<String, DocLine> map = new HashMap<String, DocLine>();

//				int iq = 0;
				
				for (MMovementLineMA lineMA : lineMAs)
				{
					int iq = lineMA.get_ID();
					System.out.println(iq);
					
					if(lineMA.getMovementQty().signum()==0)
						continue;
					String key = lineMA.getM_AttributeSetInstance_ID() + "_" + lineMA.getM_AttributeSetInstanceTo_ID();
					if (!map.containsKey(key))
					{
						DocLine docLine = new DocLine(line, this, lineMA);
						docLine.setM_AttributeSetInstance_ID(lineMA.getM_AttributeSetInstance_ID());
						docLine.setM_AttributeSetInstanceTo_ID(lineMA.getM_AttributeSetInstanceTo_ID());
						docLine.setQty(lineMA.getMovementQty(), false);
						docLine.setReversalLine_ID(line.getReversalLine_ID());
						if (log.isLoggable(Level.FINE))
							log.fine(docLine.toString());
						map.put(key, docLine);
					}
					else
					{
						DocLine docLine = map.get(key);
						
						BigDecimal lineQty = docLine.getQty();
						lineQty = lineQty == null ? Env.ZERO : lineQty;
						
						docLine.setQty(lineQty.add(lineMA.getMovementQty()), false);
					}
				}
				
				list.addAll(map.values());
			}
			else
			{
				DocLine docLine = new DocLine (line, this);
				docLine.setQty(line.getMovementQty(), false);
				docLine.setReversalLine_ID(line.getReversalLine_ID());
				docLine.setM_AttributeSetInstance_ID(line.getM_AttributeSetInstance_ID());
				docLine.setM_AttributeSetInstanceTo_ID(line.getM_AttributeSetInstanceTo_ID());
				if (log.isLoggable(Level.FINE)) log.fine(docLine.toString());
				list.add (docLine);
			}
 		}

		//	Return Array
		DocLine[] dls = new DocLine[list.size()];
		list.toArray(dls);
		return dls;
	}	//	loadLines

	/**
	 *  Get Balance
	 *  @return balance (ZERO) - always balanced
	 */
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  MMM.
	 *  <pre>
	 *  Movement
	 *      Inventory       DR      CR
	 *      InventoryTo     DR      CR
	 *  </pre>
	 *  @param as account schema
	 *  @return Fact
	 */
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());

		//  Line pointers
		FactLine dr = null;
		FactLine cr = null;

		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			BigDecimal costs = null;
			MProduct product = MProduct.get(getCtx(), line.getM_Product_ID());
            
            //If expense type stocked product, no accounting impacted
            if(MProduct.PRODUCTTYPE_ExpenseType.equals(product.getProductType()) && product.isStocked()) {
                continue;
            }
			
			if (!isReversal(line))
			{
				// MZ Goodwill
				// if Inventory Move CostDetail exist then get Cost from
				// Cost Detail
				costs = line.getProductCosts(as, line.getAD_Org_ID(), true, "M_MovementLine_ID=? AND IsSOTrx='N'");
				// end MZ
			}
			else
			{
				// In case of reversal, use cost from original movement line
				MMovementLine mline = (MMovementLine) line.getPO();
				MCostDetail cdInv = MCostDetail.get(getCtx(), "M_MovementLine_ID = ? AND IsSOTrx='N'",
						mline.getReversalLine_ID(), line.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(),
						getTrxName());
				if (cdInv != null)
					costs = cdInv.getAmt();
			}

			if (costs == null || costs.signum() == 0)
			{
				if (product.isStocked())
				{
					// ok if we have purchased zero cost item from vendor
					// before
					String sql = "SELECT Count(*) FROM M_CostDetail WHERE M_Product_ID=? AND Processed='Y' AND Amt=0.00 AND Qty > 0 AND (C_OrderLine_ID > 0 OR C_InvoiceLine_ID > 0)"
							+ " AND AD_Client_ID = ? ";
					ArrayList<Integer> list = new ArrayList<Integer>();
					list.add(product.getM_Product_ID());
					list.add(getAD_Client_ID());

					String costingLevel = product.getCostingLevel(as);
					if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
					{
						sql = "SELECT Count(*) FROM M_CostDetail WHERE M_Product_ID=? AND Processed='Y' AND Amt=0.00 AND Qty > 0 AND (C_OrderLine_ID > 0 OR C_InvoiceLine_ID > 0)"
								+ " AND AD_Client_ID = ?  AND M_AttributeSetInstance_ID=?";
						list.add(line.getM_AttributeSetInstance_ID());
					}

					int count = DB.getSQLValue(null, sql, list.toArray());
					if (count > 0)
					{
						costs = BigDecimal.ZERO;
					}
					else
					{
						p_Error = Msg.getMsg(getCtx(), "No Costs for") + " " + line.getProduct().getName();
						log.log(Level.WARNING, p_Error);
						return null;
					}
				}
			}
			
			//  ** Inventory       DR      CR
			dr = fact.createLine(line,
				line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
				as.getC_Currency_ID(), costs.negate());		//	from (-) CR
			if (dr == null)
				continue;
			dr.setM_Locator_ID(line.getM_Locator_ID());
			dr.setM_AttributeSetInstance_ID(line.getM_AttributeSetInstance_ID());
			dr.setM_Warehouse_ID(getM_Warehouse_ID());
			dr.setQty(line.getQty().negate());	//	outgoing
			if (isReversal(line))
			{
				//	Set AmtAcctDr from Original Movement
				if (!dr.updateReverseLine (MMovement.Table_ID,
						m_Reversal_ID, line.getReversalLine_ID(),Env.ONE))
				{
					p_Error = "Original Inventory Move not posted yet";
					return null;
				}
			}

			//  ** InventoryTo     DR      CR
			cr = fact.createLine(line,
				line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
				as.getC_Currency_ID(), costs);			//	to (+) DR
			if (cr == null)
				continue;
			cr.setM_Locator_ID(line.getM_LocatorTo_ID());
			cr.setM_AttributeSetInstance_ID(line.getM_AttributeSetInstanceTo_ID());
			cr.setM_Warehouse_ID(getM_WarehouseTo_ID());
			cr.setQty(line.getQty());
			if (isReversal(line))
			{
				//	Set AmtAcctCr from Original Movement
				if (!cr.updateReverseLine (MMovement.Table_ID,
						m_Reversal_ID, line.getReversalLine_ID(),Env.ONE))
				{
					p_Error = "Original Inventory Move not posted yet";
					return null;
				}
				costs = cr.getAcctBalance(); //get original cost
			}

			//	Only for between-org movements OR between ASIs
			String costingLevel = line.getProduct().getCostingLevel(as);
			if (!MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel)
					&& !MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
				continue;
			
			if ((dr.getAD_Org_ID() != cr.getAD_Org_ID() && MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel))
					|| (line.getM_AttributeSetInstance_ID() != line.getM_AttributeSetInstanceTo_ID() && MAcctSchema.COSTINGLEVEL_BatchLot
							.equals(costingLevel)))
			{
				//
				String description = line.getDescription();
				if (description == null)
					description = "";
				//	Cost Detail From
				if (!MCostDetail.createMovement(as, dr.getAD_Org_ID(), 	//	locator org
					line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
					line.get_ID(), 0,
					costs.negate(), line.getQty().negate(), true,
					description + "(|->)", getTrxName()))
				{
					p_Error = "Failed to create cost detail record";
					return null;
				}
				//	Cost Detail To
				if (!MCostDetail.createMovement(as, cr.getAD_Org_ID(),	//	locator org
					line.getM_Product_ID(), line.getM_AttributeSetInstanceTo_ID(),
					line.get_ID(), 0,
					costs, line.getQty(), false,
					description + "(|<-)", getTrxName()))
				{
					p_Error = "Failed to create cost detail record";
					return null;
				}
			}
		}

		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact

	protected boolean isReversal(DocLine line) {
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
			MMovement move = (MMovement) getPO();
			MMovement rev_move = (MMovement) move.getReversal();
			if (Util.compareDate(move.getMovementDate(), rev_move.getMovementDate()) == 0 && isNoCostDetailCreated(move, rev_move))
			{
				String revpostedsql = "SELECT Posted FROM M_Movement WHERE M_Movement_ID=?";
				String posted = DB.getSQLValueStringEx(getTrxName(), revpostedsql, rev_move.get_ID());
				if (!STATUS_Posted.equalsIgnoreCase(posted) && !STATUS_NoPostingRequired.equalsIgnoreCase(posted))
				{
					DocManager.save(getTrxName(), MMovement.Table_ID, move.getReversal_ID(), STATUS_NoPostingRequired);
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Checks if no cost detail has been created for the given Movement records.
	 * 
	 * @param  movement    The Movement document.
	 * @param  revMovement The reverse Movement document.
	 * @return          true if no cost detail exists for any line in both documents, false
	 *                  otherwise.
	 */
	public boolean isNoCostDetailCreated(MMovement movement, MMovement revMovement)
	{
		String sql = "SELECT COUNT(1) FROM M_CostDetail "
						+ " WHERE M_MovementLine_ID IN ( "
							+ "     SELECT ml.M_MovementLine_ID FROM M_MovementLine ml WHERE ml.M_Movement_ID IN (?, ?) "
							+ "	) "
							+ " AND C_AcctSchema_ID = ? AND IsActive = 'Y' ";
		int count = DB .getSQLValue(null, sql, movement.getM_Movement_ID(), revMovement.getM_Movement_ID(), m_as.getC_AcctSchema_ID());
		return count <= 0;
	} // isNoCostDetailCreated

}   //  Doc_Movement
