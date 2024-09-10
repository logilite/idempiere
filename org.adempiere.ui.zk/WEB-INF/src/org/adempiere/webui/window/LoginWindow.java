/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *                                                                            *
 * Sponsors:                                                                  *
 * - Idalica Corporation                                                      *
 *****************************************************************************/

package org.adempiere.webui.window;

import java.util.Locale;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.ILogin;
import org.adempiere.base.sso.ISSOPrinciple;
import org.adempiere.base.sso.SSOUtils;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.IWebClient;
import org.adempiere.webui.component.FWindow;
import org.adempiere.webui.panel.ChangePasswordPanel;
import org.adempiere.webui.panel.LoginPanel;
import org.adempiere.webui.panel.ResetPasswordPanel;
import org.adempiere.webui.panel.RolePanel;
import org.adempiere.webui.session.SessionContextListener;
import org.adempiere.webui.sso.filter.SSOWebuiFilter;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.util.ZkSSOUtils;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.util.Locales;
import org.zkoss.web.Attributes;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zk.ui.util.Clients;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class LoginWindow extends FWindow implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5169830531440825871L;
	protected static final CLogger log = CLogger.getCLogger(LoginWindow.class);

	protected IWebClient app;
    protected Properties ctx;
    protected LoginPanel pnlLogin;
    protected ResetPasswordPanel pnlResetPassword;
    protected ChangePasswordPanel pnlChangePassword;
    protected RolePanel pnlRole;

    public LoginWindow() {}

    public void init(IWebClient app)
    {
    	this.ctx = Env.getCtx();
        this.app = app;
        initComponents();
		if (pnlLogin != null)
			this.appendChild(pnlLogin);
        this.setStyle("background-color: transparent");
        // add listener on 'ENTER' key for the login window
        addEventListener(Events.ON_OK,this);
        setWidgetListener("onOK", "zAu.cmd0.showBusy(null)");
    }

	private void initComponents()
	{
		Object result = getDesktop().getSession().getAttribute(ISSOPrinciple.SSO_PRINCIPLE_SESSION_NAME);
		if (result == null)
		{
			createLoginPanel();
		}
		else
		{
			ssoLogin(result);
		}
	}

	/**
	 * Show role panel after SSO authentication.
	 * 
	 * @param result session principle to get user and language.
	 */
	private void ssoLogin(Object result)
	{
		String errorMessage = null;
		try
		{
			ISSOPrinciple ssoPrinciple = SSOWebuiFilter.getSSOPrinciple();
			String username = ssoPrinciple.getUserName(result);
			Language language = ssoPrinciple.getLanguage(result);
			boolean isEmailLogin = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
			if (Util.isEmpty(username))
				throw new AdempiereException("No Apps " + (isEmailLogin ? "Email" : "User"));
			if (language == null)
				language = Language.getBaseLanguage();

			Env.setContext(ctx, UserPreference.LANGUAGE_NAME, language.getName());
			Locale locale = language.getLocale();
			getDesktop().getSession().setAttribute(Attributes.PREFERRED_LOCALE, locale);

			ILogin login = Core.getLogin(ctx);
			login.setIsSSOLogin(true);
			boolean isShowRolePanel = MSysConfig.getBooleanValue(MSysConfig.SSO_SELECT_ROLE, true);
			
			// show role panel when change role
			if (getDesktop().getSession().hasAttribute(SSOUtils.ISCHANGEROLE_REQUEST))
				isShowRolePanel = isShowRolePanel || (boolean) getDesktop().getSession().getAttribute(SSOUtils.ISCHANGEROLE_REQUEST);

			KeyNamePair[] clients = login.getClients(username, null, null);
			if (clients != null)
				loginOk(username, isShowRolePanel, clients, true);
			else
			{
				log.log(Level.WARNING,"No Client found for user:" + username);
				ValueNamePair error = CLogger.retrieveError();
				if (error == null)
					error = CLogger.retrieveWarning();
				errorMessage = Msg.getMsg(language, error.getValue(), new Object[] { error.getName() });
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			errorMessage = e.getLocalizedMessage();
		}

		if (!Util.isEmpty(errorMessage))
		{
			ZkSSOUtils.setErrorMessageText(errorMessage);
			Executions.sendRedirect(SSOUtils.ERROR_VALIDATION);
		}
	}

	protected void createLoginPanel() {
		pnlLogin = new LoginPanel(ctx, this);
	}

	public void loginOk(String userName, boolean show, KeyNamePair[] clientsKNPairs)
	{
		loginOk(userName, show, clientsKNPairs, false);
	}

    public void loginOk(String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isSSOLogin)
    {
        createRolePanel(userName, show, clientsKNPairs, isSSOLogin);
        this.getChildren().clear();
        this.appendChild(pnlRole);
    }

	protected void createRolePanel(String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isSSOLogin) {
		pnlRole = Extensions.getRolePanel(ctx, this, userName, show, clientsKNPairs,isSSOLogin);
		if (!pnlRole.isShow())
			pnlRole.validateRoles();
	}
    
    public void changePassword(String userName, String userPassword, boolean show, KeyNamePair[] clientsKNPairs)
    {
    	Clients.clearBusy();
		createChangePasswordPanel(userName, userPassword, show, clientsKNPairs);
        this.getChildren().clear();
        this.appendChild(pnlChangePassword);
    }

	protected void createChangePasswordPanel(String userName,
			String userPassword, boolean show, KeyNamePair[] clientsKNPairs) {
		pnlChangePassword = new ChangePasswordPanel(ctx, this, userName, userPassword, show, clientsKNPairs);
	}
    
    public void resetPassword(String userName, boolean noSecurityQuestion)
    {
    	createResetPasswordPanel(userName, noSecurityQuestion);
        this.getChildren().clear();
        this.appendChild(pnlResetPassword);
    }

	protected void createResetPasswordPanel(String userName,
			boolean noSecurityQuestion) {
		pnlResetPassword = new ResetPasswordPanel(ctx, this, userName, noSecurityQuestion);
	}

    public void loginCompleted()
    {
        app.loginCompleted();
    }

    public void loginCancelled()
    {
        createLoginPanel();
        this.getChildren().clear();
        this.appendChild(pnlLogin);
    }

    public void onEvent(Event event)
    {
       // check that 'ENTER' key is pressed
       if (Events.ON_OK.equals(event.getName()))
       {
          /**
           * LoginWindow can have as a child, either LoginPanel or RolePanel
           * If LoginPanel is currently a child, validate login when
           * 'ENTER' key is pressed  or validate Roles if RolePanel is
           * currently a child
           */
           RolePanel rolePanel = (RolePanel)this.getFellowIfAny("rolePanel");
           if (rolePanel != null)
           {
               rolePanel.validateRoles();
               return;
           }
           
           LoginPanel loginPanel = (LoginPanel)this.getFellowIfAny("loginPanel");
           if (loginPanel != null)
           {
               loginPanel.validateLogin();
               return;
           }
           
           ChangePasswordPanel changePasswordPanel = (ChangePasswordPanel)this.getFellowIfAny("changePasswordPanel");
           if (changePasswordPanel != null){
        	   changePasswordPanel.validateChangePassword();
        	   return;
           }
           
           ResetPasswordPanel resetPasswordPanel = (ResetPasswordPanel)this.getFellowIfAny("resetPasswordPanel");
           if (resetPasswordPanel != null){
        	   resetPasswordPanel.validate();
        	   return;
           }
       }
    }
    
    /**
     * Show change role window
     * @param locale
     * @param ctx
     */
    public void changeRole(Locale locale, Properties ctx)
    {
    	Env.setCtx(ctx);
    	getDesktop().getSession().setAttribute(SessionContextListener.SESSION_CTX, ctx);
    	
    	//reload theme preference
    	PageDefinition pageDefintion = Executions.getCurrent().getPageDefinition(ThemeManager.getThemeResource("preference.zul"));
        Executions.createComponents(pageDefintion, this, null);
        
    	getDesktop().getSession().setAttribute(Attributes.PREFERRED_LOCALE, locale);
    	Locales.setThreadLocal(locale);    	
    	ILogin login = Core.getLogin(Env.getCtx());
    	MUser user = MUser.get(ctx, Env.getAD_User_ID(ctx));
    	String loginName;
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		if (email_login)
			loginName = user.getEMail();
		else
			loginName = user.getLDAPUser() != null ? user.getLDAPUser() : user.getName();
    	loginOk(loginName, true, login.getClients());
    	getDesktop().getSession().setAttribute("Check_AD_User_ID", Env.getAD_User_ID(ctx));
    	pnlRole.setChangeRole(true);
    	pnlRole.changeRole(ctx);
    }
}
