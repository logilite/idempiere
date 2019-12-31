package org.compiere.apps.form;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintPaper;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class PrintFormatEditor {

	/**
	 * @author Jonatas Silvestrini (jonatas.silvestrini@devcoffee.com.br,
	 *         https://www.devcoffee.com.br)
	 */



	protected String paperWidth, paperHeight, marginTop, marginBottom, marginLeft, marginRight;

	protected List<MPrintFormatItem> listMPrintFormatItem;

	protected MPrintPaper printPaper;

	protected List<String> getFormatTypeName() {
		List<String> names = new ArrayList<String>();
		String sql = "select name from ad_ref_list where ad_reference_id=255";

		ResultSet rs = null;
		PreparedStatement stmt = DB.prepareStatement(sql, null);

		try {
			rs = stmt.executeQuery();

			while (rs.next())
				names.add(rs.getString("name"));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(rs, stmt);
		}

		return names;
	}

	public void setPaperDimensions(int printPaperID) {
		printPaper = new MPrintPaper(Env.getCtx(), printPaperID, null);

		switch (printPaperID) {

		case 100:
			paperWidth = "792";
			paperHeight = "612";
			break;

		case 101:
			paperWidth = "612";
			paperHeight = "792";
			break;

		case 102:
			paperWidth = "842";
			paperHeight = "595";
			break;

		case 103:
			paperWidth = "595";
			paperHeight = "842";
			break;

		default:
			if (!(printPaper.getDimensionUnits() == null)) {
				int width = 0, height = 0;

				if (printPaper.getDimensionUnits().equals(MPrintPaper.DIMENSIONUNITS_Inch)) {
					width = Math.round(printPaper.getSizeX().floatValue() * 72);
					height = Math.round(printPaper.getSizeY().floatValue() * 72);
				} else if (printPaper.getDimensionUnits().equals(MPrintPaper.DIMENSIONUNITS_MM)) {
					width = Math.round(printPaper.getSizeX().floatValue() * 2.83465F);
					height = Math.round(printPaper.getSizeY().floatValue() * 2.83465F);
				}
				paperWidth = Integer.toString(width);
				paperHeight = Integer.toString(height);
			} else if (!(printPaper.getCode()==null)) {
				String code = printPaper.getCode();
				if (code.equals("iso-a4")) {
					if(printPaper.isLandscape()) {
						paperWidth = "842";
						paperHeight = "595";
					} else {
						paperWidth = "595";
						paperHeight = "842";
					}
				} else if (code.equals("na-letter")) {
					if(printPaper.isLandscape()) {
						paperWidth = "792";
						paperHeight = "612";
					} else {
						paperWidth = "612";
						paperHeight = "792";
					}
				}
			}
			break;
		}

		marginTop = Integer.toString(printPaper.getMarginTop());
		marginBottom = Integer.toString(printPaper.getMarginBottom());
		marginLeft = Integer.toString(printPaper.getMarginLeft());
		marginRight = Integer.toString(printPaper.getMarginRight());
	}

	protected List<MPrintFormatItem> loadMPrintFormatItem(int mPrintFormatID) {

		listMPrintFormatItem = new ArrayList<MPrintFormatItem>();
		MPrintFormat mpf = new MPrintFormat(Env.getCtx(), mPrintFormatID, null);

		for (int i = 0; i < mpf.getItemCount(); i++) {
			if (mpf.getItem(i).isPrinted()) {
				listMPrintFormatItem.add(mpf.getItem(i));
			}
		}
		return listMPrintFormatItem;

	}



}
