package org.adempiere.webui.print.elements;

import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.Env;

public class WPrintFormatElement extends Grid{

	/**
	 *
	 */
	private static final long serialVersionUID = 4889227052681378393L;
	private final String typeFormat = MPrintFormatItem.PRINTFORMATTYPE_PrintFormat;
	private int MPrintFormatItem_ID;
	private String name;
	private int seq;
	private String printText;
	private boolean isRelative;
	private int posX;
	private int posY;
	private boolean isSetNLPosition;
	private int Column;
	private int printFormatChild;

	//Relative Options
	private boolean isNextLine;
	private boolean isNextPage;
	private String aligLine;
	private int spaceX;
	private int spaceY;

	private int printColor;
	private int printFont;


	public WPrintFormatElement() {
		this.setSclass(WPrintFormatItem.PRINTFORMATCSS_PrintFormat);

	}

	public void createStyle(String width) {

		StringBuilder style = new StringBuilder();

		this.setWidth(width + "px");

		if (this.isRelative()) {
			style.append("display:block;");

		} else {
			style.append("position: absolute;")
				.append("top: " + this.getPosY() + "px;")
				.append("left: " + this.getPosX() + "px;")
				.append("display:inline;");

		}


		style.append("color: " + Colors.getHexColor(this.getPrintColor()) + ";")
				.append("user-select: none; ")
				.append(Fonts.getCSSFont(this.getPrintFont()));


		this.setStyle(style.toString());



	}

	public void readPrintFormat() {

		if (this.getColumns()!=null)
			this.removeChild(getColumns());

		MPrintFormat childFormat = new MPrintFormat(Env.getCtx(), this.getPrintFormatChild(), null);

		Columns columns = new Columns();
		Column column;

		for (int i = 0; i < childFormat.getItemCount();i++ ) {
			if (childFormat.getItem(i).isPrinted()) {
				column = new Column();
				column.setLabel(childFormat.getItem(i).getPrintName());
				columns.appendChild(column);
			}
		}

		this.setPrintColor(childFormat.getAD_PrintColor_ID());
		this.setPrintFont(childFormat.getAD_PrintFont_ID());
		this.appendChild(columns);
	}

	public String getTypeFormat() {
		return typeFormat;
	}

	public int getMPrintFormatItem_ID() {
		return MPrintFormatItem_ID;
	}

	public void setMPrintFormatItem_ID(int mPrintFormatItem_ID) {
		MPrintFormatItem_ID = mPrintFormatItem_ID;
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

	public int getColumn() {
		return Column;
	}

	public void setColumn(int column) {
		Column = column;
	}

	public int getPrintFormatChild() {
		return printFormatChild;
	}

	public void setPrintFormatChild(int printElement) {
		this.printFormatChild = printElement;
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
}