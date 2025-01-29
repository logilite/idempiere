package org.adempiere.util;

public class BaseUtil
{
	/**
	 * Clean error or status message
	 * @param msg
	 * @return
	 */
	public static String cleanMessage(String msg) {
		String cleanMsg=msg;
		if(cleanMsg!=null) {
			cleanMsg =cleanMsg.replaceAll("org.adempiere.exceptions.AdempiereException:", "");
		}
		
		return cleanMsg;
	}
	
}
