/******************************************************************************
  Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved.                
  This program is free software; you can redistribute it and/or modify it    
  under the terms version 2 of the GNU General Public License as published   
  by the Free Software Foundation. This program is distributed in the hope   
  that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.component;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.dashboard.DPFavourites;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.I_AD_Tree_Favorite_Node;
import org.compiere.model.MMenu;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;

/**
 * Register listener for Drag&Drop item, Context Menu, Delete Item, User Default
 * Collapse/Expand Operation
 * 
 * @author Logilite Technologies
 * @since June 20, 2017
 */
public class ADTreeFavoriteOnDropListener implements EventListener<Event>
{
	private static final CLogger	log							= CLogger
			.getCLogger(ADTreeFavoriteOnDropListener.class);

	public static final String		SQL_UPDATE_NODE_POSITION	= "UPDATE AD_Tree_Favorite_Node SET Parent_ID=?, SeqNo=?, Updated=SysDate WHERE AD_Tree_Favorite_Node_ID=?";

	public static final String		MENU_ITEM_DELETE			= "DELETE";
	public static final String		MENU_ITEM_EXPAND			= "StartWithExpanded";
	public static final String		MENU_ITEM_COLLAPSE			= "StartWithCollapsed";
	public static final String		NODE_MOVEINTO				= "MoveInto";
	public static final String		NODE_INSERTAFTER			= "InsertAfter";

	private int						AD_Role_ID					= Env.getAD_Role_ID(Env.getCtx());
	private int						AD_Client_ID				= Env.getAD_Client_ID(Env.getCtx());
	private int						AD_Org_ID					= Env.getContextAsInt(Env.getCtx(), "#AD_Org_ID");
	private int						AD_User_ID					= Env.getContextAsInt(Env.getCtx(), "#AD_User_ID");

	private FavoriteSimpleTreeModel	treeModel;
	private Tree					tree;
	private int						windowNo;
	private int						mTreeFavID;

	public ADTreeFavoriteOnDropListener(Tree tree, FavoriteSimpleTreeModel treeModel, int windowNo)
	{
		this.tree = tree;
		this.treeModel = treeModel;
		this.windowNo = windowNo;
		mTreeFavID = MTreeFavorite.getTreeID(AD_Client_ID, AD_Role_ID, AD_User_ID);
	}

