package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MContactActivity_Attendees extends X_C_ContactActivity_Attendees
{

	/**
	 * 
	 */
	private static final long	serialVersionUID	= 7229243921284876215L;

	public MContactActivity_Attendees(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public MContactActivity_Attendees(Properties ctx, int C_ContactActivity_Attendees_ID, String trxName)
	{
		super(ctx, C_ContactActivity_Attendees_ID, trxName);
	}

}
