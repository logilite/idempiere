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
package org.adempiere.webui.window;


import java.io.File;

import javax.activation.DataSource;

import org.compiere.model.MUser;
import org.compiere.model.PO; 

/**
 * @author Logilite
 *
 */
public interface IEmailDialog
{

	public void init(String title, MUser from, String to, String subject, String message,
			File attachment);

	public void addTo(String supportEMail, boolean isRemoveable);

	public void addAttachment(DataSource screenShot, boolean b);
	public void setPO(PO m_po);
	
	public void show();
	public IEmailDialog createInstance();

}
