package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

public class MTableAttribute extends X_AD_TableAttribute
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2624557341374329315L;

	public MTableAttribute(Properties ctx, int AD_TableAttribute_ID, String trxName)
	{
		super(ctx, AD_TableAttribute_ID, trxName);
	}

	public MTableAttribute(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public static MTableAttribute get(int tableID, int recordID, int attrID)
	{
		String whereClause = MTableAttribute.COLUMNNAME_AD_Table_ID + " = ? AND " + MTableAttribute.COLUMNNAME_Record_ID + " = ? AND " + MTableAttribute.COLUMNNAME_M_Attribute_ID + " = ? ";
		return new Query(Env.getCtx(), MTableAttribute.Table_Name, whereClause, null).setParameters(tableID, recordID, attrID).first();
	}
}
