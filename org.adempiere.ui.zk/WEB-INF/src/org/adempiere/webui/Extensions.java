/******************************************************************************
 * This file is part of Adempiere ERP Bazaar                                  *
 * http://www.adempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Jorg Viola			                                          *
 * Copyright (C) Contributors												  *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *****************************************************************************/
package org.adempiere.webui;

import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.apps.IProcessParameterListener;
import org.adempiere.webui.factory.IADTabPanelFactory;
import org.adempiere.webui.factory.IDashboardGadgetFactory;
import org.adempiere.webui.factory.IFormFactory;
import org.adempiere.webui.panel.ADForm;
import org.compiere.util.CCache;
import org.zkoss.zk.ui.Component;

/**
 *
 * @author viola
 * @author hengsin
 *
 */
public class Extensions {

	/**
	 *
	 * @param formId Java class name or equinox extension Id
	 * @return IFormController instance or null if formId not found
	 */
	public static ADForm getForm(String formId) {
		List<IFormFactory> factories = Service.locator().list(IFormFactory.class).getServices();
		if (factories != null) {
			for(IFormFactory factory : factories) {
				ADForm form = factory.newFormInstance(formId);
				if (form != null)
					return form;
			}
		}
		return null;
	}
	
	/**
	 * 
	 * @param processClass
	 * @param columnName
	 * @return list of parameter listener
	 */
	public static List<IProcessParameterListener> getProcessParameterListeners(String processClass, String columnName) {
		ServiceQuery query = new ServiceQuery();
		query.put("ProcessClass", processClass);
		if (columnName != null)
			query.put("|(ColumnName", columnName+")(ColumnName="+columnName+",*)(ColumnName="+"*,"+columnName+",*)(ColumnName=*,"+columnName+")");
		return Service.locator().list(IProcessParameterListener.class, null, query).getServices();
	}
	
	/**
	 * @param  tabType
	 * @return         {@link IADTabpanel}
	 */
	public static IADTabpanel getADTabPanel(String tabType)
	{
		IADTabpanel Object = null;
		List<IADTabPanelFactory> factoryList = Service.locator().list(IADTabPanelFactory.class).getServices();
		if (factoryList == null)
			return null;

		for (IADTabPanelFactory factory : factoryList)
		{
			Object = factory.getInstance(tabType);
			if (Object != null)
				return Object;
		}
		return null;
	} // getADTabPanel
	
	// partial migration of IDEMPIERE-4498
	private static final CCache<String, IServiceReferenceHolder<IDashboardGadgetFactory>> s_dashboardGadgetFactoryCache = new CCache<>(
			null, "IDashboardGadgetFactory", 100, false);

	/**
	 * 
	 * @param url
	 * @param parent
	 * @return Gadget component
	 */
	public static final Component getDashboardGadget(String url,
			Component parent) {
		IServiceReferenceHolder<IDashboardGadgetFactory> cache = s_dashboardGadgetFactoryCache
				.get(url);
		if (cache != null) {
			IDashboardGadgetFactory service = cache.getService();
			if (service != null) {
				Component component = service.getGadget(url, parent);
				if (component != null)
					return component;
			}
			s_dashboardGadgetFactoryCache.remove(url);
		}

		List<IServiceReferenceHolder<IDashboardGadgetFactory>> f = Service
				.locator().list(IDashboardGadgetFactory.class)
				.getServiceReferences();
		for (IServiceReferenceHolder<IDashboardGadgetFactory> factory : f) {
			IDashboardGadgetFactory service = factory.getService();
			if (service != null) {
				Component component = service.getGadget(url, parent);
				if (component != null)
					return component;
			}
		}

		return null;
	}
}
