package org.adempiere.webui.print.elements;

import org.adempiere.webui.component.Panel;
import org.compiere.print.MPrintFormatItem;

public class WImageElement extends Panel{
	/**
	 *
	 */
	private static final long serialVersionUID = 3116653356775135620L;
	private final String typeFormat = MPrintFormatItem.PRINTFORMATTYPE_Image;
	private int MPrintFormatItem_ID;
	private String name;
	private int seq;
	private boolean isRelative;
	private int posX;
	private int posY;
	private boolean isImageField;
	private boolean isImageAttached;
	private String printText;
	private boolean isSetNLPosition;
	private String alignField;
	private int maxWidth;
	private int maxHeight;
	private String script;
	private String imageURL;
	private int column;

	//Relative Options
	private boolean isNextLine;
	private boolean isNextPage;
	private String aligLine;
	private int SpaceX;
	private int SpaceY;



	public WImageElement() {
		this.setSclass(WPrintFormatItem.PRINTFORMATCSS_Image);
	}

	public void createStyle() {

		this.setWidth(Integer.toString(this.getMaxWidth()) + "px");
		this.setHeight(Integer.toString(this.getMaxHeight()) + "px");

		StringBuilder style = new StringBuilder();

		if (this.isRelative()) {
			style.append("display:block;");
		} else {

			style.append("position: absolute;")
					.append("top: " + this.getPosY() + "px;")
					.append("left: " + this.getPosX() + "px;")
					.append("display:inline;");

		}

		style.append("background-image: url(\"" + this.getImageURL() + "\");")
					.append("background-size: 100% 100%;");

		this.setStyle(style.toString());
	}


	public int getMPrintFormatItem_ID() {
		return MPrintFormatItem_ID;
	}

	public void setMPrintFormatItem_ID(int mPrintFormatItem_ID) {
		MPrintFormatItem_ID = mPrintFormatItem_ID;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seqID) {
		this.seq = seqID;
	}

	public boolean isRelative() {
		return isRelative;
	}

	public void setRelative(boolean isRelative) {
		this.isRelative = isRelative;
	}

	public boolean isImageField() {
		return isImageField;
	}

	public void setImageField(boolean isImageField) {
		this.isImageField = isImageField;
	}

	public boolean isImageAttached() {
		return isImageAttached;
	}

	public void setImageAttached(boolean isImageAttached) {
		this.isImageAttached = isImageAttached;
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

	public String getPrintText() {
		return printText;
	}

	public void setPrintText(String printText) {
		this.printText = printText;
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

	public void setAlignField(String aligField) {
		this.alignField = aligField;
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

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
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
		return SpaceX;
	}

	public void setSpaceX(int spaceX) {
		SpaceX = spaceX;
	}

	public int getSpaceY() {
		return SpaceY;
	}

	public void setSpaceY(int spaceY) {
		SpaceY = spaceY;
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}


}