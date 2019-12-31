package org.adempiere.webui.print.elements;

import org.adempiere.webui.apps.form.WPrintFormatEditor;
import org.adempiere.webui.component.Panel;
import org.compiere.print.MPrintFormatItem;

public class WBoxElement extends Panel {

	/**
	 *
	 */
	private static final long serialVersionUID = -8963859786439519413L;
	private String typeFormat;
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
	private int printColor;
	private int lineWidth;
	private boolean isFilledRectangle;
	private String typeRectangle;

	// Relative Options
	private boolean isNextLine;
	private boolean isNextPage;
	private String aligLine;
	private int spaceX;
	private int spaceY;

	public void createStyle() {
		if (this.getTypeFormat().equals(MPrintFormatItem.PRINTFORMATTYPE_Line)) {

			this.setWidth(Integer.toString(this.getMaxWidth()) + "px");

			this.setHeight(WPrintFormatItem.PRINTFORMATLINE_Height);
		} else {
			this.setWidth(Integer.toString(this.getMaxWidth()) + "px");
			this.setHeight(Integer.toString(this.getMaxHeight()) + "px");
		}

		StringBuilder style = new StringBuilder();

		if (this.isRelative()) {
			style.append("display:block;");

		} else {

			style.append("position: absolute;")
					.append("top: " + this.getPosY() + "px;")
					.append("left: " + this.getPosX() + "px;")
					.append("display:inline;");
		}

		style.append("border: " + this.getLineWidth() + "px solid ")
				.append(this.getPrintColor() == 0 ? Colors.getHexColor(WPrintFormatEditor.PRINTPAPER_Color) + ";": Colors.getHexColor(this.getPrintColor()) + ";");

		if (this.isFilledRectangle()) {
			style.append("background-color: ")
					.append(this.getPrintColor() == 0 ? Colors.getHexColor(WPrintFormatEditor.PRINTPAPER_Color) + ";": Colors.getHexColor(this.getPrintColor()) + ";");
		} else {
			style.append("background-color: transparent");
		}

		if (this.getTypeRectangle().equals(MPrintFormatItem.SHAPETYPE_NormalRectangle))
			style.append("border-radius: 0px;");
		else if (this.getTypeRectangle().equals(MPrintFormatItem.SHAPETYPE_Oval))
			style.append("border-radius: 100%;");
		else if (this.getTypeRectangle().equals(MPrintFormatItem.SHAPETYPE_RoundRectangle))
			style.append("border-radius: 5px;");
		else if (this.getTypeRectangle().equals(MPrintFormatItem.SHAPETYPE_3DRectangle))
			style.append("border-radius: 0px;");

		this.setStyle(style.toString());
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

	public WBoxElement() {
		this.setSclass(WPrintFormatItem.PRINTFORMATCSS_BoxElement);

	}

	public String getTypeFormat() {
		return typeFormat;
	}

	public void setTypeFormat(String typeFormat) {
		this.typeFormat = typeFormat;
	}

	public int getMPrintFormatItem_ID() {
		return MPrintFormatItem_ID;
	}

	public void setMPrintFormatItem_ID(int MPrintFormatItem_ID) {
		this.MPrintFormatItem_ID = MPrintFormatItem_ID;
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

	public int getPrintColor() {
		return printColor;
	}

	public void setPrintColor(int printColor) {
		this.printColor = printColor;
	}

	public int getLineWidth() {
		return lineWidth;
	}

	public void setLineWidth(int lineWidth) {
		this.lineWidth = lineWidth;
	}

	public boolean isFilledRectangle() {
		return isFilledRectangle;
	}

	public void setFilledRectangle(boolean isFilledRectangle) {
		this.isFilledRectangle = isFilledRectangle;
	}

	public String getTypeRectangle() {
		return typeRectangle;
	}

	public void setTypeRectangle(String typeRectangle) {
		this.typeRectangle = typeRectangle;
	}

}
