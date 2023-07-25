/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model.credit;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.ICreditManager;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MConversionRateUtil;
import org.compiere.model.MCurrency;
import org.compiere.model.MInvoice;
import org.compiere.model.MPayment;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Credit Manager for Payment
 * 
 * @author Logilite Technologies
 * @since  July 25, 2023
 */
public class CreditManagerAllocationHdr implements ICreditManager
{

	private static CLogger	log	= CLogger.getCLogger(CreditManagerAllocationHdr.class);

	private MAllocationHdr	allocationHdr;

	/**
	 * AllocationHdr Credit Manager Load Constructor
	 * 
	 * @param po MPayment
	 */
	public CreditManagerAllocationHdr(MAllocationHdr po)
	{
		this.allocationHdr = po;
	}

	@Override
	public String creditCheck(String docAction)
	{
		if (MPayment.DOCACTION_Complete.equals(docAction))
		{
			updateOpenBalForMultipleBP(false);
			return updateBP(allocationHdr.isReversal());
		}
		else if (MPayment.DOCACTION_Reverse_Accrual.equals(docAction) || MPayment.DOCACTION_Reverse_Correct.equals(docAction))
		{
			// Unlink Invoices
			updateOpenBalForMultipleBP(true);
			return updateBP(true);
		}
		else if (MPayment.DOCACTION_Void.equals(docAction))
		{
			return updateBP(true);
		}
		return null;
	}

	/**
	 * Update open balance of BP
	 * when multiple business partner
	 * 
	 * @param isReverseCorrectIt = true allocation amount will be negate.
	 */
	public void updateOpenBalForMultipleBP(boolean isReverseCorrectIt)
	{
		HashMap<Integer, BigDecimal> openBPBal = new HashMap<Integer, BigDecimal>();
		Properties ctx = allocationHdr.getCtx();
		String trxName = allocationHdr.get_TrxName();
		for (MAllocationLine line : allocationHdr.getLines(false))
		{
			int C_Payment_ID = line.getC_Payment_ID();
			int M_Invoice_ID = line.getC_Invoice_ID();

			MInvoice invoice = M_Invoice_ID > 0 ? (MInvoice) MTable.get(ctx, MInvoice.Table_ID).getPO(M_Invoice_ID, trxName) : null;

			MPayment payment = C_Payment_ID > 0 ? (MPayment) MTable.get(ctx, MPayment.Table_ID).getPO(C_Payment_ID, trxName) : null;

			BigDecimal allocationAmt = isReverseCorrectIt ? line.getAmount().negate() : line.getAmount();
			BigDecimal bpOpenBal = Env.ZERO;

			if (invoice != null)
			{
				int bPartnerID = invoice.getC_BPartner_ID();
				bpOpenBal = openBPBal.get(bPartnerID) == null ? Env.ZERO : openBPBal.get(bPartnerID);
				bpOpenBal = bpOpenBal.subtract(allocationAmt);
				openBPBal.put(bPartnerID, bpOpenBal);
			}
			if (payment != null)
			{
				int bPartnerID = payment.getC_BPartner_ID();
				bpOpenBal = openBPBal.get(bPartnerID) == null ? Env.ZERO : openBPBal.get(bPartnerID);
				bpOpenBal = bpOpenBal.add(allocationAmt);
				openBPBal.put(bPartnerID, bpOpenBal);
			}
		}

		/* Update open balance for invoice BP */
		if (!openBPBal.isEmpty())
		{
			for (Map.Entry<Integer, BigDecimal> entry : openBPBal.entrySet())
			{
				int bPartnerID = entry.getKey();
				BigDecimal allocAmt = entry.getValue();
				if (Env.ZERO.compareTo(allocAmt) != 0)
				{
					MBPartner bPartner = MBPartner.get(ctx, bPartnerID);
					bPartner.set_TrxName(trxName);
					DB.getDatabase().forUpdate(bPartner, 0);
					BigDecimal bpOpenBal = bPartner.getTotalOpenBalance().add(allocAmt);
					bPartner.setTotalOpenBalance(bpOpenBal);
					bPartner.saveEx(trxName);
				}
			}
		}
	}

