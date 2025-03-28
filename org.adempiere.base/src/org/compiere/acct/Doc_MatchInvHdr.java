package org.compiere.acct;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AverageCostingZeroQtyException;
import org.compiere.model.I_C_Order;
import org.compiere.model.I_C_OrderLine;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchInvHdr;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.MProduct;
import org.compiere.model.ProductCost;
import org.compiere.model.X_M_Cost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * @author Logilite
 */
public class Doc_MatchInvHdr extends Doc
{

	protected MMatchInvHdr	m_matchInvHdr;

	/**
	 * @param as
	 * @param clazz
	 * @param rs
	 * @param defaultDocumentType
	 * @param trxName
	 */
	public Doc_MatchInvHdr(MAcctSchema as, Class<?> clazz, ResultSet rs, String defaultDocumentType, String trxName)
	{
		super(as, clazz, rs, defaultDocumentType, trxName);
	}

	public Doc_MatchInvHdr(MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MMatchInvHdr.class, rs, DOCTYPE_MatchInvHdr, trxName);
	}

	@Override
	protected String loadDocumentDetails()
	{
		setC_Currency_ID(Doc.NO_CURRENCY);
		m_matchInvHdr = (MMatchInvHdr) getPO();
		setDateDoc(m_matchInvHdr.getDateTrx());
		setDateAcct(m_matchInvHdr.getDateAcct());
		p_lines = loadLines();
		if(p_lines.length > 0)
		{
			MMatchInv mInv = new MMatchInv(getCtx(), p_lines[0].get_ID(), getTrxName());
			setC_BPartner_ID(mInv.getC_InvoiceLine().getC_Invoice().getC_BPartner_ID());
		}
		if (log.isLoggable(Level.FINE))
			log.fine("Lines=" + p_lines.length);
		return null;
	}

	/**
	 * Load Invoice Line
	 * 
	 * @param prod production
	 * @return DocLine Array
	 */
	public DocLine[] loadLines()
	{
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		MMatchInv[] matInvList = m_matchInvHdr.getLines(true, "");
		for (MMatchInv mMInv : matInvList)
		{
			DocLine line = new DocLine(mMInv, this);
			line.setM_AttributeSetInstance_ID(mMInv.getM_AttributeSetInstance_ID());
			line.setQty(mMInv.getQty(), false);
			line.setReversalLine_ID(line.getReversalLine_ID());
			line.getM_Product_ID();
			list.add(line);
		}
		// Return Array
		DocLine[] dls = new DocLine[list.size()];
		list.toArray(dls);
		return dls;
	} // loadLines

	@Override
	public BigDecimal getBalance()
	{
		return Env.ZERO;
	}

	@Override
	public ArrayList<Fact> createFacts(MAcctSchema as)
	{
		ArrayList<Fact> facts = new ArrayList<Fact>();

		if (as.isDeleteReverseCorrectPosting()
			// check is date of both allocation same
			&& (m_matchInvHdr.getReversal_ID() > 0
				&& Util.compareDate(m_matchInvHdr.getDateAcct(), m_matchInvHdr.getReversal().getDateAcct()) == 0))
		{
			
			for (DocLine line : p_lines)
			{
				MMatchInv m_matchInv = (MMatchInv) line.getPO();
				MInvoiceLine m_invoiceLine = (MInvoiceLine) m_matchInv.getC_InvoiceLine();

				MInOutLine m_receiptLine = null;
				if (m_matchInv.getM_InOutLine_ID() > 0)
					m_receiptLine = (MInOutLine) m_matchInv.getM_InOutLine();
				// Nothing to do
				if (isNoProductQtyLine(line, m_matchInv, m_receiptLine)) // Qty = 0
				{
					if (log.isLoggable(Level.FINE))
						log.fine("No Product/Qty - M_Product_ID=" + line.getM_Product_ID() + ",Qty=" + line.getQty()
													+ ",InOutQty=" + m_receiptLine.getMovementQty());
					continue;
				}

				if (m_receiptLine != null)
				{
					// Check if the original document has created costing then only created costing.
					String error = createMatchInvCostDetail(line, as, m_invoiceLine, m_receiptLine, true);
					if (error != null && error.trim().length() > 0)
					{
						p_Error = error;
						return null;
					}
				}
			}
			return facts;
		}

		// create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());

		for (DocLine line : p_lines)
		{
			MMatchInv m_matchInv = (MMatchInv) line.getPO();
			MInvoiceLine m_invoiceLine = null;
			MInvoice invoice = null;
			if (m_matchInv.getC_InvoiceLine_ID() > 0)
			{//Handling MR line to MR line matching.
				m_invoiceLine = (MInvoiceLine) m_matchInv.getC_InvoiceLine();

				invoice = m_invoiceLine.getParent();
				if (as.isAccrual() && m_matchInv.getReversal_ID() <= 0 && !invoice.isPosted())
				{
					p_Error = "Invoice not posted yet";
					return null;
				}
			}
			MInOutLine m_receiptLine = null;
			if (m_matchInv.getM_InOutLine_ID() > 0)
			{
				m_receiptLine = (MInOutLine) m_matchInv.getM_InOutLine();
				MInOut inout = m_receiptLine.getParent();
				if(as.isAccrual() && m_matchInv.getReversal_ID() <= 0 && !inout.isPosted())
				{
					p_Error = "Mat.Receipt not posted yet";
					return null;
				}
			}

			// Nothing to do
			if (isNoProductQtyLine(line, m_matchInv, m_receiptLine)) // Qty = 0
			{
				if (log.isLoggable(Level.FINE))
					log.fine("No Product/Qty - M_Product_ID=" + line.getM_Product_ID() + ",Qty=" + line.getQty()
							+ ",InOutQty=" + m_receiptLine.getMovementQty());
				continue;
			}

			
			boolean isInterOrg = isInterOrg(as, m_receiptLine, m_invoiceLine);

			FactLine dr = null;
			if (m_receiptLine != null)
			{
				// NotInvoicedReceipt DR
				// From Receipt
				BigDecimal multiplier = line.getQty()
						.divide(m_receiptLine.getMovementQty(), 12, RoundingMode.HALF_UP).abs();
				dr = fact.createLine(line, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), as.getC_Currency_ID(),
						Env.ONE, null); // updated below
				if (dr == null)
				{
					p_Error = "No Product Costs";
					return null;
				}
				dr.setQty(line.getQty());
				BigDecimal temp = dr.getAcctBalance();
				// Set AmtAcctCr/Dr from Receipt (sets also Project)
				if (m_matchInv.getReversal_ID() > 0 && m_matchInv.isReversal())
				{
					if (!dr.updateReverseLine(MMatchInvHdr.Table_ID, // Amt updated
							m_matchInvHdr.getReversal_ID(), m_matchInv.getReversal_ID(), BigDecimal.ONE))
					{
						p_Error = "Failed to create reversal entry";
						return null;
					}
				}
				else
				{
					BigDecimal effMultiplier = multiplier;
					//TODO this needs to test as it different from match invoice
					if (getQty().signum() < 0)
						effMultiplier = effMultiplier.negate();
					
					if (!dr.updateReverseLine(MInOut.Table_ID, // Amt updated
							m_receiptLine.getM_InOut_ID(), m_receiptLine.getM_InOutLine_ID(), effMultiplier))
					{
						p_Error = "Mat.Receipt not posted yet";
						return null;
					}
				}
				if (log.isLoggable(Level.FINE))
					log.fine("CR - Amt(" + temp + "->" + dr.getAcctBalance() + ") - " + dr.toString());
			}

			
			ProductCost m_pc = new ProductCost(Env.getCtx(), line.getM_Product_ID(),
					m_matchInv.getM_AttributeSetInstance_ID(), getTrxName());
			m_pc.setQty(line.getQty());
			
			// InventoryClearing CR
			// From Invoice
			MAccount expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
			if (m_pc.isService())
				expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
			BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
			BigDecimal multiplier = line.getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP)
					.abs();
			if (multiplier.compareTo(Env.ONE) != 0)
				LineNetAmt = LineNetAmt.multiply(multiplier);
			if (m_pc.isService())
				LineNetAmt = dr.getAcctBalance(); // book out exact receipt amt
			FactLine cr = null;
			if (as.isAccrual())
			{
				cr = fact.createLine(line, expense, as.getC_Currency_ID(), null, LineNetAmt); // updated
																								// below
				if (cr == null)
				{
					if (log.isLoggable(Level.FINE))
						log.fine("Line Net Amt=0 - M_Product_ID=" + line.getM_Product_ID() + ",Qty=" + line.getQty()
								+ ",InOutQty=" + m_receiptLine.getMovementQty());

					cr = fact.createLine(line, expense, as.getC_Currency_ID(), null, Env.ONE);
					cr.setAmtAcctCr(BigDecimal.ZERO);
					cr.setAmtSourceCr(BigDecimal.ZERO);
				}
				BigDecimal temp = cr.getAcctBalance();
				if (m_matchInv.getReversal_ID() > 0 && m_matchInv.isReversal())
				{
					if (!cr.updateReverseLine(MMatchInvHdr.Table_ID, // Amt updated
							m_matchInvHdr.getReversal_ID(), m_matchInv.getReversal_ID(), BigDecimal.ONE))
					{
						p_Error = "Failed to create reversal entry";
						return null;
					}
				}
				else
				{
					cr.setQty(getQty().negate());
					BigDecimal effMultiplier = multiplier;
					//TODO this needs to test as it different from match invoice
					if (getQty().signum() < 0)
						effMultiplier = effMultiplier.negate();
					
					// Set AmtAcctCr/Dr from Invoice (sets also Project)
					if (!cr.updateReverseLine(MInvoice.Table_ID, // Amt updated
							m_invoiceLine.getC_Invoice_ID(), m_invoiceLine.getC_InvoiceLine_ID(), effMultiplier))
					{
						p_Error = "Invoice not posted yet";
						return null;
					}
				}
				if (log.isLoggable(Level.FINE))
					log.fine("DR - Amt(" + temp + "->" + cr.getAcctBalance() + ") - " + cr.toString());
			}
			else
			// Cash Acct
			{
				if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
					LineNetAmt = MConversionRate.convert(getCtx(), LineNetAmt, invoice.getC_Currency_ID(),
							as.getC_Currency_ID(), invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
							invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
				cr = fact.createLine(line, expense, as.getC_Currency_ID(), null, LineNetAmt);
				if (m_matchInv.getReversal_ID() > 0 && m_matchInv.isReversal())
				{
					if (!cr.updateReverseLine(MMatchInvHdr.Table_ID, // Amt updated
							m_matchInvHdr.getReversal_ID(), m_matchInv.getReversal_ID(), BigDecimal.ONE))
					{
						p_Error = "Failed to create reversal entry";
						return null;
					}
				}
				else
				{
					cr.setQty(line.getQty().multiply(multiplier).negate());
				}
			}
			//TODO Rounding correction logic missing here, do we needs to add it?
			if (m_matchInv.getReversal_ID() == 0)
			{
				cr.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
				cr.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
				cr.setC_Project_ID(m_invoiceLine.getC_Project_ID());
				cr.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
				cr.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
				cr.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
				cr.setUser1_ID(m_invoiceLine.getUser1_ID());
				cr.setUser2_ID(m_invoiceLine.getUser2_ID());
			}
			else
			{
				updateFactLine(cr, m_invoiceLine);
			}

			if (m_receiptLine == null)
			{
				MAccount writeOffAcct = MAccount.get(getCtx(), as.getAcctSchemaDefault().getC_MatchInv_WriteOff_Acct());
				if(writeOffAcct == null || writeOffAcct.get_ID() <= 0)
				{
					p_Error =  "Match invoic write off account is not configured";
					return null;
				}
				
				if (m_matchInv.getReversal_ID() > 0 && m_matchInv.isReversal())
				{
					dr = fact.createLine(line, writeOffAcct, NO_CURRENCY, Env.ZERO);
					
					if (dr == null)
					{
						p_Error = "No Product Costs";
						return null;
					}
					
					if (!dr.updateReverseLine(MMatchInvHdr.Table_ID, // Amt updated
							m_matchInvHdr.getReversal_ID(), m_matchInv.getReversal_ID(), BigDecimal.ONE))
					{
						p_Error = "Failed to create reversal entry";
						return null;
					}
				}
				else
				{
					dr = fact.createLine(line, writeOffAcct, cr.getC_Currency_ID(), cr.getAcctBalance().negate());
					
					if (dr == null)
					{
						p_Error = "No Product Costs";
						return null;
					}
					dr.setQty(line.getQty());
				}
			}

			// AZ Goodwill
			// Desc: Source Not Balanced problem because Currency is Difference
			// - PO=CNY but AP=USD
			// see also Fact.java: checking for isMultiCurrency()
			if (dr.getC_Currency_ID() != cr.getC_Currency_ID())
				setIsMultiCurrency(true);
			// end AZ

			// Avoid usage of clearing accounts
			// If both accounts Not Invoiced Receipts and Inventory Clearing are
			// equal
			// then remove the posting

			MAccount acct_db = dr.getAccount(); // not_invoiced_receipts
			MAccount acct_cr = cr.getAccount(); // inventory_clearing

			if ((!as.isPostIfClearingEqual()) && acct_db.equals(acct_cr) && (!isInterOrg))
			{

				BigDecimal debit = dr.getAmtSourceDr();
				BigDecimal credit = cr.getAmtSourceCr();

				if (debit.compareTo(credit) == 0)
				{
					fact.remove(dr);
					fact.remove(cr);
				}
			}
			// End Avoid usage of clearing accounts

			if(m_receiptLine != null)
			{
				// Invoice Price Variance difference
				BigDecimal ipv = cr.getAcctBalance().add(dr.getAcctBalance()).negate();
				BigDecimal ipvSource = dr.getAmtSourceDr().subtract(cr.getAmtSourceCr()).negate();
				processInvoicePriceVariance(line, as, fact, ipv, m_invoiceLine, m_receiptLine, m_pc, ipvSource);
				if (log.isLoggable(Level.FINE))
					log.fine("IPV=" + ipv + "; Balance=" + fact.getSourceBalance());
	
				String error = createMatchInvCostDetail(line, as, m_invoiceLine, m_receiptLine, false);
				if (error != null && error.trim().length() > 0)
				{
					p_Error = error;
					return null;
				}
				//

				if(createCommitmentFacts(as,facts,line,m_invoiceLine)==null) {
					return null;
				}
				
			}

		}

		facts.add(fact);
		return facts;
	}

	public ArrayList<Fact> createCommitmentFacts (MAcctSchema as,ArrayList<Fact> facts,DocLine line,MInvoiceLine m_invoiceLine){
		/** Commitment release ****/
		if (as.isAccrual() && as.isCreatePOCommitment())
		{
			Fact fact = Doc_Order.getCommitmentRelease(as, this, line.getQty(), m_invoiceLine.getC_InvoiceLine_ID(),
					Env.ONE);
			if (fact == null)
				return null;
			facts.add(fact);
		} // Commitment
		return facts;
	}
	
	private boolean isNoProductQtyLine(DocLine line, MMatchInv m_matchInv, MInOutLine m_receiptLine)
	{
		return line.getM_Product_ID() == 0 // no Product
			|| line.getQty().signum() == 0
				|| (m_receiptLine != null && m_receiptLine.getMovementQty().signum() == 0)
				|| m_matchInv.getM_MatchInvHdr_ID() != get_ID();
	}

	/**
	 * Verify if the posting involves two or more organizations
	 * 
	 * @return true if there are more than one org involved on the posting
	 */
	public boolean isInterOrg(MAcctSchema as, MInOutLine m_receiptLine, MInvoiceLine m_invoiceLine)
	{
		MAcctSchemaElement elementorg = as.getAcctSchemaElement(MAcctSchemaElement.ELEMENTTYPE_Organization);
		if (elementorg == null || !elementorg.isBalanced())
		{
			// no org element or not need to be balanced
			return false;
		}

		// verify if org of receipt line is different from org of invoice line
		if (m_receiptLine != null && m_invoiceLine != null
				&& m_receiptLine.getAD_Org_ID() != m_invoiceLine.getAD_Org_ID())
			return true;

		return false;
	}

	/**
	 * @param factLine
	 */
	protected void updateFactLine(FactLine factLine, MInvoiceLine m_invoiceLine)
	{
		factLine.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
		factLine.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
		factLine.setC_Project_ID(m_invoiceLine.getC_Project_ID());
		factLine.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
		factLine.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
		factLine.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
		factLine.setUser1_ID(m_invoiceLine.getUser1_ID());
		factLine.setUser2_ID(m_invoiceLine.getUser2_ID());
		factLine.setM_Product_ID(m_invoiceLine.getM_Product_ID());
		factLine.setQty(factLine.getQty());
	}
	
	/**
	 * Invoice currency & acct schema currency are not same then update AmtSource value
	 * to avoid source not balanced error/ignore suspense balancing.
	 * 
	 * @param factLine
	 * @param ipvSource
	 */
	protected void updateFactLineAmtSource(FactLine factLine, BigDecimal ipvSource)
	{
		// When only Rate differ then set Dr & Cr Source amount as zero.
		factLine.setAmtSourceCr(Env.ZERO);
		factLine.setAmtSourceDr(Env.ZERO);

		// Price is vary then set Source amount according to source variance
		if (ipvSource.compareTo(Env.ZERO) != 0)
		{
			if (ipvSource.signum() < 0)
				factLine.setAmtSourceCr(ipvSource);
			else
				factLine.setAmtSourceDr(ipvSource);
		}
	}

	/**
	 * @param as
	 * @param fact
	 * @param ipv
	 */
	protected void processInvoicePriceVariance(DocLine line, MAcctSchema as, Fact fact, BigDecimal ipv,
			MInvoiceLine m_invoiceLine,MInOutLine m_receiptLine, ProductCost m_pc, BigDecimal ipvSource)
	{
		if (ipv.signum() == 0)
			return;

		MMatchInv matchInv = (MMatchInv) line.getPO();
		String costingMethod = m_pc.getProduct().getCostingMethod(as);
		BigDecimal amtVariance = Env.ZERO;
		BigDecimal amtAsset = Env.ZERO;
		BigDecimal qtyInv = m_invoiceLine.getQtyInvoiced();
		BigDecimal qtyCost = null;
		Boolean isStockCoverage = false;
		
		if (X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod)  && m_invoiceLine.getM_Product_ID() > 0)
		{

			int AD_Org_ID = m_receiptLine.getAD_Org_ID();
			int M_AttributeSetInstance_ID = matchInv.getM_AttributeSetInstance_ID();

			if (MAcctSchema.COSTINGLEVEL_Client.equals(as.getCostingLevel()))
			{
				AD_Org_ID = 0;
				M_AttributeSetInstance_ID = 0;
			}
			else if (MAcctSchema.COSTINGLEVEL_Organization.equals(as.getCostingLevel()))
				M_AttributeSetInstance_ID = 0;
			else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(as.getCostingLevel()))
				AD_Org_ID = 0;

			MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), costingMethod, AD_Org_ID);
			
			MCostDetail cd = MCostDetail.get (as.getCtx(), "M_MatchInv_ID=? AND Coalesce(M_CostElement_ID,0)=0", 
					matchInv.getM_MatchInv_ID(), M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), getTrxName());
			if(cd!=null){
				qtyCost = cd.getCurrentQty();
			}else{
				MCost c = MCost.get(getCtx(), getAD_Client_ID(), AD_Org_ID, m_invoiceLine.getM_Product_ID(),
					as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(),
					M_AttributeSetInstance_ID, null);
				qtyCost = (c!=null? c.getCurrentQty():Env.ZERO);
			}
			
			isStockCoverage = true;
			if (qtyCost != null && qtyCost.compareTo(qtyInv) < 0 )
			{
				//If current cost qty < invoice qty
				amtAsset = qtyCost.multiply(ipv).divide(qtyInv);
				amtVariance = ipv.subtract(amtAsset);
				
			}else{
				//If current qty >= invoice qty
				amtAsset = ipv;
			}
			
		}
		
		Trx trx = Trx.get(getTrxName(), false);
		Savepoint savepoint = null;
		boolean zeroQty = false;
		try
		{
			savepoint = trx.setSavepoint(null);

			if (!MCostDetail.createMatchInvoice(as, m_invoiceLine.getAD_Org_ID(), m_invoiceLine.getM_Product_ID(),
					m_invoiceLine.getM_AttributeSetInstance_ID(), matchInv.getM_MatchInv_ID(), 0, 
					isStockCoverage ? amtAsset: ipv, BigDecimal.ZERO,
					"Invoice Price Variance", getTrxName()))
			{
				throw new RuntimeException("Failed to create cost detail record.");
			}
		}
		catch (SQLException e)
		{
			throw new RuntimeException(e.getLocalizedMessage(), e);
		}
		catch (AverageCostingZeroQtyException e)
		{
			zeroQty = true;
			try
			{
				trx.rollback(savepoint);
				savepoint = null;
			}
			catch (SQLException e1)
			{
				throw new RuntimeException(e1.getLocalizedMessage(), e1);
			}
		}
		finally
		{
			if (savepoint != null)
			{
				try
				{
					trx.releaseSavepoint(savepoint);
				}
				catch (SQLException e)
				{
				}
			}
		}

		//TODO Test for Expense type product?
		MAccount account = m_pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
		if (m_pc.isService())
			account = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
		if (X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod))
		{
			FactLine varianceLine = null;
			if (amtVariance.compareTo(Env.ZERO) != 0)
			{
				varianceLine = fact.createLine(null,
						m_pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as), as.getC_Currency_ID(),
						amtVariance);
				updateFactLine(varianceLine,m_invoiceLine);
				
				if (m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())
				{
					updateFactLineAmtSource(varianceLine, ipvSource.multiply(amtVariance).divide(ipv));
				}
			}
			if (amtAsset.compareTo(Env.ZERO) != 0)
			{
				FactLine factLine = fact.createLine(null, account, as.getC_Currency_ID(), amtAsset);
				updateFactLine(factLine,m_invoiceLine);
				// set Zero Qty for Product Asset Account to match Qty.
				factLine.setQty(Env.ZERO);

				if (m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())
				{
					updateFactLineAmtSource(factLine, ipvSource.multiply(amtAsset).divide(ipv));
				}
			}
		}
		else if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod) && !zeroQty)
		{
			//TODO test for avg Invoice costing method as here dropped posting of posting to IPV account
			FactLine factLine = fact.createLine(null, account, as.getC_Currency_ID(), ipv);
			updateFactLine(factLine,m_invoiceLine);
			factLine.setQty(Env.ZERO);
			if (m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())
			{
				updateFactLineAmtSource(factLine, ipvSource);
			}
		}else{
			//For standard costing post to IPV account
			FactLine pv = fact.createLine(null,
				m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv);
			updateFactLine(pv,m_invoiceLine);
			if (m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())
			{
				updateFactLineAmtSource(pv, ipvSource);
			}
		}
	}

	// Elaine 2008/6/20
	public String createMatchInvCostDetail(DocLine line, MAcctSchema as, MInvoiceLine m_invoiceLine,
			MInOutLine m_receiptLine, boolean isCheckCost)
	{
		if (m_invoiceLine != null && m_invoiceLine.get_ID() > 0 && m_receiptLine != null && m_receiptLine.get_ID() > 0)
		{
			MMatchInv matchInv = (MMatchInv) line.getPO();
			MProduct product = MProduct.get(getCtx(), matchInv.getM_Product_ID());
			 if(MProduct.PRODUCTTYPE_ExpenseType.equals(product.getProductType())) {
				 return "";
			 }

			BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
			BigDecimal multiplier = line.getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP)
					.abs();
			if (multiplier.compareTo(Env.ONE) != 0)
				LineNetAmt = LineNetAmt.multiply(multiplier);

			// MZ Goodwill
			// Create Cost Detail Matched Invoice using Total Amount and Total
			// Qty based on InvoiceLine
			MMatchInv[] mInv = MMatchInv.getInvoiceLine(getCtx(), m_invoiceLine.getC_InvoiceLine_ID(), getTrxName());
			BigDecimal tQty = Env.ZERO;
			BigDecimal tAmt = Env.ZERO;
			for (int i = 0; i < mInv.length; i++)
			{
				if (mInv[i].isPosted() && mInv[i].getM_MatchInv_ID() != get_ID()
						&& mInv[i].getM_AttributeSetInstance_ID() == matchInv.getM_AttributeSetInstance_ID())
				{
					tQty = tQty.add(mInv[i].getQty());
					multiplier = mInv[i].getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP)
							.abs();
					tAmt = tAmt.add(m_invoiceLine.getLineNetAmt().multiply(multiplier));
				}
			}
			tAmt = tAmt.add(LineNetAmt); // Invoice Price

			// Different currency
			MInvoice invoice = m_invoiceLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
			{
				tAmt = MConversionRate.convert(getCtx(), tAmt, invoice.getC_Currency_ID(), as.getC_Currency_ID(),
						invoice.getDateAcct(), invoice.getC_ConversionType_ID(), invoice.getAD_Client_ID(),
						invoice.getAD_Org_ID());
				if (tAmt == null)
				{
					return "AP Invoice not convertible - " + as.getName();
				}
			}

			// set Qty to negative value when MovementType is Vendor Returns
			MInOut receipt = m_receiptLine.getParent();
			if (receipt.getMovementType().equals(MInOut.MOVEMENTTYPE_VendorReturns))
				tQty = tQty.add(line.getQty().negate()); // Qty is set to negative
													// value
			else
				tQty = tQty.add(line.getQty());

			if(!isCheckCost || (((MMatchInv) matchInv.getReversal()).getInvoiceCostDetail(as, 0) != null))
			{ //TODO Test
				// Set Total Amount and Total Quantity from Matched Invoice
				if (!MCostDetail.createInvoice(as, getAD_Org_ID(), line.getM_Product_ID(),
						matchInv.getM_AttributeSetInstance_ID(), m_invoiceLine.getC_InvoiceLine_ID(), 0, // No cost element
						tAmt, tQty, getDescription(), getTrxName()))
				{
					return "Failed to create cost detail record";
				}
			}

			Map<Integer, BigDecimal> landedCostMap = new LinkedHashMap<Integer, BigDecimal>();
			I_C_OrderLine orderLine = m_receiptLine.getC_OrderLine();
			if (orderLine == null)
				return "";

			int C_OrderLine_ID = orderLine.getC_OrderLine_ID();
			MOrderLandedCostAllocation[] allocations = MOrderLandedCostAllocation.getOfOrderLine(C_OrderLine_ID,
					getTrxName());
			for (MOrderLandedCostAllocation allocation : allocations)
			{
				BigDecimal totalAmt = allocation.getAmt();
				BigDecimal totalQty = allocation.getQty();
				BigDecimal amt = totalAmt.multiply(tQty).divide(totalQty, 12, RoundingMode.HALF_UP);
				if (orderLine.getC_Currency_ID() != as.getC_Currency_ID())
				{
					I_C_Order order = orderLine.getC_Order();
					BigDecimal rate = MConversionRate.getRate(order.getC_Currency_ID(), as.getC_Currency_ID(),
							getDateAcct(), order.getC_ConversionType_ID(), order.getAD_Client_ID(), order.getAD_Org_ID());
					if (rate == null)
					{
						p_Error = "Purchase Order not convertible - " + as.getName();
						return null;
					}
					amt = amt.multiply(rate);
					if (amt.scale() > as.getCostingPrecision())
						amt = amt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
				}
				int elementId = allocation.getC_OrderLandedCost().getM_CostElement_ID();
				BigDecimal elementAmt = landedCostMap.get(elementId);
				if (elementAmt == null)
				{
					elementAmt = amt;
				}
				else
				{
					elementAmt = elementAmt.add(amt);
				}
				landedCostMap.put(elementId, elementAmt);
			}

			for (Integer elementId : landedCostMap.keySet())
			{
				if(!isCheckCost || (((MMatchInv) matchInv.getReversal()).getInOutLineCostDetail(as, elementId) != null))
				{ //TODO test
					BigDecimal amt = landedCostMap.get(elementId);
					if (!MCostDetail.createShipment(as, getAD_Org_ID(), line.getM_Product_ID(),
							matchInv.getM_AttributeSetInstance_ID(), m_receiptLine.getM_InOutLine_ID(), elementId, amt,
							tQty, getDescription(), false, getTrxName()))
					{
						return "Failed to create cost detail record";
					}
				}
			}
			// end MZ
		}

		return "";
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
		MMatchInvHdr matchInvHdr = (MMatchInvHdr) getPO();
		if (m_as.isDeleteReverseCorrectPosting() && matchInvHdr.getReversal_ID() > 0)
		{
			MMatchInvHdr rev_matchInvHdr = (MMatchInvHdr) matchInvHdr.getReversal();
			if (Util.compareDate(matchInvHdr.getDateAcct(), rev_matchInvHdr.getDateAcct()) == 0 && isNoCostDetailCreated(matchInvHdr, rev_matchInvHdr))
			{
				String revpostedsql = "SELECT Posted FROM M_MatchInvHdr WHERE M_MatchInvHdr_ID=?";
				String posted = DB.getSQLValueStringEx(getTrxName(), revpostedsql, rev_matchInvHdr.get_ID());
				if (!STATUS_Posted.equalsIgnoreCase(posted) && !STATUS_NoPostingRequired.equalsIgnoreCase(posted))
				{
					DocManager.save(getTrxName(), MMatchInvHdr.Table_ID, matchInvHdr.getReversal_ID(), STATUS_NoPostingRequired);
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Checks if no cost detail has been created for the given MatchInvHdr records.
	 * 
	 * @param  matchInvHdr    The MatchInvHdr document.
	 * @param  revMatchInvHdr The reverse MatchInvHdr document.
	 * @return                true if no cost detail exists for any line in both documents, false
	 *                        otherwise.
	 */
	public boolean isNoCostDetailCreated(MMatchInvHdr matchInvHdr, MMatchInvHdr revMatchInvHdr)
	{
		String sql = "SELECT COUNT(1) FROM M_CostDetail cd "
						+ " WHERE (cd.M_MatchInv_ID IN ( "
							+ "     SELECT mi.M_MatchInv_ID FROM M_MatchInv mi WHERE mi.M_MatchInvHdr_ID IN (?, ?) "
							+ " ) "
							+ " OR cd.C_InvoiceLine_ID IN ( "
							+ "     SELECT mi.C_InvoiceLine_ID FROM M_MatchInv mi WHERE mi.M_MatchInvHdr_ID IN (?, ?) "
							+ " ) "
							+ " OR cd.M_InOutLine_ID IN ( "
							+ "     SELECT mi.M_InOutLine_ID FROM M_MatchInv mi WHERE mi.M_MatchInvHdr_ID IN (?, ?) "
							+ " ) ) AND C_AcctSchema_ID = ?  AND IsActive = 'Y' ";

	       int count = DB.getSQLValue(null, sql, matchInvHdr.getM_MatchInvHdr_ID(), revMatchInvHdr.getM_MatchInvHdr_ID(),
	                                  matchInvHdr.getM_MatchInvHdr_ID(), revMatchInvHdr.getM_MatchInvHdr_ID(),
	                                  matchInvHdr.getM_MatchInvHdr_ID(), revMatchInvHdr.getM_MatchInvHdr_ID(), m_as.getC_AcctSchema_ID());

	       return count <= 0; 
	} // isNoCostDetailCreated
}
