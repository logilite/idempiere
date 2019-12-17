package org.adempiere.webui.print.elements;

import java.util.Properties;

import org.adempiere.webui.apps.form.WPrintFormatEditor;
import org.compiere.print.MPrintFormatItem;

public class WPrintFormatItem extends MPrintFormatItem{

	/**
	 *
	 */
	private static final long serialVersionUID = 2317656139927176221L;

	private String hexColor;
	private WBoxElement boxElement = null;
	private WStringElement stringElement = null;
	private WImageElement imageElement = null;
	private WFieldElement fieldElement = null;
	private WPrintFormatElement printFormatElement = null;

	public static final String PRINTFORMATCSS_BoxElement = "cof-wboxelement";
	public static final String PRINTFORMATCSS_Text = "cof-wstringelement";
	public static final String PRINTFORMATCSS_Field = "cof-wfieldelement";
	public static final String PRINTFORMATCSS_Image = "cof-wboxelement";
	public static final String PRINTFORMATCSS_PrintFormat = "cof-wprintformatelement";
	public static final String PRINTFORMATLINE_Height = "0px";

	public WPrintFormatItem(Properties ctx, int AD_PrintFormatItem_ID, String trxName) {
		super(ctx, AD_PrintFormatItem_ID, trxName);
		this.setHexColor();
	}


	public WBoxElement createBoxElement() {
		boxElement = new WBoxElement();

		boxElement.setTypeFormat(this.getPrintFormatType());
		boxElement.setMPrintFormatItem_ID(this.get_ID());
		boxElement.setName(this.getName());
		boxElement.setSeq(this.getSeqNo());
		boxElement.setPrintText(this.getPrintName());
		boxElement.setRelative(this.isRelativePosition());
		boxElement.setPosX(this.getXPosition());
		boxElement.setPosY(this.getYPosition());
		boxElement.setSetNLPosition(this.isSetNLPosition());
		boxElement.setAlignField(this.getFieldAlignmentType());
		boxElement.setMaxWidth(this.getMaxWidth());
		boxElement.setMaxHeight(this.getMaxHeight());
		boxElement.setPrintColor(this.getAD_PrintColor_ID());
		boxElement.setLineWidth(this.getLineWidth());
		boxElement.setFilledRectangle(this.isFilledRectangle());
		boxElement.setTypeRectangle(this.getShapeType());

		//relative position
		boxElement.setNextLine(this.isNextLine());
		boxElement.setNextPage(this.isNextPage());
		boxElement.setAligLine(this.getLineAlignmentType());
		boxElement.setSpaceX(this.getXSpace());
		boxElement.setSpaceY(this.getYSpace());

		boxElement.createStyle();

		return boxElement;

	}

	public WStringElement createStringElement() {

		stringElement = new WStringElement();

		stringElement.setMPrintFormatItem_ID(this.get_ID());
		stringElement.setName(this.getName());
		stringElement.setSeq(this.getSeqNo());
		stringElement.setPrintText(this.getPrintName());
		stringElement.setRelative(this.isRelativePosition());
		stringElement.setPosX(this.getXPosition());
		stringElement.setPosY(this.getYPosition());
		stringElement.setSetNLPosition(this.isSetNLPosition());
		stringElement.setAlignField(this.getFieldAlignmentType());
		stringElement.setMaxWidth(this.getMaxWidth());
		stringElement.setMaxHeight(this.getMaxHeight());
		stringElement.setPrintColor(this.getAD_PrintColor_ID());
		stringElement.setPrintFont(this.getAD_PrintFont_ID());

		//Relative options
		stringElement.setNextLine(this.isNextLine());
		stringElement.setNextPage(this.isNextPage());
		stringElement.setAligLine(this.getLineAlignmentType());
		stringElement.setSpaceX(this.getXSpace());
		stringElement.setSpaceY(this.getYSpace());

		stringElement.createStyle();

		return stringElement;
	}

