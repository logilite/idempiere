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
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCostDetail;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MTable;
import org.compiere.model.MTimeExpenseLine;
import org.compiere.model.ProductCost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	Posting for {@link MProjectIssue} document. DOCTYPE_ProjectIssue.<br/>
 *	Note:
 *		Will load the default GL Category.
 *		Set up a document type to set the GL Category.
 *
 *  @author Jorg Janke
 *  @version $Id: Doc_ProjectIssue.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_ProjectIssue extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_ProjectIssue (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MProjectIssue.class, rs, DOCTYPE_ProjectIssue, trxName);
	}   //  Doc_ProjectIssue

	/**	Pseudo Line								*/
	protected DocLine 			m_line = null;
	/** Issue									*/
	protected MProjectIssue		m_issue = null;

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	@Override
	protected String loadDocumentDetails()
	{
		setC_Currency_ID(NO_CURRENCY);
		m_issue = (MProjectIssue)getPO();
		setDateDoc (m_issue.getMovementDate());
		setDateAcct(m_issue.getMovementDate());

		//	Pseudo Line
		m_line = new DocLine (m_issue, this);
		m_line.setQty (m_issue.getMovementQty(), true);    //  sets Trx and Storage Qty
		m_line.setReversalLine_ID(m_issue.getReversal_ID());

		//	Pseudo Line Check
		if (m_line.getM_Product_ID() == 0 && m_line.getC_Charge_ID() <= 0)
			log.warning(m_line.toString() + " - No Product");
		if (m_line.getM_Product_ID() > 0 && (MAcctSchema.COSTINGLEVEL_BatchLot.equals(m_line.getProduct().getCostingLevel(m_as))
												&& m_line.getM_AttributeSetInstance_ID() <= 0))
		{
			log.warning(m_line.toString() + " - No ASI Present for Product (" + m_line.getM_Product_ID() + ")");
		}
		if (log.isLoggable(Level.FINE)) log.fine(m_line.toString());
		return null;
	}   //  loadDocumentDetails

	/**
	 * 	Get DocumentNo
	 *	@return document no
	 */
	@Override
	public String getDocumentNo ()
	{
		MProject p = m_issue.getParent();
		if (p != null){
			StringBuilder msgreturn = new StringBuilder().append(p.getValue()).append(" #").append(m_issue.getLine());
			return msgreturn.toString();
		}	
		StringBuilder msgreturn = new StringBuilder("(").append(m_issue.get_ID()).append(")");
		return msgreturn.toString();
	}	//	getDocumentNo

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
	 *  PJI
	 *  <pre>
	 *  Issue
	 *      ProjectWIP      DR
	 *      Inventory               CR
	 *  </pre>
	 *  Project Account is either Asset or WIP depending on Project Type
	 *  @param as accounting schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		
		// check is date of both issue same
		boolean isCreatePost = !(as.isDeleteReverseCorrectPosting()
									&& m_issue.getReversal_ID() > 0
										&& Util.compareDate(m_issue.getMovementDate(), m_issue.getReversal().getMovementDate()) == 0);
		setC_Currency_ID(as.getC_Currency_ID());

		MProject project = (MProject) MTable.get(getCtx(), MProject.Table_ID).getPO(m_issue.getC_Project_ID(),
				getTrxName());
		String ProjectCategory = project.getProjectCategory();
		MProduct product = MProduct.get(getCtx(), m_issue.getM_Product_ID());

		//  Line pointers
		FactLine dr = null;
		FactLine cr = null;

		//  Issue Cost
		BigDecimal cost = null;
		if (m_issue.getM_InOutLine_ID() != 0)
		{
			MInOutLine inOutLine = new MInOutLine(getCtx(), m_issue.getM_InOutLine_ID(), getTrxName());
			cost = inOutLine.getPOCost(as, m_line.getQty());
		}
		else if (m_issue.getS_TimeExpenseLine_ID() != 0)
		{
			MTimeExpenseLine timeExpenseLine = new MTimeExpenseLine(getCtx(), m_issue.getS_TimeExpenseLine_ID(), getTrxName());
			cost = timeExpenseLine.getLaborCost(as);
		}
		if (cost == null)	//	standard Product Costs
			cost = m_line.getProductCosts(as, getAD_Org_ID(), false);

		//  Project         DR
		int acctType = ACCTTYPE_ProjectWIP;
		if (MProject.PROJECTCATEGORY_AssetProject.equals(ProjectCategory))
			acctType = ACCTTYPE_ProjectAsset;
		if(isCreatePost)
		{
			dr = fact.createLine(m_line,
				getAccount(acctType, as), as.getC_Currency_ID(), cost, null);
			dr.setQty(m_line.getQty().negate());
		}
		//  Inventory               CR
		if (m_issue.getM_Product_ID() > 0)
		{
			acctType = ProductCost.ACCTTYPE_P_Asset;
			if (product.isService())
				acctType = ProductCost.ACCTTYPE_P_Expense;
		}
		else if (m_issue.getC_Charge_ID() > 0)
		{
			acctType = Doc.ACCTTYPE_Charge;
		}
		if(isCreatePost)
		{
			cr = fact.createLine(m_line,
				m_line.getAccount(acctType, as),
				as.getC_Currency_ID(), null, cost);
			cr.setM_Locator_ID(m_line.getM_Locator_ID());
			cr.setLocationFromLocator(m_line.getM_Locator_ID(), true);	// from Loc
		}
		//
		if (product != null && product.get_ID() > 0 && !product.isService() && product.isStocked()) {
			BigDecimal costDetailQty = m_line.getQty();
			BigDecimal costDetailAmt = cost;
			if (m_line.getQty().signum() != m_line.getProductCost().getQty().signum())
				costDetailAmt = costDetailAmt.negate();
			int Ref_CostDetail_ID = 0;
			if (m_line.getReversalLine_ID() > 0 && m_line.get_ID() > m_line.getReversalLine_ID())
			{
				MCostDetail cd = MCostDetail.getProduction(as, m_line.getM_Product_ID(), m_line.getM_AttributeSetInstance_ID(),
						m_line.getReversalLine_ID(), 0, getTrxName());
				if (cd != null)
					Ref_CostDetail_ID = cd.getM_CostDetail_ID();
			}
			if (!MCostDetail.createProjectIssue(as, m_line.getAD_Org_ID(),
				m_line.getM_Product_ID(), m_line.getM_AttributeSetInstance_ID(),
				m_line.get_ID(), 0,
				costDetailAmt, costDetailQty,
				m_line.getDescription(), m_line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
			{
				p_Error = "Failed to create cost detail record";
				return null;
			}
		}
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact
	
	@Override
	public boolean isNoPostingRequired( )
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
	public boolean isReversalAlsoNotPosted( )
	{
		int reversal_ID = m_issue.getReversal_ID();
		if (m_as.isDeleteReverseCorrectPosting() && reversal_ID > 0)
		{
			MProjectIssue rev_Issue = (MProjectIssue) m_issue.getReversal();
			if (Util.compareDate(m_issue.getMovementDate(), rev_Issue.getMovementDate()) == 0 && isNoCostDetailCreated(m_issue, rev_Issue))
			{
				String revpostedsql = "SELECT Posted FROM C_ProjectIssue WHERE C_ProjectIssue_ID=?";
				String posted = DB.getSQLValueStringEx(getTrxName(), revpostedsql, rev_Issue.get_ID());
				if (!STATUS_Posted.equalsIgnoreCase(posted) && !STATUS_NoPostingRequired.equalsIgnoreCase(posted))
				{
					DocManager.save(getTrxName(), MProjectIssue.Table_ID, m_issue.getReversal_ID(), STATUS_NoPostingRequired);
					return true;
				}
			}
		}
		return false;
	}// isReversalAlsoNotPosted
	
	/**
	 * Checks if no cost detail has been created for the given Project Issue records.
	 * 
	 * @param issue The Project Issue document.
	 * @param revIssue The reverse Project Issue document.
	 * @return true if no cost detail exists for any line in both documents, false otherwise.
	 */
	public boolean isNoCostDetailCreated(MProjectIssue issue, MProjectIssue revIssue)
	{
		String sql = "SELECT COUNT(1) "
						+ " FROM M_CostDetail cd "
							+ " WHERE cd.C_ProjectIssue_ID IN ( "
							+ "     SELECT pji.C_ProjectIssue_ID FROM C_ProjectIssue pji WHERE pji.C_ProjectIssue_ID IN (?, ?) "
							+ " ) "
							+ " AND cd.C_AcctSchema_ID = ? AND cd.IsActive = 'Y' ";

		int count = DB.getSQLValue(getTrxName(), sql, issue.getC_ProjectIssue_ID(), revIssue.getC_ProjectIssue_ID(), m_as.getC_AcctSchema_ID());
		return count <= 0;
	}// isNoCostDetailCreated

}	//	DocProjectIssue