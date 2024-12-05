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
package org.adempiere.webui.sso.filter;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.adempiere.base.sso.ISSOPrinciple;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 * Request filter class for the SSO authentication
 * 
 * @author Logilite Technologies
 */
public class SSOWebUIFilter implements Filter
{
	/** Logger */
	protected static CLogger		log				= CLogger.getCLogger(SSOWebUIFilter.class);

	/**
	 * AdempiereMonitorFilter
	 */
	public SSOWebUIFilter()
	{
		super();
	} // AdempiereMonitorFilter

	/**
	 * Filter
	 * 
	 * @param  request          request
	 * @param  response         response
	 * @param  chain            chain
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{

		boolean isSSOEnable = MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false);
		if (isSSOEnable && request instanceof HttpServletRequest)
		{
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			HttpServletResponse httpResponse = (HttpServletResponse) response;
			boolean isRedirectToLoginOnError = false; 
			
			// Ignore the resource request	
			if (SSOUtils.isResourceRequest(httpRequest, true))
			{
				chain.doFilter(request, response);
				return;
			}
			
			boolean isProviderFromSession = false;
			String provider = httpRequest.getParameter(ISSOPrinciple.SSO_SELECTED_PROVIDER);
			if (Util.isEmpty(provider) && httpRequest.getSession().getAttribute(ISSOPrinciple.SSO_SELECTED_PROVIDER) != null)
			{
				isProviderFromSession = true;
				provider = (String) httpRequest.getSession().getAttribute(ISSOPrinciple.SSO_SELECTED_PROVIDER);
			}

			ISSOPrinciple m_SSOPrinciple = null;
			try
			{
				m_SSOPrinciple = SSOUtils.getSSOPrinciple(provider);

				if (m_SSOPrinciple != null)
				{
					if (m_SSOPrinciple.hasAuthenticationCode(httpRequest, httpResponse))
					{
						// Use authentication code get get token
						m_SSOPrinciple.getAuthenticationToken(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
						String currentUri = httpRequest.getRequestURL().toString();
						if (!httpResponse.isCommitted())
						{
							// Redirect to default request URL after authentication and handle query string.
							Object queryString = httpRequest.getSession().getAttribute(ISSOPrinciple.SSO_QUERY_STRING);
							if (queryString != null && queryString instanceof String && !Util.isEmpty((String) queryString))
								currentUri += "?" + (String) queryString;
							httpRequest.getSession().removeAttribute(ISSOPrinciple.SSO_QUERY_STRING);
							httpResponse.sendRedirect(currentUri);
						}
						return;
					}
					else if (!m_SSOPrinciple.isAuthenticated(httpRequest, httpResponse))
					{
						if (isProviderFromSession)
						{
							// If there is an issue on the SSO provide side & if a request is not the
							// Authentication code or refresh request then have to remove the provide from the
							// session.
							httpRequest.getSession().removeAttribute(ISSOPrinciple.SSO_SELECTED_PROVIDER);
						}
						else
						{
							// Save the param that comes with orignal request so can be passed after
							// login with SSO
							String referrerUrl = httpRequest.getParameter(ISSOPrinciple.SSO_QUERY_STRING);
							if (Util.isEmpty(referrerUrl) && Util.isEmpty(provider) && !Util.isEmpty(httpRequest.getQueryString()))
								referrerUrl = httpRequest.getQueryString();

							httpRequest.getSession().setAttribute(ISSOPrinciple.SSO_QUERY_STRING, referrerUrl);
							httpRequest.getSession().setAttribute(ISSOPrinciple.SSO_SELECTED_PROVIDER, provider);
							// Redirect to SSO sing in page for authentication
							m_SSOPrinciple.redirectForAuthentication(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
							return;
						}
					}
					else if (m_SSOPrinciple.isAccessTokenExpired(httpRequest, httpResponse))
					{
						// Refresh token after expired
						isRedirectToLoginOnError = true;
						m_SSOPrinciple.refreshToken(httpRequest, httpResponse, SSOUtils.SSO_MODE_WEBUI);
					}
				}
			}
			catch (Throwable exc)
			{
				log.log(Level.SEVERE, "Exception while authenticating: ",exc);
				if (m_SSOPrinciple != null)
					m_SSOPrinciple.removePrincipleFromSession(httpRequest);
				httpRequest.getSession().removeAttribute(ISSOPrinciple.SSO_SELECTED_PROVIDER);
				httpRequest.getSession().removeAttribute(ISSOPrinciple.SSO_QUERY_STRING);
				m_SSOPrinciple = null;
				if(isRedirectToLoginOnError)
				{
					httpResponse.sendRedirect("webui/index.zul");
				}
				else
				{
					httpResponse.setStatus(500);
					httpResponse.sendRedirect(SSOUtils.ERROR_API);
				}
				return;
			}
		}
		chain.doFilter(request, response);
		return;
	} // doFilter

	@Override
	public void destroy()
	{

	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException
	{
	}
	
} // AdempiereMonitorFilter
