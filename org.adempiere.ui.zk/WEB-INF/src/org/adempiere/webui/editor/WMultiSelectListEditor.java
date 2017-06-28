/******************************************************************************
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.editor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.adempiere.webui.component.MultiSelectBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zul.Checkbox;

/**
 * Multiple Selection items from the List
 * 
 * @author Logilite Technologies
 * @since June 28, 2017
 */
public class WMultiSelectListEditor extends WEditor implements EventListener<Event>, ContextMenuListener
{

	private static final String[]	LISTENER_EVENTS	= { Events.ON_CLICK, Events.ON_OK };

	private Lookup					lookup;
	private Object					oldValue;

	public WMultiSelectListEditor(GridField gridField)
	{
		super(new MultiSelectBox(), gridField);

		lookup = gridField.getLookup();
		init();
	}

	/**
	 * ZK Initialization
	 */
	private void init()
	{
		getComponent().getPopupComponent().addEventListener(Events.ON_OPEN, this);
		getComponent().getTextbox().addEventListener(Events.ON_CLICK, this);

		if (lookup != null)
		{
			lookup.setMandatory(true);

			// no need to refresh read only lookup
			if (isReadWrite())
				lookup.refresh();
			refreshList();
		}

		popupMenu = new WEditorPopupMenu(false, true, isShowPreference());
		addChangeLogMenu(popupMenu);
	} // init

	@Override
	public MultiSelectBox getComponent()
	{
		return (MultiSelectBox) super.getComponent();
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (event.getName().equals(Events.ON_CLICK))
		{
			if (event.getTarget() == getComponent().getTextbox() && isReadWrite())
				getComponent().getPopupComponent().open(getComponent().getTextbox(), "after_start");
		}
		else if (event.getName().equals(Events.ON_OPEN) && event.getTarget() == getComponent().getPopupComponent())
		{
			OpenEvent oe = (OpenEvent) event;
			if (!oe.isOpen())
			{
				String[] nValue = (String[]) getValue();
				if (!Arrays.equals(getSortedSelectedItems(false), nValue))
				{
					ValueChangeEvent changeValue = new ValueChangeEvent(this, getColumnName(), oldValue, nValue);
					super.fireValueChange(changeValue);
					oldValue = nValue;
				}
			}
		}
	} // onEvent

	@Override
	public void setReadWrite(boolean readWrite)
	{
		getComponent().setEditable(readWrite);
	}

	@Override
	public boolean isReadWrite()
	{
		return getComponent().isEnabled();
	}

	@Override
	public void setValue(Object newValue)
	{
		if (newValue == null || (newValue instanceof String[] && ((String[]) newValue).length == 0))
		{
			for (Checkbox cbx : getComponent().getCheckboxList())
			{
				if (cbx.isChecked())
					cbx.setChecked(false);
			}
			oldValue = null;
			setCompTextboxValue(Msg.getMsg(Env.getCtx(), "PleaseSelect"));

			return;
		}

		String values[] = (String[]) newValue;
		if (Arrays.equals(getSortedSelectedItems(false), values))
		{
			oldValue = values;
			return;
		}

		oldValue = values;
		String txtBoxValue = "";
		for (Checkbox cbx : getComponent().getCheckboxList())
		{
			for (String intval : values)
			{
				if (intval.equals(cbx.getAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT).toString()))
				{
					cbx.setChecked(true);
					txtBoxValue += cbx.getLabel() + "; ";
					break;
				}
				cbx.setChecked(false);
			}
		}
		setCompTextboxValue(txtBoxValue);
	} // setValue

	@Override
	public Object getValue()
	{
		return getSortedSelectedItems(true);
	}

	@Override
	public String getDisplay()
	{
		return getComponent().getTextbox().getText();
	}

	@Override
	public String[] getEvents()
	{
		return LISTENER_EVENTS;
	}

	/**
	 * The sorted array items for new/old value
	 * 
	 * @param isNewValue - If true then return to new value list else old value
	 *            list
	 * @return return the sorted array items
	 */
	private String[] getSortedSelectedItems(boolean isNewValue)
	{
		List<String> items = new ArrayList<String>();
		if (isNewValue)
		{
			for (Checkbox cbx : getComponent().getCheckboxList())
				if (cbx.isChecked())
					items.add(cbx.getAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT).toString());
		}
		else
		{
			if (oldValue != null && oldValue instanceof String[])
			{
				String values[] = (String[]) oldValue;
				for (String value : values)
				{
					items.add(value);
				}
			}
		}

		Collections.sort(items);
		return items.toArray(new String[items.size()]);
	} // getSortedSelectedItems

	/**
	 * Re/Generate selection list items
	 */
	private void refreshList()
	{
		if (isReadWrite() && lookup != null)
		{
			setCompTextboxValue(Msg.getMsg(Env.getCtx(), "PleaseSelect"));

			// Clear the component
			for (Checkbox cbx : getComponent().getCheckboxList())
			{
				cbx.detach();
			}
			getComponent().getCheckboxList().clear();

			// fill the component
			for (int i = 0; i < lookup.getSize(); i++)
			{
				Object obj = lookup.getElementAt(i);
				if (obj instanceof ValueNamePair)
				{
					ValueNamePair vnp = (ValueNamePair) obj;
					Checkbox cbx = new Checkbox(vnp.getName());
					cbx.setAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT, vnp.getValue());
					getComponent().getCheckboxList().add(cbx);
					getComponent().getVBox().appendChild(cbx);
				}
			}
		}
	} // refreshList

	@Override
	public void onMenu(ContextMenuEvent evt)
	{

	}

	private void setCompTextboxValue(String textValue)
	{
		getComponent().getTextbox().setValue(textValue.trim());
	}
}
