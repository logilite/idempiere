/******************************************************************************
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.editor;

import java.beans.PropertyChangeEvent;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.adwindow.QuickGridTabRowRenderer;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.MultiSelectBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.util.CCache;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
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
public class WMultiSelectEditor extends WEditor implements EventListener<Event>, ContextMenuListener, ListDataListener
{

	private static final String[]	LISTENER_EVENTS	= { Events.ON_CLICK, Events.ON_OK };

	public CCacheListener			tableCacheListener;

	private Lookup					lookup;
	private Object					oldValue;

	public WMultiSelectEditor(GridField gridField)
	{
		super(new MultiSelectBox(), gridField);
		((MultiSelectBox) getComponent()).editor = this;
		((MultiSelectBox) getComponent()).getTextbox().setPlaceholder(gridField.getPlaceholder());
		((MultiSelectBox) getComponent()).getTextbox().setTooltip(gridField.getDescription());
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
		getComponent().getBtnSelectAll().addEventListener(Events.ON_CLICK, this);

		if (lookup != null)
		{
			lookup.addListDataListener(this);
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
		if (event.getName().equals(Events.ON_CLICK) && event.getTarget() instanceof Button && event.getTarget() == getComponent().getBtnSelectAll())
		{
			doActionSelectAllItems();
		}
		if (event.getName().equals(Events.ON_CLICK))
		{
			Object isQuickFormComponent = getComponent().getAttribute(QuickGridTabRowRenderer.IS_QUICK_FORM_COMPONENT);
			if (isQuickFormComponent != null && (Boolean) isQuickFormComponent)
				Events.postEvent(Events.ON_FOCUS, event.getTarget(), null);
			if (event.getTarget() == getComponent().getTextbox() && isReadWrite())
				getComponent().getPopupComponent().open(getComponent().getTextbox(), "after_start");
		}
		else if (event.getName().equals(Events.ON_OPEN) && event.getTarget() == getComponent().getPopupComponent())
		{
			OpenEvent oe = (OpenEvent) event;
			if (!oe.isOpen())
			{
				isValueChange(getValue(), true);
				setComponentTextValue(getPrintableValue(oldValue));
			}
		}
	} // onEvent

	private void doActionSelectAllItems()
	{
		boolean checked = "Y".equals((String) getComponent().getBtnSelectAll().getAttribute(MultiSelectBox.ATTRIBUTE_ACTION_SELECT_ALL));

		//
		for (Checkbox list : getComponent().getCheckboxList())
		{
			list.setChecked(checked);
		}
		for (Component list : getComponent().getVBox().getChildren())
		{
			((Checkbox) list).setChecked(checked);
		}

		//
		getComponent().getBtnSelectAll().setAttribute(MultiSelectBox.ATTRIBUTE_ACTION_SELECT_ALL, checked ? "N" : "Y");
		getComponent().getBtnSelectAll().setLabel(Msg.getMsg(Env.getCtx(), (checked ? "DeSelectAll" : "select.all")));
	} // doActionSelectAllItems

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

		boolean isValueSame = isValueChange(newValue, false);

		setComponentTextValue(getPrintableValue(oldValue));

		/**
		 * Fire value change event. For Example, Item X is selected and Deleting
		 * X item from the referenced table then fires value change event for
		 * the field that containing window is opened.
		 */
		if (isValueSame)
			isValueChange(getValue(), true);

	} // setValue

	public boolean isValueChange(Object newValue, boolean isFireChangeEvent)
	{
		if (DisplayType.MultiSelectTable == lookup.getDisplayType())
		{
			Integer values[] = (Integer[]) newValue;
			if (Arrays.equals(getSortedSelectedItems(false), values))
				return true;
			if (isFireChangeEvent)
			{
				ValueChangeEvent changeValue = new ValueChangeEvent(this, getColumnName(), oldValue, values);
				super.fireValueChange(changeValue);
			}
			oldValue = values;
		}
		else
		{
			String values[] = (String[]) newValue;
			if (Arrays.equals(getSortedSelectedItems(false), values))
				return true;
			if (isFireChangeEvent)
			{
				ValueChangeEvent changeValue = new ValueChangeEvent(this, getColumnName(), oldValue, values);
				super.fireValueChange(changeValue);
			}
			oldValue = values;
		}

		return false;
	} // isValueChange

	public String getPrintableValue(Object values)
	{
		StringBuffer sb = new StringBuffer();

		if (values == null)
			return Msg.getMsg(Env.getCtx(), "PleaseSelect");

		// Track the list of values which are retrieve after dynamic validation logic applies
		ArrayList<Object> lookupMatchedValues = new ArrayList<Object>();

		//
		for (Checkbox cbx : getComponent().getCheckboxList())
		{
			String val = cbx.getAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT).toString();
			if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			{
				for (Integer value : (Integer[]) values)
				{
					if (value.compareTo(Integer.valueOf(val)) == 0)
					{
						cbx.setChecked(true);
						sb.append(cbx.getLabel()).append("; ");
						//
						lookupMatchedValues.add(value);
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
						//
						lookupMatchedValues.add(value);
						break;
					}
					cbx.setChecked(false);
				}
			}
		}

		// check Check-box List has all Printable value for parameter values
		boolean found = false;
		if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			found = ((Integer[]) values).length == (sb.toString().split("; ").length);
		else
			found = ((String[]) values).length == (sb.toString().split("; ").length);

		// If Printable Value is missing or not found, use look-up to get the display text for passed parameter values
		if (Util.isEmpty(sb.toString()) || !found)
		{
			sb = new StringBuffer();
			if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			{
				for (Integer value : (Integer[]) values)
				{
					String name = lookup.getDisplay(value);
					if (!Util.isEmpty(name))
					{
						sb.append(name).append("; ");
						//
						addExistingValue(lookupMatchedValues, name, value);
					}
				}
			}
			else
			{
				for (String value : (String[]) values)
				{
					String name = lookup.getDisplay(value);
					if (!Util.isEmpty(name))
					{
						sb.append(name).append("; ");
						//
						addExistingValue(lookupMatchedValues, name, value);
					}
				}
			}
		}

		return sb.toString();
	} // getPrintableValue

	/**
	 * For keep existing selected values
	 * Add values in selection list which are missed by dynamic validation logic
	 * 
	 * @param lookupMatchedValues
	 * @param name
	 * @param value
	 */
	private void addExistingValue(ArrayList<Object> lookupMatchedValues, String name, Object value)
	{
		if (!lookupMatchedValues.contains(value))
		{
			Checkbox cbx = new Checkbox(name);
			cbx.setAttribute(MultiSelectBox.ATTRIBUTE_MULTI_SELECT, value);
			cbx.setChecked(true);
			getComponent().getCheckboxList().add(cbx);
			getComponent().getVBox().appendChild(cbx);
		}
	} // addExistingValue

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
						itemsInt.add(Integer.valueOf(val));
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
			lookup.setMandatory(true);
			lookup.refresh();

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
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh();
		}
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start(getComponent(), this.getGridField(), Util.convertArrayToStringForDB(getValue()),
						null);
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
	}

	private void setComponentTextValue(String textValue)
	{
		getComponent().getTextbox().setValue(textValue.trim());
	} // setComponentTextValue

	public void actionRefresh()
	{
		refreshList();

		if (oldValue != null)
			setValue(oldValue);
	} // actionRefresh

	public void createCacheListener()
	{
		if (lookup != null)
		{
			String columnName = lookup.getColumnName();
			int dotIndex = columnName.indexOf(".");
			if (dotIndex > 0)
			{
				String tableName = columnName.substring(0, dotIndex);
				tableCacheListener = new CCacheListener(tableName, this);
			}
		}
	} // createCacheListener

	@Override
	public void contentsChanged(ListDataEvent e)
	{
		actionRefresh();
	}

	@Override
	public void intervalAdded(ListDataEvent e)
	{
	}

	@Override
	public void intervalRemoved(ListDataEvent e)
	{
	}

	@Override
	public void dynamicDisplay()
	{
		if ((lookup != null) && (!lookup.isValidated() || !lookup.isLoaded()
				|| (isReadWrite() && lookup.getSize() != getComponent().getCheckboxList().size())))
		{
			this.actionRefresh();
		}
	}

	@Override
	public void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}

	private static class CCacheListener extends CCache<String, Object>
	{

		/**
		 * 
		 */
		private static final long	serialVersionUID	= 5317205647791598504L;

		private WMultiSelectEditor	editor;

		protected CCacheListener(String tableName, WMultiSelectEditor editor)
		{
			super(tableName, tableName, 0, true);
			this.editor = editor;
		}

		@Override
		public int reset()
		{
			if (editor.getComponent().getDesktop() != null && editor.isReadWrite())
			{
				refreshLookupList();
			}
			return 0;
		} // reset

		private void refreshLookupList()
		{
			Executions.schedule(editor.getComponent().getDesktop(), new EventListener<Event>() {

				@Override
				public void onEvent(Event event)
				{
					try
					{
						if (editor.isReadWrite())
						{
							editor.actionRefresh();
						}
					}
					catch (Exception e)
					{
					}
				}

			}, new Event("onResetLookupList"));

		} // refreshLookupList

		@Override
		public void newRecord(int record_ID)
		{
			if (editor.getComponent().getDesktop() != null && editor.isReadWrite())
			{
				refreshLookupList();
			}
		} // newRecord

	} // CCacheListener class

}
