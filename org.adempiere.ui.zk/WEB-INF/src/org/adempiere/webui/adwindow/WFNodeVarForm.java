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
package org.adempiere.webui.adwindow;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MultiMap;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeVar;
import org.zkoss.zul.Div;

/**
 * Dynamic workflow variable form built from {@link MColumn} metadata.
 * <p>
 * It dynamically creates editors at runtime for workflow node variables,
 * manages dependencies, validates mandatory values, and provides
 * user-entered values as a map of column IDs to strings.
 */
public class WFNodeVarForm extends Window implements ValueChangeListener
{
	private static final long				serialVersionUID	= 3400124922854405892L;
	
	private static final Set <String>		SKIP_COLUMNS		= new HashSet <>(Arrays.asList("CREATED", "CREATEDBY", "UPDATED", "UPDATEDBY"));

	/** Dependency map: fieldName → dependent GridFields */
	private MultiMap <String, GridField>	m_depOnField		= new MultiMap <>();

	private int								m_WindowNo;

	/** All editors shown in UI order */
	private List <WEditor>					editors				= new ArrayList <>();

	/** Lookup of GridField → WEditor */
	private Map <GridField, WEditor>		editorsMap			= new HashMap <>();

	/**
	 * Creates a new workflow variable form.
	 * @param node 
	 *
	 * @param columns workflow variable columns
	 * @param po persistent object providing context and defaults
	 * @param gridTab 
	 */
	public WFNodeVarForm(MWFNode node, List <MColumn> columns, PO po, GridTab gridTab)
	{
		if (node == null || columns == null || po == null)
			throw new IllegalArgumentException("node, columns, and po must not be null");

		init(node, columns, po, gridTab);
		setHeight((columns.size() * 35 + 50) + "px");
	}

	/**
	 * Initializes UI, creates editors, and registers field dependencies.
	 * @param node 
	 *
	 * @param columns list of workflow node variable columns
	 * @param po persistent object for default values
	 * @param gridTab 
	 */
	private void init(MWFNode node, List <MColumn> columns, PO po, GridTab gridTab)
	{
		// TODO future: To add support for the window record value parsing for mandatory and displaylogic
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		setTitle(Msg.getMsg(Env.getCtx(), "WFNodeVariable"));
		setWidth("100%");
		setClosable(false);
		setStyle("position: absolute;");
		setSclass("popup-dialog");

		Borderlayout borderlayout = new Borderlayout();
		borderlayout.setParent(this);

		Panel pc = new Panel();
		borderlayout.appendCenter(pc);
		borderlayout.getCenter().setStyle("overflow-y: auto;");

		Div gridDiv = new Div();
		Grid grid = new Grid();
		gridDiv.setHeight("98%");
		gridDiv.setWidth("98%");
		grid.setWidth("100%");

		Columns cols = new Columns();
		Column colField = new Column();
		colField.setWidth("30%");
		cols.appendChild(colField);
		colField = new Column();
		colField.setWidth("70%");
		cols.appendChild(colField);
		grid.appendChild(cols);

		Rows rows = new Rows();

		Env.setContext(Env.getCtx(), m_WindowNo, 0, GridTab.CTX_KeyColumnName, po.get_KeyColumns()[0]);
		Env.setContext(Env.getCtx(), m_WindowNo, 0, po.get_KeyColumns()[0], String.valueOf(po.get_Value(po.get_KeyColumns()[0])));
		Env.setContext(Env.getCtx(), m_WindowNo, 0, "IsActive", po.isActive() ? "Y" : "N");
		// Build one row per workflow variable column
		for (MColumn column : columns)
		{
			if (shouldSkipColumn(column))
				continue;

			Row row = new Row();
			WEditor editor = getEditorForColumn(column, node, po, gridTab);
			if (editor != null)
			{
				row.appendChild(editor.getLabel());
				editors.add(editor);
				editor.setReadWrite(true);
				Object value = po.get_Value(column.getColumnName());
				if (value != null)
					Env.setContext(Env.getCtx(), m_WindowNo, editor.getGridField().getColumnName(), value.toString());
				editor.setValue(value);
				row.appendChild(editor.getComponent());
				applyDynamicLogic(editor);
			}
			else
			{
				row.appendChild(new Label("(No Editor)"));
			}
			rows.appendChild(row);
		}

		grid.appendChild(rows);
		gridDiv.appendChild(grid);
		pc.appendChild(gridDiv);
	}

