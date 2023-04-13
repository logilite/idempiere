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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Favorite Tree Model
 * 
 * @author Logilite Technologies
 * @since  June 20, 2017
 */
public class MTreeFavorite extends X_AD_Tree_Favorite
{

	/**
	 * 
	 */
	private static final long				serialVersionUID			= -1781192037651191816L;

	public static final String				SQL_GET_TREE_FAVORITE_ID	= "SELECT AD_Tree_Favorite_ID FROM AD_Tree_Favorite	WHERE IsActive='Y' ";

	public static final String				SQL_COUNT_TREE_FAVORITENODE	= "SELECT COUNT(1) FROM AD_Tree_Favorite_Node WHERE IsActive='Y' AND AD_Tree_Favorite_ID=? ";

	public static final String				SQL_GET_TREE_FAVORITE_NODE	= "SELECT AD_Tree_Favorite_Node_ID, Parent_ID, SeqNo, Name, IsSummary, AD_Menu_ID, IsCollapsible, IsFavourite "
																			+ " FROM AD_Tree_Favorite_Node WHERE IsActive='Y' AND AD_Tree_Favorite_ID=? "
																			+ " ORDER BY COALESCE(Parent_ID, -1), SeqNo, Name ";

	/** Cache for AD_Tree_Favorite_ID */
	private static CCache<String, Integer>	cache_TreeFavID				= new CCache<String, Integer>("AD_Tree_Favorite_ID", 30);

	private ArrayList<MTreeNode>			m_buffer					= new ArrayList<MTreeNode>();
	private MTreeNode						root						= null;

	/**
	 * Construct Tree Favorite Model
	 * 
	 * @param ctx
	 * @param AD_Tree_Favorite_ID
	 * @param trxName
	 */
	public MTreeFavorite(Properties ctx, int AD_Tree_Favorite_ID, String trxName)
	{
		super(ctx, AD_Tree_Favorite_ID, trxName);

		if (AD_Tree_Favorite_ID > 0)
		{
			loadNode();
		}
	}

