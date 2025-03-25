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
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * User Identity Configuration for SSO login
 */
public class MUserIdentity extends X_AD_UserIdentity
{
	/**
	 * 
	 */
	private static final long	serialVersionUID		= 6217444930942765522L;

	public static final String	SQL_NOT_EXISTS			= "(NOT EXISTS		(SELECT 1 			FROM AD_UserIdentity ui	WHERE ui.Identity=? AND ui.SSO_PrincipalConfig_ID = ? AND ui.IsActive = 'Y'))";
	public static final String	SQL_USER_IDENTITY_IN	= "AD_User_ID IN	(SELECT AD_User_ID	FROM AD_UserIdentity ui	WHERE ui.Identity=? AND ui.SSO_PrincipalConfig_ID = ? AND ui.IsActive = 'Y') ";

	public MUserIdentity(Properties ctx, int AD_UserIdentity_ID, String trxName)
	{
		super(ctx, AD_UserIdentity_ID, trxName);
	}

	public MUserIdentity(Properties ctx, int AD_UserIdentity_ID, String trxName, String[] virtualColumns)
	{
		super(ctx, AD_UserIdentity_ID, trxName, virtualColumns);
	}

	public MUserIdentity(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public MUserIdentity(Properties ctx, String AD_UserIdentity_UU, String trxName)
	{
		super(ctx, AD_UserIdentity_UU, trxName);
	}

	public MUserIdentity(Properties ctx, String AD_UserIdentity_UU, String trxName, String[] virtualColumns)
	{
		super(ctx, AD_UserIdentity_UU, trxName, virtualColumns);
	}

}
