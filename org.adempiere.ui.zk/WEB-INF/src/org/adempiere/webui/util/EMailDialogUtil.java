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
package org.adempiere.webui.util;

import java.util.List;

import org.adempiere.base.Service;
import org.adempiere.webui.window.IEmailDialog;

/**
 * @author Logilite
 */
public class EMailDialogUtil
{

	/**
	 * @return Email dialog instance of highest ranked from services
	 */
	public static IEmailDialog getEmailDialog(int AD_Table_ID)
	{
		List<IEmailDialog> serviceList = Service.locator().list(IEmailDialog.class).getServices();
		
		if (serviceList != null)
		{
			for (IEmailDialog dialog : serviceList)
			{
				dialog = dialog.createInstance(AD_Table_ID);
				if (dialog != null)
					return dialog;
			}
		}
		return null;
	}

}
