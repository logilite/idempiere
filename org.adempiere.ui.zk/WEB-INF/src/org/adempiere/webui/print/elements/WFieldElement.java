package org.adempiere.webui.print.elements;

import org.adempiere.webui.apps.form.WPrintFormatEditor;
import org.adempiere.webui.component.Label;
import org.compiere.model.MColumn;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.Env;

public class WFieldElement extends Label{
	/**
	 *
	 */
	private static final long serialVersionUID = -3488674779300880914L;
	private final String typeFormat = MPrintFormatItem.PRINTFORMATTYPE_Field;
	private int MPrintFormatItem_ID;
	private String name;
	private int seq;
	private String printText;
	private boolean isRelative;
	private int posX;
	private int posY;
	private boolean isSetNLPosition;
	private String alignField;
	private int maxWidth;
	private int maxHeight;
	private boolean isFixedWidth;
	private boolean isHeighOneLine;
	private int printColor;
	private int printFont;
	private int Column;

	//Relative Options
	private boolean isNextLine;
	private boolean isNextPage;
	private String aligLine;
	private int spaceX;
	private int spaceY;


	private String text;


	public WFieldElement() {
		this.setSclass(WPrintFormatItem.PRINTFORMATCSS_Field);
	}

	public void createStyle() {

		StringBuilder style = new StringBuilder();

		MColumn column = new MColumn(Env.getCtx(), this.getColumn(), null);

		this.setText(this.getPrintText()!=null ? this.getPrintText() : "");
		this.setText(this.getText() + "<<"+column.get_Translation(MColumn.COLUMNNAME_Name)+">>");

		String tagAlign=null;

		if (this.getAlignField().equals(MPrintFormatItem.FIELDALIGNMENTTYPE_Center))
			tagAlign = "text-align: center;";
		else if (this.getAlignField().equals(MPrintFormatItem.FIELDALIGNMENTTYPE_LeadingLeft))
			tagAlign = "text-align: left;";
		else if (this.getAlignField().equals(MPrintFormatItem.FIELDALIGNMENTTYPE_TrailingRight))
			tagAlign = "text-align: right;";

		if (this.isRelative()) {
			style.append("display:block;");

		} else {
			style.append("position: absolute;")
					.append("top: " + this.getPosY() + "px;")
					.append("left: " + this.getPosX() + "px;")
					.append("display:inline;");
		}

		style.append("color: ")
					.append(this.getPrintColor() == 0 ? Colors.getHexColor(WPrintFormatEditor.PRINTPAPER_Color) : Colors.getHexColor(this.getPrintColor()))
					.append(";")
					.append("user-select: none;")
					.append("white-space: nowrap;")
					.append("overflow:hidden;")
					.append("text-overflow: ellipsis;")
					.append(this.getMaxWidth() != 0 ? "width: " + this.getMaxWidth() + "px; " : "width: max;")
					.append(this.getPrintFont() == 0 ? Fonts.getCSSFont(WPrintFormatEditor.PRINTPAPER_Font) : Fonts.getCSSFont(this.getPrintFont()))
					.append(tagAlign);


		this.setStyle(style.toString());
	}

	@Override
	public void setText(String text) {
		super.setText(text);
		this.text = text;
	}

	public String getText() {
		return this.text;
	}

	public int getMPrintFormatItem_ID() {
		return MPrintFormatItem_ID;
	}


	public void setMPrintFormatItem_ID(int mPrintFormatItem_ID) {
		MPrintFormatItem_ID = mPrintFormatItem_ID;
	}

	public String getTypeFormat() {
		return typeFormat;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getPrintText() {
		return printText;
	}


	public void setPrintText(String printText) {
		this.printText = printText;
	}


	public boolean isRelative() {
		return isRelative;
	}


	public void setRelative(boolean isRelative) {
		this.isRelative = isRelative;
	}


	public int getPosX() {
		return posX;
	}


	public void setPosX(int posX) {
		this.posX = posX;
	}


	public int getPosY() {
		return posY;
	}


	public void setPosY(int posY) {
		this.posY = posY;
	}


	public boolean isSetNLPosition() {
		return isSetNLPosition;
	}


	public void setSetNLPosition(boolean isSetNLPosition) {
		this.isSetNLPosition = isSetNLPosition;
	}


	public String getAlignField() {
		return alignField;
	}


	public void setAlignField(String alignField) {
		this.alignField = alignField;
	}


	public int getMaxWidth() {
		return maxWidth;
	}


	public void setMaxWidth(int maxWidth) {
		this.maxWidth = maxWidth;
	}


	public int getMaxHeight() {
		return maxHeight;
	}


	public void setMaxHeight(int maxHeight) {
		this.maxHeight = maxHeight;
	}


	public boolean isHeighOneLine() {
		return isHeighOneLine;
	}


	public void setHeighOneLine(boolean isHeighOneLine) {
		this.isHeighOneLine = isHeighOneLine;
	}


	public int getPrintColor() {
		return printColor;
	}


	public void setPrintColor(int printColor) {
		this.printColor = printColor;
	}


	public int getPrintFont() {
		return printFont;
	}


	public void setPrintFont(int printFont) {
		this.printFont = printFont;
	}


	public int getColumn() {
		return Column;
	}


	public void setColumn(int column) {
		Column = column;
	}


	public boolean isNextLine() {
		return isNextLine;
	}


	public void setNextLine(boolean isNextLine) {
		this.isNextLine = isNextLine;
	}


	public boolean isNextPage() {
		return isNextPage;
	}


	public void setNextPage(boolean isNextPage) {
		this.isNextPage = isNextPage;
	}


	public String getAligLine() {
		return aligLine;
	}


	public void setAligLine(String aligLine) {
		this.aligLine = aligLine;
	}


	public int getSpaceX() {
		return spaceX;
	}


	public void setSpaceX(int spaceX) {
		this.spaceX = spaceX;
	}


	public int getSpaceY() {
		return spaceY;
	}


	public void setSpaceY(int spaceY) {
		this.spaceY = spaceY;
	}

	public boolean isFixedWidth() {
		return isFixedWidth;
	}

	public void setFixedWidth(boolean isFixedWidth) {
		this.isFixedWidth = isFixedWidth;
	}


}
