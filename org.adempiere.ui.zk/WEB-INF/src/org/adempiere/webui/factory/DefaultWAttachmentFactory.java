/******************************************************************************
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *****************************************************************************/

package org.adempiere.webui.factory;

import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.WAttachment;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Default attachment factory
 * 
 * @author Logilite Technologies
 * @contributor Logilite Technologies
 * @contributor Adaxa
 * @since July 05, 2018
 */
public class DefaultWAttachmentFactory implements IWAttachmentFactory
{

	@Override
	public Window getWAttachment(int WindowNo, int AD_Attachment_ID, int AD_Table_ID, int Record_ID, String trxName)
	{
		return new WAttachment(WindowNo, AD_Attachment_ID, AD_Table_ID, Record_ID, trxName);
	}

	@Override
	public Window getWAttachment(int WindowNo, int AD_Attachment_ID, int AD_Table_ID, int Record_ID, String trxName,
			EventListener<Event> eventListener)
	{
		return new WAttachment(WindowNo, AD_Attachment_ID, AD_Table_ID, Record_ID, trxName, eventListener);
	}
}
