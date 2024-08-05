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


import javax.activation.DataSource;

import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.PrintInfo; 

/**
 * @author Logilite
 *
 */
public interface IEmailDialog
{

	public IEmailDialog createInstance(int ad_Table_ID);

	/**
	 * @param title
	 * @param from
	 * @param to
	 * @param subject
	 * @param message
	 * @param attachment
	 * @param m_WindowNo
	 * @param ad_Table_ID
	 * @param record_ID
	 * @param record_UU
	 * @param printInfo
	 */
	public void init(String title, MUser from, String to, String subject, String message, 
			DataSource attachment, int m_WindowNo, int ad_Table_ID, int record_ID, String record_UU, PrintInfo printInfo);

	public String getTo();
	public void addTo(String supportEMail, boolean isShowEmailFirst);
	public void addCC(String supportEMail, boolean isShowEmailFirst);
	public void addAttachment(DataSource screenShot, boolean isRemoveable);
	public void setPO(PO m_po);
	
	public void show();

	public void setAD_PInstance_ID(int pInstance_ID);

}
