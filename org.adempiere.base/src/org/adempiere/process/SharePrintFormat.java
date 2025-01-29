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
package org.adempiere.process;

import java.util.logging.Level;

import org.compiere.model.MPrintFormatAccess;
import org.compiere.model.MRole;
import org.compiere.model.MUser;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Msg;

public class SharePrintFormat extends SvrProcess
{

	private int		p_AD_User_ID;
	private int		p_AD_Role_ID;
	private boolean	p_IsReadWrite = false;

	@Override
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_User_ID"))
				p_AD_User_ID = para[i].getParameterAsInt();
			else if (name.equals("AD_Role_ID"))
				p_AD_Role_ID = para[i].getParameterAsInt();
			else if (name.equals("IsReadWrite"))
				p_IsReadWrite = para[i].getParameterAsBoolean();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception
	{
		MPrintFormatAccess access = MPrintFormatAccess.get(getRecord_ID(), p_AD_User_ID, p_AD_Role_ID, get_TrxName());
		if (access != null && access.getAD_PrintFormat_Access_ID() > 0 && (access.isReadWrite() == p_IsReadWrite))
			return Msg.getMsg(getCtx(), MPrintFormatAccess.Msg_PF_Access_Already_Exists, true);

		MRole mRole = null;
		MUser mUser = null;
		Object[] infoPara = new Object[2];
		int access_ID = 0;

		if (access != null && access.getAD_PrintFormat_Access_ID() > 0)
			access_ID = access.getAD_PrintFormat_Access_ID();

		access = new MPrintFormatAccess(getCtx(), access_ID, get_TrxName());
		access.setAD_PrintFormat_ID(getRecord_ID());
		access.setIsReadWrite(p_IsReadWrite);
		if (p_AD_User_ID > 0)
		{
			mUser = MUser.get(getCtx(), p_AD_User_ID);
			access.setAD_User_ID(p_AD_User_ID);
			infoPara[0] = mUser.getName();
		}
		else
		{
			infoPara[0] = "N/A";
		}

		if (p_AD_Role_ID > 0)
		{
			mRole = MRole.get(getCtx(), p_AD_Role_ID);
			access.setAD_Role_ID(p_AD_Role_ID);
			infoPara[1] = mRole.getName();
		}
		else
		{
			infoPara[1] = "N/A";
		}

		access.saveEx();

		return Msg.getMsg(getCtx(), MPrintFormatAccess.Mag_PF_Access_Share_Successfully, infoPara);
	}

}
