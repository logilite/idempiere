package org.compiere.minigrid;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.compiere.model.Lookup;
import org.compiere.util.DisplayType;
import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;

/**
 * MultiSelect Column for MiniGrid allows to multi-select type data and value.
 * 
 * @author Logilite Technologies
 */
public class MultiSelectColumn
{
	private String						displayValue;
	private Object						value;
	private Lookup						lookup;
	private ArrayList<ValueNamePair>	items;

	public MultiSelectColumn(Object value, String displayValue, Lookup lookup)
	{
		this.displayValue = displayValue;
		this.value = value;
		this.lookup = lookup;
	}

	public String getDisplayValue()
	{
		return displayValue;
	}

	public Integer[] getIntArrayValue()
	{
		if (value != null && value instanceof Integer[])
			return (Integer[]) value;
		return null;
	}

	public String[] getStringArrayValue()
	{
		if (value != null && value instanceof String[])
			return (String[]) value;
		return null;
	}

	public Object getValue()
	{
		return value;
	}

	public void setValue(ArrayList<ValueNamePair> selectedValue)
	{
		if (selectedValue != null)
		{
			if (lookup.getDisplayType() == DisplayType.MultiSelectList)
			{
				String[] strValue = new String[selectedValue.size()];
				for (int i = 0; i < selectedValue.size(); i++)
				{
					strValue[i] = selectedValue.get(i).getValue();
				}
				value = strValue;
			}
			else
			{
				Integer[] intValue = new Integer[selectedValue.size()];
				for (int i = 0; i < selectedValue.size(); i++)
				{
					intValue[i] = Integer.valueOf(selectedValue.get(i).getValue());
				}
				value = intValue;
			}
		}
	} // setValue

	public ArrayList<ValueNamePair> getItemList()
	{
		if (lookup != null)
		{
			ArrayList<Object> list = lookup.getData(true, true, true, true, false);
			if (list != null && !list.isEmpty())
			{
				items = new ArrayList<ValueNamePair>();
				for (Object item : list)
				{
					if (item instanceof ValueNamePair)
					{
						items.add((ValueNamePair) item);
					}
					else
					{
						KeyNamePair keyNamePair = (KeyNamePair) item;
						items.add(new ValueNamePair(String.valueOf(keyNamePair.getKey()), keyNamePair.getName()));
					}
				}
			}
		}
		return items;
	} // getItemList

	public ArrayList<ValueNamePair> getSelectedItems()
	{
		ArrayList<ValueNamePair> selectedItems = new ArrayList<ValueNamePair>();
		if (value != null)
		{
			if (lookup.getDisplayType() == DisplayType.MultiSelectList)
			{
				List<String> selected = Arrays.asList(getStringArrayValue());

				for (ValueNamePair item : items)
				{
					if (selected.contains(item.getValue()))
					{
						selectedItems.add(item);
					}
				}
			}
			else
			{
				List<Integer> selected = Arrays.asList(getIntArrayValue());
				for (ValueNamePair item : items)
				{
					if (selected.contains(Integer.valueOf(item.getValue())))
					{
						selectedItems.add(item);
					}
				}
			}
		}
		return selectedItems;
	} // getSelectedItems
}
