package org.idempiere.adinterface;

import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAuthorizationToken;

public class AuthTokenContext
{
	/**
	 * 
	 */
	private static final long	serialVersionUID	= 2616420632810428439L;
	private Properties			m_ctx;
	private MAuthorizationToken	authToken;
	private Timestamp			lastUsageTime;

	public AuthTokenContext()
	{
		this.lastUsageTime = new Timestamp(System.currentTimeMillis());
	}

	public Properties getPropertie()
	{
		return m_ctx;
	}

	public void setPropertie(Properties m_ctx)
	{
		if (m_ctx != null)
		{
			this.m_ctx = m_ctx;
			//this.m_ctx.setProperty("#AD_Session_ID", "");
			//Env.setContext(m_ctx, "#AD_Session_ID", "");
		}
	}

	public MAuthorizationToken getAuthToken()
	{
		return authToken;
	}

	public void setAuthToken(MAuthorizationToken authToken)
	{
		if (authToken != null)
		{
			this.authToken = authToken;
			this.lastUsageTime = authToken.getLastAccessTime();
		}
	}

	public Timestamp getLastUsageTime()
	{
		return lastUsageTime;
	}

	public void setLastUsageTime(Timestamp lastUsageTime)
	{
		this.lastUsageTime = lastUsageTime;
	}

}
