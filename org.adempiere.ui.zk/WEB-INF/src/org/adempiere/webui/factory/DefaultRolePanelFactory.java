package org.adempiere.webui.factory;

import java.util.Properties;

import org.adempiere.webui.panel.RolePanel;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.util.KeyNamePair;

public class DefaultRolePanelFactory implements IRolePanelFactory
{

	@Override
	public RolePanel newInstance(Properties ctx, LoginWindow loginWindow, String userName, boolean show,
			KeyNamePair[] clientsKNPairs, boolean isClientDefined, MSSOPrincipalConfig principalConfig)
	{
		return new RolePanel(ctx, loginWindow, userName, show, clientsKNPairs, isClientDefined, principalConfig);
	}

}