	/**
	 * Checks whether a column should be skipped (system or meta fields).
	 *
	 * @param column column metadata
	 * @return true if column should not be displayed
	 */
	private boolean shouldSkipColumn(MColumn column)
	{
		String colName = column.getColumnName();
		if (column.isKey() || column.isVirtualColumn() || column.isEncrypted())
			return true;
		return SKIP_COLUMNS.contains(colName.toUpperCase());
	}

	/**
	 * Creates an editor for the given column and registers dependencies.
	 *
	 * @param column workflow node variable column
	 * @param node 
	 * @param po 
	 * @param gridTab 
	 * @return created editor or null if unavailable
	 */
	private WEditor getEditorForColumn(MColumn column, MWFNode node, PO po, GridTab gridTab)
	{
		// gridTab != null ? gridTab.getField(column.getColumnName()) :
		GridField field = getGridField(column);
		if (field == null)
			return null;

		if (gridTab != null)
		{
			field.setGridTab(gridTab);
			GridField windowField = gridTab.getField(column.getColumnName());
			if (windowField != null)
				field.getVO().Header = windowField.getHeader();
		}

		MWFNodeVar nodeVar = MWFNodeVar.getNodeVarsField(node.getCtx(), node.getAD_WF_Node_ID(), column.getAD_Column_ID());
		field.getVO().DisplayLogic = nodeVar.getDisplayLogic() != null ? nodeVar.getDisplayLogic() : "";
		field.getVO().MandatoryLogic = nodeVar.getMandatoryLogic() != null ? nodeVar.getMandatoryLogic() : "";
		field.getVO().AD_Table_ID = po.get_Table_ID();

		// Register dependencies
		ArrayList <String> dep = field.getDependentOn();
		for (String d : dep)
			m_depOnField.put(d, field);

		String name = column.getColumnName();
		if ("IsActive".equals(name) || "Processed".equals(name) || "Processing".equals(name))
			m_depOnField.put(name, null);

		WEditor editor = WebEditorFactory.getEditor(field, true);
		editor.dynamicDisplay();
		editor.addValueChangeListener(this);
		editor.fillHorizontal();
		editorsMap.put(field, editor);
		return editor;
	}

	/**
	 * Converts MColumn metadata to GridField.
	 *
	 * @param column source column metadata
	 * @return GridField instance for editor creation
	 */
	private GridField getGridField(MColumn column)
	{
		String name = Msg.translate(Env.getCtx(), column.get_Translation(MColumn.COLUMNNAME_Name));
		String desc = column.get_Translation(MColumn.COLUMNNAME_Description);

		GridFieldVO vo
						= GridFieldVO.createParameter(
										Env.getCtx(),
										m_WindowNo,
										AEnv.getADWindowID(m_WindowNo),
										0,
										column.getAD_Column_ID(),
										column.getColumnName(),
										name,
										column.getAD_Reference_ID(),
										column.getAD_Reference_Value_ID(),
										column.isMandatory(),
										column.isEncrypted(),
										column.getPlaceholder());

		vo.Description = desc != null ? desc : "";

		if (column.getAD_Val_Rule_ID() > 0)
		{
			vo.ValidationCode = column.getAD_Val_Rule().getCode();
			if (vo.lookupInfo != null)
			{
				vo.lookupInfo.ValidationCode = vo.ValidationCode;
				vo.lookupInfo.IsValidated = false;
			}
		}
		return new GridField(vo);
	}

	/**
	 * Validates mandatory fields and returns message for missing values.
	 *
	 * @return error message or null if all fields are filled
	 */
	public String validateMandatory( )
	{
		List <String> missing = new ArrayList <>();
		for (WEditor editor : editors)
		{
			GridField field = editor.getGridField();
			if (field != null && field.isMandatory(true))
			{
				Object val = editor.getValue();
				if (val == null || (val instanceof String && ((String) val).trim().isEmpty()))
					missing.add(field.getHeader());
			}
		}

		if (!missing.isEmpty())
			return Msg.getMsg(Env.getCtx(), "FillMandatory") + ": " + String.join(", ", missing);

		return null;
	}

