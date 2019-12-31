package org.adempiere.webui.print.elements;

import org.compiere.print.MPrintFont;
import org.compiere.util.Env;

public class Fonts{

	public static String getCSSFont(int id) {
		int lastTracePos=0, arrayCont=0;
		String fontInfo[] = new String[3];
		String fontStyle;
		MPrintFont font = new MPrintFont(Env.getCtx(), id, null);

		String fontCode = font.getCode();

		if (fontCode.equals("."))
			return null;

		for (int i = 0; i < fontCode.length(); i++) {
			if (fontCode.charAt(i)=='-'){
				fontInfo[arrayCont] = fontCode.substring(lastTracePos, i);
				lastTracePos = i+1;
				arrayCont++;
			} else if (i == fontCode.length()-1) {
				if (lastTracePos == i)
					fontInfo[arrayCont] = Character.toString(fontCode.charAt(i));
				else
					fontInfo[arrayCont] = fontCode.substring(lastTracePos, fontCode.length());
			}
		}

		if (fontInfo[0].equals("dialog") || fontInfo[0].equals("sansserif"))
			fontStyle = "font-family: Helvetica;";
		else if (fontInfo[0].equals("monospaced"))
			fontStyle = "font-family: monospace;";
		else if (fontInfo[0].equals("serif"))
			fontStyle = "font-family: \"Times New Roman\";";
		else if (fontInfo[0].equals("dialoginput"))
			fontStyle = "font-family: sans-serif; font-stretch: condensed;";
		else
			fontStyle = "font-family: sans-serif;";

		if (fontInfo[1].equals("PLAIN"))
			fontStyle += "font-style: normal;";
		else if (fontInfo[1].equals("BOLD"))
			fontStyle += "font-weight: bold;";
		else if (fontInfo[1].equals("ITALIC"))
			fontStyle += "font-style: italic;";
		else
			fontStyle += "font-style: normal;";

		if (fontInfo[2]!=null)
			fontStyle += "font-size: " + fontInfo[2] + "px;";

		return fontStyle;
	}


}