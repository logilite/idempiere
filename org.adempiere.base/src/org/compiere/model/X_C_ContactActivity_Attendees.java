/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for C_ContactActivity_Attendees
 *  @author iDempiere (generated) 
 *  @version Release 2.1 - $Id$ */
public class X_C_ContactActivity_Attendees extends PO implements I_C_ContactActivity_Attendees, I_Persistent 
{

    /**
	 * 
	 */
	private static final long	serialVersionUID	= 6664606892376018628L;

	/** Standard Constructor */
    public X_C_ContactActivity_Attendees (Properties ctx, int C_ContactActivity_Attendees_ID, String trxName)
    {
      super (ctx, C_ContactActivity_Attendees_ID, trxName);
      /** if (C_ContactActivity_Attendees_ID == 0)
        {
        } */
    }

    /** Load Constructor */
    public X_C_ContactActivity_Attendees (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_C_ContactActivity_Attendees[")
        .append(get_ID()).append("]");
      return sb.toString();
    }


	/** Set C_ContactActivity_Attendees_ID.
		@param C_ContactActivity_Attendees_ID C_ContactActivity_Attendees_ID	  */
	public void setC_ContactActivity_Attendees_ID (int C_ContactActivity_Attendees_ID)
	{
		if (C_ContactActivity_Attendees_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_ContactActivity_Attendees_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_ContactActivity_Attendees_ID, Integer.valueOf(C_ContactActivity_Attendees_ID));
	}

	/** Get C_ContactActivity_Attendees_ID.
	@return C_ContactActivity_Attendees_ID	  */
	public int getC_ContactActivity_Attendees_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ContactActivity_Attendees_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ContactActivity getC_ContactActivity() throws RuntimeException
    {
		return (org.compiere.model.I_C_ContactActivity)MTable.get(getCtx(), org.compiere.model.I_C_ContactActivity.Table_Name)
			.getPO(getC_ContactActivity_ID(), get_TrxName());	}

	/** Set Contact Activity.
		@param C_ContactActivity_ID 
		Events, tasks, communications related to a contact
	  */
	public void setC_ContactActivity_ID (int C_ContactActivity_ID)
	{
		if (C_ContactActivity_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_ContactActivity_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_ContactActivity_ID, Integer.valueOf(C_ContactActivity_ID));
	}

	/** Get Contact Activity.
		@return Events, tasks, communications related to a contact
	  */
	public int getC_ContactActivity_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ContactActivity_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getSalesRep() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getSalesRep_ID(), get_TrxName());	}

	/** Set Sales Representative.
		@param SalesRep_ID 
		Sales Representative or Company Agent
	  */
	public void setSalesRep_ID (int SalesRep_ID)
	{
		if (SalesRep_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_SalesRep_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_SalesRep_ID, Integer.valueOf(SalesRep_ID));
	}

	/** Get Sales Representative.
		@return Sales Representative or Company Agent
	  */
	public int getSalesRep_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SalesRep_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}