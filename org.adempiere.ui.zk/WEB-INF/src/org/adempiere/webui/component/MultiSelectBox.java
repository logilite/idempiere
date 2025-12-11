/******************************************************************************
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.component;

import java.util.ArrayList;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.editor.WMultiSelectEditor;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Vbox;

/**
 * Layout for handle multiple selection items ( IDEMPIERE-3413 )
 * 
 * @author Logilite Technologies
 * @since June 28, 2017
 */
public class MultiSelectBox extends Div
{

	/**
	 * 
	 */
	private static final long	serialVersionUID			= -632973531627268781L;

	public static final String	ATTRIBUTE_MULTI_SELECT		= "ATTRIBUTE_MULTI_SELECT";
	public static final String	ATTRIBUTE_ACTION_SELECT_ALL	= "ATTRIB_ACTION_SELECT_ALL";

	public WMultiSelectEditor	editor;
	protected DesktopCleanup	listener					= null;

	private Button				btnSelectAll;
	private Textbox				textbox;
	private Popup				popup;
	private Vbox				vbox;
	private boolean				editable;

	private ArrayList<Checkbox>	cbxList						= new ArrayList<Checkbox>();

	public MultiSelectBox()
	{
		super();
		ZKUpdateUtil.setWidth(this, "100%");
		init();
	}

	private void init()
	{
		LayoutUtils.addSclass(".multi-select-box", this);

		popup = new Popup();
		LayoutUtils.addSclass("multi-select-popup", popup);
		ZKUpdateUtil.setVflex(popup, "1");
		appendChild(popup);

		vbox = new Vbox();
		ZKUpdateUtil.setHflex(vbox, "1");
		ZKUpdateUtil.setWidth(vbox, "100%");
		LayoutUtils.addSclass("multi-select-vbox", vbox);

		btnSelectAll = new Button(Msg.getMsg(Env.getCtx(), "select.all"));
		btnSelectAll.setAttribute(ATTRIBUTE_ACTION_SELECT_ALL, "Y");
		LayoutUtils.addSclass("multi-select-all-btn", btnSelectAll);

		//
		popup.appendChild(btnSelectAll);
		popup.appendChild(vbox);

		textbox = new Textbox("") {

			/**
			 * 
			 */
			private static final long serialVersionUID = 1567895599198729743L;

			public void setValue(String value) throws WrongValueException
			{
				super.setValue(value);
			}
		};

		if (isEnabled())
			textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");

		textbox.setReadonly(true);
		ZKUpdateUtil.setHflex(textbox, "1");
		LayoutUtils.addSclass("multi-select-textbox", textbox);
		appendChild(textbox);
	} // init

	public Popup getPopupComponent()
	{
		return popup;
	}

	public Textbox getTextbox()
	{
		return textbox;
	}

	public ArrayList<Checkbox> getCheckboxList()
	{
		return cbxList;
	}

	public Vbox getVBox()
	{
		return vbox;
	}

	public Button getBtnSelectAll()
	{
		return btnSelectAll;
	}

	public boolean isEnabled()
	{
		return editable;
	}

	public void setEditable(boolean editable)
	{
		this.editable = editable;

		if (textbox != null)
		{
			if (!isEnabled())
			{
				LayoutUtils.removeSclass("multi-select-textbox", textbox);
				LayoutUtils.addSclass("multi-select-textbox-readonly", textbox);
				textbox.setPopup((Popup) null);
			}
			else
			{
				LayoutUtils.addSclass("multi-select-textbox", textbox);
				LayoutUtils.removeSclass("multi-select-textbox-readonly", textbox);
				textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");
			}
		}
	} // setEditable

	@Override
	public void onPageAttached(Page newpage, Page oldpage)
	{
		super.onPageAttached(newpage, oldpage);
		if (editor.tableCacheListener == null)
		{
			editor.createCacheListener();
			if (listener == null)
			{
				listener = new DesktopCleanup() {
					@Override
					public void cleanup(Desktop desktop) throws Exception
					{
						MultiSelectBox.this.cleanup();
					}
				};
				newpage.getDesktop().addListener(listener);
			}
		}
	} // onPageAttached

	@Override
	public void onPageDetached(Page page)
	{
		super.onPageDetached(page);
		if (listener != null && page.getDesktop() != null)
			page.getDesktop().removeListener(listener);
		cleanup();
	} // onPageDetached

	protected void cleanup()
	{
		if (editor.tableCacheListener != null)
		{
			CacheMgt.get().unregister(editor.tableCacheListener);
			editor.tableCacheListener = null;
		}
	} // cleanup
}
