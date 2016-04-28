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

package org.adempiere.webui.factory;

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
