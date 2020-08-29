/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

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

	/** Cache of Client, User & Role wise Tree Favorite ID */
	private static CCache<String, Integer>	s_treeCache					= new CCache<String, Integer>(Table_Name, 30);

	public static final String				SQL_GET_TREE_FAVORITE_ID	= "SELECT AD_Tree_Favorite_ID FROM AD_Tree_Favorite	WHERE AD_Client_ID = ? AND AD_Role_ID = ? AND COALESCE(AD_User_ID, 0) = ?";

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

		if (AD_Tree_Favorite_ID != 0)
		{
			loadNode(AD_Tree_Favorite_ID);
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
	public void loadNode(int AD_Tree_Favorite_ID)
	{
		root = new MTreeNode(0, 0, "User Favourite Root", "User Favourite Root", 0, true, 0, null, false);

		List<MTreeFavoriteNode> nodes = getNode(AD_Tree_Favorite_ID, get_TrxName());

		for (MTreeFavoriteNode node : nodes)
		{
			int nodeID = node.getAD_Tree_Favorite_Node_ID();
			int parentID = node.getParent_ID();
			int seqNo = node.getSeqNo();
			String name = node.getName();
			boolean isSummary = node.isSummary();
			boolean isCollapsible = node.isCollapsible();

			String img = null;
			int menuID = 0;
			if (!isSummary)
			{
				menuID = node.getAD_Menu_ID();
				MMenu mMenu = new MMenu(Env.getCtx(), menuID, null);
				name = mMenu.get_Translation(MMenu.COLUMNNAME_Name);
				img = mMenu.getAction();
			}

			if (AD_Tree_Favorite_ID == 0 && (parentID == 0 || nodeID == 0))
				;
			else
				addToTree(nodeID, parentID, seqNo, name, isSummary, menuID, img, isCollapsible);
		}
	} // loadNode

	/**
	 * Get tree favorite node list
	 * 
	 * @param  AD_Tree_Favorite_ID
	 * @param  trxName
	 * @return                     list of nodes
	 */
	private static List<MTreeFavoriteNode> getNode(int AD_Tree_Favorite_ID, String trxName)
	{
		List<MTreeFavoriteNode> retValue = new Query(Env.getCtx(), MTreeFavoriteNode.Table_Name, MTreeFavoriteNode.COLUMNNAME_AD_Tree_Favorite_ID + "=? ", trxName)
						.setParameters(AD_Tree_Favorite_ID)
						.setOnlyActiveRecords(true)
						.setOrderBy("COALESCE(Parent_ID, -1), SeqNo, Name")
						.list();
		return retValue;
	} // getNode

	/**
	 * Adding Node Into Tree
	 * 
	 * @param favNodeID
	 * @param parentID
	 * @param seqNo
	 * @param name
	 * @param isSummary
	 * @param menuID
	 * @param img
	 * @param isCollapsible
	 */
	private void addToTree(int favNodeID, int parentID, int seqNo, String name, boolean isSummary, int menuID, String img, boolean isCollapsible)
	{
		MTreeNode child = new MTreeNode(favNodeID, seqNo, name, name, parentID, isSummary, menuID, img, isCollapsible);

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
	 * Getting Tree ID for a specific User & Role Wise
	 * 
	 * @param  clientID
	 * @param  roleID
	 * @param  userID
	 * @return          Tree Favorite ID
	 */
	public static int getTreeID(int clientID, int roleID, int userID)
	{
		String key = clientID + "_" + roleID + "_" + userID;
		if (s_treeCache.containsKey(key))
			return s_treeCache.get(key);

		Object[] params = { clientID, roleID, userID };
		int id = DB.getSQLValue(null, SQL_GET_TREE_FAVORITE_ID, params);
		if (id > 0)
			s_treeCache.put(key, id);

		return id;
	} // getTreeID

	/**
	 * Get Default Favorite Tree ID for a specific Client & Role Wise
	 * 
	 * @param  clientID
	 * @param  roleID
	 * @return          Default Tree Favorite ID
	 */
	public static int getDefaultUserFavTreeID(int clientID, int roleID)
	{
		return getTreeID(clientID, roleID, 0);
	} // getDefaultUserFavTreeID

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
	 * @param clientID       - AD_Client_ID
	 * @param roleID         - AD_Role_ID
	 * @param userID         - AD_User_ID
	 * @param trxName        - Trx Name
	 */
	public static void cloneTreeStructure(int fromTreeFav_ID, int clientID, int roleID, int userID, String trxName)
	{
		int toFavTree_ID = getTreeID(clientID, roleID, userID);
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
