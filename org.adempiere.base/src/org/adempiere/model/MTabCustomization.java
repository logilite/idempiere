package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.Query;
import org.compiere.model.X_AD_Tab_Customization;

public class MTabCustomization extends X_AD_Tab_Customization {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3977886674683054829L;
	
	public static final int SUPERUSER = 100;

	public MTabCustomization(Properties ctx, int AD_Tab_Customization_ID, String trxName) {
		super(ctx, AD_Tab_Customization_ID, trxName);
		if (AD_Tab_Customization_ID == 0)
		{
			setIsActive(true); 
			
		}		
	}

	public MTabCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param AD_Tab_ID
	 */
	public static MTabCustomization get(Properties ctx, int AD_User_ID, int AD_Tab_ID, String trxName) {
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND AD_Tab_ID=?", trxName);
		return query.setClient_ID().setParameters(new Object[]{AD_User_ID, AD_Tab_ID}).first();
	}
	
	/**
	 * Save Tab Customization Data
	 *
	 * @param ctx - Context
	 * @param AD_Tab_ID - Tab ID
	 * @param AD_User_ID - User ID
	 * @param Custom - Customized Field IDs with it's Size
	 * @param GridView - Default preference of Grid view
	 * @param trxName - Transaction
	 * @return True if save successfully
	 */
	public static boolean saveData(Properties ctx, int AD_Tab_ID, int AD_User_ID, String Custom, String GridView,
			String trxName)
	{
		MTabCustomization tabCust = get(ctx, AD_User_ID, AD_Tab_ID, trxName);

		if (tabCust != null && tabCust.getAD_Tab_Customization_ID() > 0)
		{
			tabCust.setCustom(Custom);
			tabCust.setIsDisplayedGrid(GridView);
		}
		else
		{
			tabCust = new MTabCustomization(ctx, 0, trxName);
			tabCust.setAD_Tab_ID(AD_Tab_ID);
			tabCust.setAD_User_ID(AD_User_ID);
			tabCust.setCustom(Custom);
			tabCust.setIsDisplayedGrid(GridView);
		}

		return tabCust.save();

	} // saveTabCustomization

}
