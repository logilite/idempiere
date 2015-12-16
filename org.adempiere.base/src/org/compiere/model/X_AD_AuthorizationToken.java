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
import java.sql.Timestamp;
import java.util.Properties;

/** Generated Model for AD_AuthorizationToken
 *  @author iDempiere (generated) 
 *  @version Release 2.1 - $Id$ */
public class X_AD_AuthorizationToken extends PO implements I_AD_AuthorizationToken, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20150923L;

    /** Standard Constructor */
    public X_AD_AuthorizationToken (Properties ctx, int AD_AuthorizationToken_ID, String trxName)
    {
      super (ctx, AD_AuthorizationToken_ID, trxName);
      /** if (AD_AuthorizationToken_ID == 0)
        {
			setIsManual (true);
// Y
			setisWebservice (false);
// N
			setValidForSameClient (true);
// Y
        } */
    }

    /** Load Constructor */
    public X_AD_AuthorizationToken (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_AuthorizationToken[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** AD_Language AD_Reference_ID=106 */
	public static final int AD_LANGUAGE_AD_Reference_ID=106;
	/** Set Language.
		@param AD_Language 
		Language for this entity
	  */
	public void setAD_Language (String AD_Language)
	{

		set_ValueNoCheck (COLUMNNAME_AD_Language, AD_Language);
	}

	/** Get Language.
		@return Language for this entity
	  */
	public String getAD_Language () 
	{
		return (String)get_Value(COLUMNNAME_AD_Language);
	}

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_Name)
			.getPO(getAD_Role_ID(), get_TrxName());	}

	/** Set Role.
		@param AD_Role_ID 
		Responsibility Role
	  */
	public void setAD_Role_ID (int AD_Role_ID)
	{
		if (AD_Role_ID < 0) 
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
	}

	/** Get Role.
		@return Responsibility Role
	  */
	public int getAD_Role_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Manual.
		@param IsManual 
		This is a manual process
	  */
	public void setIsManual (boolean IsManual)
	{
		set_Value (COLUMNNAME_IsManual, Boolean.valueOf(IsManual));
	}

	/** Get Manual.
		@return This is a manual process
	  */
	public boolean isManual () 
	{
		Object oo = get_Value(COLUMNNAME_IsManual);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set isWebservice.
		@param isWebservice isWebservice	  */
	public void setisWebservice (boolean isWebservice)
	{
		set_Value (COLUMNNAME_isWebservice, Boolean.valueOf(isWebservice));
	}

	/** Get isWebservice.
		@return isWebservice	  */
	public boolean isWebservice () 
	{
		Object oo = get_Value(COLUMNNAME_isWebservice);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set LastAccessTime.
		@param LastAccessTime LastAccessTime	  */
	public void setLastAccessTime (Timestamp LastAccessTime)
	{
		set_Value (COLUMNNAME_LastAccessTime, LastAccessTime);
	}

	/** Get LastAccessTime.
		@return LastAccessTime	  */
	public Timestamp getLastAccessTime () 
	{
		return (Timestamp)get_Value(COLUMNNAME_LastAccessTime);
	}

	public org.compiere.model.I_M_Warehouse getM_Warehouse() throws RuntimeException
    {
		return (org.compiere.model.I_M_Warehouse)MTable.get(getCtx(), org.compiere.model.I_M_Warehouse.Table_Name)
			.getPO(getM_Warehouse_ID(), get_TrxName());	}

	/** Set Warehouse.
		@param M_Warehouse_ID 
		Storage Warehouse and Service Point
	  */
	public void setM_Warehouse_ID (int M_Warehouse_ID)
	{
		if (M_Warehouse_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_Warehouse_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_Warehouse_ID, Integer.valueOf(M_Warehouse_ID));
	}

	/** Get Warehouse.
		@return Storage Warehouse and Service Point
	  */
	public int getM_Warehouse_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Warehouse_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Remote IP.
		@param RemoteIP Remote IP	  */
	public void setRemoteIP (String RemoteIP)
	{
		set_Value (COLUMNNAME_RemoteIP, RemoteIP);
	}

	/** Get Remote IP.
		@return Remote IP	  */
	public String getRemoteIP () 
	{
		return (String)get_Value(COLUMNNAME_RemoteIP);
	}

	/** Set Timeout in Minutes.
		@param TimeOutMins Timeout in Minutes	  */
	public void setTimeOutMins (int TimeOutMins)
	{
		set_Value (COLUMNNAME_TimeOutMins, Integer.valueOf(TimeOutMins));
	}

	/** Get Timeout in Minutes.
		@return Timeout in Minutes	  */
	public int getTimeOutMins () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_TimeOutMins);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Token.
		@param Token Token	  */
	public void setToken (String Token)
	{
		set_Value (COLUMNNAME_Token, Token);
	}

	/** Get Token.
		@return Token	  */
	public String getToken () 
	{
		return (String)get_Value(COLUMNNAME_Token);
	}

	/** Set ValidForSameClient.
		@param ValidForSameClient ValidForSameClient	  */
	public void setValidForSameClient (boolean ValidForSameClient)
	{
		set_Value (COLUMNNAME_ValidForSameClient, Boolean.valueOf(ValidForSameClient));
	}

	/** Get ValidForSameClient.
		@return ValidForSameClient	  */
	public boolean isValidForSameClient () 
	{
		Object oo = get_Value(COLUMNNAME_ValidForSameClient);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Valid to.
		@param ValidTo 
		Valid to including this date (last day)
	  */
	public void setValidTo (Timestamp ValidTo)
	{
		set_Value (COLUMNNAME_ValidTo, ValidTo);
	}

	/** Get Valid to.
		@return Valid to including this date (last day)
	  */
	public Timestamp getValidTo () 
	{
		return (Timestamp)get_Value(COLUMNNAME_ValidTo);
	}
}