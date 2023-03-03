package org.adempiere.webui.factory;

import java.util.Properties;

import org.adempiere.webui.panel.RolePanel;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.util.KeyNamePair;

public interface IRolePanelFactory
{
	public RolePanel newInstance(Properties ctx, LoginWindow loginWindow, String userName, boolean show,
			KeyNamePair[] clientsKNPairs);
}
