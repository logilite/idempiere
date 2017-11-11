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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Combinationbox;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Locationbox;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Searchbox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WImageEditor;
import org.adempiere.webui.editor.WPAttributeEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.GridTabDataBinder;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MSysConfig;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Html;
import org.zkoss.zul.Label;
import org.zkoss.zul.Paging;
import org.zkoss.zul.RendererCtrl;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;
import org.zkoss.zul.RowRendererExt;

/**
 * Row renderer for Quick GridTab grid.
 * 
 * @author Logilite Technologies
 * @since Nov 03, 2017
 */
public class QuickGridTabRowRenderer
		implements RowRenderer<Object[]>, RowRendererExt, RendererCtrl, EventListener<Event> {

	public static final String GRID_ROW_INDEX_ATTR = "grid.row.index";
	private static final String CELL_DIV_STYLE = "height: 100%; cursor: pointer; ";
	private static final String CELL_DIV_STYLE_ALIGN_CENTER = CELL_DIV_STYLE + "text-align:center; ";
	private static final String CELL_DIV_STYLE_ALIGN_RIGHT = CELL_DIV_STYLE + "text-align:right; ";
	public static final String CURRENT_ROW_STYLE = "border-top: 2px solid #6f97d2; border-bottom: 2px solid #6f97d2";

	private static final int MAX_TEXT_LENGTH_DEFAULT = 60;
	private GridTab gridTab;
	private int windowNo;
	private GridTabDataBinder dataBinder;
	private Map<GridField, WEditor> editors = new LinkedHashMap<GridField, WEditor>();
	private Map<GridField, WEditor> readOnlyEditors = new LinkedHashMap<GridField, WEditor>();
	private Paging paging;

	private RowListener rowListener;

	private Grid grid = null;
	private QuickGridView gridPanel = null;
	private Row currentRow;
	private Object[] currentValues;
	private boolean editing = false;
	private int currentRowIndex = -1;
	private AbstractADWindowContent m_windowPanel;
	private ActionListener buttonListener;
	/**
	 * Flag detect this view has customized column or not
	 * value is set at {@link #render(Row, Object[], int)}
	 */
	private boolean isGridViewCustomized = false;
	/** DefaultFocusField		*/
	private WEditor	defaultFocusField = null;

	/**
	 *
	 * @param gridTab
	 * @param windowNo
	 */
	public QuickGridTabRowRenderer(GridTab gridTab, int windowNo) {
		this.gridTab = gridTab;
		this.windowNo = windowNo;
		this.dataBinder = new GridTabDataBinder(gridTab);
	}

	private WEditor getEditorCell(GridField gridField, Object object) {
		WEditor editor = WebEditorFactory.getEditor(gridField, true);
		if (editor != null) {
			prepareFieldEditor(gridField, editor);
			editor.addValueChangeListener(dataBinder);
			gridField.removePropertyChangeListener(editor);
			gridField.addPropertyChangeListener(editor);
			editor.setValue(object);
		}
		return editor;
	}

	private void prepareFieldEditor(GridField gridField, WEditor editor) {
			if (editor instanceof WButtonEditor)
            {
				if (buttonListener != null)
				{
					((WButtonEditor)editor).addActionListener(buttonListener);	
				}
				else
				{
					Object window = SessionManager.getAppDesktop().findWindow(windowNo);
	            	if (window != null && window instanceof ADWindow)
	            	{
	            		AbstractADWindowContent windowPanel = ((ADWindow)window).getADWindowContent();
	            		((WButtonEditor)editor).addActionListener(windowPanel);
	            	}
				}
            }

            //Stretch component to fill grid cell
			if (editor.getComponent() instanceof HtmlBasedComponent) {
            	editor.fillHorizontal();
		}
	}

	public int getColumnIndex(GridField field) {
		GridField[] fields = gridPanel.getFields();
		for(int i = 0; i < fields.length; i++) {
			if (fields[i] == field)
				return i;
		}
		return 0;
	}

	/**
	 * call {@link #getDisplayText(Object, GridField, int, boolean)} with isForceGetValue = false
	 * @param value
	 * @param gridField
	 * @param rowIndex
	 * @return
	 */
	private String getDisplayText(Object value, GridField gridField, int rowIndex){
		return getDisplayText(value, gridField, rowIndex, false);
	}
	
	/**
	 * Get display text of a field. when field have isDisplay = false always return empty string, except isForceGetValue = true
	 * @param value
	 * @param gridField
	 * @param rowIndex
	 * @param isForceGetValue
	 * @return
	 */
	private String getDisplayText(Object value, GridField gridField, int rowIndex, boolean isForceGetValue)
	{
		if (value == null)
			return "";

		if (rowIndex >= 0) {
			GridRowCtx gridRowCtx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
			if (!isForceGetValue && !gridField.isDisplayed(gridRowCtx, true)) {
				return "";
			}
		}
		
		if (gridField.isEncryptedField())
		{
			return "********";
		}		
		else if (readOnlyEditors.get(gridField) != null) 
		{
			WEditor editor = readOnlyEditors.get(gridField);			
			return editor.getDisplayTextForGridView(value);
		}
    	else
    		return value.toString();
	}
	
	/**
	 * @param text
	 * @param label
	 */
	private void setLabelText(String text, Label label) {
		String display = text;
		final int MAX_TEXT_LENGTH = MSysConfig.getIntValue(MSysConfig.MAX_TEXT_LENGTH_ON_GRID_VIEW,MAX_TEXT_LENGTH_DEFAULT,Env.getAD_Client_ID(Env.getCtx()));
		if (text != null && text.length() > MAX_TEXT_LENGTH)
			display = text.substring(0, MAX_TEXT_LENGTH - 3) + "...";
		// since 5.0.8, the org.zkoss.zhtml.Text is encoded by default
//		if (display != null)
//			display = XMLs.encodeText(display);
		label.setValue(display);
		
		final int MIN_TOOLTIP_TEXT_LENGTH = MSysConfig.getIntValue(MSysConfig.MIN_TOOLTIP_TEXT_LENGTH_ON_GRID_VIEW, MAX_TEXT_LENGTH_DEFAULT, Env.getAD_Client_ID(Env.getCtx()));
		if (text != null && (text.length() > MAX_TEXT_LENGTH || text.length() > MIN_TOOLTIP_TEXT_LENGTH))
			label.setTooltiptext(text);
	}

	/**
	 *
	 * @return active editor list
	 */
	public List<WEditor> getEditors() {
		List<WEditor> editorList = new ArrayList<WEditor>();
		if (!editors.isEmpty())
			editorList.addAll(editors.values());

		return editorList;
	}
	
	/**
	 * @param paging
	 */
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	/**
	 * Detach all editor and optionally set the current value of the editor as cell label.
	 * @param updateCellLabel
	 */
	public void stopEditing(boolean updateCellLabel) {
		if (!editing) {
			return;
		} else {
			editing = false;
		}
		Row row = null;
		for (Entry<GridField, WEditor> entry : editors.entrySet()) {
			if (entry.getValue().getComponent().getParent() != null) {
				Component child = entry.getValue().getComponent();
				Cell div = null;
				while (div == null && child != null) {
					Component parent = child.getParent();
					if (parent instanceof Cell && parent.getParent() instanceof Row)
						div = (Cell)parent;
					else
						child = parent;
				}
				Component component = div!=null ? (Component) div.getAttribute("display.component") : null;
				if (updateCellLabel) {
					if (component instanceof Label) {
						Label label = (Label)component;
						label.getChildren().clear();
						String text = getDisplayText(entry.getValue().getValue(), entry.getValue().getGridField(), -1);
						setLabelText(text, label);
					} else if (component instanceof Checkbox) {
						Checkbox checkBox = (Checkbox)component;
						Object value = entry.getValue().getValue();
						if (value != null && "true".equalsIgnoreCase(value.toString()))
							checkBox.setChecked(true);
						else
							checkBox.setChecked(false);
					} else if (component instanceof Html){
						((Html)component).setContent(getDisplayText(entry.getValue().getValue(), entry.getValue().getGridField(), -1));
					}
				}
				component.setVisible(true);
				if (row == null)
					row = ((Row)div.getParent());

				entry.getValue().getComponent().detach();
				entry.getKey().removePropertyChangeListener(entry.getValue());
				entry.getValue().removeValuechangeListener(dataBinder);
				
				if (component.getParent() == null || component.getParent() != div)
					div.appendChild(component);
				else if (!component.isVisible()) {
					component.setVisible(true);
				}
			}
		}

		GridTableListModel model = (GridTableListModel) grid.getModel();
		model.setEditing(false);
	}

	/**
	 * @param row
	 * @param data
	 * @see RowRenderer#render(Row, Object)
	 */
	@Override
	public void render(Row row, Object[] data, int index) throws Exception {
		//don't render if not visible
		int columnCount = 0;
		GridField[] gridPanelFields = null;
		GridField[] gridTabFields = null;
		
		if (gridPanel != null) {
			if (!gridPanel.isVisible()) {
				return;
			}
			else{
				gridPanelFields = gridPanel.getFields();
				columnCount = gridPanelFields.length;
				gridTabFields = gridTab.getFields();
				isGridViewCustomized = gridTabFields.length != gridPanelFields.length;
			}	
		}
		
		if (grid == null)
			grid = (Grid) row.getParent().getParent();

		if (rowListener == null)
			rowListener = new RowListener((Grid)row.getParent().getParent());
		
		if (!isGridViewCustomized) {
			for(int i = 0; i < gridTabFields.length; i++) {
				if (gridPanelFields[i].getAD_Field_ID() != gridTabFields[i].getAD_Field_ID()) {
					isGridViewCustomized = true;
					break;
				}
			}
		}
		if (!isGridViewCustomized) {
			currentValues = data;
		} else {
			List<Object> dataList = new ArrayList<Object>();
			for(GridField gridField : gridPanelFields) {
				for(int i = 0; i < gridTabFields.length; i++) {
					if (gridField.getAD_Field_ID() == gridTabFields[i].getAD_Field_ID()) {
						dataList.add(data[i]);
						break;
					}
				}
			}
			currentValues = dataList.toArray(new Object[0]);
		}
		
		
		Grid grid = (Grid) row.getParent().getParent();
		org.zkoss.zul.Columns columns = grid.getColumns();

		int rowIndex = index;
		if (paging != null && paging.getPageSize() > 0) {
			rowIndex = (paging.getActivePage() * paging.getPageSize()) + rowIndex;
		}

		Cell cell = new Cell();
		cell.setTooltiptext(Msg.getMsg(Env.getCtx(), "Select"));
		Checkbox selection = new Checkbox();
		selection.setAttribute(GRID_ROW_INDEX_ATTR, rowIndex);
		selection.setChecked(gridTab.isSelected(rowIndex));
		cell.setStyle("border: none;");
		selection.addEventListener(Events.ON_CHECK, this);
		
		if (!selection.isChecked()) {
			if (gridPanel.selectAll.isChecked()) {
				gridPanel.selectAll.setChecked(false);
			}
		}
		
		cell.appendChild(selection);
		row.appendChild(cell);
		
		Boolean isActive = null;
		int colIndex = -1;
		for (int i = 0; i < columnCount; i++) {
			if (!gridPanelFields[i].isQuickForm()){
				continue;
			}

			if ("IsActive".equals(gridPanelFields[i].getColumnName())) {
				isActive = Boolean.FALSE;
				if (currentValues[i] != null) {
					if ("true".equalsIgnoreCase(currentValues[i].toString())) {
						isActive = Boolean.TRUE;
					}
				}
			}
			
			// IDEMPIERE-2148: when has tab customize, ignore check properties isDisplayedGrid
			if ((!isGridViewCustomized && gridPanelFields[i].isDisplayedGrid()) || gridPanelFields[i].isToolbarOnlyButton()) {
				continue;
			}
			colIndex ++;

			Cell div = new Cell();
			String divStyle = CELL_DIV_STYLE;
			org.zkoss.zul.Column column = (org.zkoss.zul.Column) columns.getChildren().get(colIndex);
			if (column.isVisible()) {
				WEditor componenteditor = getEditorCell(gridPanelFields[i], currentValues[i]);
				componenteditor.getComponent().addEventListener(Events.ON_FOCUS, gridPanel);
				Component component = componenteditor.getComponent();
				div.appendChild(component);
				div.setAttribute("display.component", component);
				if (componenteditor instanceof WPAttributeEditor) {
					((WPAttributeEditor) componenteditor).getComponent().getButton().addEventListener(Events.ON_FOCUS,
							gridPanel);
				} else if (componenteditor instanceof WSearchEditor) {
					((WSearchEditor) componenteditor).getComponent().getButton().addEventListener(Events.ON_FOCUS,
							gridPanel);
				}
				if (gridPanelFields[i].isHeading()) {
					component.setVisible(false);
				}

				if (DisplayType.YesNo == gridPanelFields[i].getDisplayType() || DisplayType.Image == gridPanelFields[i].getDisplayType()) {
					divStyle = CELL_DIV_STYLE_ALIGN_CENTER;
				}
				else if (DisplayType.isNumeric(gridPanelFields[i].getDisplayType())) {
					divStyle = CELL_DIV_STYLE_ALIGN_RIGHT;
				}
				
				GridRowCtx ctx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
				if (!gridPanelFields[i].isDisplayed(ctx, true)){
					// IDEMPIERE-2253 
					component.setVisible(false);
				}
			}
			div.setStyle(divStyle);
			div.setWidth("100%");
			div.setAttribute("columnName", gridPanelFields[i].getColumnName());
			div.addEventListener(Events.ON_CLICK, rowListener);
			div.addEventListener(Events.ON_DOUBLE_CLICK, rowListener);						
			editing = true;
			GridTableListModel model = (GridTableListModel) grid.getModel();
			model.setEditing(true);
			row.appendChild(div);
		}

		if (rowIndex == gridTab.getCurrentRow()) {
			setCurrentRow(row);
		}
		
		row.setStyle("cursor:pointer");
		row.addEventListener(Events.ON_CLICK, rowListener);
		row.addEventListener(Events.ON_OK, rowListener);
		row.setTooltiptext("Row " + (rowIndex+1));
		
		if (isActive == null) {
			Object isActiveValue = gridTab.getValue(rowIndex, "IsActive");
			if (isActiveValue != null) {
				if ("true".equalsIgnoreCase(isActiveValue.toString())) {							
					isActive = Boolean.TRUE;
				} else {
					isActive = Boolean.FALSE;
				}
			}
		}
		if (isActive != null && !isActive.booleanValue()) {
			LayoutUtils.addSclass("grid-inactive-row", row);
		}
		if (currentCell == null || currentCell.getUuid() == null) {
			setCurrentCell(gridTab.getCurrentRow(), 1, KeyEvent.RIGHT);
		}
	}

	private Cell currentCell = null;

	public Cell getCurrentCell() {
		return currentCell;
	}

	public void setCurrentCell(Cell currentCell) {
		this.currentCell = currentCell;
	}

	public void setCurrentCell(int row, int col, int code) {
		if (col < 0)
			return;
		while (!isEditable(row, col)) {
			if (!(code == KeyEvent.RIGHT || code == KeyEvent.LEFT))
				break;
			else if (code == KeyEvent.RIGHT)
				++col;
			else if (code == KeyEvent.LEFT)
				--col;

			if (col < 1) {
				setFocusOnCurrentCell();
				return;
			}
		}

		int pgIndex = row >= 0 ? row % paging.getPageSize() : 0;
		if (row != currentRowIndex || pgIndex != currentRowIndex) {
			if (currentRow != null)
				currentRow.setStyle(null);
			if (grid.getRows().getChildren().size() <= 0) {
				currentCell = null;
				return;
			}
			gridTab.setCurrentRow(pgIndex + paging.getActivePage() * paging.getPageSize());
			currentRow = ((Row) grid.getRows().getChildren().get(pgIndex));
			currentRowIndex = gridTab.getCurrentRow();
			currentRow.setStyle(CURRENT_ROW_STYLE);
		}
		
		setCurrentRow(currentRow);

		if (grid.getCell(pgIndex, col) instanceof Cell) {
			currentCell = (Cell) grid.getCell(pgIndex, col);
		}
		if (currentCell != null && code != 0) {
			setFocusOnCurrentCell();
		} 
	}

	private boolean isEditable(int row, int col) {
		Cell cell = null;

		if (col > getCurrentRow().getChildren().size())
			return true;

		if (grid.getCell(row, col) instanceof Cell)
			cell = (Cell) grid.getCell(row, col);
		else
			return true;

		if (cell == null)
			return true;
		if (cell.getChildren().size() <= 0)
			return false;

		if (cell.getChildren().get(0) instanceof NumberBox
				&& (!((NumberBox) cell.getChildren().get(0)).getDecimalbox().isDisabled()
						&& !((NumberBox) cell.getChildren().get(0)).getDecimalbox().isReadonly()))
			return true;
		else if (cell.getChildren().get(0) instanceof Checkbox && ((Checkbox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof Combobox && ((Combobox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof Textbox && (!((Textbox) cell.getChildren().get(0)).isDisabled()
				&& !((Textbox) cell.getChildren().get(0)).isReadonly()))
			return true;
		else if (cell.getChildren().get(0) instanceof Datebox && ((Datebox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof DatetimeBox
				&& ((DatetimeBox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof Locationbox
				&& ((Locationbox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof Searchbox
				&& (!((Searchbox) cell.getChildren().get(0)).getTextbox().isDisabled()
						&& !((Searchbox) cell.getChildren().get(0)).getTextbox().isReadonly()))
			return true;
		else if (cell.getChildren().get(0) instanceof Button && ((Button) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof Combinationbox
				&& ((Combinationbox) cell.getChildren().get(0)).isEnabled())
			return true;
		else if (cell.getChildren().get(0) instanceof EditorBox && ((EditorBox) cell.getChildren().get(0)).isEnabled())
			return true;
		else
			return false;
	}

	public void setFocusOnCurrentCell() {
		if (currentCell == null || currentCell.getChildren().size() <= 0) {
			return;
		}

		if (currentCell.getChildren().get(0) instanceof NumberBox) {
			((NumberBox) currentCell.getChildren().get(0)).focus();
			((NumberBox) currentCell.getChildren().get(0)).getDecimalbox().select();
		} else if (currentCell.getChildren().get(0) instanceof Checkbox)
			((Checkbox) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof Combobox)
			((Combobox) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof Textbox) {
			((Textbox) currentCell.getChildren().get(0)).focus();
			((Textbox) currentCell.getChildren().get(0)).select();
		} else if (currentCell.getChildren().get(0) instanceof Datebox)
			((Datebox) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof DatetimeBox)
			((DatetimeBox) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof Locationbox)
			((Locationbox) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof Combinationbox) {
			((Combinationbox) currentCell.getChildren().get(0)).getTextbox().focus();
			((Combinationbox) currentCell.getChildren().get(0)).getTextbox().select();
		} else if (currentCell.getChildren().get(0) instanceof Searchbox) {
			((Searchbox) currentCell.getChildren().get(0)).getTextbox().focus();
			((Searchbox) currentCell.getChildren().get(0)).getTextbox().select();
		} else if (currentCell.getChildren().get(0) instanceof Button)
			((Button) currentCell.getChildren().get(0)).focus();
		else if (currentCell.getChildren().get(0) instanceof EditorBox)
			((EditorBox) currentCell.getChildren().get(0)).focus();
		else
			((HtmlBasedComponent) currentCell).focus();
	} // setFocusOnCurrentCell

	/**
	 * @param row
	 */
	public void setCurrentRow(Row row) {
		if (currentRow != null && currentRow.getParent() != null && currentRow != row) {
			Cell cell = (Cell) currentRow.getChildren().get(1);
			if (cell != null) {
				cell.setSclass("row-indicator");
			}
		}
		currentRow = row;
		if (currentRow.getChildren().size() > 1)
		{
			Cell cell = (Cell) currentRow.getChildren().get(1);
			if (cell != null)
			{
				cell.setSclass("row-indicator-selected");
			}
		}

		String script = "jq('#" + row.getUuid() + "').addClass('highlight').siblings().removeClass('highlight')";

		Boolean isActive = null;
		Object isActiveValue = gridTab.getValue(currentRowIndex, "IsActive");
		if (isActiveValue != null) {
			if ("true".equalsIgnoreCase(isActiveValue.toString())) {							
				isActive = Boolean.TRUE;
			} else {
				isActive = Boolean.FALSE;
			}
		}
		if (isActive != null && !isActive.booleanValue()) {
			script = "jq('#"+row.getUuid()+"').addClass('grid-inactive-row').siblings().removeClass('highlight')";
		}
		
		Clients.response(new AuScript(script));
	}

	/**
	 * @return Row
	 */
	public Row getCurrentRow() {
		return currentRow;
	}

	/**
	 * @return current row index ( absolute )
	 */
	public int getCurrentRowIndex() {
		return currentRowIndex;
	}

	/**
	 * Enter edit mode
	 */
	public void editCurrentRow() {
		if (currentRow != null && currentRow.getParent() != null && currentRow.isVisible() && grid != null
				&& grid.isVisible() && grid.getParent() != null && grid.getParent().isVisible()) {
		
			editing = true;

			GridTableListModel model = (GridTableListModel) grid.getModel();
			model.setEditing(true);
		}
	}

	/**
	 * @see RowRendererExt#getControls()
	 */
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	/**
	 * @see RowRendererExt#newCell(Row)
	 */
	public Component newCell(Row row) {
		return null;
	}

	/**
	 * @see RowRendererExt#newRow(Grid)
	 */
	public Row newRow(Grid grid) {
		return null;
	}

	/**
	 * @see RendererCtrl#doCatch(Throwable)
	 */
	public void doCatch(Throwable ex) throws Throwable {
	}

	/**
	 * @see RendererCtrl#doFinally()
	 */
	public void doFinally() {
	}

	/**
	 * @see RendererCtrl#doTry()
	 */
	public void doTry() {
	}

	/**
	 * set focus to first active editor
	 */
	public void focusToFirstEditor() {
		if (currentRow != null && currentRow.getParent() != null) {
			WEditor toFocus = null;
			WEditor firstEditor = null;
			if (defaultFocusField != null 
					&& defaultFocusField.isVisible() && defaultFocusField.isReadWrite() && defaultFocusField.getComponent().getParent() != null
					&& !(defaultFocusField instanceof WImageEditor)) {
				toFocus = defaultFocusField;
			}
			else
			{
				for (WEditor editor : getEditors()) {
					if (editor.isVisible() && editor.getComponent().getParent() != null) {
						if (editor.isReadWrite()) {
							toFocus = editor;
							break;
						}
						if (firstEditor == null)
							firstEditor = editor;
					}
				}
			}
			if (toFocus != null) {
				focusToEditor(toFocus);
			} else if (firstEditor != null) {
				focusToEditor(firstEditor);
			}
		}
	}

	protected void focusToEditor(WEditor toFocus) {
		Component c = toFocus.getComponent();
		if (c instanceof EditorBox) {
			c = ((EditorBox)c).getTextbox();
		} else if (c instanceof NumberBox) {
			c = ((NumberBox)c).getDecimalbox();
		} else if (c instanceof Urlbox) {
			c = ((Urlbox) c).getTextbox();
		}
		((HtmlBasedComponent)c).focus();
	}
	
	/**
	 * set focus to next readwrite editor from ref
	 * @param ref
	 */
	public void focusToNextEditor(WEditor ref) {
		boolean found = false;
		for (WEditor editor : getEditors()) {
			if (editor == ref) {
				found = true;
				continue;
			}
			if (found) {
				if (editor.isVisible() && editor.isReadWrite()) {
					focusToEditor(editor);
					break;
				}
			}
		}
	}

	/**
	 *
	 * @param gridPanel
	 */
	public void setGridPanel(QuickGridView gridPanel) {
		this.gridPanel = gridPanel;
	}

	static class RowListener implements EventListener<Event> {

		private Grid _grid;

		public RowListener(Grid grid) {
			_grid = grid;
		}

		public void onEvent(Event event) throws Exception {
			if (Events.ON_CLICK.equals(event.getName())) {
				if (Executions.getCurrent().getAttribute("gridView.onSelectRow") != null)
					return;
				Event evt = new Event(Events.ON_CLICK, _grid, event.getTarget());
				Events.sendEvent(_grid, evt);
				evt.stopPropagation();
			}
			else if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
				Event evt = new Event(Events.ON_DOUBLE_CLICK, _grid, _grid);
				Events.sendEvent(_grid, evt);
			}
			else if (Events.ON_OK.equals(event.getName())) {
				Event evt = new Event(Events.ON_OK, _grid, _grid);
				Events.sendEvent(_grid, evt);
			}
		}
	}

	/**
	 * @return boolean
	 */
	public boolean isEditing() {
		return editing;
	}

	/**
	 * @param windowPanel
	 */
	public void setADWindowPanel(AbstractADWindowContent windowPanel) {
		if (this.m_windowPanel == windowPanel)
			return;
		
		this.m_windowPanel = windowPanel;
		
		buttonListener = new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				WButtonEditor editor = (WButtonEditor) event.getSource();
				Integer rowIndex = (Integer) editor.getComponent().getAttribute(GRID_ROW_INDEX_ATTR);
				if (rowIndex != null) {
					int newRowIndex = gridTab.navigate(rowIndex);
					if (newRowIndex == rowIndex) {
						m_windowPanel.actionPerformed(event);
					}
				} else {
					m_windowPanel.actionPerformed(event);
				}
			}
		};
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() instanceof Cell) {
			Cell cell = (Cell) event.getTarget();
			if (cell.getSclass() != null && cell.getSclass().indexOf("row-indicator-selected") >= 0)
				Events.sendEvent(gridPanel, new Event(DetailPane.ON_EDIT_EVENT, gridPanel));
			else
				Events.sendEvent(event.getTarget().getParent(), event);
		} else if (event.getTarget() instanceof Checkbox) {
			Executions.getCurrent().setAttribute("gridView.onSelectRow", Boolean.TRUE);
			Checkbox checkBox = (Checkbox) event.getTarget();
			Events.sendEvent(gridPanel, new Event("onSelectRow", gridPanel, checkBox));
		}
	}

	
}
