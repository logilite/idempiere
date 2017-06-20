/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;

/**
 * Favorite Tree Node Model
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class MTreeFavoriteNode extends X_AD_Tree_Favorite_Node
{

	/**
	 * 
	 */
	private static final long	serialVersionUID	= -1085269880909860587L;

	public static final String	SQL_GET_MENU_ID		= "SELECT AD_Menu_ID FROM AD_Tree_Favorite_Node "
			+ " WHERE AD_Tree_Favorite_ID=? AND Parent_ID=? AND AD_Menu_ID IS NOT NULL";

	/**
	 * @param ctx
	 * @param AD_Tree_Favorite_Node_ID
	 * @param trxName
	 */
	public MTreeFavoriteNode(Properties ctx, int AD_Tree_Favorite_Node_ID, String trxName)
	{
		super(ctx, AD_Tree_Favorite_Node_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MTreeFavoriteNode(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Check the Menu ID is Present on specified Parent id or not
	 * 
	 * @param menuID
	 * @param nodeID
	 * @param favTreeID
	 * @return True if same menu exits
	 */
	public static boolean isMenuExists(int menuID, int nodeID, int favTreeID)
	{
		boolean isSameMenu = false;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL_GET_MENU_ID, null);
			pstmt.setInt(1, favTreeID);
			pstmt.setInt(2, nodeID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				if (rs.getInt(1) == menuID)
					isSameMenu = true;
			}
		}
		catch (SQLException e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return isSameMenu;
	} // isMenuExists

}
