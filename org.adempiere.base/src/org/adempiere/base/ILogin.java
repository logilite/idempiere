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

package org.adempiere.base;

import java.sql.Timestamp;

import org.compiere.db.CConnection;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.util.KeyNamePair;

public interface ILogin
{

	KeyNamePair[] getClients(String userId, String userPassword);
	
	KeyNamePair[] getClients(String userId, String userPassword, String roleTypes);

	KeyNamePair[] getClients(String userId, String userPassword, String roleTypes, Object token);

	String getLoginErrMsg();

	boolean isPasswordExpired();

	KeyNamePair[] getRoles(String m_userName, KeyNamePair clientKNPair);
	
	KeyNamePair[] getRoles(String m_userName, KeyNamePair clientKNPair, String roleTypes);

	KeyNamePair[] getOrgs(KeyNamePair roleKNPair);

	KeyNamePair[] getWarehouses(KeyNamePair organisationKNPair);

	String loadPreferences(KeyNamePair orgKNPair, KeyNamePair warehouseKNPair, Timestamp date, String printerName);

	String validateLogin(KeyNamePair orgKNPair);

	boolean batchLogin(Timestamp loginDate);

	KeyNamePair[] getRoles(CConnection cConnection, String string, String string2, boolean b);

	KeyNamePair[] getClients(KeyNamePair keyNamePair);

	KeyNamePair[] getRoles(String identity, String string);

	KeyNamePair[] getClients();
	
	void setSSOPrincipalConfig(MSSOPrincipalConfig principalConfig);
}
