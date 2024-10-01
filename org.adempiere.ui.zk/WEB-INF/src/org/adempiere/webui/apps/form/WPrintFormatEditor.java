package org.adempiere.webui.apps.form;

import java.util.List;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Group;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WYesNoEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.panel.WPrintFormatEditorForm;
import org.adempiere.webui.print.elements.WBoxElement;
import org.adempiere.webui.print.elements.WFieldElement;
import org.adempiere.webui.print.elements.WImageElement;
import org.adempiere.webui.print.elements.WPrintFormatElement;
import org.adempiere.webui.print.elements.WPrintFormatItem;
import org.adempiere.webui.print.elements.WStringElement;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.form.PrintFormatEditor;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MPrintFormatAccess;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Center;
import org.zkoss.zul.East;
import org.zkoss.zul.West;

public class WPrintFormatEditor extends PrintFormatEditor
		implements IFormController, EventListener<Event>, ValueChangeListener {

	/**
	 * @author Jonatas Silvestrini (jonatas.silvestrini@devcoffee.com.br,
	 *         https://www.devcoffee.com.br)
	 */

	private MPrintFormat mpf;

	private WPrintFormatEditorForm formEditor = null;

	private Borderlayout mainLayout = new Borderlayout();
	private West formatTypePanel = new West();
	private Center mainPanel = new Center();
	private East propertiesPanel = new East();

	private String currentTypeSelected = "null";

	// Paper
	Panel paperArea = new Panel();
	Panel editorArea;

	// Print Format Options
	private WEditor editorPaperSize = null;
	private WEditor editorPrintFontPaper = null;
	private WEditor editorPrintColorPaper = null;

	private ConfirmPanel confirmPanel = new ConfirmPanel(true);

	// Always visible options
	private WEditor editorName = null;
	private WEditor editorSeq = null;

	// Common options
	private WEditor editorPrintText = null;
	private WYesNoEditor editorIsRelative = null;

	// Relative Options
	private WYesNoEditor editorIsNextLine = null;
	private WYesNoEditor editorIsNextPage = null;
	private WEditor editorAlignLine = null; // lookup
	private WEditor editorSpaceX = null;
	private WEditor editorSpaceY = null;
	//

	private WEditor editorPosX = null;
	private WEditor editorPosY = null;
	private WYesNoEditor editorIsSetNLPosition = null;
	private WEditor editorAlignField = null; // lookup
	private WEditor editorMaxWidth = null;
	private WEditor editorMaxHeight = null;
	private WYesNoEditor editorIsFixedWidth = null;
	private WYesNoEditor editorIsHeightOneLine = null;
	private WEditor editorPrintColor = null; // lookup
	private WEditor editorPrintFont = null; // lookup
	private WEditor editorColumn = null; // lookup

	private int seqNo;

	// Field Options
	private WEditor editorBarCode = null; // lookup

	// Print Format Options
	private WEditor editorPrintFormat = null; // lookup

	// Image Options
	private WYesNoEditor editorIsImageField = null;
	private WYesNoEditor editorImageIsAttached = null;
	private WEditor editorImageURL = null;

	// Line Options
	private WEditor editorLineWidth = null;

	// Rectangle Options
	private WEditor editorTypeRectangle = null; // lookup
	private WYesNoEditor editorIsFilledRectangle = null;

	private Row rowPrintText = new Row();
	private Row rowIsRelative = new Row();
	private Row rowIsNextLine = new Row();
	private Row rowIsNextPage = new Row();
	private Row rowAligLine = new Row();
	private Row rowSpaceX = new Row();
	private Row rowSpaceY = new Row();
	private Row rowPosX = new Row();
	private Row rowPosY = new Row();
	private Row rowIsSetNLPosition = new Row();
	private Row rowAligField = new Row();
	private Row rowMaxWidth = new Row();
	private Row rowMaxHeight = new Row();
	private Row rowIsFixedWidth = new Row();
	private Row rowIsHeightOneLine = new Row();
	private Row rowPrintColor = new Row();
	private Row rowPrintFont = new Row();
	private Row rowColumn = new Row();
	private Row rowBarCode = new Row();
	private Row rowPrintFormat = new Row();
	private Row rowIsImageField = new Row();
	private Row rowImageIsAttached = new Row();
	private Row rowImageURL = new Row();
	private Row rowLineWidth = new Row();
	private Row rowTypeRectangle = new Row();
	private Row rowIsFilledRectangle = new Row();
	private Row rowFormatPattern = new Row();
	private Row rowAlignLine = new Row();

	private List<MPrintFormatItem> mpiList;

	public static int PRINTPAPER_Color;
	public static int PRINTPAPER_Font;
	public static String widthAreaEditor;

	// Elements
	private WBoxElement wBox;
	private WStringElement wString;
	private WImageElement wImage;
	private WFieldElement wField;
	private WPrintFormatElement wPrintFormat;

	private boolean isUpdatable = true;

	public WPrintFormatEditor() {
		formEditor = new WPrintFormatEditorForm(this);
	}

	@Override
	public ADForm getForm() {
		return formEditor;
	}

	public void initForm() throws Exception {

		isUpdatable = (MRole.getDefault().getWindowAccess(240)== true)//access to Print format Window
						&& MPrintFormatAccess.isWriteAccessPrintFormat(formEditor.getProcessInfo().getRecord_ID(), null);
		mpf = new MPrintFormat(Env.getCtx(), formEditor.getProcessInfo().getRecord_ID(), null);
		Env.setContext(Env.getCtx(), this.getForm().getWindowNo(), "AD_Table_ID", mpf.getAD_Table_ID());
		mpiList = loadMPrintFormatItem(formEditor.getProcessInfo().getRecord_ID());

		formProperties();
		mountPanels();
	}

	private void formProperties() {
		formEditor.setMaximizable(true);
		formEditor.setClosable(true);
		formEditor.setSizable(true);
		ZKUpdateUtil.setHflex(formEditor, "95%");
		ZKUpdateUtil.setWidth(formEditor, "95%");
	}

	private void mountPanels() throws Exception {
		mountPropertiesPanel();
		mountFormatTypePanel();
		mountMainPanel();
		mainPanel.appendChild(paperArea);
		mainLayout.appendChild(formatTypePanel);
		mainLayout.appendChild(mainPanel);
		mainLayout.appendChild(propertiesPanel);
		formEditor.appendChild(mainLayout);
	}

	private void mountFormatTypePanel() {

		Grid gridView = GridFactory.newGridLayout();

		ZKUpdateUtil.setWidth(formatTypePanel, "135px");

		Rows rows = new Rows();

		List<String> names = getFormatTypeName();

		for (String nameType : names) {
			Row row = new Row();
			Button name = new Button(nameType);
			name.setEnabled(isUpdatable);
			name.setWidth("115px");
			name.addEventListener(Events.ON_CLICK, this);
			row.appendChild(name);
			rows.appendChild(row);
		}

		gridView.appendChild(rows);

		formatTypePanel.appendChild(gridView);
	}

	private void mountMainPanel() {

		mainPanel.setStyle("background-color: #f2f2f2;overflow:auto");

		editorArea = new Panel();

		loadPaperProperties();

		loadItens();

	}

	public void loadItens() {
		seqNo = 10;
		for (MPrintFormatItem item : mpiList) {
			item.setSeqNo(seqNo);
			String type = item.getPrintFormatType();
			if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Line)
					|| type.equals(MPrintFormatItem.PRINTFORMATTYPE_Rectangle)) {
				WPrintFormatItem box = new WPrintFormatItem(Env.getCtx(), item.get_ID(), null);
				box.setPrintFormatType(item.getPrintFormatType());
				box.setIsRelativePosition(item.isRelativePosition());
				box.setXPosition(item.getXPosition());
				box.setYPosition(item.getYPosition());
				box.setMaxWidth(item.getMaxWidth());
				box.setMaxHeight(item.getMaxHeight());
				box.setLineWidth(item.getLineWidth());
				box.setName(item.getName());
				box.setSeqNo(item.getSeqNo());
				box.setAD_PrintColor_ID(item.getAD_PrintColor_ID());
				box.setAD_PrintFormat_ID(item.getAD_PrintFormat_ID());
				box.setAD_Org_ID(item.getAD_Org_ID());
				box.setFieldAlignmentType(item.getFieldAlignmentType());
				WBoxElement wBox = box.createBoxElement();
				wBox.setVisible(isUpdatable);
				wBox.addEventListener(Events.ON_CLICK, this);
				editorArea.appendChild(wBox);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Text)) {
				WPrintFormatItem text = new WPrintFormatItem(Env.getCtx(), item.get_ID(), null);
				text.setPrintFormatType(item.getPrintFormatType());
				text.setIsRelativePosition(item.isRelativePosition());
				text.setPrintName(item.getPrintName());
				text.setXPosition(item.getXPosition());
				text.setYPosition(item.getYPosition());
				text.setMaxWidth(item.getMaxWidth());
				text.setMaxHeight(item.getMaxHeight());
				text.setAD_PrintColor_ID(item.getAD_PrintColor_ID());
				text.setName(item.getName());
				text.setSeqNo(item.getSeqNo());
				text.setAD_Org_ID(item.getAD_Org_ID());
				text.setFieldAlignmentType(item.getFieldAlignmentType());
				WStringElement wString = text.createStringElement();
				wString.setVisible(isUpdatable);
				wString.addEventListener(Events.ON_CLICK, this);
				editorArea.appendChild(wString);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Field)) {
				WPrintFormatItem field = new WPrintFormatItem(Env.getCtx(), item.get_ID(), null);
				field.setPrintFormatType(item.getPrintFormatType());
				field.setIsRelativePosition(item.isRelativePosition());
				field.setPrintName(item.getPrintName());
				field.setXPosition(item.getXPosition());
				field.setYPosition(item.getYPosition());
				field.setMaxWidth(item.getMaxWidth());
				field.setMaxHeight(item.getMaxHeight());
				field.setAD_Column_ID(item.getAD_Column_ID());
				field.setName(item.getName());
				field.setSeqNo(item.getSeqNo());
				field.setAD_PrintFormat_ID(item.getAD_PrintFormat_ID());
				field.setAD_PrintColor_ID(item.getAD_PrintColor_ID());
				field.setAD_Org_ID(item.getAD_Org_ID());
				field.setFieldAlignmentType(item.getFieldAlignmentType());
				WFieldElement wField = field.createFieldElement();
				wField.setVisible(isUpdatable);
				wField.addEventListener(Events.ON_CLICK, this);
				editorArea.appendChild(wField);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {
				WPrintFormatItem image = new WPrintFormatItem(Env.getCtx(), item.get_ID(), null);
				image.setPrintFormatType(item.getPrintFormatType());
				image.setIsRelativePosition(item.isRelativePosition());
				image.setXPosition(item.getXPosition());
				image.setYPosition(item.getYPosition());
				image.setMaxWidth(item.getMaxWidth());
				image.setMaxHeight(item.getMaxHeight());
				image.setName(item.getName());
				image.setSeqNo(item.getSeqNo());
				image.setImageURL(item.getImageURL());
				WImageElement wImage = image.createImageElement();
				wImage.setVisible(isUpdatable);
				wImage.addEventListener(Events.ON_CLICK, this);
				editorArea.appendChild(wImage);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
				WPrintFormatItem printFormat = new WPrintFormatItem(Env.getCtx(), item.get_ID(), null);
				printFormat.setPrintFormatType(item.getPrintFormatType());
				printFormat.setIsRelativePosition(item.isRelativePosition());
				printFormat.setPrintName(item.getPrintName());
				printFormat.setXPosition(item.getXPosition());
				printFormat.setYPosition(item.getYPosition());
				printFormat.setAD_Column_ID(item.getAD_Column_ID());
				printFormat.setAD_PrintFormatChild_ID(item.getAD_PrintFormatChild_ID());
				printFormat.setName(item.getName());
				printFormat.setSeqNo(item.getSeqNo());
				printFormat.setAD_PrintFormat_ID(item.getAD_PrintFormat_ID());
				printFormat.setAD_Org_ID(item.getAD_Org_ID());
				WPrintFormatElement wPrintFormat = printFormat.createPrintFormatElement();
				wPrintFormat.setVisible(isUpdatable);
				wPrintFormat.addEventListener(Events.ON_CLICK, this);
				editorArea.appendChild(wPrintFormat);

			}
			seqNo += 10;
		}
	}

	public void loadPaperProperties() {

		setPaperDimensions(mpf.getAD_PrintPaper_ID());
		editorPaperSize.setValue(printPaper.getAD_PrintPaper_ID());

		paperArea.appendChild(editorArea);

		paperArea.setWidth(paperWidth + "px");
		paperArea.setHeight(paperHeight + "px");
		paperArea.setStyle("border: 1px solid rgba(0,0,0,0.3); " + "margin: auto; " + "margin-top: 25px;"
				+ "background-color: white;");

		editorArea.setStyle("margin-top: " + marginTop + "px;" + "margin-bottom: " + marginBottom + "px;"
				+ "margin-left: " + marginLeft + "px;" + "margin-right: " + marginRight + "px;" + "width: 100%;"
				+ "height: 100%;" + "position: relative;");

		widthAreaEditor = Integer
				.toString(Integer.parseInt(paperWidth) - Integer.parseInt(marginLeft) - Integer.parseInt(marginRight));
		PRINTPAPER_Color = mpf.getAD_PrintColor_ID();
		PRINTPAPER_Font = mpf.getAD_PrintFont_ID();

	}

	private void mountPropertiesPanel() throws Exception {

		ZKUpdateUtil.setWidth(propertiesPanel, "260px");
		Grid gridView = GridFactory.newGridLayout();
		gridView.setVflex(true);

		Rows rows = new Rows();
		Row row = null;

		Group printProps = new Group("Print");
		printProps.setOpen(true);
		rows.appendChild(printProps);

		row = new Row();
		Label labelPaperSize = new Label(Msg.getElement(Env.getCtx(), MPrintFormat.COLUMNNAME_AD_PrintPaper_ID));
		MLookup lookupPaperID = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 6997,
				DisplayType.TableDir);
		editorPaperSize = new WTableDirEditor(MPrintFormat.COLUMNNAME_AD_PrintPaper_ID, false, false, true,
				lookupPaperID);
		editorPaperSize.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPaperSize).getComponent(), "1");
		row.appendChild(labelPaperSize.rightAlign());
		row.appendChild(editorPaperSize.getComponent());
		editorPaperSize.addValueChangeListener(this);
		row.setGroup(printProps);
		rows.appendChild(row);

		row = new Row();
		Label labelPrintColorPaper = new Label(Msg.getElement(Env.getCtx(), MPrintFormat.COLUMNNAME_AD_PrintColor_ID));
		MLookup lookupPrintColorPaper = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 7017,
				DisplayType.TableDir);
		editorPrintColorPaper = new WTableDirEditor(MPrintFormat.COLUMNNAME_AD_PrintColor_ID, false, false, true,
				lookupPrintColorPaper);
		editorPrintColorPaper.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPrintColorPaper).getComponent(), "1");
		row.appendChild(labelPrintColorPaper.rightAlign());
		row.appendChild(editorPrintColorPaper.getComponent());
		row.setGroup(printProps);
		editorPrintColorPaper.addValueChangeListener(this);
		rows.appendChild(row);

		row = new Row();
		Label labelPrintFontPaper = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID));
		MLookup lookupPrintFontPaper = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 6989,
				DisplayType.TableDir);
		editorPrintFontPaper = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID, false, false, true,
				lookupPrintFontPaper);
		editorPrintFontPaper.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPrintFontPaper).getComponent(), "1");
		row.appendChild(labelPrintFontPaper.rightAlign());
		row.appendChild(editorPrintFontPaper.getComponent());
		row.setGroup(printProps);
		editorPrintFontPaper.addValueChangeListener(this);
		rows.appendChild(row);

		Group formatItemProps = new Group("Format Item");
		formatItemProps.setOpen(true);
		rows.appendChild(formatItemProps);

		MLookupInfo info;

		row = new Row();
		Label labelName = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_Name));
		editorName = new WStringEditor(MPrintFormatItem.COLUMNNAME_Name, false, false, true, 1000, 1000, null, null);
		editorName.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WStringEditor) editorName).getComponent(), "1");
		row.appendChild(labelName.rightAlign());
		row.appendChild(editorName.getComponent());
		row.setGroup(formatItemProps);
		editorName.addValueChangeListener(this);
		rows.appendChild(row);

		row = new Row();
		Label labelSeq = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_SeqNo));
		editorSeq = new WNumberEditor(MPrintFormatItem.COLUMNNAME_SeqNo, true, false, true, DisplayType.Integer,
				labelSeq.getValue());
		editorSeq.setReadWrite(isUpdatable);
		row.appendChild(labelSeq.rightAlign());
		row.appendChild(editorSeq.getComponent());
		row.setGroup(formatItemProps);
		editorSeq.addValueChangeListener(this);
		rows.appendChild(row);

		// Common Options

		// PrintAreaType - Lookup

		Label labelPrintText = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_PrintName));
		editorPrintText = new WStringEditor(MPrintFormatItem.COLUMNNAME_PrintName, false, false, true, 1000, 1000, null,
				null);
		editorPrintText.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WStringEditor) editorPrintText).getComponent(), "1");
		rowPrintText.appendChild(labelPrintText.rightAlign());
		rowPrintText.appendChild(editorPrintText.getComponent());
		rowPrintText.setGroup(formatItemProps);
		editorPrintText.addValueChangeListener(this);
		rowPrintText.setVisible(false);
		rows.appendChild(rowPrintText);

		// Column -- lookup
		Label labelColumn = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_AD_Column_ID));
		MLookup lookupColumn = MLookupFactory.get(Env.getCtx(), getForm().getWindowNo(), 0,
				MColumn.getColumn_ID(MPrintFormatItem.Table_Name, MPrintFormatItem.COLUMNNAME_AD_Column_ID),
				DisplayType.TableDir);
		editorColumn = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_AD_Column_ID, false, false, true, lookupColumn);
		editorColumn.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorColumn).getComponent(), "1");
		rowColumn.appendChild(labelColumn.rightAlign());
		rowColumn.appendChild(editorColumn.getComponent());
		rowColumn.setGroup(formatItemProps);
		editorColumn.addValueChangeListener(this);
		rowColumn.setVisible(false);
		rows.appendChild(rowColumn);

		// PrintColor -- lookup
		Label labelPrintColor = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID));
		MLookup lookupPrintColor = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 7017,
				DisplayType.TableDir);
		editorPrintColor = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID, false, false, true,
				lookupPrintColor);
		editorPrintColor.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPrintColor).getComponent(), "1");
		rowPrintColor.appendChild(labelPrintColor.rightAlign());
		rowPrintColor.appendChild(editorPrintColor.getComponent());
		rowPrintColor.setGroup(formatItemProps);
		editorPrintColor.addValueChangeListener(this);
		rowPrintColor.setVisible(false);
		rows.appendChild(rowPrintColor);

		// PrintFont -- lookup
		Label labelPrintFont = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID));
		MLookup lookupPrintFont = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 6989,
				DisplayType.TableDir);
		editorPrintFont = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID, false, false, true,
				lookupPrintFont);
		editorPrintFont.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPrintFont).getComponent(), "1");
		rowPrintFont.appendChild(labelPrintFont.rightAlign());
		rowPrintFont.appendChild(editorPrintFont.getComponent());
		rowPrintFont.setGroup(formatItemProps);
		editorPrintFont.addValueChangeListener(this);
		rowPrintFont.setVisible(false);
		rows.appendChild(rowPrintFont);

		Label labelIsRelative = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsRelativePosition));
		editorIsRelative = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsRelativePosition, "", "", true, false, true);
		editorIsRelative.setReadWrite(isUpdatable);
		rowIsRelative.appendCellChild(labelIsRelative.rightAlign());
		rowIsRelative.appendChild(editorIsRelative.getComponent());
		rowIsRelative.setGroup(formatItemProps);
		editorIsRelative.addValueChangeListener(this);
		rowIsRelative.setVisible(false);
		rows.appendChild(rowIsRelative);

		Label labelPosX = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_XPosition));
		editorPosX = new WNumberEditor(MPrintFormatItem.COLUMNNAME_XPosition, true, false, true, DisplayType.Integer,
				labelPosX.getValue());
		editorPosX.setReadWrite(isUpdatable);
		rowPosX.appendChild(labelPosX.rightAlign());
		rowPosX.appendChild(editorPosX.getComponent());
		rowPosX.setGroup(formatItemProps);
		editorPosX.addValueChangeListener(this);
		rowPosX.setVisible(false);
		rows.appendChild(rowPosX);

		Label labelPosY = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_YPosition));
		editorPosY = new WNumberEditor(MPrintFormatItem.COLUMNNAME_YPosition, true, false, true, DisplayType.Integer,
				labelPosX.getValue());
		editorPosY.setReadWrite(isUpdatable);
		rowPosY.appendChild(labelPosY.rightAlign());
		rowPosY.appendChild(editorPosY.getComponent());
		rowPosY.setGroup(formatItemProps);
		editorPosY.addValueChangeListener(this);
		rowPosY.setVisible(false);
		rows.appendChild(rowPosY);

		Label labelSpaceX = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_XSpace));
		editorSpaceX = new WNumberEditor(MPrintFormatItem.COLUMNNAME_XSpace, true, false, true, DisplayType.Integer,
				labelSpaceX.getValue());
		editorSpaceX.setReadWrite(isUpdatable);
		rowSpaceX.appendChild(labelSpaceX.rightAlign());
		rowSpaceX.setGroup(formatItemProps);
		rowSpaceX.appendChild(editorSpaceX.getComponent());
		editorSpaceX.addValueChangeListener(this);
		rowSpaceX.setVisible(false);
		rows.appendChild(rowSpaceX);

		Label labelSpaceY = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_YSpace));
		editorSpaceY = new WNumberEditor(MPrintFormatItem.COLUMNNAME_YSpace, true, false, true, DisplayType.Integer,
				labelSpaceX.getValue());
		editorSpaceY.setReadWrite(isUpdatable);
		rowSpaceY.appendChild(labelSpaceY.rightAlign());
		rowSpaceY.appendChild(editorSpaceY.getComponent());
		editorSpaceY.addValueChangeListener(this);
		rowSpaceY.setVisible(false);
		rows.appendChild(rowSpaceY);

		Label labelIsNextLine = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsNextLine));
		editorIsNextLine = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsNextLine, "", "", true, false, true);
		editorIsNextLine.setReadWrite(isUpdatable);
		rowIsNextLine.appendCellChild(labelIsNextLine.rightAlign());
		rowIsNextLine.appendChild(editorIsNextLine.getComponent());
		rowIsNextLine.setGroup(formatItemProps);
		editorIsNextLine.addValueChangeListener(this);
		rowIsNextLine.setVisible(false);
		rows.appendChild(rowIsNextLine);

		Label labelIsNextPage = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsNextPage));
		editorIsNextPage = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsNextPage, "", "", true, false, true);
		editorIsNextPage.setReadWrite(isUpdatable);
		rowIsNextPage.appendCellChild(labelIsNextPage.rightAlign());
		rowIsNextPage.appendChild(editorIsNextPage.getComponent());
		rowIsNextPage.setGroup(formatItemProps);
		editorIsNextPage.addValueChangeListener(this);
		rowIsNextPage.setVisible(false);
		rows.appendChild(rowIsNextPage);

		Label labelIsSetNLPosition = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsSetNLPosition));
		editorIsSetNLPosition = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsSetNLPosition, "", "", true, false,
				true);
		editorIsSetNLPosition.setReadWrite(isUpdatable);
		rowIsSetNLPosition.appendCellChild(labelIsSetNLPosition.rightAlign());
		rowIsSetNLPosition.appendChild(editorIsSetNLPosition.getComponent());
		rowIsSetNLPosition.setGroup(formatItemProps);
		editorIsSetNLPosition.addValueChangeListener(this);
		rowIsSetNLPosition.setVisible(false);
		rows.appendChild(rowIsSetNLPosition);

		// AligField -- Lookup
		Label labelFieldAlignmentType = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_FieldAlignmentType));
		info = MLookupFactory.getLookup_List(Env.getLanguage(Env.getCtx()), 253);
		MLookup lookupFieldAlignmentType = new MLookup(info, 0);
		editorAlignField = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_FieldAlignmentType, false, false, true,
				lookupFieldAlignmentType);
		editorAlignField.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorAlignField).getComponent(), "1");
		rowAligField.appendChild(labelFieldAlignmentType.rightAlign());
		rowAligField.appendChild(editorAlignField.getComponent());
		rowAligField.setGroup(formatItemProps);
		editorAlignField.addValueChangeListener(this);
		rowAligField.setVisible(false);
		rows.appendChild(rowAligField);

		Label labelMaxWidth = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_MaxWidth));
		editorMaxWidth = new WNumberEditor(MPrintFormatItem.COLUMNNAME_MaxWidth, true, false, true, DisplayType.Integer,
				labelMaxWidth.getValue());
		editorMaxWidth.setReadWrite(isUpdatable);
		rowMaxWidth.appendChild(labelMaxWidth.rightAlign());
		rowMaxWidth.appendChild(editorMaxWidth.getComponent());
		rowMaxWidth.setGroup(formatItemProps);
		editorMaxWidth.addValueChangeListener(this);
		rowMaxWidth.setVisible(false);
		rows.appendChild(rowMaxWidth);

		Label labelMaxHeight = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_MaxHeight));
		editorMaxHeight = new WNumberEditor(MPrintFormatItem.COLUMNNAME_MaxHeight, true, false, true,
				DisplayType.Integer, labelMaxHeight.getValue());
		editorMaxHeight.setReadWrite(isUpdatable);
		rowMaxHeight.appendChild(labelMaxHeight.rightAlign());
		rowMaxHeight.appendChild(editorMaxHeight.getComponent());
		rowMaxHeight.setGroup(formatItemProps);
		editorMaxHeight.addValueChangeListener(this);
		rowMaxHeight.setVisible(false);
		rows.appendChild(rowMaxHeight);

		Label labelIsFixedWidth = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsFixedWidth));
		editorIsFixedWidth = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsFixedWidth, "", "", true, false, true);
		editorIsFixedWidth.setReadWrite(isUpdatable);
		rowIsFixedWidth.appendCellChild(labelIsFixedWidth.rightAlign());
		rowIsFixedWidth.appendChild(editorIsFixedWidth.getComponent());
		rowIsFixedWidth.setGroup(formatItemProps);
		editorIsFixedWidth.addValueChangeListener(this);
		rowIsFixedWidth.setVisible(false);
		rows.appendChild(rowIsFixedWidth);

		Label labelIsHeightOneLine = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsHeightOneLine));
		editorIsHeightOneLine = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsHeightOneLine, "", "", true, false,
				true);
		editorIsHeightOneLine.setReadWrite(isUpdatable);
		rowIsHeightOneLine.appendCellChild(labelIsHeightOneLine.rightAlign());
		rowIsHeightOneLine.appendChild(editorIsHeightOneLine.getComponent());
		rowIsHeightOneLine.setGroup(formatItemProps);
		editorIsHeightOneLine.addValueChangeListener(this);
		rowIsHeightOneLine.setVisible(false);
		rows.appendChild(rowIsHeightOneLine);

		// Relative Options

		// editorAlignLine -- lookup
		Label labelAlignLine = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_LineAlignmentType));
		info = MLookupFactory.getLookup_List(Env.getLanguage(Env.getCtx()), 254);
		MLookup lookupAlignLine = new MLookup(info, 0);
		editorAlignLine = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_LineAlignmentType, false, false, true,
				lookupAlignLine);
		editorAlignLine.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorAlignLine).getComponent(), "1");
		rowAlignLine.appendChild(labelAlignLine.rightAlign());
		rowAlignLine.appendChild(editorAlignLine.getComponent());
		rowAlignLine.setGroup(formatItemProps);
		editorAlignLine.addValueChangeListener(this);
		rowAlignLine.setVisible(false);
		rows.appendChild(rowAlignLine);

		// Field Options
		// editorBarCode -- lookup
		Label labelBarCode = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_BarcodeType));
		info = MLookupFactory.getLookup_List(Env.getLanguage(Env.getCtx()), 15015);
		MLookup lookupBarCode = new MLookup(info, 0);
		editorBarCode = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_BarcodeType, false, false, true, lookupBarCode);
		editorBarCode.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorBarCode).getComponent(), "1");
		rowBarCode.appendChild(labelBarCode.rightAlign());
		rowBarCode.setGroup(formatItemProps);
		rowBarCode.appendChild(editorBarCode.getComponent());
		editorBarCode.addValueChangeListener(this);
		rowBarCode.setVisible(false);
		rows.appendChild(rowBarCode);

		// Print Format Options
		// editorPrintFormat -- lookup
		Label labelPrintFormat = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID));
		MLookup lookupPrintFormat = MLookupFactory.get(Env.getCtx(), formEditor.getWindowNo(), 0, 12470,
				DisplayType.Table);
		editorPrintFormat = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID, false, false, true,
				lookupPrintFormat);
		editorPrintFormat.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorPrintFormat).getComponent(), "1");
		rowPrintFormat.appendChild(labelPrintFormat.rightAlign());
		rowPrintFormat.setGroup(formatItemProps);
		rowPrintFormat.appendChild(editorPrintFormat.getComponent());
		editorPrintFormat.addValueChangeListener(this);
		rowPrintFormat.setVisible(false);
		rows.appendChild(rowPrintFormat);

		// Image Options
		Label labelIsImageField = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsImageField));
		editorIsImageField = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsNextLine, "", "", true, false, true);
		editorIsImageField.setReadWrite(isUpdatable);
		rowIsImageField.appendCellChild(labelIsImageField.rightAlign());
		rowIsImageField.appendChild(editorIsImageField.getComponent());
		rowIsImageField.setGroup(formatItemProps);
		editorIsImageField.addValueChangeListener(this);
		rowIsImageField.setVisible(false);
		rows.appendChild(rowIsImageField);

		Label labelImageIsAttached = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_ImageIsAttached));
		editorImageIsAttached = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_ImageIsAttached, "", "", true, false,
				true);
		editorImageIsAttached.setReadWrite(isUpdatable);
		rowImageIsAttached.appendCellChild(labelImageIsAttached.rightAlign());
		rowImageIsAttached.appendChild(editorImageIsAttached.getComponent());
		rowImageIsAttached.setGroup(formatItemProps);
		editorImageIsAttached.addValueChangeListener(this);
		rowImageIsAttached.setVisible(false);
		rows.appendChild(rowImageIsAttached);

		Label labelImageURL = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_ImageURL));
		editorImageURL = new WStringEditor(MPrintFormatItem.COLUMNNAME_ImageURL, false, false, true, 1000, 1000, null,
				null);
		editorImageURL.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WStringEditor) editorImageURL).getComponent(), "1");
		rowImageURL.appendChild(labelImageURL.rightAlign());
		rowImageURL.appendChild(editorImageURL.getComponent());
		rowImageURL.setGroup(formatItemProps);
		editorImageURL.addValueChangeListener(this);
		rowImageURL.setVisible(false);
		rows.appendChild(rowImageURL);

		// Line Options
		Label labelLineWidth = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_LineWidth));
		editorLineWidth = new WNumberEditor(MPrintFormatItem.COLUMNNAME_LineWidth, true, false, true,
				DisplayType.Integer, labelLineWidth.getValue());
		editorLineWidth.setReadWrite(isUpdatable);
		rowLineWidth.appendChild(labelLineWidth.rightAlign());
		rowLineWidth.appendChild(editorLineWidth.getComponent());
		rowLineWidth.setGroup(formatItemProps);
		editorLineWidth.addValueChangeListener(this);
		rowLineWidth.setVisible(false);
		rows.appendChild(rowLineWidth);

		// Rectangle Options
		// editorTypeRectangle -- lookup
		Label labelTypeRectangle = new Label(Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_ShapeType));
		info = MLookupFactory.getLookup_List(Env.getLanguage(Env.getCtx()), 333);
		MLookup lookupTypeRectangle = new MLookup(info, 0);
		editorTypeRectangle = new WTableDirEditor(MPrintFormatItem.COLUMNNAME_ShapeType, false, false, true,
				lookupTypeRectangle);
		editorTypeRectangle.setReadWrite(isUpdatable);
		ZKUpdateUtil.setHflex(((WTableDirEditor) editorTypeRectangle).getComponent(), "1");
		rowTypeRectangle.appendChild(labelTypeRectangle.rightAlign());
		rowTypeRectangle.appendChild(editorTypeRectangle.getComponent());
		rowTypeRectangle.setGroup(formatItemProps);
		editorTypeRectangle.addValueChangeListener(this);
		rowTypeRectangle.setVisible(false);
		rows.appendChild(rowTypeRectangle);

		Label labelIsFilledRectangle = new Label(
				Msg.getElement(Env.getCtx(), MPrintFormatItem.COLUMNNAME_IsFilledRectangle));
		editorIsFilledRectangle = new WYesNoEditor(MPrintFormatItem.COLUMNNAME_IsFilledRectangle, "", "", true, false,
				true);
		editorIsFilledRectangle.setReadWrite(isUpdatable);
		rowIsFilledRectangle.appendCellChild(labelIsFilledRectangle.rightAlign());
		rowIsFilledRectangle.appendChild(editorIsFilledRectangle.getComponent());
		rowIsFilledRectangle.setGroup(formatItemProps);
		editorIsFilledRectangle.addValueChangeListener(this);
		rowIsFilledRectangle.setVisible(false);
		rows.appendChild(rowIsFilledRectangle);

		row = new Row();
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		row.appendCellChild(confirmPanel, 2);
		rows.appendChild(row);

		gridView.appendChild(rows);
		propertiesPanel.appendChild(gridView);

	}

	@Override
	public void onEvent(Event event) throws Exception {
		if ((Events.ON_CLICK.equals(event.getName())) && (event.getTarget() instanceof Button)) {

			Button btn = (Button) event.getTarget();

			String btnLabel = btn.getLabel();

			if (btnLabel.equals("Field")) {
				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_Field);
				newItem.setIsRelativePosition(false);
				newItem.setPrintName("New field:");
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setMaxWidth(0);
				newItem.setMaxHeight(0);
				newItem.setName("New field");
				newItem.setSeqNo(10);
				MTable tab = new MTable(Env.getCtx(), mpf.get_Table_ID(), null);
				newItem.setAD_Column_ID(MColumn.getColumn_ID(tab.get_TableName(), tab.get_ColumnName(0)));
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);
				paperArea.removeChild(editorArea);

				mountMainPanel();

			} else if (btnLabel.equals("Image")) {
				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_Image);
				newItem.setIsRelativePosition(false);
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setMaxWidth(86);
				newItem.setMaxHeight(20);
				newItem.setName("New Image");
				newItem.setSeqNo(10);
				newItem.setImageURL("theme/default/images/login-logo.png");
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);
				paperArea.removeChild(editorArea);

				mountMainPanel();

			} else if (btnLabel.equals("Line")) {

				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_Line);
				newItem.setIsRelativePosition(false);
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setMaxWidth(100);
				newItem.setMaxHeight(0);
				newItem.setLineWidth(1);
				newItem.setName("New Line");
				newItem.setSeqNo(10);
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);

				paperArea.removeChild(editorArea);

				mountMainPanel();

			} else if (btnLabel.equals("Print Format")) {
				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat);
				newItem.setIsRelativePosition(false);
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setName("New Print Format Included");
				newItem.setSeqNo(10);
				newItem.setAD_PrintFormatChild_ID(50051);
				MTable tab = new MTable(Env.getCtx(), mpf.get_Table_ID(), null);
				newItem.setAD_Column_ID(MColumn.getColumn_ID(tab.get_TableName(), tab.get_ColumnName(0)));
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);

				paperArea.removeChild(editorArea);

				mountMainPanel();

			} else if (btnLabel.equals("Rectangle")) {
				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_Rectangle);
				newItem.setIsRelativePosition(false);
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setMaxWidth(100);
				newItem.setMaxHeight(100);
				newItem.setName("New Rectangle");
				newItem.setSeqNo(10);
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);

				paperArea.removeChild(editorArea);

				mountMainPanel();
			} else if (btnLabel.equals("Text")) {
				MPrintFormatItem newItem = new MPrintFormatItem(Env.getCtx(), 0, null);
				newItem.setPrintFormatType(MPrintFormatItem.PRINTFORMATTYPE_Text);
				newItem.setIsRelativePosition(false);
				newItem.setPrintName("New text");
				newItem.setXPosition(0);
				newItem.setYPosition(0);
				newItem.setMaxWidth(0);
				newItem.setMaxHeight(0);
				newItem.setName("New text");
				newItem.setSeqNo(10);
				newItem.setAD_PrintFormat_ID(mpf.get_ID());
				newItem.setAD_Org_ID(mpf.getAD_Org_ID());
				newItem.setFieldAlignmentType(MPrintFormatItem.FIELDALIGNMENTTYPE_Default);
				mpiList.add(newItem);

				paperArea.removeChild(editorArea);

				mountMainPanel();
			}

		} else if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget() instanceof WBoxElement) {
				wBox = (WBoxElement) event.getTarget();
				setProperties(wBox);
			} else if (event.getTarget() instanceof WStringElement) {
				wString = (WStringElement) event.getTarget();
				setProperties(wString);
			} else if (event.getTarget() instanceof WImageElement) {
				wImage = (WImageElement) event.getTarget();
				setProperties(wImage);
			} else if (event.getTarget() instanceof WFieldElement) {
				wField = (WFieldElement) event.getTarget();
				setProperties(wField);
			} else if (event.getTarget() instanceof WPrintFormatElement) {
				wPrintFormat = (WPrintFormatElement) event.getTarget();
				setProperties(wPrintFormat);
			}
		} else if (Events.ON_MOVE.equals(event.getName())) {
			WBoxElement box = (WBoxElement) event.getTarget();
			box.setVisible(false);
		}

		if (event.getTarget().getId().equals("Cancel")) {
			formEditor.detach();
		} else if (event.getTarget().getId().equals("Ok")) {
			if (save())
				formEditor.detach();
		}

	} // actionPerformed

	@Override
	public void valueChange(ValueChangeEvent evt) {
		String propertyName = evt.getPropertyName();

		if (propertyName.equals(MPrintFormat.COLUMNNAME_AD_PrintPaper_ID)) {
			mpf.setAD_PrintPaper_ID(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			loadPaperProperties();
		} else if (propertyName.equals(MPrintFormat.COLUMNNAME_AD_PrintFont_ID)
				&& evt.getSource().equals(editorPrintFontPaper)) {
			mpf.setAD_PrintFont_ID(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			paperArea.removeChild(editorArea);
			editorArea = new Panel();
			loadPaperProperties();
			loadItens();
		} else if (propertyName.equals(MPrintFormat.COLUMNNAME_AD_PrintColor_ID)
				&& evt.getSource().equals(editorPrintColorPaper)) {
			mpf.setAD_PrintColor_ID(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			paperArea.removeChild(editorArea);
			editorArea = new Panel();
			loadPaperProperties();
			loadItens();
		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Rectangle)
				|| currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Line)) {

			if (propertyName.equals(MPrintFormatItem.COLUMNNAME_Name)) {
				wBox.setName(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_SeqNo)) {
				wBox.setSeq(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_PrintName)) {
				wBox.setPrintText(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsRelativePosition)) {
				wBox.setRelative((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XPosition)) {
				wBox.setPosX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YPosition)) {
				wBox.setPosY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsSetNLPosition)) {
				wBox.setSetNLPosition((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_FieldAlignmentType)) {
				wBox.setAlignField(
						evt.getNewValue() != null ? evt.getNewValue().toString() : evt.getOldValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxWidth)) {
				wBox.setMaxWidth(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxHeight)) {
				wBox.setMaxHeight(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID)) {
				wBox.setPrintColor(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineWidth)) {
				wBox.setLineWidth(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsFilledRectangle)) {
				wBox.setFilledRectangle((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_ShapeType)) {
				wBox.setTypeRectangle(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextLine)) {
				wBox.setNextLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextPage)) {
				wBox.setNextPage((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineAlignmentType)) {
				wBox.setAligLine(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XSpace)) {
				wBox.setSpaceX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YSpace)) {
				wBox.setSpaceY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			}

			wBox.createStyle();
			changeVisiblePropertiesField(wBox.getTypeFormat(), wBox.isRelative());
			updateValues();

		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Text)) {

			if (propertyName.equals(MPrintFormatItem.COLUMNNAME_Name)) {
				wString.setName(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_SeqNo)) {
				wString.setSeq(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_PrintName)) {
				wString.setPrintText(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsRelativePosition)) {
				wString.setRelative((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XPosition)) {
				wString.setPosX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YPosition)) {
				wString.setPosY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsSetNLPosition)) {
				wString.setSetNLPosition((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_FieldAlignmentType)) {
				wString.setAlignField(
						evt.getNewValue() != null ? evt.getNewValue().toString() : evt.getOldValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxWidth)) {
				wString.setMaxWidth(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxHeight)) {
				wString.setMaxHeight(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsHeightOneLine)) {
				wString.setHeighOneLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID)) {
				wString.setPrintFont(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID)) {
				wString.setPrintColor(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextLine)) {
				wString.setNextLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextPage)) {
				wString.setNextPage((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineAlignmentType)) {
				wString.setAligLine(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XSpace)) {
				wString.setSpaceX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YSpace)) {
				wString.setSpaceY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			}
			changeVisiblePropertiesField(wString.getTypeFormat(), wString.isRelative());
			wString.createStyle();
			updateValues();

		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Field)) {

			if (propertyName.equals(MPrintFormatItem.COLUMNNAME_Name)) {
				wField.setName(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_SeqNo)) {
				wField.setSeq(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_PrintName)) {
				wField.setPrintText(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsRelativePosition)) {
				wField.setRelative((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XPosition)) {
				wField.setPosX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YPosition)) {
				wField.setPosY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsSetNLPosition)) {
				wField.setSetNLPosition((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_FieldAlignmentType)) {
				wField.setAlignField(
						evt.getNewValue() != null ? evt.getNewValue().toString() : evt.getOldValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxWidth)) {
				wField.setMaxWidth(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxHeight)) {
				wField.setMaxHeight(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsFixedWidth)) {
				wField.setFixedWidth((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsHeightOneLine)) {
				wField.setHeighOneLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintFont_ID)) {
				wField.setPrintFont(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintColor_ID)) {
				wField.setPrintColor(evt.getNewValue() == null ? 0 : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_Column_ID)) {
				wField.setColumn(evt.getNewValue() == null ? (int) evt.getOldValue() : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextLine)) {
				wField.setNextLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextPage)) {
				wField.setNextPage((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineAlignmentType)) {
				wField.setAligLine(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XSpace)) {
				wField.setSpaceX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YSpace)) {
				wField.setSpaceY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			}

			changeVisiblePropertiesField(wField.getTypeFormat(), wField.isRelative());
			wField.createStyle();
			updateValues();

		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
			if (propertyName.equals(MPrintFormatItem.COLUMNNAME_Name)) {
				wPrintFormat.setName(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_SeqNo)) {
				wPrintFormat.setSeq(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_PrintName)) {
				wPrintFormat.setPrintText(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsRelativePosition)) {
				wPrintFormat.setRelative((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XPosition)) {
				wPrintFormat.setPosX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YPosition)) {
				wPrintFormat.setPosY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsSetNLPosition)) {
				wPrintFormat.setSetNLPosition((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_Column_ID)) {
				wPrintFormat.setColumn(evt.getNewValue() == null ? (int) evt.getOldValue() : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID)) {
				wPrintFormat.setPrintFormatChild(
						evt.getNewValue() == null ? (int) evt.getOldValue() : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextLine)) {
				wPrintFormat.setNextLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextPage)) {
				wPrintFormat.setNextPage((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineAlignmentType)) {
				wPrintFormat.setAligLine(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XSpace)) {
				wPrintFormat.setSpaceX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YSpace)) {
				wPrintFormat.setSpaceY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			}


			changeVisiblePropertiesField(wPrintFormat.getTypeFormat(), wPrintFormat.isRelative());
			wPrintFormat.createStyle(widthAreaEditor);
			updateValues();

		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {

			if (propertyName.equals(MPrintFormatItem.COLUMNNAME_Name)) {
				wImage.setName(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_SeqNo)) {
				wImage.setSeq(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_PrintName)) {
				wImage.setPrintText(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsRelativePosition)) {
				wImage.setRelative((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XPosition)) {
				wImage.setPosX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YPosition)) {
				wImage.setPosY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsSetNLPosition)) {
				wImage.setSetNLPosition((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_FieldAlignmentType)) {
				wImage.setAlignField(
						evt.getNewValue() != null ? evt.getNewValue().toString() : evt.getOldValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxWidth)) {
				wImage.setMaxWidth(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_MaxHeight)) {
				wImage.setMaxHeight(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextLine)) {
				wImage.setNextLine((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsNextPage)) {
				wImage.setNextPage((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_LineAlignmentType)) {
				wImage.setAligLine(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_XSpace)) {
				wImage.setSpaceX(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_YSpace)) {
				wImage.setSpaceY(evt.getNewValue() != null ? (int) evt.getNewValue() : 0);
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_AD_Column_ID)) {
				wImage.setColumn(evt.getNewValue() == null ? (int) evt.getOldValue() : (int) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_ImageIsAttached)) {
				wImage.setImageAttached((boolean) evt.getNewValue());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_ImageURL)) {
				wImage.setImageURL(evt.getNewValue().toString());
			} else if (propertyName.equals(MPrintFormatItem.COLUMNNAME_IsImageField)) {
				wImage.setImageField((boolean) evt.getNewValue());
			}

			changeVisiblePropertiesField(wImage.isRelative(), wImage.isImageField(), wImage.isImageAttached());
			wImage.createStyle();
			updateValues();
		}

	} // valueChange

	private void setProperties(WBoxElement wBox) {
		changeVisiblePropertiesField(wBox.getTypeFormat(), wBox.isRelative());
		editorName.setValue(wBox.getName());
		editorSeq.setValue(wBox.getSeq());
		editorPrintText.setValue(wBox.getPrintText());
		editorIsRelative.setValue(wBox.isRelative());
		if (wBox.isRelative()) {
			editorIsNextLine.setValue(wBox.isNextLine());
			editorIsNextPage.setValue(wBox.isNextPage());
			editorAlignLine.setValue(wBox.getAligLine());
			editorSpaceX.setValue(wBox.getSpaceX());
			editorSpaceY.setValue(wBox.getSpaceY());
		} else {
			editorPosX.setValue(wBox.getPosX());
			editorPosY.setValue(wBox.getPosY());
		}
		editorIsSetNLPosition.setValue(wBox.isSetNLPosition());
		editorAlignField.setValue(wBox.getAlignField());
		editorMaxWidth.setValue(wBox.getMaxWidth());
		editorMaxHeight.setValue(wBox.getMaxHeight());
		editorPrintColor.setValue(wBox.getPrintColor());
		if (wBox.getTypeFormat().equals(MPrintFormatItem.PRINTFORMATTYPE_Line)) {
			editorLineWidth.setValue(wBox.getLineWidth());
		} else {
			editorIsFilledRectangle.setValue(wBox.isFilledRectangle());
			editorTypeRectangle.setValue(wBox.getTypeRectangle());
		}
	}

	private void setProperties(WStringElement wString) {
		changeVisiblePropertiesField(MPrintFormatItem.PRINTFORMATTYPE_Text, wString.isRelative());
		editorName.setValue(wString.getName());
		editorSeq.setValue(wString.getSeq());

		editorPrintText.setValue(wString.getPrintText());
		editorIsRelative.setValue(wString.isRelative());
		if (wString.isRelative()) {
			editorIsNextLine.setValue(wString.isNextLine());
			editorIsNextPage.setValue(wString.isNextPage());
			editorAlignLine.setValue(wString.getAligLine());
			editorSpaceX.setValue(wString.getSpaceX());
			editorSpaceY.setValue(wString.getSpaceY());
		} else {
			editorPosX.setValue(wString.getPosX());
			editorPosY.setValue(wString.getPosY());
		}
		editorIsSetNLPosition.setValue(wString.isSetNLPosition());
		editorAlignField.setValue(wString.getAlignField());
		editorMaxWidth.setValue(wString.getMaxWidth());
		editorMaxHeight.setValue(wString.getMaxHeight());
		editorPrintColor.setValue(wString.getPrintColor());
		editorPrintFont.setValue(wString.getPrintFont());

	}

	private void setProperties(WImageElement wImage) {
		changeVisiblePropertiesField(wImage.isRelative(), wImage.isImageField(), wImage.isImageAttached());
		editorName.setValue(wImage.getName());
		editorSeq.setValue(wImage.getSeq());
		editorIsRelative.setValue(wImage.isRelative());
		if (wImage.isRelative()) {
			editorIsNextLine.setValue(wImage.isNextLine());
			editorIsNextPage.setValue(wImage.isNextPage());
			editorAlignLine.setValue(wImage.getAligLine());
			editorSpaceX.setValue(wImage.getSpaceX());
			editorSpaceY.setValue(wImage.getSpaceY());
		} else {
			editorPosX.setValue(wImage.getPosX());
			editorPosY.setValue(wImage.getPosY());
		}
		editorIsImageField.setValue(wImage.isImageField());
		editorImageIsAttached.setValue(wImage.isImageAttached());
		editorPrintText.setValue(wImage.getPrintText());
		editorIsSetNLPosition.setValue(wImage.isSetNLPosition());
		editorAlignField.setValue(wImage.getAlignField());
		editorMaxWidth.setValue(wImage.getMaxWidth());
		editorMaxHeight.setValue(wImage.getMaxHeight());
		editorImageURL.setValue(wImage.getImageURL());

	}

	private void setProperties(WFieldElement wField) {
		changeVisiblePropertiesField(MPrintFormatItem.PRINTFORMATTYPE_Field, wField.isRelative());
		editorName.setValue(wField.getName());
		editorSeq.setValue(wField.getSeq());

		editorPrintText.setValue(wField.getPrintText());
		editorIsRelative.setValue(wField.isRelative());
		if (wField.isRelative()) {
			editorIsNextLine.setValue(wField.isNextLine());
			editorIsNextPage.setValue(wField.isNextPage());
			editorAlignLine.setValue(wField.getAligLine());
			editorSpaceX.setValue(wField.getSpaceX());
			editorSpaceY.setValue(wField.getSpaceY());
		} else {
			editorPosX.setValue(wField.getPosX());
			editorPosY.setValue(wField.getPosY());
		}
		editorIsSetNLPosition.setValue(wField.isSetNLPosition());
		editorAlignField.setValue(wField.getAlignField());
		editorMaxWidth.setValue(wField.getMaxWidth());
		editorMaxHeight.setValue(wField.getMaxHeight());
		editorPrintColor.setValue(wField.getPrintColor());
		editorPrintFont.setValue(wField.getPrintFont());
		editorColumn.setValue(wField.getColumn());
	}

	private void setProperties(WPrintFormatElement wPrintFormat) {
		changeVisiblePropertiesField(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat, wPrintFormat.isRelative());
		editorName.setValue(wPrintFormat.getName());
		editorSeq.setValue(wPrintFormat.getSeq());

		editorPrintText.setValue(wPrintFormat.getPrintText());
		editorIsRelative.setValue(wPrintFormat.isRelative());
		if (wPrintFormat.isRelative()) {
			editorIsNextLine.setValue(wPrintFormat.isNextLine());
			editorIsNextPage.setValue(wPrintFormat.isNextPage());
			editorAlignLine.setValue(wPrintFormat.getAligLine());
			editorSpaceX.setValue(wPrintFormat.getSpaceX());
			editorSpaceY.setValue(wPrintFormat.getSpaceY());
		} else {
			editorPosX.setValue(wPrintFormat.getPosX());
			editorPosY.setValue(wPrintFormat.getPosY());
		}
		editorIsSetNLPosition.setValue(wPrintFormat.isSetNLPosition());
		editorPrintFormat.setValue(wPrintFormat.getPrintFormatChild());
		editorColumn.setValue(wPrintFormat.getColumn());

	}

	private void changeVisiblePropertiesField(String type, boolean isRelative) {
		if (!currentTypeSelected.equals("type")) {
			if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Rectangle)) {
				rowPrintText.setVisible(true);
				rowIsRelative.setVisible(true);
				rowIsSetNLPosition.setVisible(true);
				rowAligField.setVisible(true);
				rowMaxWidth.setVisible(true);
				rowMaxHeight.setVisible(true);
				rowIsFixedWidth.setVisible(false);
				rowIsHeightOneLine.setVisible(false);
				rowPrintColor.setVisible(true);
				rowPrintFont.setVisible(false);
				rowColumn.setVisible(false);
				rowBarCode.setVisible(false);
				rowPrintFormat.setVisible(false);
				rowIsImageField.setVisible(false);
				rowImageIsAttached.setVisible(false);
				rowImageURL.setVisible(false);
				rowLineWidth.setVisible(false);
				rowTypeRectangle.setVisible(true);
				rowIsFilledRectangle.setVisible(true);
				rowFormatPattern.setVisible(false);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Line)) {
				rowPrintText.setVisible(true);
				rowIsRelative.setVisible(true);
				rowIsSetNLPosition.setVisible(true);
				rowAligField.setVisible(true);
				rowMaxWidth.setVisible(true);
				rowMaxHeight.setVisible(true);
				rowIsFixedWidth.setVisible(false);
				rowIsHeightOneLine.setVisible(false);
				rowPrintColor.setVisible(true);
				rowPrintFont.setVisible(false);
				rowColumn.setVisible(false);
				rowBarCode.setVisible(false);
				rowPrintFormat.setVisible(false);
				rowIsImageField.setVisible(false);
				rowImageIsAttached.setVisible(false);
				rowImageURL.setVisible(false);
				rowLineWidth.setVisible(true);
				rowTypeRectangle.setVisible(false);
				rowIsFilledRectangle.setVisible(true);
				rowFormatPattern.setVisible(false);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Text)) {
				rowPrintText.setVisible(true);
				rowIsRelative.setVisible(true);
				rowIsSetNLPosition.setVisible(true);
				rowAligField.setVisible(true);
				rowMaxWidth.setVisible(true);
				rowMaxHeight.setVisible(true);
				rowIsFixedWidth.setVisible(false);
				rowIsHeightOneLine.setVisible(true);
				rowPrintColor.setVisible(true);
				rowPrintFont.setVisible(true);
				rowColumn.setVisible(false);
				rowBarCode.setVisible(false);
				rowPrintFormat.setVisible(false);
				rowIsImageField.setVisible(false);
				rowImageIsAttached.setVisible(false);
				rowImageURL.setVisible(false);
				rowLineWidth.setVisible(false);
				rowTypeRectangle.setVisible(false);
				rowIsFilledRectangle.setVisible(false);
				rowFormatPattern.setVisible(false);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_Field)) {
				rowPrintText.setVisible(true);
				rowIsRelative.setVisible(true);
				rowIsSetNLPosition.setVisible(true);
				rowAligField.setVisible(true);
				rowMaxWidth.setVisible(true);
				rowMaxHeight.setVisible(true);
				rowIsFixedWidth.setVisible(true);
				rowIsHeightOneLine.setVisible(true);
				rowPrintColor.setVisible(true);
				rowPrintFont.setVisible(true);
				rowColumn.setVisible(true);
				rowBarCode.setVisible(false);
				rowPrintFormat.setVisible(false);
				rowIsImageField.setVisible(false);
				rowImageIsAttached.setVisible(false);
				rowImageURL.setVisible(false);
				rowLineWidth.setVisible(false);
				rowTypeRectangle.setVisible(false);
				rowIsFilledRectangle.setVisible(false);
				rowFormatPattern.setVisible(false);
			} else if (type.equals(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
				rowPrintText.setVisible(true);
				rowIsRelative.setVisible(true);
				rowIsSetNLPosition.setVisible(true);
				rowAligField.setVisible(false);
				rowMaxWidth.setVisible(false);
				rowMaxHeight.setVisible(false);
				rowIsFixedWidth.setVisible(false);
				rowIsHeightOneLine.setVisible(false);
				rowPrintColor.setVisible(false);
				rowPrintFont.setVisible(false);
				rowColumn.setVisible(true);
				rowBarCode.setVisible(false);
				rowPrintFormat.setVisible(true);
				rowIsImageField.setVisible(false);
				rowImageIsAttached.setVisible(false);
				rowImageURL.setVisible(false);
				rowLineWidth.setVisible(false);
				rowTypeRectangle.setVisible(false);
				rowIsFilledRectangle.setVisible(false);
				rowFormatPattern.setVisible(false);
			}
			currentTypeSelected = type;
		}
		if (isRelative) {
			rowIsNextLine.setVisible(true);
			rowIsNextPage.setVisible(true);
			rowAligLine.setVisible(true);
			rowSpaceX.setVisible(true);
			rowSpaceY.setVisible(true);
			rowPosX.setVisible(false);
			rowPosY.setVisible(false);
		} else {
			rowIsNextLine.setVisible(false);
			rowIsNextPage.setVisible(false);
			rowAligLine.setVisible(false);
			rowSpaceX.setVisible(false);
			rowSpaceY.setVisible(false);
			rowPosX.setVisible(true);
			rowPosY.setVisible(true);
		}
	}

	private void changeVisiblePropertiesField(boolean isRelative, boolean isImageField, boolean isImageAttached) {
		if (!currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {
			rowPrintText.setVisible(true);
			rowIsRelative.setVisible(true);
			rowIsSetNLPosition.setVisible(true);
			rowAligField.setVisible(true);
			rowMaxWidth.setVisible(true);
			rowMaxHeight.setVisible(true);
			rowIsFixedWidth.setVisible(false);
			rowIsHeightOneLine.setVisible(false);
			rowPrintColor.setVisible(false);
			rowPrintFont.setVisible(false);
			rowBarCode.setVisible(false);
			rowPrintFormat.setVisible(false);
			rowIsImageField.setVisible(true);
			rowLineWidth.setVisible(false);
			rowTypeRectangle.setVisible(false);
			rowIsFilledRectangle.setVisible(false);
			rowFormatPattern.setVisible(false);

			currentTypeSelected = MPrintFormatItem.PRINTFORMATTYPE_Image;
		}

		if (isImageField) {
			rowColumn.setVisible(true);
			rowImageIsAttached.setVisible(false);
			rowImageURL.setVisible(false);
		} else {
			if (isImageAttached)
				rowImageURL.setVisible(false);
			else
				rowImageURL.setVisible(true);
		}

		if (isRelative) {
			rowIsNextLine.setVisible(true);
			rowIsNextPage.setVisible(true);
			rowAligLine.setVisible(true);
			rowSpaceX.setVisible(true);
			rowSpaceY.setVisible(true);
			rowPosX.setVisible(false);
			rowPosY.setVisible(false);
		} else {
			rowIsNextLine.setVisible(false);
			rowIsNextPage.setVisible(false);
			rowAligLine.setVisible(false);
			rowSpaceX.setVisible(false);
			rowSpaceY.setVisible(false);
			rowPosX.setVisible(true);
			rowPosY.setVisible(true);
		}

	}

	public void updateValues() {
		if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Rectangle)
				|| currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Line)) {
			for (MPrintFormatItem item : mpiList) {
				if (item.getSeqNo() == wBox.getSeq()) {
					item.setName(wBox.getName());
					item.setSeqNo(wBox.getSeq());
					item.setPrintName(wBox.getPrintText());
					item.setIsRelativePosition(wBox.isRelative());
					item.setXPosition(wBox.getPosX());
					item.setYPosition(wBox.getPosY());
					item.setIsSetNLPosition(wBox.isSetNLPosition());
					item.setFieldAlignmentType(wBox.getAlignField());
					item.setMaxWidth(wBox.getMaxWidth());
					item.setMaxHeight(wBox.getMaxHeight());
					item.setAD_PrintColor_ID(wBox.getPrintColor());
					item.setLineWidth(wBox.getLineWidth());
					item.setIsFilledRectangle(wBox.isFilledRectangle());
					item.setShapeType(wBox.getTypeRectangle());
					item.setIsNextLine(wBox.isNextLine());
					item.setIsNextPage(wBox.isNextPage());
					item.setLineAlignmentType(wBox.getAligLine());
					item.setXSpace(wBox.getSpaceX());
					item.setYSpace(wBox.getSpaceY());
				}
			}
		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Text)) {
			for (MPrintFormatItem item : mpiList) {
				if (item.get_ID() == wString.getMPrintFormatItem_ID()) {
					item.setName(wString.getName());
					item.setSeqNo(wString.getSeq());
					item.setPrintName(wString.getPrintText());
					item.setIsRelativePosition(wString.isRelative());
					item.setXPosition(wString.getPosX());
					item.setYPosition(wString.getPosY());
					item.setIsSetNLPosition(wString.isSetNLPosition());
					item.setFieldAlignmentType(wString.getAlignField());
					item.setMaxWidth(wString.getMaxWidth());
					item.setMaxHeight(wString.getMaxHeight());
					item.setAD_PrintColor_ID(wString.getPrintColor());
					item.setAD_PrintFont_ID(wString.getPrintFont());
					item.setIsNextLine(wString.isNextLine());
					item.setIsNextPage(wString.isNextPage());
					item.setLineAlignmentType(wString.getAligLine());
					item.setXSpace(wString.getSpaceX());
					item.setYSpace(wString.getSpaceY());
				}
			}
		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Field)) {
			for (MPrintFormatItem item : mpiList) {
				if (item.get_ID() == wField.getMPrintFormatItem_ID()) {
					item.setName(wField.getName());
					item.setSeqNo(wField.getSeq());
					item.setPrintName(wField.getPrintText());
					item.setIsRelativePosition(wField.isRelative());
					item.setXPosition(wField.getPosX());
					item.setYPosition(wField.getPosY());
					item.setIsSetNLPosition(wField.isSetNLPosition());
					item.setFieldAlignmentType(wField.getAlignField());
					item.setMaxWidth(wField.getMaxWidth());
					item.setMaxHeight(wField.getMaxHeight());
					item.setAD_PrintColor_ID(wField.getPrintColor());
					item.setAD_PrintFont_ID(wField.getPrintFont());
					item.setAD_Column_ID(wField.getColumn());
					item.setIsNextLine(wField.isNextLine());
					item.setIsNextPage(wField.isNextPage());
					item.setLineAlignmentType(wField.getAligLine());
					item.setXSpace(wField.getSpaceX());
					item.setYSpace(wField.getSpaceY());
				}
			}
		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_Image)) {
			for (MPrintFormatItem item : mpiList) {
				if (item.get_ID() == wImage.getMPrintFormatItem_ID()) {
					item.setName(wImage.getName());
					item.setSeqNo(wImage.getSeq());
					item.setPrintName(wImage.getPrintText());
					item.setIsRelativePosition(wImage.isRelative());
					item.setXPosition(wImage.getPosX());
					item.setYPosition(wImage.getPosY());
					item.setIsImageField(wImage.isImageField());
					item.setImageIsAttached(wImage.isImageAttached());
					item.setIsSetNLPosition(wImage.isSetNLPosition());
					item.setFieldAlignmentType(wImage.getAlignField());
					item.setMaxWidth(wImage.getMaxWidth());
					item.setMaxHeight(wImage.getMaxHeight());
					item.setImageURL(wImage.getImageURL());
					item.set_ValueOfColumn("script", wImage.getScript());
					item.setAD_Column_ID(wImage.getColumn());
					item.setIsNextLine(wImage.isNextLine());
					item.setIsNextPage(wImage.isNextPage());
					item.setLineAlignmentType(wImage.getAligLine());
					item.setXSpace(wImage.getSpaceX());
					item.setYSpace(wImage.getSpaceY());
				}
			}
		} else if (currentTypeSelected.equals(MPrintFormatItem.PRINTFORMATTYPE_PrintFormat)) {
			for (MPrintFormatItem item : mpiList) {
				if (item.get_ID() == wPrintFormat.getMPrintFormatItem_ID()) {
					item.setName(wPrintFormat.getName());
					item.setSeqNo(wPrintFormat.getSeq());
					item.setPrintName(wPrintFormat.getPrintText());
					item.setIsRelativePosition(wPrintFormat.isRelative());
					item.setXPosition(wPrintFormat.getPosX());
					item.setYPosition(wPrintFormat.getPosY());
					item.setIsSetNLPosition(wPrintFormat.isSetNLPosition());
					item.setAD_PrintFormatChild_ID(wPrintFormat.getPrintFormatChild());
					item.setAD_Column_ID(wPrintFormat.getColumn());
					item.setIsNextLine(wPrintFormat.isNextLine());
					item.setIsNextPage(wPrintFormat.isNextPage());
					item.setLineAlignmentType(wPrintFormat.getAligLine());
					item.setXSpace(wPrintFormat.getSpaceX());
					item.setYSpace(wPrintFormat.getSpaceY());
				}
			}
		}
	}

	public boolean save() {
		for (MPrintFormatItem item : mpiList) {
			if (item.is_Changed())
				item.saveEx();
		}
		if (mpf.is_Changed())
			mpf.saveEx();
		return true;
	}

}