/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.dashboard;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.FavoriteSimpleTreeModel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.I_AD_Tree_Favorite;
import org.compiere.model.MTable;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.model.MUser;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.Button;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Vbox;

/**
 * Dashboard item: User's Favorite Dashboard Panel
 * 
 * @author Logilite Technologies
 * @since  June 20, 2017
 */
public class DPUserFavorites extends DashboardPanel implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long		serialVersionUID				= 4341658324859506048L;

	private static String			SQL_COUNT_TREE_FAVORITE_NODE	= "SELECT COUNT(1) FROM AD_Tree_Favorite_Node WHERE AD_Tree_Favorite_ID=?";

	private FavoriteSimpleTreeModel	treeModel;
	private Checkbox				chkExpand;
	private Checkbox				addAsRoot;
	private Textbox					textbox;
	private Tree					tree;
	private Panel					panel;
	private Panelchildren			favContent;

	private Button					btnAdd;
	private Button					btnCopyTree;
	private Button					btnShowMyTree;
	private Button					btnShowDefaultTree;

	private Div						favToolbarRow1;
	private Div						favToolbarRow2;

	private MUser					user;

	private int						m_AD_FavTree_ID;
	private int						AD_Role_ID;
	private int						AD_Client_ID;
	private int						AD_Org_ID;
	private int						AD_User_ID;

	private boolean					isDefaultTree					= false;
	private boolean					isUserUseOwnTree				= false;

	public DPUserFavorites()
	{
		super();

		AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());

		user = (MUser) MTable.get(Env.getCtx(), MUser.Table_ID).getPO(AD_User_ID, null);

		panel = new Panel();
		panel.setClass("fav-tree-panel");
		this.appendChild(panel);

		chkExpand = new Checkbox();
		chkExpand.setClass("fav-chkbox");
		chkExpand.setText(Msg.getMsg(Env.getCtx(), "ExpandTree"));
		chkExpand.addEventListener(Events.ON_CHECK, this);
		chkExpand.setTooltiptext("Expand/Collapse Tree");

		addAsRoot = new Checkbox();
		addAsRoot.setClass("fav-chkbox");
		addAsRoot.setText(Msg.getMsg(Env.getCtx(), "AddAsRoot"));
		addAsRoot.setTooltiptext("If checked then new node added as on root node.");

		textbox = new Textbox();
		textbox.setClass("fav-folder-textbox");
		textbox.setPlaceholder(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		textbox.setTooltiptext("Specify new node name");
		textbox.addEventListener(Events.ON_OK, this);

		btnAdd = new Button();
		btnAdd.setClass("fav-tree-btn");
		btnAdd.setTooltiptext(Msg.getMsg(Env.getCtx(), "AddFolderFavTree"));
		btnAdd.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnAdd.setIconSclass("z-icon-TreeFavNodeAdd");
		else
			btnAdd.setImage(ThemeManager.getThemeResource("images/FolderAdd16.png"));

		btnCopyTree = new Button();
		btnCopyTree.setClass("fav-tree-btn");
		btnCopyTree.setTooltiptext(Msg.getMsg(Env.getCtx(), "CopyTree"));
		btnCopyTree.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnCopyTree.setIconSclass("z-icon-CopyTree");
		else
			btnCopyTree.setImage(ThemeManager.getThemeResource("images/CopyTree16.png"));

		btnShowMyTree = new Button();
		btnShowMyTree.setClass("fav-tree-btn");
		btnShowMyTree.setTooltiptext(Msg.getMsg(Env.getCtx(), "ShowMyTree"));
		btnShowMyTree.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnShowMyTree.setIconSclass("z-icon-ChangeTree");
		else
			btnShowMyTree.setImage(ThemeManager.getThemeResource("images/ShowMyTree16.png"));

		btnShowDefaultTree = new Button();
		btnShowDefaultTree.setClass("fav-tree-btn");
		btnShowDefaultTree.setTooltiptext(Msg.getMsg(Env.getCtx(), "ShowDefaultTree"));
		btnShowDefaultTree.addEventListener(Events.ON_CLICK, this);
		if (ThemeManager.isUseFontIconForImage())
			btnShowDefaultTree.setIconSclass("z-icon-ChangeTree");
		else
			btnShowDefaultTree.setImage(ThemeManager.getThemeResource("images/ShowDefaultTree16.png"));

		favToolbarRow1 = new Div();
		favToolbarRow1.setClass("fav-toolbar-div favToolbarRow1");
		favToolbarRow1.appendChild(addAsRoot);
		favToolbarRow1.appendChild(textbox);
		favToolbarRow1.appendChild(btnAdd);

		favToolbarRow2 = new Div();
		favToolbarRow2.setClass("fav-toolbar-div favToolbarRow2");
		favToolbarRow2.appendChild(chkExpand);
		favToolbarRow2.appendChild(btnCopyTree);
		favToolbarRow2.appendChild(btnShowMyTree);
		favToolbarRow2.appendChild(btnShowDefaultTree);

		Div favToolbar = new Div();
		favToolbar.setClass("fav-toolbar");
		favToolbar.appendChild(favToolbarRow1);
		favToolbar.appendChild(favToolbarRow2);
		this.appendChild(favToolbar);

		//
		updateUI();
	} // DPUserFavorites

	private Box createFavoritePanel()
	{
		int myTreeFavoriteID = 0;
		if (!isDefaultTree)
		{
			myTreeFavoriteID = MTreeFavorite.getTreeID(AD_Client_ID, AD_Role_ID, AD_User_ID);
			if (myTreeFavoriteID > 0)
			{
				int nodeCount = DB.getSQLValue(null, SQL_COUNT_TREE_FAVORITE_NODE, myTreeFavoriteID);
				if (nodeCount <= 0 && !isUserUseOwnTree)
					myTreeFavoriteID = 0;
			}
		}

		int defaultTreeFavoriteID = MTreeFavorite.getDefaultUserFavTreeID(AD_Client_ID, AD_Role_ID);
		if (myTreeFavoriteID <= 0)
		{
			if (defaultTreeFavoriteID > 0)
			{
				m_AD_FavTree_ID = defaultTreeFavoriteID;
				isDefaultTree = true;
				isUserUseOwnTree = false;
			}
			else
			{
				myTreeFavoriteID = MTreeFavorite.getTreeID(AD_Client_ID, AD_Role_ID, AD_User_ID);
				if (myTreeFavoriteID <= 0)
				{
					MTreeFavorite treeFav = createTreeFavorite(AD_User_ID);
					myTreeFavoriteID = treeFav.getAD_Tree_Favorite_ID();
				}
				m_AD_FavTree_ID = myTreeFavoriteID;
				isDefaultTree = false;
				isUserUseOwnTree = true;
			}
		}
		else
		{
			m_AD_FavTree_ID = myTreeFavoriteID;
		}

		int dtNodeCount = 1;
		if (isDefaultTree)
			dtNodeCount = DB.getSQLValue(null, SQL_COUNT_TREE_FAVORITE_NODE, defaultTreeFavoriteID);

		boolean isDisabledShowMyTree = m_AD_FavTree_ID == myTreeFavoriteID;
		boolean isDisabledShowDefaultTree = m_AD_FavTree_ID == defaultTreeFavoriteID;
		boolean isDisabledCopyTree = isDisabledShowMyTree || dtNodeCount <= 0;

		btnCopyTree.setDisabled(isDisabledCopyTree);
		btnShowMyTree.setDisabled(isDisabledShowMyTree);
		btnShowDefaultTree.setDisabled(isDisabledShowDefaultTree);

		btnCopyTree.setVisible(!isDisabledCopyTree);
		btnShowMyTree.setVisible(!isDisabledShowMyTree);
		btnShowDefaultTree.setVisible(!isDisabledShowDefaultTree);

		favToolbarRow1.setVisible(isDefaultTree ? user.isAllowAccessDefaultFavTree() : true);

		tree = new Tree();
		tree.setMultiple(false);
		tree.setSizedByContent(false);
		tree.setClass("menu-tree");
		ZKUpdateUtil.setWidth(tree, "100%");
		tree.setStyle("border: none");

		Box box = new Vbox();
		ZKUpdateUtil.setVflex(box, "1");
		ZKUpdateUtil.setHflex(box, "1");
		box.appendChild(tree);

		//
		initTreeModel();

		return box;
	} // createFavoritePanel

	/**
	 * Initiate tree model structure
	 */
	public void initTreeModel()
	{
		treeModel = FavoriteSimpleTreeModel.initADTree(tree, m_AD_FavTree_ID, 0, !isDefaultTree || user.isAllowAccessDefaultFavTree(), null);
	} // initTreeModel

	/**
	 * Event Like open Menu Window, Expand/Collapse Node, Add node into Tree
	 */
	public void onEvent(Event event)
	{
		String eventName = event.getName();
		if (eventName.equals(Events.ON_CLICK) && event.getTarget() instanceof Button)
		{
			if (event.getTarget() == btnAdd)
			{
				addNodeBtnPressed();
			}
			else if (event.getTarget() == btnCopyTree)
			{
				MTreeFavorite.cloneTreeStructure(m_AD_FavTree_ID, AD_Client_ID, AD_Role_ID, AD_User_ID, null);
				isDefaultTree = false;
				//
				updateUI();
			}
			else if (event.getTarget() == btnShowMyTree)
			{
				if (MTreeFavorite.getTreeID(AD_Client_ID, AD_Role_ID, AD_User_ID) <= 0)
					createTreeFavorite(AD_User_ID);

				isDefaultTree = false;
				isUserUseOwnTree = true;
				//
				updateUI();
			}
			else if (event.getTarget() == btnShowDefaultTree)
			{
				if (MTreeFavorite.getDefaultUserFavTreeID(AD_Client_ID, AD_Role_ID) <= 0)
					createTreeFavorite(0);

				isDefaultTree = true;
				//
				updateUI();
			}
		}
		else if (eventName.equals(Events.ON_OK))
		{
			addNodeBtnPressed();
		}
		else if (eventName.equals(Events.ON_CHECK) && event.getTarget() == chkExpand)
		{
			expandOnCheck();
		}
	} // onEvent

	/**
	 * When Button or Enter Key Pressed Add Node Into Tree.
	 */
	private void addNodeBtnPressed()
	{
		String nodeName = textbox.getText().toString();
		if (Util.isEmpty(nodeName))
			textbox.setFocus(true);
		else
			insertNode(nodeName);
	} // addNodeBtnPressed

	/**
	 * Insert Folder as Node to Tree.
	 * 
	 * @param nodeName
	 */
	private void insertNode(String nodeName)
	{
		MTreeFavoriteNode tfNode = new MTreeFavoriteNode(Env.getCtx(), 0, null);
		tfNode.set_ValueOfColumn(I_AD_Tree_Favorite.COLUMNNAME_AD_Client_ID, AD_Client_ID);
		tfNode.setAD_Org_ID(AD_Org_ID);
		tfNode.setAD_Tree_Favorite_ID(m_AD_FavTree_ID);
		tfNode.setIsSummary(true);
		tfNode.setName(nodeName);
		if (addAsRoot.isChecked())
			tfNode.setParent_ID(0);
		else
			tfNode.setParent_ID(treeModel.getSelectedFolderID());
		tfNode.setSeqNo(0);

		if (!tfNode.save())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NodeNotCreate"));
		else
		{
			MTreeNode mtnNew = new MTreeNode(tfNode.getAD_Tree_Favorite_Node_ID(), tfNode.getSeqNo(), tfNode.getName(),
							"", tfNode.getParent_ID(), tfNode.isSummary(), tfNode.getAD_Menu_ID(), null, false);

			DefaultTreeNode<Object> newNode = new DefaultTreeNode<Object>(mtnNew);
			DefaultTreeNode<Object> parentNode = treeModel.find(null, mtnNew.getParent_ID());

			try
			{
				treeModel.addNode(parentNode, newNode, 0);
				int[] path = treeModel.getPath(newNode);
				Treeitem ti = tree.renderItemByPath(path);
				tree.setSelectedItem(ti);
				Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));
				treeModel.setSelectedFolderID(mtnNew.getNode_ID());
				textbox.setText("");
			}
			catch (Exception e)
			{
				FDialog.warn(0, Msg.getMsg(Env.getCtx(), "SelectMenuItem"));
			}
		}
	} // insertNode

	/**
	 * Expand All Node
	 */
	public void expandAll()
	{
		if (!chkExpand.isChecked())
			chkExpand.setChecked(true);
		if (!tree.getChildren().isEmpty())
			TreeUtils.expandAll(tree);
	} // expandAll

	/**
	 * Collapse All Node
	 */
	public void collapseAll()
	{
		if (chkExpand.isChecked())
			chkExpand.setChecked(false);
		if (!tree.getChildren().isEmpty())
			TreeUtils.collapseAll(tree);
	} // collapseAll

	/**
	 * On check to Expand/Collapse Tree
	 */
	private void expandOnCheck()
	{
		if (chkExpand.isChecked())
			expandAll();
		else
			collapseAll();
	} // expandOnCheck

	/**
	 * Reload UI
	 */
	public void updateUI()
	{
		treeModel = null;
		tree = null;

		if (favContent != null)
		{
			favContent.removeEventListener(Events.ON_DROP, this);
			favContent.detach();
			panel.removeChild(favContent);
		}

		//
		favContent = new Panelchildren();
		favContent.appendChild(createFavoritePanel());
		favContent.setDroppable(DPFavourites.FAVOURITE_DROPPABLE);
		favContent.addEventListener(Events.ON_DROP, this);
		panel.appendChild(favContent);
	} // updateUI

	/**
	 * Create Tree favorite
	 * 
	 * @param  userID - AD_User_ID
	 * @return        {@link MTreeFavorite}
	 */
	private MTreeFavorite createTreeFavorite(int userID)
	{
		MTreeFavorite mtFav = (MTreeFavorite) MTable.get(Env.getCtx(), MTreeFavorite.Table_ID).getPO(0, null);
		mtFav.set_ValueOfColumn(MTreeFavorite.COLUMNNAME_AD_Client_ID, AD_Client_ID);
		mtFav.setAD_Org_ID(AD_Org_ID);
		mtFav.setAD_Role_ID(AD_Role_ID);
		mtFav.set_ValueNoCheck(MTreeFavorite.COLUMNNAME_AD_User_ID, Integer.valueOf(userID));
		if (!mtFav.save())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FavTreeNotCreate"));
		return mtFav;
	} // createTreeFavorite

}
