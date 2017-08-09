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
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zul.Checkbox;

/**
 * Multiple Selection items from the List ( IDEMPIERE-3413 )
 * 
 * @author Logilite Technologies
 * @since Aug 07, 2017
 */
public class WMultiSelectEditor extends WEditor implements EventListener<Event>, ContextMenuListener
{

	private static final String[]	LISTENER_EVENTS	= { Events.ON_CLICK, Events.ON_OK };

	private Lookup					lookup;
	private Object					oldValue;

	public WMultiSelectEditor(GridField gridField)
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
				if (DisplayType.MultiSelectTable == lookup.getDisplayType())
				{
					Integer[] nValue = (Integer[]) getValue();
					if (!Arrays.equals(getSortedSelectedItems(false), nValue))
					{
						ValueChangeEvent changeValue = new ValueChangeEvent(this, getColumnName(), oldValue, nValue);
						super.fireValueChange(changeValue);
						oldValue = nValue;
						setComponentTextValue(getPrintableValue(nValue));
					}
				}
				else
				{
					String[] nValue = (String[]) getValue();
					if (!Arrays.equals(getSortedSelectedItems(false), nValue))
					{
						ValueChangeEvent changeValue = new ValueChangeEvent(this, getColumnName(), oldValue, nValue);
						super.fireValueChange(changeValue);
						oldValue = nValue;
						setComponentTextValue(getPrintableValue(nValue));
					}
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
		if (newValue == null
				|| (DisplayType.MultiSelectTable == lookup.getDisplayType() && newValue instanceof Integer[]
						&& ((Integer[]) newValue).length == 0)
				|| (DisplayType.MultiSelectList == lookup.getDisplayType() && newValue instanceof String[]
						&& ((String[]) newValue).length == 0))
		{
			for (Checkbox cbx : getComponent().getCheckboxList())
			{
				if (cbx.isChecked())
					cbx.setChecked(false);
			}
			oldValue = null;
			setComponentTextValue(Msg.getMsg(Env.getCtx(), "PleaseSelect"));

			return;
		}

		if (DisplayType.MultiSelectTable == lookup.getDisplayType())
		{
			Integer values[] = (Integer[]) newValue;
			if (Arrays.equals(getSortedSelectedItems(false), values))
				return;
			oldValue = values;
		}
		else
		{
			String values[] = (String[]) newValue;
			if (Arrays.equals(getSortedSelectedItems(false), values))
				return;
			oldValue = values;
		}

		setComponentTextValue(getPrintableValue(oldValue));
	} // setValue

	public String getPrintableValue(Object values)
	{
		StringBuffer sb = new StringBuffer();

		if (values == null)
			return Msg.getMsg(Env.getCtx(), "PleaseSelect");

		for (Checkbox cbx : getComponent().getCheckboxList())
		{
			String val = cbx.getAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT).toString();
			if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			{
				for (Integer value : (Integer[]) values)
				{
					if (value.compareTo(new Integer(val)) == 0)
					{
						cbx.setChecked(true);
						sb.append(cbx.getLabel()).append("; ");
						break;
					}
					cbx.setChecked(false);
				}
			}
			else
			{
				for (String value : (String[]) values)
				{
					if (value.equals(val))
					{
						cbx.setChecked(true);
						sb.append(cbx.getLabel()).append("; ");
						break;
					}
					cbx.setChecked(false);
				}
			}
		}

		return sb.toString();
	} // getPrintableValue

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
	private Object[] getSortedSelectedItems(boolean isNewValue)
	{
		Object obj[] = null;
		List<String> itemsStr = new ArrayList<String>();
		List<Integer> itemsInt = new ArrayList<Integer>();
		if (isNewValue)
		{
			for (Checkbox cbx : getComponent().getCheckboxList())
			{
				if (cbx.isChecked())
				{
					String val = cbx.getAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT).toString();
					if (DisplayType.MultiSelectTable == lookup.getDisplayType())
						itemsInt.add(new Integer(val));
					else
						itemsStr.add(val);
				}
			}
		}
		else if (oldValue != null)
		{
			if (DisplayType.MultiSelectTable == lookup.getDisplayType() && oldValue instanceof Integer[])
			{
				Integer values[] = (Integer[]) oldValue;
				for (Integer value : values)
					itemsInt.add(value);
			}
			else
			{
				String values[] = (String[]) oldValue;
				for (String value : values)
					itemsStr.add(value);
			}
		}

		if (itemsInt != null && itemsInt.size() > 0)
		{
			Collections.sort(itemsInt);
			obj = itemsInt.toArray(new Integer[itemsInt.size()]);
		}
		else if (itemsStr != null && itemsStr.size() > 0)
		{
			Collections.sort(itemsStr);
			obj = itemsStr.toArray(new String[itemsStr.size()]);
		}
		return obj;
	} // getSortedSelectedItems

	/**
	 * Re-Generate selection list items
	 */
	private void refreshList()
	{
		if (lookup != null)
		{
			setComponentTextValue(Msg.getMsg(Env.getCtx(), "PleaseSelect"));

			// Clear the component
			for (Checkbox cbx : getComponent().getCheckboxList())
			{
				cbx.detach();
			}
			getComponent().getCheckboxList().clear();

			// fill the component
			for (int i = 0; i < lookup.getSize(); i++)
			{
				Checkbox cbx = null;
				Object pair = lookup.getElementAt(i);
				if (pair instanceof KeyNamePair)
				{
					KeyNamePair knp = (KeyNamePair) pair;
					cbx = new Checkbox(knp.getName());
					cbx.setAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT, knp.getKey());
				}
				else if (pair instanceof ValueNamePair)
				{
					ValueNamePair vnp = (ValueNamePair) pair;
					cbx = new Checkbox(vnp.getName());
					cbx.setAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT, vnp.getValue());
				}
				getComponent().getCheckboxList().add(cbx);
				getComponent().getVBox().appendChild(cbx);
			}
		}
	} // refreshList

	@Override
	public void onMenu(ContextMenuEvent evt)
	{

	}

	private void setComponentTextValue(String textValue)
	{
		getComponent().getTextbox().setValue(textValue.trim());
	} // setComponentTextValue
}