	public MTreeFavorite(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public MTreeNode getRoot()
	{
		return root;
	} // getRoot

	/**
	 * Load Node Into Tree
	 * 
	 * @param AD_Tree_Favorite_ID
	 */
	private void loadNode()
	{
		MRole role = MRole.get(getCtx(), Env.getAD_Role_ID(Env.getCtx()));

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			root = new MTreeNode(0, 0, "User Favourite Root", "User Favourite Root", 0, 0, null, true, false, false);

			pstmt = DB.prepareStatement(SQL_GET_TREE_FAVORITE_NODE, get_TrxName());
			pstmt.setInt(1, getAD_Tree_Favorite_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int nodeID = rs.getInt(1);
				int parentID = rs.getInt(2);
				int seqNo = rs.getInt(3);
				String name = rs.getString(4);
				boolean isSummary = (rs.getString(5).equals("Y"));
				boolean isCollapsible = rs.getString(7).equals("Y");
				boolean isFavourite = rs.getString("IsFavourite").equals("Y");

				int menuID = 0;
				String img = null;
				Boolean access = null;
				if (!isSummary)
				{
					menuID = rs.getInt(6);
					MMenu menu = (MMenu) MTable.get(Env.getCtx(), MMenu.Table_ID).getPO(menuID, null);
					access = getAccessForMenuItem(role, menu);

					if (access != null)
					{
						name = menu.getDisplayedName();
						img = menu.getAction();
					}
				}

				if (access != null || isSummary)
					addToTree(nodeID, parentID, seqNo, name, menuID, img, isSummary, isCollapsible, isFavourite);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL_GET_TREE_FAVORITE_NODE, e);
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	} // loadNode

	/**
	 * Adding Node Into Tree
	 * 
	 * @param favNodeID
	 * @param parentID
	 * @param seqNo
	 * @param name
	 * @param menuID
	 * @param imgSrc
	 * @param isSummary
	 * @param isCollapsible
	 * @param isFavourite
	 */
	private void addToTree(	int favNodeID, int parentID, int seqNo, String name, int menuID, String imgSrc, boolean isSummary, boolean isCollapsible,
							boolean isFavourite)
	{
		MTreeNode child = new MTreeNode(favNodeID, seqNo, name, name, parentID, menuID, imgSrc, isSummary, isCollapsible, isFavourite);

		MTreeNode parent = null;
		if (root != null)
			parent = root.findNode(parentID);
		// Parent found
		if (parent != null && parent.getAllowsChildren())
		{
			parent.add(child);
			if (m_buffer.size() > 0)
				checkBuffer(child);
		}
		else
			m_buffer.add(child);
	} // addToTree

	/**
	 * Check the buffer for nodes which have newNode as Parents
	 * 
	 * @param newNode new node
	 */
	private void checkBuffer(MTreeNode child)
	{
		// Ability to add nodes
		if (!child.isSummary() || !child.getAllowsChildren())
			return;
		for (int i = 0; i < m_buffer.size(); i++)
		{
			MTreeNode node = (MTreeNode) m_buffer.get(i);
			if (node.getParent_ID() == child.getParent_ID())
			{
				try
				{
					child.add(node);
				}
				catch (Exception e)
				{
					log.severe("Adding " + node.getName() + " to " + child.getName() + ": " + e.getMessage());
				}
				m_buffer.remove(i);
				i--;
			}
			else if (node.getParent_ID() == child.getNode_ID())
			{
				try
				{
					child.add(node);
				}
				catch (Exception e)
				{
					log.severe("Adding " + node.getName() + " to " + child.getName() + ": " + e.getMessage());
				}
				m_buffer.remove(i);
				i--;
			}
		}
	} // checkBuffer

	/**
	 * Get Favorite Tree ID for a specific User wise or Role wise tree reference
	 * 
	 * @param  userID
	 * @param  roleID
	 * @return        Favorite Tree_ID
	 */
	public static int getFavoriteTreeID(int userID, int roleID)
	{
		String key = "" + userID + "_" + roleID;
		if (cache_TreeFavID.containsKey(key))
			return cache_TreeFavID.get(key);

		String sql = SQL_GET_TREE_FAVORITE_ID
						+ (userID > 0 ? " AND AD_User_ID=? " : " AND COALESCE(AD_User_ID, 0)=0 AND AD_Role_ID=? ")
						+ "ORDER BY AD_Tree_Favorite_ID ";
		int id = DB.getSQLValue(null, sql, (userID > 0 ? userID : roleID));
		if (id > 0)
			cache_TreeFavID.put(key, id);
		return id;
	} // getFavoriteTreeID

	/**
	 * get access for the menu from specified role
	 * 
	 * @param  role
	 * @param  menu
	 * @return
	 */
	public static Boolean getAccessForMenuItem(MRole role, I_AD_Menu menu)
	{
		Boolean access = null;
		if (MMenu.ACTION_Window.equals(menu.getAction()))
			access = role.getWindowAccess(menu.getAD_Window_ID());
		else if (MMenu.ACTION_Process.equals(menu.getAction()) || MMenu.ACTION_Report.equals(menu.getAction()))
			access = role.getProcessAccess(menu.getAD_Process_ID());
		else if (MMenu.ACTION_Form.equals(menu.getAction()))
			access = role.getFormAccess(menu.getAD_Form_ID());
		else if (MMenu.ACTION_WorkFlow.equals(menu.getAction()))
			access = role.getWorkflowAccess(menu.getAD_Workflow_ID());
		else if (MMenu.ACTION_Task.equals(menu.getAction()))
			access = role.getTaskAccess(menu.getAD_Task_ID());
		else if (MMenu.ACTION_Info.equals(menu.getAction()))
			access = role.getInfoAccess(menu.getAD_InfoWindow_ID());

		return access;
	} // getAccessForMenuItem

	/**
	 * Copy From
	 * 
	 * @param  from       - MTreeFavorite
	 * @param  AD_User_ID
	 * @param  trxName
	 * @return            MTreeFavorite
	 */
	public static MTreeFavorite copyFrom(MTreeFavorite from, int AD_User_ID, String trxName)
	{
		MTreeFavorite to = (MTreeFavorite) MTable.get(from.getCtx(), MTreeFavorite.Table_ID).getPO(0, trxName);
		to.set_TrxName(trxName);
		PO.copyValues(from, to, from.getAD_Client_ID(), from.getAD_Org_ID());
		to.setAD_User_ID(AD_User_ID);
		if (!to.save(trxName))
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "FavTreeNotCreate"));

