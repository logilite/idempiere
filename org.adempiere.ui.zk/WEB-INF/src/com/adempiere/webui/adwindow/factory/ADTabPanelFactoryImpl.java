package com.adempiere.webui.adwindow.factory;

import org.adempiere.webui.adwindow.ADSortTab;
import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.adwindow.IADTabpanel;

public class ADTabPanelFactoryImpl implements IADTabPanelFactory{

	@Override
	public IADTabpanel getInstance(String type) {
		if (type.equalsIgnoreCase("SORT")) {
			return new ADSortTab();		
		}else if(type.equalsIgnoreCase("FORM")){
			return new ADTabpanel();
		}
		return null;
	}

}
