/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.adempiere.webui.window;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.adwindow.QuickGridView;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.form.WQuickForm;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * From clipboard data to paste in quick form and insert directly in the panel.
 * 
 * @author Logilite Technologies
 * @since  Sep 15, 2021
 */
public class QuickFormPasteData extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long	serialVersionUID	= 487985089555512127L;

	int							windowNo;
	WQuickForm					quickForm;

	private GridTab				gridTab;
	private QuickGridView		quickGridView;
	private Textbox				textbox				= new Textbox();
	private ConfirmPanel		confirmPanel		= new ConfirmPanel(false, false, false, false, false, false);

	/**
	 * Constructor
	 * 
	 * @param windowNo
	 * @param gridTab
	 * @param quickGridView
	 * @param quickForm
	 */
	public QuickFormPasteData(int windowNo, GridTab gridTab, QuickGridView quickGridView, WQuickForm quickForm)
	{
		setTitle(Msg.getMsg(Env.getCtx(), "PasteInForm"));
		setMaximizable(true);
		setClosable(true);

		this.windowNo = windowNo;
		this.gridTab = gridTab;
		this.quickGridView = quickGridView;
		this.quickForm = quickForm;

		initComponent();
	}

	public void initComponent()
	{
		ZKUpdateUtil.setWindowWidthX(this, 500);
		ZKUpdateUtil.setWindowHeightX(this, 410);

		// CreateUI
		Borderlayout layout = new Borderlayout();
		layout.setStyle("height: 100%; width: 100%; border: none; margin: none; padding: 2px;");

		ZKUpdateUtil.setHeight(textbox, "98%");
		ZKUpdateUtil.setWidth(textbox, "99%");
		textbox.setStyle("padding-left: 10px; padding-right: 10px;");
		textbox.setMultiline(true);

		this.appendChild(layout);
		layout.appendCenter(textbox);
		layout.appendSouth(confirmPanel);

		confirmPanel.addActionListener(this);
	} // initComponent

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_OK)))
		{
			if (!textbox.isDisabled() && !Util.isEmpty(textbox.getValue(), true))
			{
				// Ignore the unsaved change before processing
				gridTab.dataIgnore();
				gridTab.dataRefreshAll();
				quickGridView.updateListIndex();

				//
				String result = ""; //TODO instead of String, this should be StringBuilder
				String[] lines = textbox.getValue().split("\n");
				int lineCnt = 0;
				int failCnt = 0;
				// line
				for (String line : lines)
				{
					if (!Util.isEmpty(line, true))
					{
						try
						{
							// create the new line in quick form
							quickGridView.createNewLine();
							quickGridView.updateListIndex();

							String[] columns = line.split("\t");
							if (!Util.isEmpty(result))
								result += "\n";
							result += line;

							lineCnt++;
							int f =-1;
							// Columns
							for (int i = 0; i < columns.length; i++)
							{
								String value = columns[i];

								if (Util.isEmpty(value))
									continue;
								GridField field = null;
								//Find next non read only field
								do {
									f++;
									field = quickGridView.getGridField()[f];
								}while(field.isEditable(true)==false);
								
								int dt = field.getDisplayType();
								if (dt == DisplayType.Integer || (DisplayType.isID(dt) && field.getColumnName().endsWith("_ID")))
								{
									Pattern p = Pattern.compile("[0-9]+");
									if (p.matcher(value).matches())
									{
										gridTab.setValue(field, Integer.valueOf(value));
									}
									else
									{
										Integer id = parseFieldValue(field, value);
										if (id < 0)
											throw new AdempiereException("Invalid data = '" + value + "'");
										gridTab.setValue(field, id);
									}
								}
								// Return BigDecimal
								else if (DisplayType.isNumeric(dt))
								{
									gridTab.setValue(field, new BigDecimal(value));
								}
								// Return Timestamp
								else if (DisplayType.isDate(dt))
								{
									//TODO this required testing as different region has different date format.
									SimpleDateFormat sdf = DisplayType.getDateFormat_JDBC();
									try
									{
										if (dt == DisplayType.DateTime)
											sdf = DisplayType.getTimestampFormat_Default();
										else if (dt == DisplayType.Time)
											sdf = DisplayType.getTimeFormat_Default();
										long time = sdf.parse(value).getTime();
										gridTab.setValue(field, new Timestamp(time));
									}
									catch (ParseException e)
									{
										throw new AdempiereException("Invalid Format = '" + value + "' expected Format = [ " + sdf.toPattern() + " ]");
									}
								}
								else if (dt == DisplayType.YesNo)
								{
									Boolean bvalue;
									if (value.toUpperCase().equals("Y") || value.toUpperCase().equals("TRUE"))
										bvalue = Boolean.TRUE;
									else if (value.toUpperCase().equals("N") || value.toUpperCase().equals("FALSE"))
										bvalue = Boolean.FALSE;
									else
										throw new AdempiereException(" Invalid data = '" + value + "' - Must be Y/N ");
									gridTab.setValue(field, bvalue);
								}
								else if (DisplayType.isMultiSelect(dt))
								{
									// Current only support ID and value String
									// TODO Add support to convert the name string to ID/value.
									gridTab.setValue(field, Util.getArrayObjectFromString(dt, value));
								}
								else
								{
									gridTab.setValue(field, value);
								}
							} // Column

							// save the record
							if (!quickGridView.dataSave(0))
							{
								// log the error if save fail
								ValueNamePair error = CLogger.retrieveWarning();
								if (error == null)
									error = CLogger.retrieveError();

								if (error != null)
									throw new AdempiereException(" Save Error = " + error.getName());
								else
									throw new AdempiereException(" Save Fail ");
							}
							result += " [ Successfully record inserted ]";
						}
						catch (Exception e)
						{
							failCnt++;
							result += "	[ Error = " + e.getLocalizedMessage() + " ]";
							gridTab.dataIgnore();
							gridTab.dataRefreshAll();
							quickGridView.updateListIndex();
							continue;
						}
					}
				} // line

				// Display output
				if(failCnt>0) {
					textbox.setValue(result);
					textbox.setEnabled(false);
					Dialog.warn(windowNo, "line " + failCnt + " out of " + lineCnt + " has failed. Please review same in paste area!!!");
				}else {
					dispose();
				}
			}
			else
			{
				dispose();
			}
		}
	} // onEvent

	/**
	 * Get passed reference value record ID.
	 * - Find in Lookup list
	 * - Get ID from DB base on Value and Name.
	 * 
	 * @param  field - GridField
	 * @param  value - String
	 * @return       Record ID
	 */
	private Integer parseFieldValue(GridField field, String value)
	{
		int parseValue = -1;
		try
		{
			Lookup lookup = field.getLookup();
			String columName = field.getColumnName();
			if (lookup != null && !Util.isEmpty(lookup.getColumnName()))
				columName = lookup.getColumnName();

			//
			parseValue = getIDFromLookup(lookup, value);
			if (parseValue < 0)
				parseValue = getIDFromText(columName, value, getWhereClause(lookup), true);
			if (parseValue < 0)
				parseValue = getIDFromText(columName, value, getWhereClause(lookup), false);
		}
		catch (Exception e)
		{
			return -1;
		}

		if (parseValue < 0)
			return -1;
		return parseValue;
	} // parseFieldValue

	/**
	 * Get SQL Default where clause for the field
	 * 
	 * @param  lookup
	 * @return
	 */
	private String getWhereClause(Lookup lookup)
	{
		String whereClause = "";

		if (lookup == null)
			return "";

		if (lookup.getZoomQuery() != null)
			whereClause = lookup.getZoomQuery().getWhereClause();

		String validation = lookup.getValidation();

		if (validation == null)
			validation = "";

		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;

		if (whereClause.indexOf('@') != -1)
		{
			String validated = null;
			if (lookup instanceof MLookup)
			{
				MLookupInfo m_info = ((MLookup) lookup).getLookupInfo();
				validated = Env.parseContext(m_info.ctx, m_info.WindowNo, m_info.tabNo, whereClause, false);
			}
			else
			{
				validated = Env.parseContext(Env.getCtx(), lookup.getWindowNo(), whereClause, false);
			}

			return validated;
		}
		return whereClause;
	} // getWhereClause

	/**
	 * Get the record ID from lookup data list.
	 * 
	 * @param  lookup
	 * @param  recordName
	 * @return
	 */
	private int getIDFromLookup(Lookup lookup, String recordName)
	{
		if (lookup != null)
		{
			ArrayList<Object> dataList = lookup.getData(lookup.isMandatory(), true, true, false, lookup.isShortList());
			for (Object data : dataList)
			{
				if (data instanceof KeyNamePair)
				{
					if (((KeyNamePair) data).getName().equals(recordName))
					{
						return ((KeyNamePair) data).getKey();
					}
				}
			}
		}
		return -1;
	} // getIDFromLookup

	/**
	 * Get record ID from DB base on the Value column
	 * 
	 * @param  columnName
	 * @param  textData
	 * @param  where       - Default where clause
	 * @param  isValueText - Check with Value field other wise Name field
	 * @return             Resolved integer record ID
	 */
	private int getIDFromText(String columnName, String textData, String where, boolean isValueText)
	{
		String tableName = columnName.substring(0, (columnName.length() - 3));
		if (columnName.indexOf(".") != -1)
		{
			tableName = columnName.substring(0, columnName.indexOf("."));
			columnName = columnName.substring(columnName.indexOf(".") + 1);
		}

		if (!Util.isEmpty(where))
			where += " AND ";

		if (isValueText)
		{
			MColumn columnExists = MTable.get(Env.getCtx(), tableName).getColumn("Value");
			if (columnExists == null)
				return -1;
			where = " Value = ?";
		}
		else
		{
			MColumn columnExists = MTable.get(Env.getCtx(), tableName).getColumn("Name");
			if (columnExists == null)
				return -1;
			where = " Name = ?";
		}

		return DB.getSQLValue(null, "SELECT " + columnName + " FROM " + tableName + " WHERE " + where, textData);
	} // getIDFromText

	/**
	 * Show Dialog
	 * 
	 * @param windowNo
	 * @param gridTab
	 * @param quickGridView
	 * @param quickForm
	 */
	public static void showDialog(int windowNo, GridTab gridTab, QuickGridView quickGridView, WQuickForm quickForm)
	{
		QuickFormPasteData formPaste = new QuickFormPasteData(windowNo, gridTab, quickGridView, quickForm);
		//
		AEnv.showWindow(formPaste);
	} // showDialog

}
