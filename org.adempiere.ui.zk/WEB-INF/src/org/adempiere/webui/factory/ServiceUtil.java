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
import org.adempiere.webui.component.Window;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

public class ServiceUtil {

	/**
	 * Call to IWAttachmentFactory service
	 * 
	 * @param WindowNo
	 * @param AD_Attachment_ID
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param trxName
	 * @return {@link Window}
	 */
	public static Window getWAttachment(int WindowNo, int AD_Attachment_ID, int AD_Table_ID, int Record_ID,
			String trxName)
	{
		return getWAttachment(WindowNo, AD_Attachment_ID, AD_Table_ID, Record_ID, trxName, null);
	}

	/**
	 * Call to IWAttachmentFactory service
	 * 
	 * @param WindowNo
	 * @param AD_Attachment_ID
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param trxName
	 * @param eventListener
	 * @return {@link Window}
	 */
	public static Window getWAttachment(int WindowNo, int AD_Attachment_ID, int AD_Table_ID, int Record_ID,
			String trxName, EventListener<Event> eventListener)
	{
		Window window = null;
		List<IWAttachmentFactory> factoryList = Service.locator().list(IWAttachmentFactory.class).getServices();
		for (IWAttachmentFactory factory : factoryList)
		{
			window = factory.getWAttachment(WindowNo, AD_Attachment_ID, AD_Table_ID, Record_ID, trxName, eventListener);
			if (window != null)
				break;
		}
		return window;
	} // getWAttachment
}
