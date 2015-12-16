package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;

public class MAuthorizationToken extends X_AD_AuthorizationToken
{

	/**
	 * 
	 */
	private static final long	serialVersionUID	= -7222574226855752416L;

	public MAuthorizationToken(Properties ctx, int AD_AuthorizationToken_ID, String trxName)
	{
		super(ctx, AD_AuthorizationToken_ID, trxName);
	}

	public MAuthorizationToken(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public static MAuthorizationToken get(Properties ctx, String Username, String Token)
	{
		StringBuilder m_sql = new StringBuilder();
		m_sql.append("SELECT AD_AuthorizationToken_ID FROM AD_AuthorizationToken WHERE");
		
		if (MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false))
			m_sql.append(" AD_User_ID IN (SELECT AD_User_ID FROM AD_User WHERE EMail ILIKE ? AND AD_User.AD_Client_ID=AD_AuthorizationToken.AD_Client_ID)");
		else
			m_sql.append(" AD_User_ID IN (SELECT AD_User_ID FROM AD_User WHERE Name LIKE ? AND AD_User.AD_Client_ID=AD_AuthorizationToken.AD_Client_ID)");
		
		m_sql.append(" AND Token LIKE ? AND (ValidTo IS NULL OR ValidTo > now())");
		m_sql.append(" AND IsActive = 'Y'");
		int id = DB.getSQLValue(null, m_sql.toString(), Username, Token);
		if (id > 0)
		{
			return new MAuthorizationToken(ctx, id,null);
		}
		return null;
	}

}
