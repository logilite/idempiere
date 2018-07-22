package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
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
import org.compiere.model.MCostDetail;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchInvHdr;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.ProductCost;
import org.compiere.model.X_M_Cost;
import org.compiere.util.Env;
import org.compiere.util.Trx;

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
		// create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());
		ArrayList<Fact> facts = new ArrayList<Fact>();

		for (DocLine line : p_lines)
		{
			MMatchInv m_matchInv = (MMatchInv) line.getPO();
			MInvoiceLine m_invoiceLine = (MInvoiceLine) m_matchInv.getC_InvoiceLine();
			
			MInvoice invoice = m_invoiceLine.getParent();
			if(as.isAccrual() && m_matchInv.getReversal_ID() <= 0 && !invoice.isPosted())
			{
				p_Error = "Invoice not posted yet";
				return null;
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
			if (line.getM_Product_ID() == 0 // no Product
					|| line.getQty().signum() == 0
					|| (m_receiptLine != null && m_receiptLine.getMovementQty().signum() == 0)
					|| m_matchInv.getM_MatchInvHdr_ID() != get_ID()) // Qty = 0
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
						.divide(m_receiptLine.getMovementQty(), 12, BigDecimal.ROUND_HALF_UP).abs();
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
					if (!dr.updateReverseLine(MInOut.Table_ID, // Amt updated
							m_receiptLine.getM_InOut_ID(), m_receiptLine.getM_InOutLine_ID(), multiplier))
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
			BigDecimal multiplier = line.getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, BigDecimal.ROUND_HALF_UP)
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
					cr.setQty(line.getQty().negate());
					// Set AmtAcctCr/Dr from Invoice (sets also Project)
					if (!cr.updateReverseLine(MInvoice.Table_ID, // Amt updated
							m_invoiceLine.getC_Invoice_ID(), m_invoiceLine.getC_InvoiceLine_ID(), multiplier))
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
				processInvoicePriceVariance(line, as, fact, ipv, m_invoiceLine, m_pc);
				if (log.isLoggable(Level.FINE))
					log.fine("IPV=" + ipv + "; Balance=" + fact.getSourceBalance());
	
				String error = createMatchInvCostDetail(line, as, m_invoiceLine, m_receiptLine);
				if (error != null && error.trim().length() > 0)
				{
					p_Error = error;
					return null;
				}
				//

				/** Commitment release ****/
				if (as.isAccrual() && as.isCreatePOCommitment())
				{
					fact = Doc_Order.getCommitmentRelease(as, this, line.getQty(), m_invoiceLine.getC_InvoiceLine_ID(),
							Env.ONE);
					if (fact == null)
						return null;
					facts.add(fact);
				} // Commitment
			}

		}

		facts.add(fact);
		return facts;
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
	 * @param as
	 * @param fact
	 * @param ipv
	 */
	protected void processInvoicePriceVariance(DocLine line, MAcctSchema as, Fact fact, BigDecimal ipv,
			MInvoiceLine m_invoiceLine, ProductCost m_pc)
	{
		if (ipv.signum() == 0)
			return;

		FactLine pv = fact
				.createLine(line, m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as), as.getC_Currency_ID(), ipv);
		updateFactLine(pv, m_invoiceLine);

		MMatchInv matchInv = (MMatchInv) line.getPO();
		Trx trx = Trx.get(getTrxName(), false);
		Savepoint savepoint = null;
		boolean zeroQty = false;
		try
		{
			savepoint = trx.setSavepoint(null);

			if (!MCostDetail.createMatchInvoice(as, m_invoiceLine.getAD_Org_ID(), m_invoiceLine.getM_Product_ID(),
					m_invoiceLine.getM_AttributeSetInstance_ID(), matchInv.getM_MatchInv_ID(), 0, ipv, BigDecimal.ZERO,
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

		String costingMethod = m_pc.getProduct().getCostingMethod(as);
		if (X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod))
		{
			MAccount account = zeroQty ? m_pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as) : m_pc
					.getAccount(ProductCost.ACCTTYPE_P_Asset, as);

			FactLine factLine = fact.createLine(line, m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv.negate());
			updateFactLine(factLine, m_invoiceLine);

			factLine = fact.createLine(line, account, as.getC_Currency_ID(), ipv);
			updateFactLine(factLine, m_invoiceLine);
		}
		else if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod) && !zeroQty)
		{
			MAccount account = m_pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);

			FactLine factLine = fact.createLine(line, m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv.negate());
			updateFactLine(factLine, m_invoiceLine);

			factLine = fact.createLine(line, account, as.getC_Currency_ID(), ipv);
			updateFactLine(factLine, m_invoiceLine);
		}
	}

	// Elaine 2008/6/20
	public String createMatchInvCostDetail(DocLine line, MAcctSchema as, MInvoiceLine m_invoiceLine,
			MInOutLine m_receiptLine)
	{
		if (m_invoiceLine != null && m_invoiceLine.get_ID() > 0 && m_receiptLine != null && m_receiptLine.get_ID() > 0)
		{
			MMatchInv matchInv = (MMatchInv) line.getPO();

			BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
			BigDecimal multiplier = line.getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, BigDecimal.ROUND_HALF_UP)
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
					multiplier = mInv[i].getQty().divide(m_invoiceLine.getQtyInvoiced(), 12, BigDecimal.ROUND_HALF_UP)
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

			// Set Total Amount and Total Quantity from Matched Invoice
			if (!MCostDetail.createInvoice(as, getAD_Org_ID(), line.getM_Product_ID(),
					matchInv.getM_AttributeSetInstance_ID(), m_invoiceLine.getC_InvoiceLine_ID(), 0, // No
																										// cost
																										// element
					tAmt, tQty, getDescription(), getTrxName()))
			{
				return "Failed to create cost detail record";
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
				BigDecimal amt = totalAmt.multiply(tQty).divide(totalQty, 12, BigDecimal.ROUND_HALF_UP);
				if (orderLine.getC_Currency_ID() != as.getC_Currency_ID())
				{
					I_C_Order order = orderLine.getC_Order();
					Timestamp dateAcct = order.getDateAcct();
					BigDecimal rate = MConversionRate.getRate(order.getC_Currency_ID(), as.getC_Currency_ID(),
							dateAcct, order.getC_ConversionType_ID(), order.getAD_Client_ID(), order.getAD_Org_ID());
					if (rate == null)
					{
						p_Error = "Purchase Order not convertible - " + as.getName();
						return null;
					}
					amt = amt.multiply(rate);
					if (amt.scale() > as.getCostingPrecision())
						amt = amt.setScale(as.getCostingPrecision(), BigDecimal.ROUND_HALF_UP);
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
				BigDecimal amt = landedCostMap.get(elementId);
				if (!MCostDetail.createShipment(as, getAD_Org_ID(), line.getM_Product_ID(),
						matchInv.getM_AttributeSetInstance_ID(), m_receiptLine.getM_InOutLine_ID(), elementId, amt,
						tQty, getDescription(), false, getTrxName()))
				{
					return "Failed to create cost detail record";
				}
			}
			// end MZ
		}

		return "";
	}
}
