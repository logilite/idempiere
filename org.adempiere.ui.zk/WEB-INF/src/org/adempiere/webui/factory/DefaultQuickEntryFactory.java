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

import org.adempiere.webui.grid.WQuickEntry;

public class DefaultQuickEntryFactory implements IQuickEntryFactory {

	@Override
	public WQuickEntry getInstance(int AD_Window_ID) {
			return new WQuickEntry(AD_Window_ID);
	}

	@Override
	public WQuickEntry getInstance(int WindowNo, int AD_Window_ID) {
		return new WQuickEntry(WindowNo, AD_Window_ID);
	}

	@Override
	public WQuickEntry getInstance(int WindowNo, int AD_Window_ID, int TabNo, int AD_Tab_ID)
	{
		return new WQuickEntry(WindowNo, AD_Window_ID, TabNo, AD_Tab_ID);
	}

	

}