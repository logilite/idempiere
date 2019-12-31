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
import java.util.LinkedHashSet;
import java.util.Properties;
import java.util.Set;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.adwindow.QuickGridTabRowRenderer;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.util.CCache;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.addon.chosenbox.Chosenbox;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.ListModelList;

/**
 * Multiple Selection items from the List ( IDEMPIERE-3413 )
 * 
 * @author Logilite Technologies
 * @since Aug 07, 2017
 */
public class WMultiSelectEditor extends WEditor implements ContextMenuListener
{

	public final static String[]	LISTENER_EVENTS	= { Events.ON_SELECT };

	private Lookup					lookup;
	private Object					oldValue;

	public CCacheListener			tableCacheListener;

	private boolean					onselecting		= false;

	private ListModelList<Object>	model			= new ListModelList<>();

	public WMultiSelectEditor(GridField gridField)
	{
		super(new ChosenboxEditor(), gridField);
		lookup = gridField.getLookup();
		if (lookup == null)
			throw new IllegalArgumentException("Lookup cannot be null");

		init();
	}

	/**
	 * ZK Initialization
	 */
	private void init()
	{
		getComponent().setHflex("true");
		getComponent().editor = this;
		getComponent().setModel(model);

		if (lookup != null)
		{
			lookup.setMandatory(true);

			//no need to refresh readonly lookup
			if (isReadWrite())
			{
				refreshLookup();
			}
			else
			{
				updateModel();
			}
		}

		if (gridField != null)
		{
			popupMenu = new WEditorPopupMenu(false, true, isShowPreference(), false, false, false, lookup);
			addChangeLogMenu(popupMenu);
		}
	} // init

	protected void refreshLookup()
	{
		lookup.refresh();
		updateModel();
	} // refreshLookup

	@Override
	public String getDisplay()
	{
		StringBuilder display = new StringBuilder();
		LinkedHashSet<Object> selected = getComponent().getSelectedObjects();
		if (selected != null && selected.size() > 0)
		{
			for (Object pair : selected)
			{
				if (display.length() > 0)
					display.append(", ");

				if (lookup.getDisplayType() == DisplayType.MultiSelectTable)
					display.append(((KeyNamePair) pair).getName());
				else
					display.append(((ValueNamePair) pair).getName());
			}
		}

		return display.toString();
	} // getDisplay

	@Override
	public Object getValue()
	{
		return oldValue;
	}

	/**
	 * @return Array of data
	 */
	private Object getValueFromComponent()
	{
		LinkedHashSet<Object> selected = getComponent().getSelectedObjects();
		if (selected != null && selected.size() > 0)
		{
			int i = 0;
			if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			{
				Integer keys[] = new Integer[selected.size()];
				for (Object obj : selected)
				{
					KeyNamePair pair = (KeyNamePair) obj;
					keys[i] = pair.getKey();
					i++;
				}
				return keys;
			}
			else
			{
				String keys[] = new String[selected.size()];
				for (Object obj : selected)
				{
					ValueNamePair pair = (ValueNamePair) obj;
					keys[i] = pair.getValue();
					i++;
				}
				return keys;
			}
		}
		return null;
	} // getValueFromComponent