	/**
	 * Applies dynamic UI display rules to all editors.
	 * Evaluates visibility, editability, and mandatory status based on context.
	 */
	public void dynamicDisplay( )
	{
		for (WEditor comp : editors)
		{
			applyDynamicLogic(comp);
		} // all components
	}

	/**
	 * Updates the display state of a single editor based on its GridField configuration.
	 * Handles visibility, read/write mode, mandatory flag, and triggers editor-specific dynamic behavior.
	 *
	 * @param comp the editor whose dynamic UI rules should be evaluated
	 */
	private void applyDynamicLogic(WEditor comp)
	{
		GridField mField = comp.getGridField();
		if (mField != null)
		{
			if (mField.isDisplayed(true)) // check context
			{
				if (!comp.isVisible())
				{
					comp.setVisible(true); // visibility
				}

				boolean rw = mField.isEditable(true); // r/w - check Context
				if (rw && !comp.isReadWrite()) // IDEMPIERE-3421 - if it was read-only the list can contain direct values
					mField.refreshLookup();
				comp.setReadWrite(rw);
				comp.setMandatory(mField.isMandatory(true)); // check context
				comp.dynamicDisplay();
			}
			else if (comp.isVisible())
			{
				comp.setVisible(false);
			}
		}
		comp.updateStyle();
	}

	/**
	 * Returns a map of column IDs to editor values.
	 *
	 * @return map of AD_Column_ID → value string
	 */
	public Map <Integer, String> getValuesMap( )
	{
		Map <Integer, String> values = new HashMap <>();
		for (WEditor editor : editors)
		{
			GridField field = editor.getGridField();
			if (field != null && field.isDisplayed(true))
			{
				int columnID = field.getAD_Column_ID();
				Object val = editor.getValue();
				values.put(columnID, val == null ? "" : val.toString());
			}
		}
		return values;
	}

	/**
	 * Handles value change events and refreshes dependent fields.
	 *
	 * @param evt the value change event
	 */
	@Override
	public void valueChange(ValueChangeEvent evt)
	{
		Object source = evt.getSource();
		if (source instanceof WEditor)
		{
			WEditor editor = (WEditor) source;
			GridField f = editor.getGridField();
			Env.setContext(Env.getCtx(), m_WindowNo, f.getColumnName(), evt.getNewValue() == null ? "" : evt.getNewValue().toString());
			processDependencies(f);
			dynamicDisplay();
		}
	}

	/**
	 * Refreshes fields dependent on the given changed field.
	 *
	 * @param changedField the field whose value changed
	 */
	private void processDependencies(GridField changedField)
	{
		String name = changedField.getColumnName();
		if (!hasDependants(name))
			return;

		for (GridField dep : getDependantFields(name))
		{
			if (dep == null || dep.isLookupEditorSettingValue())
				continue;

			if (editorsMap.containsKey(dep))
				editorsMap.get(dep).setValue(null);

			if (dep.getLookup() instanceof MLookup)
			{
				MLookup m = (MLookup) dep.getLookup();
				String validation = m.getValidation();
				if (!Util.isEmpty(validation))
				{
					// Refresh lookup if validation references this field
					// Matches patterns like: @FieldName@, @~FieldName@, @FieldName:modifier@
					if (validation.contains("@" + name + "@")
						|| validation.matches(".*[@][~]?" + name + "([:].+)?[@].*"))
						m.refresh();
				}
			}

			if (dep.isVirtualUIColumn())
				dep.processUIVirtualColumn();
		}
	}

	/**
	 * Checks if the given column has dependent fields.
	 *
	 * @param columnName column name
	 * @return true if dependent fields exist
	 */
	public boolean hasDependants(String columnName)
	{
		return m_depOnField.containsKey(columnName);
	}

	/**
	 * Returns dependent GridFields for a column.
	 *
	 * @param columnName column name
	 * @return list of dependent GridFields
	 */
	public ArrayList <GridField> getDependantFields(String columnName)
	{
		return m_depOnField.getValues(columnName);
	}

	public int getWindowNo( )
	{
		return m_WindowNo;
	}

}