	public WImageElement createImageElement() {
		imageElement = new WImageElement();

		imageElement.setMPrintFormatItem_ID(this.get_ID());
		imageElement.setName(this.getName());
		imageElement.setSeq(this.getSeqNo());
		imageElement.setRelative(this.isRelativePosition());
		imageElement.setPosX(this.getXPosition());
		imageElement.setPosY(this.getYPosition());
		imageElement.setImageField(this.isImageField());
		imageElement.setImageAttached(this.isImageIsAttached());
		imageElement.setPrintText(this.getPrintName());
		imageElement.setSetNLPosition(this.isSetNLPosition());
		imageElement.setAlignField(this.getFieldAlignmentType());
		imageElement.setMaxWidth(this.getMaxWidth());
		imageElement.setMaxHeight(this.getMaxHeight());
		imageElement.setImageURL(this.getImageURL());

		//Relative Options
		imageElement.setNextLine(this.isNextLine());
		imageElement.setNextPage(this.isNextPage());
		imageElement.setAligLine(this.getLineAlignmentType());
		imageElement.setSpaceX(this.getXSpace());
		imageElement.setSpaceY(this.getYSpace());

		imageElement.createStyle();

		return imageElement;
	}

	public WFieldElement createFieldElement() {
		fieldElement = new WFieldElement();

		fieldElement.setMPrintFormatItem_ID(this.get_ID());
		fieldElement.setName(this.getName());
		fieldElement.setSeq(this.getSeqNo());
		fieldElement.setPrintText(this.getPrintName());
		fieldElement.setRelative(this.isRelativePosition());
		fieldElement.setPosX(this.getXPosition());
		fieldElement.setPosY(this.getYPosition());
		fieldElement.setSetNLPosition(this.isSetNLPosition());
		fieldElement.setAlignField(this.getFieldAlignmentType());
		fieldElement.setMaxWidth(this.getMaxWidth());
		fieldElement.setMaxHeight(this.getMaxHeight());
		fieldElement.setPrintColor(this.getAD_PrintColor_ID());
		fieldElement.setPrintFont(this.getAD_PrintFont_ID());
		fieldElement.setColumn(this.getAD_Column_ID());

		//Relative options
		fieldElement.setNextLine(this.isNextLine());
		fieldElement.setNextPage(this.isNextPage());
		fieldElement.setAligLine(this.getLineAlignmentType());
		fieldElement.setSpaceX(this.getXSpace());
		fieldElement.setSpaceY(this.getYSpace());

		fieldElement.createStyle();

		return fieldElement;
	}

	public WPrintFormatElement createPrintFormatElement() {
		printFormatElement = new WPrintFormatElement();

		printFormatElement.setMPrintFormatItem_ID(this.get_ID());
		printFormatElement.setName(this.getName());
		printFormatElement.setSeq(this.getSeqNo());
		printFormatElement.setPrintText(this.getPrintName());
		printFormatElement.setRelative(this.isRelativePosition());
		printFormatElement.setPosX(this.getXPosition());
		printFormatElement.setPosY(this.getYPosition());
		printFormatElement.setSetNLPosition(this.isSetNLPosition());
		printFormatElement.setColumn(this.getAD_Column_ID());
		printFormatElement.setPrintFormatChild(this.getAD_PrintFormatChild_ID());

		//Relative options
		printFormatElement.setNextLine(this.isNextLine());
		printFormatElement.setNextPage(this.isNextPage());
		printFormatElement.setAligLine(this.getLineAlignmentType());
		printFormatElement.setSpaceX(this.getXSpace());
		printFormatElement.setSpaceY(this.getYSpace());

		printFormatElement.readPrintFormat();

		printFormatElement.createStyle(WPrintFormatEditor.widthAreaEditor);

		return printFormatElement;
	}



	public String getHexColor() {
		return hexColor;
	}

	public void setHexColor() {
		this.hexColor = Colors.getHexColor(this.getAD_PrintColor_ID());
	}



}