package org.compiere.model;

import java.math.BigDecimal;
import java.util.Properties;

import org.adempiere.util.ProjectIssueUtil;
import org.compiere.util.Env;

/**
 * Project Issue Callout
 * Set Data from In Out Line, Expense Line and Invoice Line
 */
public class CalloutProjectIssue extends CalloutEngine
{
	public String setData(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		String name = mField.getColumnName();

		MAcctSchema as = MAcctSchema.getClientAcctSchema(Env.getCtx(), (int) mTab.getValue(MProjectIssue.COLUMNNAME_AD_Client_ID), null)[0];

		// Set Data From InOutLine
		if (MProjectIssue.COLUMNNAME_M_InOutLine_ID.equals(name) && value != null && ((int) value) > 0)
		{
			MInOutLine inOutLine = (MInOutLine) MTable.get(ctx, MInOutLine.Table_ID).getPO((int) value, null);

			if (inOutLine.getM_Product_ID() > 0)
			{
				// Set Product, Movement Qty and Locator and Remove Charge if selected
				mTab.setValue(MProjectIssue.COLUMNNAME_M_Product_ID, inOutLine.getM_Product_ID());
				mTab.setValue(MProjectIssue.COLUMNNAME_C_Charge_ID, 0);
				mTab.setValue(MProjectIssue.COLUMNNAME_MovementQty, inOutLine.getMovementQty());
				mTab.setValue(MProjectIssue.COLUMNNAME_M_Locator_ID, inOutLine.getM_Locator_ID());

				// set Description
				mTab.setValue(MProjectIssue.COLUMNNAME_Description, MProjectIssue.getInOutLineDesc(inOutLine));
				BigDecimal amt = ProjectIssueUtil.getPOCost(as, inOutLine.get_ID(), inOutLine.getMovementQty());

				// Get standard price of Product if product Price is null
				if (amt == null)
				{
					amt = ProjectIssueUtil.getProductStdCost(	as, inOutLine.getAD_Org_ID(), inOutLine.getM_Product_ID(),
																inOutLine.getM_AttributeSetInstance_ID(), null, inOutLine.getMovementQty());
				}
				mTab.setValue(MProjectIssue.COLUMNNAME_Amt, amt);
			}
		}
		// Set Data From TimeExpenseLine
		else if (MProjectIssue.COLUMNNAME_S_TimeExpenseLine_ID.equals(name) && value != null && ((int) value) > 0)
		{
			MTimeExpenseLine expenseLine = (MTimeExpenseLine) MTable.get(ctx, MTimeExpenseLine.Table_ID).getPO((int) value, null);

			if (expenseLine.getM_Product_ID() > 0)
			{
				// Set Product, Movement Qty and Locator and Remove Charge if selected
				mTab.setValue(MProjectIssue.COLUMNNAME_M_Product_ID, expenseLine.getM_Product_ID());
				mTab.setValue(MProjectIssue.COLUMNNAME_C_Charge_ID, 0);
				mTab.setValue(MProjectIssue.COLUMNNAME_MovementQty, expenseLine.getQty());
				mTab.setValue(MProjectIssue.COLUMNNAME_M_Locator_ID, MProjectIssue.getExpenseLineLocator(expenseLine));

				// Set amt
				BigDecimal amt = ProjectIssueUtil.getLaborCost(as, expenseLine.get_ID());
				// Get Standard Price of Product
				if (amt == null)
				{
					amt = ProjectIssueUtil.getProductStdCost(	as, expenseLine.getAD_Org_ID(), expenseLine.getM_Product_ID(),
																0, null, expenseLine.getQty());
				}

				mTab.setValue(MProjectIssue.COLUMNNAME_Amt, amt);
			}
		}
		// Set Data From InvoiceLine
		else if (MProjectIssue.COLUMNNAME_C_InvoiceLine_ID.equals(name) && value != null && ((int) value) > 0)
		{
			MInvoiceLine invLine = (MInvoiceLine) MTable.get(ctx, MInvoiceLine.Table_ID).getPO((int) value, null);

			if (MProjectIssue.projectIssueHasInvoiceLine(invLine.get_ID(), null))
				throw new IllegalArgumentException("Invoice Line is not valid - " + invLine);

			if (invLine.getC_Charge_ID() > 0)
			{
				// Set Charge, Qty and Amount
				mTab.setValue(MProjectIssue.COLUMNNAME_M_Product_ID, 0);
				mTab.setValue(MProjectIssue.COLUMNNAME_C_Charge_ID, invLine.getC_Charge_ID());
				mTab.setValue(MProjectIssue.COLUMNNAME_MovementQty, invLine.getQtyInvoiced());
				mTab.setValue(MProjectIssue.COLUMNNAME_Amt, MProjectIssue.getInvLineAmt(invLine));

				// Set Description
				mTab.setValue(MProjectIssue.COLUMNNAME_Description, MProjectIssue.getInvDescription(invLine));
			}
		}

		return null;
	} // setData
}
