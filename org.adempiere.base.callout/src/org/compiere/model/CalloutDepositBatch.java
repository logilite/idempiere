package org.compiere.model;

import java.util.Properties;

public class CalloutDepositBatch extends CalloutEngine
{

	/**
	 * 	Bank Account Changed.
	 * 	Update Currency
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String bankAccount (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null)
			return "";
		int C_BankAccount_ID = ((Integer)value).intValue();
		MBankAccount ba = MBankAccount.get(ctx, C_BankAccount_ID);
		mTab.setValue(MCurrency.COLUMNNAME_C_Currency_ID, ba.getC_Currency_ID());
		return "";
	}	
	
}
