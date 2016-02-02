package com.adempiere.webui.adwindow.factory;

import java.util.List;

import org.adempiere.base.Service;
import org.adempiere.webui.adwindow.IADTabpanel;

public class ServiceUtil {
	public static IADTabpanel getADTabPanel(String type) {
		IADTabpanel Object = null;
		List<IADTabPanelFactory> factoryList = Service.locator().list(IADTabPanelFactory.class).getServices();
		if (factoryList == null)
			return null;
		for (IADTabPanelFactory factory : factoryList) {
			Object = factory.getInstance(type);
			if (Object != null)
				return Object;
		}
		return null;
	}
}