	/**
	 * Update open balance & SO Credit of BP
	 * 
	 * @param  reverse
	 * @return
	 */
	public String updateBP(boolean reverse)
	{
		for (MAllocationLine line : allocationHdr.getLines(false))
		{
			int C_Payment_ID = line.getC_Payment_ID();
			int C_BPartner_ID = line.getC_BPartner_ID();
			int M_Invoice_ID = line.getC_Invoice_ID();

			if ((C_BPartner_ID == 0) || ((M_Invoice_ID == 0) && (C_Payment_ID == 0)))
				continue;

			boolean isSOTrxInvoice = false;
			Properties ctx = allocationHdr.getCtx();
			String trxName = allocationHdr.get_TrxName();
			MInvoice invoice = M_Invoice_ID > 0 ? (MInvoice) MTable.get(ctx, MInvoice.Table_ID).getPO(M_Invoice_ID, trxName) : null;
			if (M_Invoice_ID > 0)
				isSOTrxInvoice = invoice.isSOTrx();

			MBPartner bpartner = (MBPartner) MTable.get(ctx, MBPartner.Table_ID).getPO(line.getC_BPartner_ID(), trxName);
			DB.getDatabase().forUpdate(bpartner, 0);

			BigDecimal allocAmt = line.getAmount().add(line.getDiscountAmt()).add(line.getWriteOffAmt());
			BigDecimal openBalanceDiff = Env.ZERO;
			int client_ID = allocationHdr.getAD_Client_ID();
			MClient client = MClient.get(ctx, client_ID);

			boolean paymentProcessed = false;
			boolean paymentIsReceipt = false;

			// Retrieve payment information
			int currency_ID = allocationHdr.getC_Currency_ID();
			int org_ID = allocationHdr.getAD_Org_ID();
			Timestamp dateAcct = allocationHdr.getDateAcct();
			if (C_Payment_ID > 0)
			{
				MPayment payment = null;
				int convTypeID = 0;
				Timestamp paymentDate = null;

				payment = (MPayment) MTable.get(ctx, MPayment.Table_ID).getPO(C_Payment_ID, trxName);
				convTypeID = payment.getC_ConversionType_ID();
				paymentDate = payment.getDateAcct();
				paymentProcessed = payment.isProcessed();
				paymentIsReceipt = payment.isReceipt();

				// Adjust open amount with allocated amount.
				if (paymentProcessed)
				{
					if (invoice != null)
					{
						// If payment is already processed, only adjust open balance by discount and
						// write off amounts.
						BigDecimal amt = MConversionRate.convertBase(	ctx, line.getWriteOffAmt().add(line.getDiscountAmt()), currency_ID, paymentDate,
																		convTypeID, client_ID, org_ID);
						if (amt == null)
						{
							return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingAllocationCurrencyToBaseCurrency",
																		currency_ID, MClient.get(ctx).getC_Currency_ID(), convTypeID,
																		paymentDate, trxName);
						}
						openBalanceDiff = openBalanceDiff.add(amt);
					}
					else
					{
						// Allocating payment to payment.
						BigDecimal amt = MConversionRate.convertBase(ctx, allocAmt, currency_ID, paymentDate, convTypeID, client_ID, org_ID);
						if (amt == null)
						{
							return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingAllocationCurrencyToBaseCurrency",
																		currency_ID, MClient.get(ctx).getC_Currency_ID(), convTypeID,
																		paymentDate, trxName);
						}
						openBalanceDiff = openBalanceDiff.add(amt);
					}
				}
				else
				{
					// If payment has not been processed, adjust open balance by entire allocated
					// amount.
					BigDecimal allocAmtBase = MConversionRate.convertBase(ctx, allocAmt, currency_ID, dateAcct, convTypeID, client_ID, org_ID);
					if (allocAmtBase == null)
					{
						return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingAllocationCurrencyToBaseCurrency",
																	currency_ID, MClient.get(ctx).getC_Currency_ID(), convTypeID,
																	dateAcct, trxName);
					}

					openBalanceDiff = openBalanceDiff.add(allocAmtBase);
				}
			}
			else if (invoice != null)
			{
				// adjust open balance by discount and write off amounts.
				BigDecimal amt = MConversionRate.convertBase(	ctx, allocAmt.negate(),
																currency_ID, invoice.getDateAcct(), invoice.getC_ConversionType_ID(), client_ID,
																org_ID);
				if (amt == null)
				{
					return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingAllocationCurrencyToBaseCurrency",
																currency_ID, MClient.get(ctx).getC_Currency_ID(), invoice.getC_ConversionType_ID(),
																invoice.getDateAcct(), trxName);
				}
				openBalanceDiff = openBalanceDiff.add(amt);
			}

			// Adjust open amount for currency gain/loss
			if ((invoice != null)	&&
				((currency_ID != client.getC_Currency_ID()) ||
					(currency_ID != invoice.getC_Currency_ID())))
			{
				if (currency_ID != invoice.getC_Currency_ID())
				{
					allocAmt = MConversionRate.convert(	ctx, allocAmt, currency_ID, invoice.getC_Currency_ID(), dateAcct, invoice.getC_ConversionType_ID(),
														client_ID, org_ID);
					if (allocAmt == null)
					{
						return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingAllocationCurrencyToInvoiceCurrency",
																	currency_ID, invoice.getC_Currency_ID(), invoice.getC_ConversionType_ID(),
																	dateAcct, trxName);
					}
				}
				BigDecimal invAmtAccted = MConversionRate.convertBase(	ctx, invoice.getGrandTotal(), invoice.getC_Currency_ID(), invoice.getDateAcct(),
																		invoice.getC_ConversionType_ID(), client_ID, org_ID);
				if (invAmtAccted == null)
				{
					return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingInvoiceCurrencyToBaseCurrency", invoice.getC_Currency_ID(),
																MClient.get(ctx).getC_Currency_ID(), invoice.getC_ConversionType_ID(),
																invoice.getDateAcct(), trxName);
				}

				BigDecimal allocAmtAccted = MConversionRate.convertBase(ctx, allocAmt, invoice.getC_Currency_ID(), dateAcct, invoice.getC_ConversionType_ID(),
																		client_ID, org_ID);
				if (allocAmtAccted == null)
				{
					return MConversionRateUtil.getErrorMessage(	ctx, "ErrorConvertingInvoiceCurrencyToBaseCurrency", invoice.getC_Currency_ID(),
																MClient.get(ctx).getC_Currency_ID(), invoice.getC_ConversionType_ID(),
																dateAcct, trxName);
				}

				if (allocAmt.compareTo(invoice.getGrandTotal()) == 0)
				{
					openBalanceDiff = openBalanceDiff.add(invAmtAccted).subtract(allocAmtAccted);
				}
				else
				{
					// allocation as a percentage of the invoice
					double multiplier = allocAmt.doubleValue() / invoice.getGrandTotal().doubleValue();
					// Reduce Orig Invoice Accounted
					invAmtAccted = invAmtAccted.multiply(BigDecimal.valueOf(multiplier));
					// Difference based on percentage of Orig Invoice
					// gain is negative
					openBalanceDiff = openBalanceDiff.add(invAmtAccted).subtract(allocAmtAccted);
					// ignore Tolerance
					if (openBalanceDiff.abs().compareTo(MAllocationHdr.TOLERANCE) < 0)
						openBalanceDiff = Env.ZERO;
					// Round
					int precision = MCurrency.getStdPrecision(ctx, client.getC_Currency_ID());
					if (openBalanceDiff.scale() > precision)
						openBalanceDiff = openBalanceDiff.setScale(precision, RoundingMode.HALF_UP);
				}
			}

			// Total Balance
			BigDecimal newBalance = bpartner.getTotalOpenBalance();
			if (newBalance == null)
				newBalance = Env.ZERO;

			BigDecimal originalBalance = new BigDecimal(newBalance.toString());

			if (openBalanceDiff.signum() != 0)
			{
				if (reverse)
					newBalance = newBalance.add(openBalanceDiff);
				else
					newBalance = newBalance.subtract(openBalanceDiff);
			}

			// Update BP Credit Used only for Customer Invoices and for payment-to-payment
			// allocations.
			BigDecimal newCreditAmt = Env.ZERO;
			if (isSOTrxInvoice || (invoice == null && paymentIsReceipt && paymentProcessed))
			{
				if (invoice == null)
					openBalanceDiff = openBalanceDiff.negate();

				newCreditAmt = bpartner.getSO_CreditUsed();

				if (reverse)
				{
					if (newCreditAmt == null)
						newCreditAmt = openBalanceDiff;
					else
						newCreditAmt = newCreditAmt.add(openBalanceDiff);
				}
				else
				{
					if (newCreditAmt == null)
						newCreditAmt = openBalanceDiff.negate();
					else
						newCreditAmt = newCreditAmt.subtract(openBalanceDiff);
				}

				if (log.isLoggable(Level.FINE))
				{
					log.fine(	"TotalOpenBalance=" + bpartner.getTotalOpenBalance() + "(" + openBalanceDiff
								+ ", Credit=" + bpartner.getSO_CreditUsed() + "->" + newCreditAmt
								+ ", Balance=" + bpartner.getTotalOpenBalance() + " -> " + newBalance);
				}
				bpartner.setSO_CreditUsed(newCreditAmt);
			}
			else
			{
				if (log.isLoggable(Level.FINE))
				{
					log.fine(	"TotalOpenBalance=" + bpartner.getTotalOpenBalance() + "(" + openBalanceDiff
								+ ", Balance=" + bpartner.getTotalOpenBalance() + " -> " + newBalance);
				}
			}

			if (newBalance.compareTo(originalBalance) != 0)
				bpartner.setTotalOpenBalance(newBalance);

			bpartner.setSOCreditStatus();
			if (!bpartner.save(trxName))
			{
				return "Could not update Business Partner";
			}

		} // for all lines
		return null;
	} // updateBP

}
