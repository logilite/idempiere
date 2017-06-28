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
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Vbox;

/**
 * Layout for handle multiple selection items
 * 
 * @author Logilite Technologies
 * @since June 28, 2017
 */
public class MultiSelectBox extends Div
{

	/**
	 * 
	 */
	private static final long	serialVersionUID		= -632973531627268781L;

	public static final String	ATTRIBUTE_MULTI_SELECT	= "ATTRIBUTE_MULTI_SELECT";

	private Textbox				textbox;
	private Popup				popup;
	private Vbox				vbox;
	private boolean				editable;

	private ArrayList<Checkbox>	cbxList					= new ArrayList<Checkbox>();

	public MultiSelectBox()
	{
		super();
		this.setWidth("100%");
		init();
	}

	private void init()
	{
		LayoutUtils.addSclass(".z-popup", this);

		popup = new Popup();
		ZkCssHelper.appendStyle(popup, "max-height:350px; min-width:350px; overflow: auto;");
		appendChild(popup);

		vbox = new Vbox();
		vbox.setHflex("1");
		ZkCssHelper.appendStyle(vbox,
				"background-color: #ffffff; border-color:#ffffff; border:none; background:#ffffff;");
		popup.appendChild(vbox);

		textbox = new Textbox("") {

			/**
			 * 
			 */
			private static final long serialVersionUID = 1567895599198729743L;

			public void setValue(String value) throws WrongValueException
			{
				super.setValue(value);
				setTooltiptext(value);
			}
		};

		if (isEnabled())
			textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");

		textbox.setReadonly(true);
		textbox.setHflex("1");
		ZkCssHelper.appendStyle(textbox, "background-color: white");
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
				textbox.setPopup((Popup) null);
			else
				textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");
		}
	} // setEditable

}
