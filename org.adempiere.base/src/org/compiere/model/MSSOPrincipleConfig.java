package org.compiere.model;

import java.sql.ResultSet;
import java.util.Base64;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Util;

public class MSSOPrincipleConfig extends X_SSO_PrincipleConfig
{
	/**
	 * 
	 */
	private static final long					serialVersionUID				= -6330419996581130413L;

	private static final CCache<String, Object>	s_SSOPrincipleConfigCache		= new CCache<String, Object>(MSSOPrincipleConfig.class.getSimpleName(), 10, 0);

	private static final String					DEFAULT_SSO_PRINCIPLE_CACHEKEY	= "DEFAULT_SSO_PRINCIPLE";
	private static final String					ALL_SSO_CONFIG_CACHEKEY			= "ALL_SSO_CONFIG";

	private String								imageBase64Src					= null;

	public MSSOPrincipleConfig(Properties ctx, int MFA_SSOAuthentication_ID, String trxName)
	{
		super(ctx, MFA_SSOAuthentication_ID, trxName);
	}

	public MSSOPrincipleConfig(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (newRecord || is_ValueChanged(COLUMNNAME_IsDefault) || is_ValueChanged(COLUMNNAME_IsActive))
		{
			if (!isActive())
			{
				setIsDefault(false);
			}

			if (isDefault() && getDefaultSSOPrinciple() != null)
			{
				throw new AdempiereException("Then can be only one default SSO Authenticattion");
			}

			if (newRecord && getDefaultSSOPrinciple() == null)
			{
				setIsDefault(true);
			}

		}
		return super.beforeSave(newRecord);
	}

	public static MSSOPrincipleConfig getDefaultSSOPrinciple()
	{
		MSSOPrincipleConfig defaultConfig = (MSSOPrincipleConfig) s_SSOPrincipleConfigCache.get(DEFAULT_SSO_PRINCIPLE_CACHEKEY);
		if (defaultConfig != null)
			return defaultConfig;

		defaultConfig = new Query(Env.getCtx(), Table_Name, COLUMNNAME_IsDefault + " = 'Y'", null).setOnlyActiveRecords(true).firstOnly();

		if (defaultConfig != null)
			s_SSOPrincipleConfigCache.put(DEFAULT_SSO_PRINCIPLE_CACHEKEY, defaultConfig);

		return defaultConfig;
	}

	public static MSSOPrincipleConfig getSSOPrincipleConfig(String uuID)
	{
		if (Util.isEmpty(uuID))
			return null;

		MSSOPrincipleConfig cachedConfig = (MSSOPrincipleConfig) s_SSOPrincipleConfigCache.get(uuID);
		if (cachedConfig != null)
			return cachedConfig;

		cachedConfig = new Query(Env.getCtx(), Table_Name, COLUMNNAME_SSO_PrincipleConfig_UU + " = ?", null).setOnlyActiveRecords(true).setParameters(uuID)
																											.firstOnly();

		if (cachedConfig != null)
			s_SSOPrincipleConfigCache.put(uuID, cachedConfig);

		return cachedConfig;
	}

	public static List<MSSOPrincipleConfig> getAllConfig()
	{
		@SuppressWarnings("unchecked")
		List<MSSOPrincipleConfig> allConfigs = (List<MSSOPrincipleConfig>) s_SSOPrincipleConfigCache.get(ALL_SSO_CONFIG_CACHEKEY);
		if (allConfigs != null)
			return allConfigs;

		allConfigs = new Query(Env.getCtx(), Table_Name, null, null).setOnlyActiveRecords(true).list();

		if (allConfigs != null && !allConfigs.isEmpty())
			s_SSOPrincipleConfigCache.put(ALL_SSO_CONFIG_CACHEKEY, allConfigs);

		return allConfigs;
	}

	/**
	 * Generates a Base64-encoded image source string or retrieves the image URL.
	 * If binary data is available, it is encoded in Base64 and prefixed for direct use in HTML
	 * image tags.
	 * If no binary data exists but an image URL is available, the URL is returned.
	 *
	 * @return a string containing a Base64-encoded image source or the image URL, or null if
	 *         neither is available
	 */
	public String getBase64Src()
	{
		if (!Util.isEmpty(imageBase64Src))
			return imageBase64Src;

		if (getSSO_LoginButtonImage_ID() > 0)
		{
			MImage image = (MImage) getSSO_LoginButtonImage();
			if (image.getBinaryData() != null)
				imageBase64Src = "data:image;base64," + Base64.getEncoder().encodeToString(image.getBinaryData());
			else if (!Util.isEmpty(image.getImageURL()))
				imageBase64Src = image.getImageURL();
		}

		return imageBase64Src;
	}
}
