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
import org.compiere.model.I_SSO_PrincipalConfig;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.util.CCache;
import org.compiere.util.Util;

/**
 * @author Logilite Technologies
 */
public class SSOUtils
{
	private static final CCache<Integer, ISSOPrincipalService>	s_SSOPrincipalServicecache	= new CCache<Integer, ISSOPrincipalService>(SSOUtils.class.getSimpleName(), 40, 0);

	public static final String									ERROR_VALIDATION_URL		= "/error.zul";

	public static final String									SSO_MODE_OSGI				= "SSO_MODE_OSGI";
	public static final String									SSO_MODE_WEBUI				= "SSO_MODE_WEBUI";
	public static final String									SSO_MODE_MONITOR			= "SSO_MODE_MONITOR";

	public static final String									ISCHANGEROLE_REQUEST		= "ISCHANGEROLE_REQUEST";

	public static final String									EVENT_ON_AFTER_SSOLOGIN		= "onAfterSSOLogin";

	// List of url patterns ignored for validating token
	private static ArrayList<String>							ignoreResourceURL			= null;

	static
	{
		ignoreResourceURL = new ArrayList<String>();
		ignoreResourceURL.add("zkau");
		ignoreResourceURL.add("images");
		ignoreResourceURL.add("css");
		ignoreResourceURL.add("res");
	}

	/**
	 * Retrieves an ISSOPrincipalService based on the provided UUID.
	 * If the UUID is empty or null, it attempts to retrieve the principal from a list of
	 * configurations.
	 * If only one configuration exists, it retrieves the principal for that configuration.
	 *
	 * @param  uuID the unique identifier for the SSO principal configuration
	 * @return      an ISSOPrincipalService object if found, or null otherwise
	 */
	public static ISSOPrincipalService getSSOPrincipalService(String uuID)
	{
		if (Util.isEmpty(uuID, true))
		{
			List<MSSOPrincipalConfig> configList = MSSOPrincipalConfig.getAllSSOPrincipalConfig();
			if (configList == null || configList.size() > 1)
				return null;
			else
				return getSSOPrincipalService(configList.get(0));
		}

		MSSOPrincipalConfig config = MSSOPrincipalConfig.getSSOPrincipalConfig(uuID);
		if (config == null)
			return null;
		return getSSOPrincipalService(config);
	}

	/**
	 * Retrieves the default ISSOPrincipalService.
	 * The default configuration is fetched, and if it exists, its associated principal is returned.
	 *
	 * @return an ISSOPrincipalService object based on the default configuration, or null if none exists
	 */
	public static ISSOPrincipalService getSSOPrincipalService()
	{
		MSSOPrincipalConfig config = MSSOPrincipalConfig.getDefaultSSOPrincipalConfig();
		if (config == null)
			return null;
		return getSSOPrincipalService(config);
	}

	/**
	 * Retrieves or creates an ISSOPrincipalService service based on the provided configuration.
	 * If the principal service is already cached, it is returned directly.
	 * Otherwise, it attempts to create a new service using available ISSOPrincipalFactory
	 * implementations
	 * and caches the result.
	 *
	 * @param  config the MSSOPrincipalConfig object containing the configuration details
	 * @return        an ISSOPrincipalService object if successfully created or found in the cache, or null
	 *                otherwise
	 */
	private static ISSOPrincipalService getSSOPrincipalService(MSSOPrincipalConfig config)
	{
		// Check cache for existing principal service
		if (s_SSOPrincipalServicecache.containsKey(config.getSSO_PrincipalConfig_ID()))
			return s_SSOPrincipalServicecache.get(config.getSSO_PrincipalConfig_ID());
		ISSOPrincipalService principal = null;
		List<ISSOPrincipalFactory> factories = Service.locator().list(ISSOPrincipalFactory.class).getServices();
		for (ISSOPrincipalFactory factory : factories)
		{
			principal = factory.getSSOPrincipalService(config);
			if (principal != null)
			{
				// Cache the newly created principal service
				s_SSOPrincipalServicecache.put(config.getSSO_PrincipalConfig_ID(), principal);
				break;
			}
		}
		return principal;
	}
	
	/**
	 * Retrieves the appropriate redirected URL based on the specified redirect mode and SSO
	 * configuration.
	 * The method checks the redirect mode and returns the corresponding URL from the configuration.
	 *
	 * @param  redirectMode the mode of redirection, such as SSO_MODE_OSGI, SSO_MODE_MONITOR, or
	 *                      others
	 * @param  config       the SSO principal configuration object containing the redirect URIs
	 * @return              the redirected URL as a string, or an empty string if the configuration
	 *                      is null
	 */
	public static String getRedirectedURL(String redirectMode, I_SSO_PrincipalConfig config)
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
	 * Create HTML page for error message
	 * @param error
	 * @return HTML error page
	 */
	public static String getCreateErrorResponce(String error)
	{
		return new StringBuffer("<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>")
						.append("<html xmlns='http://www.w3.org/1999/xhtml'>")
						.append("<head>")
						.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />")
						.append("<title>iDempiere Server Error</title>")
						.append("<link href='/standard.css' rel='stylesheet'/>")
						.append("</head>")
						.append("<body>")
						.append("<h1>iDempiere Server Error </h1>")
						.append("<p>The iDempiere Server encountered a unrecoverable error.</p>")
						.append("<p>")
						.append(error)
						.append("</p>")
						.append("<h2>Please notify the administrator.</h2>")
						.append("</body>")
						.append("</html>")
						.toString();

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
