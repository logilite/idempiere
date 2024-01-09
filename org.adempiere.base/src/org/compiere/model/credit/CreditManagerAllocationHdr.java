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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.CreditStatus;
import org.adempiere.base.ICreditManager;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MPayment;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Credit Manager for Payment
 * 
 * @author Logilite Technologies
 * @since  July 25, 2023
 */
public class CreditManagerAllocationHdr implements ICreditManager
{
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
	public CreditStatus checkCreditStatus(String docAction)
	{
		String errorMsg = null;
		if (MPayment.DOCACTION_Complete.equals(docAction))
		{
			updateOpenBalForMultipleBP(false);
			errorMsg = updateBP();
		}
		else if (MPayment.DOCACTION_Reverse_Accrual.equals(docAction) || MPayment.DOCACTION_Reverse_Correct.equals(docAction))
		{
			// Unlink Invoices
			updateOpenBalForMultipleBP(true);
			errorMsg = updateBP();
		}
		else if (MPayment.DOCACTION_Void.equals(docAction))
		{
			errorMsg = updateBP();
		}
		return new CreditStatus(errorMsg, !Util.isEmpty(errorMsg));
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
	private String updateBP()
	{
		List<Integer> bps = new ArrayList<Integer>();
		for (MAllocationLine line : allocationHdr.getLines(false))
		{
			int C_BPartner_ID = line.getC_BPartner_ID();
			if (!bps.contains(C_BPartner_ID))
			{
				bps.add(C_BPartner_ID);
				MBPartner bpartner = (MBPartner) MTable.get(Env.getCtx(), MBPartner.Table_ID).getPO(C_BPartner_ID,
						allocationHdr.get_TrxName());
				bpartner.setTotalOpenBalance();
				bpartner.saveEx();
			}
		} // for all lines
		return null;
	} // updateBP
}
