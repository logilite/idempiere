package org.adempiere.webui.print.elements;

public class Colors {

	public static String getHexColor(int idColor) {
		String hexColor = null;

		switch (idColor) {
		case 100:
			hexColor = "#000000";
			break;

		case 104:
			hexColor = "#0045f9";
			break;

		case 119:
			hexColor = "#000a3f";
			break;

		case 114:
			hexColor = "#0d2c69";
			break;

		case 120:
			hexColor = "#916638";
			break;

		case 121:
			hexColor = "#5f340a";
			break;

		case 109:
			hexColor = "#79fcfe";
			break;

		case 106:
			hexColor = "#808080";
			break;

		case 105:
			hexColor = "#404040";
			break;

		case 107:
			hexColor = "#c0c0c0";
			break;

		case 115:
			hexColor = "#e0e0e0";
			break;

		case 103:
			hexColor = "#7cf43a";
			break;

		case 117:
			hexColor = "#1a3d07";
			break;

		case 116:
			hexColor = "#3b7b18";
			break;

		case 110:
			hexColor = "#e753fa";
			break;

		case 111:
			hexColor = "#f6c334";
			break;

		case 112:
			hexColor = "#f1b1b0";
			break;

		case 102:
			hexColor = "#e82e19";
			break;

		case 108:
			hexColor = "#ffffff";
			break;

		case 113:
			hexColor = "#fff841";
			break;

		default:
			hexColor = "#000000";
			break;
		}

		return hexColor;

	}

}