		return to;
	} // copyFrom

	/**
	 * Clone tree structure from reference tree
	 * 
	 * @param fromTreeFav_ID - AD_Tree_Favorite_ID
	 * @param roleID         - AD_Role_ID
	 * @param userID         - AD_User_ID
	 * @param trxName        - Trx Name
	 */
	public static void cloneTreeStructure(int fromTreeFav_ID, int roleID, int userID, String trxName)
	{
		int toFavTree_ID = getFavoriteTreeID(userID, roleID);
		if (toFavTree_ID > 0)
		{
			/***
			 * Delete user tree favorite nodes
			 */
			List<MTreeFavoriteNode> toNodeList = getTreeFavoriteNodeLevelWise(toFavTree_ID, 0, trxName);

			for (MTreeFavoriteNode tfn : toNodeList)
			{
				tfn.delete(true);
			}
		}
		else
		{
			MTreeFavorite fromTreeFav = (MTreeFavorite) MTable.get(Env.getCtx(), MTreeFavorite.Table_ID).getPO(fromTreeFav_ID, trxName);
			MTreeFavorite toTreeFav = copyFrom(fromTreeFav, userID, trxName);
			toFavTree_ID = toTreeFav.getAD_Tree_Favorite_ID();
		}

		// Get root level nodes
		List<MTreeFavoriteNode> fromNodeList = getTreeFavoriteNodeLevelWise(fromTreeFav_ID, 0, trxName);

		for (MTreeFavoriteNode fromTFN : fromNodeList)
		{
			cloneNode(toFavTree_ID, fromTFN, null, trxName);
		}
	} // cloneTreeStructure

	/**
	 * Recursive call for cloning hierarchy of the nodes
	 * 
	 * @param toFavTree_ID - New tree favorite ID
	 * @param fromTFN      - Old tree favorite node
	 * @param parentTFN    - New parent tree favorite node
	 * @param trxName      - Trx name
	 */
	public static void cloneNode(int toFavTree_ID, MTreeFavoriteNode fromTFN, MTreeFavoriteNode parentTFN, String trxName)
	{
		int parentNodeID = 0;
		if (parentTFN != null && fromTFN.getParent_ID() > 0)
			parentNodeID = parentTFN.getAD_Tree_Favorite_Node_ID();

		MTreeFavoriteNode newTFN = MTreeFavoriteNode.copyFrom(fromTFN, toFavTree_ID, parentNodeID, trxName);

		if (fromTFN.isSummary())
		{
			// Get level wise nodes
			List<MTreeFavoriteNode> fromChildNodeList = getTreeFavoriteNodeLevelWise(fromTFN.getAD_Tree_Favorite_ID(), fromTFN.getAD_Tree_Favorite_Node_ID(), trxName);

			for (MTreeFavoriteNode fromChildTFN : fromChildNodeList)
			{
				cloneNode(toFavTree_ID, fromChildTFN, newTFN, trxName);
			}
		}
	} // cloneNode

	/**
	 * Get tree favorite node level wise
	 * 
	 * @param  AD_Tree_Favorite_ID
	 * @param  parentNodeID
	 * @param  trxName
	 * @return                     list of node
	 */
	public static List<MTreeFavoriteNode> getTreeFavoriteNodeLevelWise(int AD_Tree_Favorite_ID, int parentNodeID, String trxName)
	{
		List<MTreeFavoriteNode> childNodeList = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, MTreeFavoriteNode.COLUMNNAME_AD_Tree_Favorite_ID + "=? AND COALESCE(Parent_ID, 0) = ?", trxName)
						.setParameters(AD_Tree_Favorite_ID, parentNodeID)
						.setOnlyActiveRecords(true)
						.setOrderBy(MTreeFavoriteNode.COLUMNNAME_AD_Tree_Favorite_Node_ID)
						.list();
		return childNodeList;
	} // getTreeFavoriteNodeLevelWise

}