	/**
	 * Events For Right Click And Menu Item Dragged Source to Target Folder
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void onEvent(Event event) throws Exception
	{
		if (Events.ON_RIGHT_CLICK.equals(event.getName()))
		{
			MouseEvent me = (MouseEvent) event;
			Treeitem target = (Treeitem) ((Treerow) me.getTarget()).getParent();
			DefaultTreeNode<Object> toNode = (DefaultTreeNode<Object>) target.getValue();
			menuItemList(toNode);
		}
		else if (event instanceof DropEvent)
		{
			DropEvent de = (DropEvent) event;
			log.fine("Source=" + de.getDragged() + " Target=" + de.getTarget());

			if (de.getDragged() != de.getTarget())
			{
				Treeitem src;
				Treeitem target;

				if (de.getDragged() instanceof Treerow && de.getTarget() instanceof Treerow)
				{
					src = (Treeitem) ((Treerow) de.getDragged()).getParent();
					target = (Treeitem) ((Treerow) de.getTarget()).getParent();
				}
				else
				{
					FDialog.error(0, "DragItemMenu");
					return;
				}

				Treerow tr = (Treerow) de.getDragged();
				String strDraggable = tr.getDraggable();

				/*
				 * Here Condition True when Node Moving Internally, False when
				 * Node Drag from Menu Bar to User Favorite Panel dashboard...
				 * For more reference @see on AbstractMenuPanel.generateMenu(),
				 * set Draggable = 'favourite'
				 */
				if (!strDraggable.equals(DPFavourites.FAVOURITE_DROPPABLE))
				{
					DefaultTreeNode<?> stn_src = (DefaultTreeNode<?>) src.getValue();
					DefaultTreeNode<?> stn_target = (DefaultTreeNode<?>) target.getValue();
					MTreeNode nd_src = (MTreeNode) stn_src.getData();
					MTreeNode nd_target = (MTreeNode) stn_target.getData();

					/*
					 * True When Source is a Menu otherwise a folder.
					 */
					if (!nd_src.isSummary())
					{
						int menuID = nd_src.getMenu_ID();
						boolean menuAvailable;

						if (!nd_target.isSummary())
						{
							menuAvailable = MTreeFavoriteNode.isMenuExists(menuID, nd_target.getParent_ID(),
									mTreeFavID);
							if (nd_src.getParent_ID() == nd_target.getParent_ID())
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(),
										(DefaultTreeNode<Object>) target.getValue());
							}
							else if (menuAvailable)
							{
								showWarningDialog();
							}
							else
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(),
										(DefaultTreeNode<Object>) target.getValue());
							}
						}
						else
						{
							menuAvailable = MTreeFavoriteNode.isMenuExists(menuID, nd_target.getNode_ID(), mTreeFavID);
							if (menuAvailable)
							{
								showWarningDialog();
							}
							else
							{
								moveNode((DefaultTreeNode<Object>) src.getValue(),
										(DefaultTreeNode<Object>) target.getValue());
							}
						}
					}
					else
					{
						moveNode((DefaultTreeNode<Object>) src.getValue(), (DefaultTreeNode<Object>) target.getValue());
					}
				}
				else
				{
					int mID = Integer.valueOf((src.getValue().toString()));
					DefaultTreeNode<Object> stn_target = (DefaultTreeNode<Object>) target.getValue();
					MTreeNode nd = (MTreeNode) stn_target.getData();

					/*
					 * True when Target is Folder, Otherwise its Menu item.
					 */
					if (nd.isSummary())
					{
						if (MTreeFavoriteNode.isMenuExists(mID, nd.getNode_ID(), mTreeFavID))
						{
							showWarningDialog();
						}
						else
						{
							insertNodeMenu(mID, nd.getNode_ID(), stn_target);
						}
					}
					else
					{
						DefaultTreeNode<Object> dtn_target_parent = treeModel.getParent(stn_target);
						int pID = ((MTreeNode) dtn_target_parent.getData()).getNode_ID();

						if (MTreeFavoriteNode.isMenuExists(mID, pID, mTreeFavID))
						{
							showWarningDialog();
						}
						else
						{
							insertNodeMenu(mID, pID, dtn_target_parent);
						}
					}
				}
			}
		}
	}

	/**
	 * Show Dialog for Warning
	 */
	private void showWarningDialog()
	{
		FDialog.warn(0, Msg.getMsg(Env.getCtx(), "AlreadyExists"));
	}

	/**
	 * When Right click on Item show Delete Menu popup for Delete a node.
	 * 
	 * @param toNode
	 */
	private void menuItemList(DefaultTreeNode<Object> toNode)
	{
		int path[] = treeModel.getPath(toNode);
		Treeitem toItem = tree.renderItemByPath(path);

		tree.setSelectedItem(toItem);
		Events.sendEvent(tree, new Event(Events.ON_RIGHT_CLICK, tree));

		Menupopup popup = new Menupopup();
		Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), "delete"),
				"/theme/" + ThemeManager.getTheme() + "/images/Delete24.png");
		menuItem.setValue(MENU_ITEM_DELETE);
		menuItem.setParent(popup);
		menuItem.addEventListener(Events.ON_CLICK, new DeleteListener(toNode));

		MTreeNode mtn = (MTreeNode) toNode.getData();
		if (mtn.isSummary())
		{
			MTreeFavoriteNode favNode = new MTreeFavoriteNode(Env.getCtx(), mtn.getNode_ID(), null);
			if (favNode.isCollapsible())
			{
				menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), MENU_ITEM_EXPAND),
						"/theme/" + ThemeManager.getTheme() + "/images/expand-header.png");
				menuItem.setValue(MENU_ITEM_EXPAND);
			}
			else
			{
				menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), MENU_ITEM_COLLAPSE),
						"/theme/" + ThemeManager.getTheme() + "/images/collapse-header.png");
				menuItem.setValue(MENU_ITEM_COLLAPSE);
			}
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, new CollExpdListener(favNode));
		}

		popup.setPage(tree.getPage());
		popup.open(toItem.getTreerow(), "after_pointer");
	}

	/**
	 * Listener for Delete Node on Right click on MouseEvent
	 */
	class DeleteListener implements EventListener<Event>
	{
		private DefaultTreeNode<Object> toNode;

		DeleteListener(DefaultTreeNode<Object> toNode)
		{
			this.toNode = toNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (MENU_ITEM_DELETE.equals(menuItem.getValue()))
				{
					deleteNodeItem(toNode);
				}
			}
		}

		/**
		 * Deleting a Node and its hierarchy
		 * 
		 * @param toNode
		 */
		private void deleteNodeItem(DefaultTreeNode<Object> toNode)
		{
			int nodeID = ((MTreeNode) toNode.getData()).getNode_ID();
			MTreeFavoriteNode mtfNode = new MTreeFavoriteNode(Env.getCtx(), nodeID, null);
			if (mtfNode.delete(true))
			{
				treeModel.removeNode(toNode);
			}
		}
	}

	/**
	 * Listener for set default start Collapse/Expand Node by Right click on
	 * MouseEvent.
	 */
	class CollExpdListener implements EventListener<Event>
	{
		private MTreeFavoriteNode favNode;

		CollExpdListener(MTreeFavoriteNode favNode)
		{
			this.favNode = favNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (MENU_ITEM_EXPAND.equals(menuItem.getValue()))
				{
					favNode.setIsCollapsible(false);
				}
				else if (MENU_ITEM_COLLAPSE.equals(menuItem.getValue()))
				{
					favNode.setIsCollapsible(true);
				}
				favNode.saveEx();
			}
		} // onEvent

	} // ColExpListener

	/**
	 * Insert Node into Tree it's contains only Menu type node, Dragged from
	 * Menu Tab.
	 * 
	 * @param menuID
	 * @param parentNodeID
	 * @param stn
	 */
	public void insertNodeMenu(int menuID, int parentNodeID, DefaultTreeNode<Object> stn)
	{
		MTreeFavoriteNode mtFavNode = new MTreeFavoriteNode(Env.getCtx(), 0, null);
		mtFavNode.set_ValueOfColumn(I_AD_Tree_Favorite_Node.COLUMNNAME_AD_Client_ID, AD_Client_ID);
		mtFavNode.setAD_Org_ID(AD_Org_ID);
		mtFavNode.setAD_Tree_Favorite_ID(mTreeFavID);
		mtFavNode.setSeqNo(0);
		mtFavNode.setParent_ID(parentNodeID);
		mtFavNode.setIsSummary(false);
		mtFavNode.setAD_Menu_ID(menuID);
		if (!mtFavNode.save())
		{
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NodeNotCreate"));
		}
		MMenu menu = new MMenu(Env.getCtx(), menuID, null);
		MTreeNode mNode = new MTreeNode(mtFavNode.getAD_Tree_Favorite_Node_ID(), mtFavNode.getSeqNo(), menu.get_Translation(MMenu.COLUMNNAME_Name),
				menu.get_Translation(MMenu.COLUMNNAME_Name), mtFavNode.getParent_ID(), mtFavNode.isSummary(), mtFavNode.getAD_Menu_ID(),
				menu.getAction(), false);

		DefaultTreeNode<Object> node = new DefaultTreeNode<Object>(mNode);
		int index = 0;
		if (mNode.isSummary())
			index = stn.getChildren().indexOf(node) + 1;

		treeModel.addNode(stn, node, index);
		int[] path = treeModel.getPath(node);
		Treeitem ti = tree.renderItemByPath(path);
		tree.setSelectedItem(ti);
		Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));
	}

	/**
	 * Internally movement of Tree node
	 * 
	 * @param movingNode
	 * @param toNode
	 */
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode)
	{
		log.info(movingNode.toString() + " to " + toNode.toString());

		if (movingNode == toNode)
			return;

		MTreeNode toMNode = (MTreeNode) toNode.getData();
		if (!toMNode.isSummary())
		{
			// drop on a child node
			moveNode(movingNode, toNode, false);
		}
		else
		{
			// drop on a summary node
			// prompt user to select insert after or drop into the summary node
			int path[] = treeModel.getPath(toNode);
			Treeitem toItem = tree.renderItemByPath(path);

			tree.setSelectedItem(toItem);
			Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));

			MenuListener listener = new MenuListener(movingNode, toNode);

			Menupopup popup = new Menupopup();
			Menuitem menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), NODE_INSERTAFTER));
			menuItem.setValue(NODE_INSERTAFTER);
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);

			menuItem = new Menuitem(Msg.getMsg(Env.getCtx(), NODE_MOVEINTO));
			menuItem.setValue(NODE_MOVEINTO);
			menuItem.setParent(popup);
			menuItem.addEventListener(Events.ON_CLICK, listener);
			popup.setPage(tree.getPage());
			popup.open(toItem.getTreerow(), "overlap");
		}
	} // moveNode

	/**
	 * It's specify the Moving node where to inserted... Like Insert After or
	 * Move Into.
	 * 
	 * @param movingNode
	 * @param toNode
	 * @param moveInto
	 */
	private void moveNode(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode, boolean moveInto)
	{
		DefaultTreeNode<Object> newParent;
		int index;

		// remove
		DefaultTreeNode<Object> oldParent = treeModel.getParent(movingNode);
		treeModel.removeNode(movingNode);

		// get new index
		if (!moveInto)
		{
			newParent = treeModel.getParent(toNode);
			// the next node
			index = newParent.getChildren().indexOf(toNode) + 1;
		}
		else
		{
			// drop on a summary node
			newParent = toNode;
			index = 0; // the first node
		}

		// insert
		treeModel.addNode(newParent, movingNode, index);

		int path[] = treeModel.getPath(movingNode);
		if (TreeUtils.isOnInitRenderPosted(tree) || tree.getTreechildren() == null)
		{
			tree.onInitRender();
		}
		Treeitem movingItem = tree.renderItemByPath(path);
		tree.setSelectedItem(movingItem);
		Events.sendEvent(tree, new Event(Events.ON_SELECT, tree));
		DefaultTreeNode<?> dtNode = movingItem.getValue();
		treeModel.setSelectedFolderID(((MTreeNode) dtNode.getData()).getNode_ID());

		// *** Save changes to disk
		Trx trx = Trx.get(Trx.createTrxName("ADTreeFavoriteNode"), true);
		try
		{
			MTreeNode oldMParent = (MTreeNode) oldParent.getData();
			for (int i = 0; i < oldParent.getChildCount(); i++)
			{
				DefaultTreeNode<Object> nd = (DefaultTreeNode<Object>) oldParent.getChildAt(i);
				MTreeNode md = (MTreeNode) nd.getData();

				Object objParam[] = new Object[] { (oldMParent.getNode_ID() == 0 ? null : oldMParent.getNode_ID()), i,
						md.getNode_ID() };
				DB.executeUpdateEx(SQL_UPDATE_NODE_POSITION, objParam, trx.getTrxName());

				md.setParent_ID(oldMParent.getNode_ID());
			}
			if (oldParent != newParent)
			{
				MTreeNode newMParent = (MTreeNode) newParent.getData();
				for (int i = 0; i < newParent.getChildCount(); i++)
				{
					DefaultTreeNode<Object> nd = (DefaultTreeNode<Object>) newParent.getChildAt(i);
					MTreeNode md = (MTreeNode) nd.getData();

					Object objParam[] = new Object[] { (newMParent.getNode_ID() == 0 ? null : newMParent.getNode_ID()),
							i, md.getNode_ID() };
					DB.executeUpdateEx(SQL_UPDATE_NODE_POSITION, objParam, trx.getTrxName());

					md.setParent_ID(newMParent.getNode_ID());
				}
			}
			trx.commit(true);
		}
		catch (Exception e)
		{
			trx.rollback();
			FDialog.error(windowNo, tree, "Tree Update Error", e.getLocalizedMessage());
		}
		finally
		{
			trx.close();
			trx = null;
		}
	}

	/**
	 * Listener for Movement of Node
	 */
	class MenuListener implements EventListener<Event>
	{
		private DefaultTreeNode<Object>	movingNode;
		private DefaultTreeNode<Object>	toNode;

		MenuListener(DefaultTreeNode<Object> movingNode, DefaultTreeNode<Object> toNode)
		{
			this.movingNode = movingNode;
			this.toNode = toNode;
		}

		public void onEvent(Event event) throws Exception
		{
			if (Events.ON_CLICK.equals(event.getName()) && event.getTarget() instanceof Menuitem)
			{
				Menuitem menuItem = (Menuitem) event.getTarget();
				if (NODE_INSERTAFTER.equals(menuItem.getValue()))
				{
					moveNode(movingNode, toNode, false);
				}
				else if (NODE_MOVEINTO.equals(menuItem.getValue()))
				{
					moveNode(movingNode, toNode, true);
				}
			}
		}
	}

}