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
import org.adempiere.webui.factory.IQuickEntryFactory;
import org.adempiere.webui.grid.WQuickEntry;

public class QuickEntryServiceUtil {
	
	public static WQuickEntry getWQuickEntry(int AD_Window_ID) {
		WQuickEntry Object = null;
		List<IQuickEntryFactory> factoryList = Service.locator().list(IQuickEntryFactory.class).getServices();
		if (factoryList == null)
			return null;
		for (IQuickEntryFactory factory : factoryList) {
			Object = factory.getInstance(AD_Window_ID);
			if (Object != null)
				return Object;
		}
		return null;
	}
	
	public static WQuickEntry getWQuickEntry(int WindowNo, int AD_Window_ID) {
		WQuickEntry Object = null;
		List<IQuickEntryFactory> factoryList = Service.locator().list(IQuickEntryFactory.class).getServices();
		if (factoryList == null)
			return null;
		for (IQuickEntryFactory factory : factoryList) {
			Object = factory.getInstance(WindowNo, AD_Window_ID);
			if (Object != null)
				return Object;
		}
		return null;
	}
	
	public static WQuickEntry getWQuickEntry(int WindowNo, int AD_Window_ID, int TabNo, int AD_Tab_ID) {
		WQuickEntry Object = null;
		List<IQuickEntryFactory> factoryList = Service.locator().list(IQuickEntryFactory.class).getServices();
		if (factoryList == null)
			return null;
		for (IQuickEntryFactory factory : factoryList) {
			Object = factory.getInstance(WindowNo, AD_Window_ID, TabNo, AD_Tab_ID);
			if (Object != null)
				return Object;
		}
		return null;
	}
	
}