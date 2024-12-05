/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.adempiere.base.sso;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.adempiere.base.Service;
import org.compiere.model.I_SSO_PrincipleConfig;
import org.compiere.model.MSSOPrincipleConfig;
import org.compiere.util.CCache;
import org.compiere.util.Util;

/**
 * @author Logilite Technologies
 */
public class SSOUtils
{
	private static final CCache<Integer, ISSOPrinciple>	s_SSOPrincipalcache		= new CCache<Integer, ISSOPrinciple>(SSOUtils.class.getSimpleName(), 40, 0);

	public static final String							ERROR_API				= "/error.html";

	public static final String							ERROR_VALIDATION		= "/error.zul";

	public static final String							SSO_MODE_OSGI			= "SSO_MODE_OSGI";
	public static final String							SSO_MODE_WEBUI			= "SSO_MODE_WEBUI";
	public static final String							SSO_MODE_MONITOR		= "SSO_MODE_MONITOR";

	public static final String							ISCHANGEROLE_REQUEST	= "ISCHANGEROLE_REQUEST";

	public static final String							EVENT_ON_AFTER_SSOLOGIN	= "onAfterSSOLogin";

	// List of url patterns ignored for validating token
	private static ArrayList<String>					ignoreResourceURL		= null;

	static
	{
		ignoreResourceURL = new ArrayList<String>();
		ignoreResourceURL.add("zkau");
		ignoreResourceURL.add("images");
		ignoreResourceURL.add("css");
		ignoreResourceURL.add("res");
	}

	/**
	 * Retrieves an ISSOPrinciple based on the provided UUID.
	 * If the UUID is empty or null, it attempts to retrieve the principle from a list of
	 * configurations.
	 * If only one configuration exists, it retrieves the principle for that configuration.
	 *
	 * @param  uuID the unique identifier for the SSO principle configuration
	 * @return      an ISSOPrinciple object if found, or null otherwise
	 */
	public static ISSOPrinciple getSSOPrinciple(String uuID)
	{
		if (Util.isEmpty(uuID, true))
		{
			List<MSSOPrincipleConfig> configList = MSSOPrincipleConfig.getAllConfig();
			if (configList == null || configList.size() > 1)
				return null;
			else
				return getSSOPrincipalService(configList.get(0));
		}

		MSSOPrincipleConfig config = MSSOPrincipleConfig.getSSOPrincipleConfig(uuID);
		if (config == null)
			return null;
		return getSSOPrincipalService(config);
	}

	/**
	 * Retrieves the default ISSOPrinciple.
	 * The default configuration is fetched, and if it exists, its associated principle is returned.
	 *
	 * @return an ISSOPrinciple object based on the default configuration, or null if none exists
	 */
	public static ISSOPrinciple getSSOPrinciple()
	{
		MSSOPrincipleConfig config = MSSOPrincipleConfig.getDefaultSSOPrinciple();
		if (config == null)
			return null;
		return getSSOPrincipalService(config);
	}

	/**
	 * Retrieves or creates an ISSOPrinciple service based on the provided configuration.
	 * If the principle service is already cached, it is returned directly.
	 * Otherwise, it attempts to create a new service using available ISSOPrincipleFactory
	 * implementations
	 * and caches the result.
	 *
	 * @param  config the MSSOPrincipleConfig object containing the configuration details
	 * @return        an ISSOPrinciple object if successfully created or found in the cache, or null
	 *                otherwise
	 */
	private static ISSOPrinciple getSSOPrincipalService(MSSOPrincipleConfig config)
	{
		// Check cache for existing principal service
		if (s_SSOPrincipalcache.containsKey(config.getSSO_PrincipleConfig_ID()))
			return s_SSOPrincipalcache.get(config.getSSO_PrincipleConfig_ID());
		ISSOPrinciple principle = null;
		List<ISSOPrincipleFactory> factories = Service.locator().list(ISSOPrincipleFactory.class).getServices();
		for (ISSOPrincipleFactory factory : factories)
		{
			principle = factory.getSSOPrincipleService(config);
			if (principle != null)
			{
				// Cache the newly created principal service
				s_SSOPrincipalcache.put(config.getSSO_PrincipleConfig_ID(), principle);
				break;
			}
		}
		return principle;
	}
	
	/**
	 * Retrieves the appropriate redirected URL based on the specified redirect mode and SSO
	 * configuration.
	 * The method checks the redirect mode and returns the corresponding URL from the configuration.
	 *
	 * @param  redirectMode the mode of redirection, such as SSO_MODE_OSGI, SSO_MODE_MONITOR, or
	 *                      others
	 * @param  config       the SSO principle configuration object containing the redirect URIs
	 * @return              the redirected URL as a string, or an empty string if the configuration
	 *                      is null
	 */
	public static String getRedirectedURL(String redirectMode, I_SSO_PrincipleConfig config)
	{
		if (config == null)
			return "";

		if (SSO_MODE_OSGI.equalsIgnoreCase(redirectMode))
			return config.getSSO_OSGIRedirectURIs();
		else if (SSO_MODE_MONITOR.equalsIgnoreCase(redirectMode))
			return config.getSSO_IDempMonitorRedirectURIs();
		return config.getSSO_ApplicationRedirectURIs();
	}
	
	/**
	 * If request is a resource request, do not redirected to identity provider for authentication
	 * @param request
	 * @param isWebUI
	 * @return true if request is a resource request
	 */
	public static boolean isResourceRequest(HttpServletRequest request, boolean isWebUI)
	{
		String[] urlpath = request.getServletPath().toLowerCase().split("/");
		if (isWebUI)
			return urlpath != null && urlpath.length > 1 && ignoreResourceURL.contains(urlpath[1]);
		else
			return urlpath != null && urlpath.length > 3 && ignoreResourceURL.contains(urlpath[3]);
	}
}