	@Override
	public void setValue(Object value)
	{
		if (onselecting)
		{
			return;
		}

		if (value == null
		    || (DisplayType.MultiSelectTable == lookup.getDisplayType() && value instanceof Integer[] && ((Integer[]) value).length == 0)
		    || (DisplayType.MultiSelectList == lookup.getDisplayType() && value instanceof String[] && ((String[]) value).length == 0))
		{
			getComponent().setSelectedObjects(new LinkedHashSet<Object>());
			oldValue = value;
		}
		else
		{
			Set<Object> selected = createNamePairSetFromValue(value);

			getComponent().setSelectedObjects(selected);

			boolean isQuickFormComp = false;
			if (getComponent().getAttribute(QuickGridTabRowRenderer.IS_QUICK_FORM_COMPONENT) != null)
				isQuickFormComp = (boolean) getComponent().getAttribute(QuickGridTabRowRenderer.IS_QUICK_FORM_COMPONENT);
			if (getComponent().getSelectedObjects().size() != selected.size() || isQuickFormComp)
			{
				Object newValue = getValueFromComponent();
				ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), value, newValue);
				super.fireValueChange(changeEvent);
				oldValue = value;
			}
			else
			{
				oldValue = value;
			}
		}

	} // setValue

	public Set<Object> createNamePairSetFromValue(Object value)
	{
		Set<Object> selected = new LinkedHashSet<>();
		if (value != null)
		{
			if (DisplayType.MultiSelectTable == lookup.getDisplayType())
			{
				Integer keys[] = (Integer[]) value;
				for (Integer key : keys)
				{
					String name = lookup.getDisplay(key);
					KeyNamePair pair = new KeyNamePair(key, name);
					selected.add(pair);
				}
			}
			else
			{
				String keys[] = (String[]) value;
				for (String key : keys)
				{
					String name = lookup.getDisplay(key);
					ValueNamePair pair = new ValueNamePair(key, name);
					selected.add(pair);
				}
			}
		}
		return selected;
	} // createNamePairSetFromValue

	@Override
	public ChosenboxEditor getComponent()
	{
		return (ChosenboxEditor) component;
	}

	@Override
	public boolean isReadWrite()
	{
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite)
	{
		getComponent().setEnabled(readWrite);
	}

	/**
	 * Update selection list items
	 */
	private void updateModel()
	{
		Set<Object> list = new LinkedHashSet<>();

		if (isReadWrite())
		{
			for (int i = 0; i < lookup.getSize(); i++)
			{
				Object pair = lookup.getElementAt(i);
				if (pair instanceof KeyNamePair)
				{
					KeyNamePair lookupKNPair = (KeyNamePair) pair;
					list.add(lookupKNPair);
				}
				else if (pair instanceof ValueNamePair)
				{
					ValueNamePair lookupKNPair = (ValueNamePair) pair;
					list.add(lookupKNPair);
				}
			}
		}
		else
		{
			if (oldValue != null)
			{

				list = createNamePairSetFromValue(oldValue);
			}
		}

		model.clear();
		model.addAll(list);
	} // updateModel

	@Override
	public void onEvent(Event event)
	{
		if (Events.ON_SELECT.equalsIgnoreCase(event.getName()))
		{
			try
			{
				onselecting = true;
				Object newValue = getValueFromComponent();
				if (isValueChange(newValue))
				{
					try
					{
						if (gridField != null)
							gridField.setLookupEditorSettingValue(true);
						ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
						super.fireValueChange(changeEvent);
						oldValue = newValue;
					}
					finally
					{
						if (gridField != null)
							gridField.setLookupEditorSettingValue(false);
					}
				}
			}
			finally
			{
				onselecting = false;
			}
		}
	} // onEvent

	private boolean isValueChange(Object newValue)
	{
		return (oldValue == null && newValue != null) || (oldValue != null && newValue == null) || ((oldValue != null && newValue != null) && !oldValue.equals(newValue));
	}

	@Override
	public String[] getEvents()
	{
		return LISTENER_EVENTS;
	}

	public void actionRefresh()
	{
		Object curValue = getValue();

		if (isReadWrite())
			refreshLookup();
		else
			updateModel();

		if (curValue != null)
		{
			setValue(curValue);
		}
	} // actionRefresh

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
				ValuePreference.start(getComponent(), this.getGridField(), Util.convertArrayToStringForDB(getValue()), null);
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
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

	@Override
	public void dynamicDisplay(Properties ctx)
	{
		if (lookup instanceof MLookup)
			((MLookup) lookup).getLookupInfo().ctx = ctx;

		if ((!lookup.isValidated() || !lookup.isLoaded() || (isReadWrite() && lookup.getSize() != getComponent().getModel().getSize())))
			this.actionRefresh();

		super.dynamicDisplay(ctx);
	}

	public void createCacheListener()
	{
		String columnName = lookup.getColumnName();
		int dotIndex = columnName.indexOf(".");
		if (dotIndex > 0)
		{
			String tableName = columnName.substring(0, dotIndex);
			tableCacheListener = new CCacheListener(tableName, this);
		}
	} // createCacheListener

	/**
	 * Chosebox Editor Component
	 * 
	 * @since December 05, 2019
	 */
	public final static class ChosenboxEditor extends Chosenbox<Object>
	{

		/**
		 * generated serial id
		 */
		private static final long	serialVersionUID	= 7777300782255405327L;
		private DesktopCleanup		listener			= null;
		private WMultiSelectEditor	editor				= null;

		protected ChosenboxEditor()
		{
		}

		public void setEnabled(boolean readWrite)
		{
			setDisabled(readWrite == false);
		}

		public boolean isEnabled()
		{
			return isDisabled() == false;
		}

		@Override
		public void setPage(Page page)
		{
			super.setPage(page);
		}

		@Override
		public void onPageAttached(Page newpage, Page oldpage)
		{
			super.onPageAttached(newpage, oldpage);
			if (editor != null && editor.tableCacheListener == null)
			{
				editor.createCacheListener();
				if (listener == null)
				{
					listener = new DesktopCleanup() {

						@Override
						public void cleanup(Desktop desktop) throws Exception
						{
							ChosenboxEditor.this.cleanup();
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

		/**
		 * 
		 */
		protected void cleanup()
		{
			if (editor != null && editor.tableCacheListener != null)
			{
				CacheMgt.get().unregister(editor.tableCacheListener);
				editor.tableCacheListener = null;
			}
		} // cleanup
	}

	/**
	 * Cache Listener
	 */
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
					{}
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
