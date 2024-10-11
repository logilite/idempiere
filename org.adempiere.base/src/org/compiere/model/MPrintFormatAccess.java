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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.print.MPrintFormat;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class MPrintFormatAccess extends X_AD_PrintFormat_Access
{
	/**
	 * 
	 */
	private static final long				serialVersionUID					= -1289603024280848272L;

	public static final String				Msg_PF_Access_Update				= "PFAccessUpdate";
	public static final String				Msg_PF_Access_Share					= "PFAccessShare";
	public static final String				Msg_PF_Access_Delete				= "PFAccessDelete";
	public static final String				Msg_PF_Access_Already_Exists		= "PFAccessAlreadyExists";
	public static final String				Mag_PF_Access_Share_Successfully	= "PFAccessShareSuccessfully";

	/** Cached Formats Access */
	private static CCache<String, String>	s_formatAccess						= new CCache<String, String>(Table_Name, 30);

	private static final String				SQL_PRINTFORMAT_ACCESS				= "SELECT AD_PrintFormat_Access_ID FROM AD_PrintFormat_Access WHERE ((AD_User_ID IS NULL AND AD_Role_ID = ?) OR (AD_Role_ID IS NULL AND AD_User_ID = ?) OR (AD_Role_ID = ? AND AD_User_ID = ?)) AND AD_PrintFormat_ID = ? ";

	private static final String				SQL_HAS_PRINTFORMAT_ACCESS			= "SELECT COUNT(1) FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = ? ";

	public MPrintFormatAccess(Properties ctx, int AD_PrintFormat_Access_ID, String trxName)
	{
		super(ctx, AD_PrintFormat_Access_ID, trxName);
	}

	public MPrintFormatAccess(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * Checks if the current user has read access to a given print format.
	 * 
	 * @param printFormat_ID  The ID of the print format to check.
	 * @param trxName         The name of the transaction, can be null.
	 * 
	 * @return true if the user has read access, false otherwise.
	 */
	public static boolean isReadAccessPrintFormat(int printFormat_ID, String trxName)
	{
		MUser user = MUser.get(Env.getCtx());
		if (user.isSupportUser())
			return true;

		// Created user has access by default & PF created by System is accessed by all user
		MPrintFormat pf = (MPrintFormat) MTable.get(Env.getCtx(), MPrintFormat.Table_Name, trxName).getPO(printFormat_ID, trxName);

		if (!isPFAccessExist(printFormat_ID, trxName))
			return true;

		String accessLevel = getAccessLevel(printFormat_ID, trxName, true);
		if (accessLevel.contains("R"))
			return true;

		return pf.getCreatedBy() == Env.getAD_User_ID(Env.getCtx());
	}// isReadAccessPrintFormat
	
	/**
	 * Checks if the current user has write access to a given print format.
	 * 
	 * @param printFormat_ID  The ID of the print format to check.
	 * @param trxName         The name of the transaction, can be null.
	 * 
	 * @return true if the user has write access, false otherwise.
	 */
	public static boolean isWriteAccessPrintFormat(int printFormat_ID, String trxName)
	{
		MUser user = MUser.get(Env.getCtx());
		if (user.isSupportUser())
			return true;

		// Created user has access by default & PF created by System is accessed by all user
		MPrintFormat pf = (MPrintFormat) MTable.get(Env.getCtx(), MPrintFormat.Table_Name, trxName).getPO(printFormat_ID, trxName);

		if (!isPFAccessExist(printFormat_ID, trxName))
			return true;

		String accessLevel = getAccessLevel(printFormat_ID, trxName, true);
		if (accessLevel.contains("W"))
			return true;

		return pf.getCreatedBy() == Env.getAD_User_ID(Env.getCtx());
	}// isWriteAccessPrintFormat

	/**
	 * Retrieves the access level for a given print format.
	 * 
	 * @param printFormat_ID  The ID of the print format.
	 * @param trxName         The name of the transaction, can be null.
	 * @param isReload        Flag indicating if the access levels should be reloaded if not found.
	 * 
	 * @return A string representing the access level, "R" for read, "RW" for read-write, or an empty string if no access exists.
	 */
	private static String getAccessLevel(int printFormat_ID, String trxName, boolean isReload)
	{
		// user + role level
		String key = String.valueOf(printFormat_ID) + "_U-" + String.valueOf(Env.getAD_User_ID(Env.getCtx())) + "_R-" + String.valueOf(Env.getAD_Role_ID(Env
																																							.getCtx()));
		if (s_formatAccess.containsKey(key))
			return s_formatAccess.get(key);
		// User level
		key = String.valueOf(printFormat_ID) + "_U-" + String.valueOf(Env.getAD_User_ID(Env.getCtx()));
		if (s_formatAccess.containsKey(key))
			return s_formatAccess.get(key);
		// role level
		key = String.valueOf(printFormat_ID) + "_R-" + String.valueOf(Env.getAD_Role_ID(Env.getCtx()));
		if (s_formatAccess.containsKey(key))
			return s_formatAccess.get(key);

		if (isReload)
		{
			loadAccessLevel(printFormat_ID, trxName);
			return getAccessLevel(printFormat_ID, trxName, false);
		}

		return "";
	}
	
	/**
	 * Loads the access level for the specified print format from the database.
	 * Populates the access level for the current user and role.
	 * 
	 * @param printFormat_ID  The ID of the print format to load access levels for.
	 * @param trxName         The name of the transaction, can be null.
	 */
	public static void loadAccessLevel(int printFormat_ID, String trxName)
	{
		int role_ID = Env.getAD_Role_ID(Env.getCtx());
		int user_ID = Env.getAD_User_ID(Env.getCtx());
		int[] access_IDs = DB.getIDsEx(trxName, SQL_PRINTFORMAT_ACCESS, role_ID, user_ID, role_ID, user_ID, printFormat_ID);
		for (int access_ID : access_IDs)
		{
			MPrintFormatAccess access = new MPrintFormatAccess(Env.getCtx(), access_ID, trxName);
			String accessLevel = access.isReadWrite() ? "RW" : "R";
			String key = getKeyValue(access);
			s_formatAccess.put(key, accessLevel);
		}
	}

	private static String getKeyValue(MPrintFormatAccess access)
	{
		String key = String.valueOf(access.getAD_PrintFormat_ID());
		if (access.getAD_User_ID() > 0)
			key += "_U-" + String.valueOf(access.getAD_User_ID());
		if (access.getAD_Role_ID() > 0)
			key += "_R-" + String.valueOf(access.getAD_Role_ID());
		return key;
	}

	/**
	 * @param  printFormat_ID Print Format
	 * @param  trxName        Trx Name
	 * @return                true if access record for print format exists.
	 */
	public static boolean isPFAccessExist(int printFormat_ID, String trxName)
	{
		int count = DB.getSQLValue(trxName, SQL_HAS_PRINTFORMAT_ACCESS, printFormat_ID);
		if (count > 0)
			return true;
		return false;
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (!isWriteAccessPrintFormat(getAD_PrintFormat_ID(), get_TrxName()))
			throw new AdempiereException(Msg.getMsg(getCtx(), Msg_PF_Access_Share, true));
		return super.beforeSave(newRecord);
	}

	@Override
	protected boolean beforeDelete()
	{
		if ((!isWriteAccessPrintFormat(getAD_PrintFormat_ID(), get_TrxName()))
			|| (getCreatedBy() != Env.getAD_User_ID(Env.getCtx())))// The user who creates access
																	// can delete accessed record.
			throw new AdempiereException(Msg.getMsg(getCtx(), Msg_PF_Access_Delete, true));
		return super.beforeDelete();
	}

	/**
	 * Retrieves the print format access for the given parameters.
	 * If `ad_User_ID` or `ad_Role_ID` is greater than 0, those are included in the query.
	 * 
	 * @param printFormat_ID  The ID of the print format to retrieve access for.
	 * @param ad_User_ID      The ID of the user. If greater than 0, the access is filtered by this user.
	 * @param ad_Role_ID      The ID of the role. If greater than 0, the access is filtered by this role.
	 * @param trxName         The name of the transaction, can be null.
	 * 
	 * @return The matching {@link MPrintFormatAccess} object if found, or null if no match is found.
	 */
	public static MPrintFormatAccess get(int printFormat_ID, int ad_User_ID, int ad_Role_ID, String trxName)
	{
		List<Object> params = new ArrayList<Object>();
		String whereClause = "AD_PrintFormat_ID = ?";
		params.add(printFormat_ID);
		if (ad_User_ID > 0)
		{
			whereClause += " AND AD_User_ID = ? ";
			params.add(ad_User_ID);
		}
		if (ad_Role_ID > 0)
		{
			whereClause += " AND AD_Role_ID = ? ";
			params.add(ad_Role_ID);
		}

		return new Query(Env.getCtx(), MPrintFormatAccess.Table_Name, whereClause, trxName).setParameters(params).setOnlyActiveRecords(true).first();
	}
	
	/**
	 * Shares or creates print format access for a given user and/or role.
	 * Either retrieves an existing access record or creates a new one if none exists.
	 * 
	 * @param ctx            The context properties.
	 * @param PrintFormat_ID The ID of the print format for which access is being shared.
	 * @param user_ID        The ID of the user to assign the access to. If greater than 0, access is assigned to this user.
	 * @param role_ID        The ID of the role to assign the access to. If greater than 0, access is assigned to this role.
	 * @param isReadWrite    Flag indicating whether the access is read-write (true) or read-only (false).
	 * @param trxName        The name of the transaction, can be null.
	 * 
	 * @return The {@link MPrintFormatAccess} object representing the shared or created access.
	 * 
	 * @throws IllegalStateException If saving the access fails.
	 */
	public static MPrintFormatAccess sharePrintFormatAccess(Properties ctx, int PrintFormat_ID, int user_ID, int role_ID, boolean isReadWrite, String trxName)
	{
		MPrintFormatAccess access = MPrintFormatAccess.get(PrintFormat_ID, user_ID, role_ID, trxName);
		int access_ID = 0;
		if (access != null && access.getAD_PrintFormat_Access_ID() > 0)
			access_ID = access.getAD_PrintFormat_Access_ID();
		access = new MPrintFormatAccess(ctx, access_ID, trxName);
		access.setAD_PrintFormat_ID(PrintFormat_ID);
		access.setIsReadWrite(isReadWrite);
		if (user_ID > 0)
			access.setAD_User_ID(user_ID);
		if (role_ID > 0)
			access.setAD_Role_ID(role_ID);
		access.saveEx();
		return access;
	}
}
