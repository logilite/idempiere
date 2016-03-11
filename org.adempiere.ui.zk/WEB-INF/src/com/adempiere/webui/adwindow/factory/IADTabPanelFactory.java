package com.adempiere.webui.adwindow.factory;

import org.adempiere.webui.adwindow.IADTabpanel;

public interface IADTabPanelFactory {
	public IADTabpanel getInstance(String type);
}
