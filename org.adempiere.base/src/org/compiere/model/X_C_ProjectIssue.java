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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for C_ProjectIssue
 *  @author iDempiere (generated)
 *  @version Release 11 - $Id$ */
@org.adempiere.base.Model(table="C_ProjectIssue")
public class X_C_ProjectIssue extends PO implements I_C_ProjectIssue, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250626L;

    /** Standard Constructor */
    public X_C_ProjectIssue (Properties ctx, int C_ProjectIssue_ID, String trxName)
    {
      super (ctx, C_ProjectIssue_ID, trxName);
      /** if (C_ProjectIssue_ID == 0)
        {
			setC_Project_ID (0);
			setC_ProjectIssue_ID (0);
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setIsApproved (false);
// N
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_ProjectIssue WHERE C_Project_ID=@C_Project_ID@
			setM_AttributeSetInstance_ID (0);
			setM_Locator_ID (0);
			setMovementDate (new Timestamp( System.currentTimeMillis() ));
			setMovementQty (Env.ZERO);
			setM_Product_ID (0);
			setPosted (false);
// N
			setProcessed (false);
        } */
    }

    /** Standard Constructor */
    public X_C_ProjectIssue (Properties ctx, int C_ProjectIssue_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_ProjectIssue_ID, trxName, virtualColumns);
      /** if (C_ProjectIssue_ID == 0)
        {
			setC_Project_ID (0);
			setC_ProjectIssue_ID (0);
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setIsApproved (false);
// N
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_ProjectIssue WHERE C_Project_ID=@C_Project_ID@
			setM_AttributeSetInstance_ID (0);
			setM_Locator_ID (0);
			setMovementDate (new Timestamp( System.currentTimeMillis() ));
			setMovementQty (Env.ZERO);
			setM_Product_ID (0);
			setPosted (false);
// N
			setProcessed (false);
        } */
    }

    /** Standard Constructor */
    public X_C_ProjectIssue (Properties ctx, String C_ProjectIssue_UU, String trxName)
    {
      super (ctx, C_ProjectIssue_UU, trxName);
      /** if (C_ProjectIssue_UU == null)
        {
			setC_Project_ID (0);
			setC_ProjectIssue_ID (0);
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setIsApproved (false);
// N
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_ProjectIssue WHERE C_Project_ID=@C_Project_ID@
			setM_AttributeSetInstance_ID (0);
			setM_Locator_ID (0);
			setMovementDate (new Timestamp( System.currentTimeMillis() ));
			setMovementQty (Env.ZERO);
			setM_Product_ID (0);
			setPosted (false);
// N
			setProcessed (false);
        } */
    }

    /** Standard Constructor */
    public X_C_ProjectIssue (Properties ctx, String C_ProjectIssue_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, C_ProjectIssue_UU, trxName, virtualColumns);
      /** if (C_ProjectIssue_UU == null)
        {
			setC_Project_ID (0);
			setC_ProjectIssue_ID (0);
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setIsApproved (false);
// N
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_ProjectIssue WHERE C_Project_ID=@C_Project_ID@
			setMovementDate (new Timestamp( System.currentTimeMillis() ));
			setMovementQty (Env.ZERO);
			setPosted (false);
// N
			setProcessed (false);
        } */
    }

    /** Load Constructor */
    public X_C_ProjectIssue (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_ProjectIssue[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_A_Asset getA_Asset() throws RuntimeException
    {
		return (org.compiere.model.I_A_Asset)MTable.get(getCtx(), org.compiere.model.I_A_Asset.Table_Name)
			.getPO(getA_Asset_ID(), get_TrxName());	}

	/** Set Asset.
		@param A_Asset_ID 
		Asset used internally or by customers
	  */
	public void setA_Asset_ID (int A_Asset_ID)
	{
		if (A_Asset_ID < 1) 
			set_Value (COLUMNNAME_A_Asset_ID, null);
		else 
			set_Value (COLUMNNAME_A_Asset_ID, Integer.valueOf(A_Asset_ID));
	}

	/** Get Asset.
		@return Asset used internally or by customers
	  */
	public int getA_Asset_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_A_Asset_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Amount.
		@param Amt 
		Amount
	  */
	public void setAmt (BigDecimal Amt)
	{
		set_Value (COLUMNNAME_Amt, Amt);
	}

	/** Get Amount.
		@return Amount
	  */
	public BigDecimal getAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Amt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException
    {
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_Name)
			.getPO(getC_Charge_ID(), get_TrxName());	}

	/** Set Charge.
		@param C_Charge_ID 
		Additional document charges
	  */
	public void setC_Charge_ID (int C_Charge_ID)
	{
		if (C_Charge_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, Integer.valueOf(C_Charge_ID));
	}

	/** Get Charge.
		@return Additional document charges
	  */
	public int getC_Charge_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_CostCenter getC_CostCenter() throws RuntimeException
    {
		return (org.compiere.model.I_C_CostCenter)MTable.get(getCtx(), org.compiere.model.I_C_CostCenter.Table_Name)
			.getPO(getC_CostCenter_ID(), get_TrxName());	}

	/** Set Cost Center.
		@param C_CostCenter_ID Cost Center	  */
	public void setC_CostCenter_ID (int C_CostCenter_ID)
	{
		if (C_CostCenter_ID < 1) 
			set_Value (COLUMNNAME_C_CostCenter_ID, null);
		else 
			set_Value (COLUMNNAME_C_CostCenter_ID, Integer.valueOf(C_CostCenter_ID));
	}

	/** Get Cost Center.
		@return Cost Center	  */
	public int getC_CostCenter_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CostCenter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Department getC_Department() throws RuntimeException
    {
		return (org.compiere.model.I_C_Department)MTable.get(getCtx(), org.compiere.model.I_C_Department.Table_Name)
			.getPO(getC_Department_ID(), get_TrxName());	}

	/** Set Department.
		@param C_Department_ID Department	  */
	public void setC_Department_ID (int C_Department_ID)
	{
		if (C_Department_ID < 1) 
			set_Value (COLUMNNAME_C_Department_ID, null);
		else 
			set_Value (COLUMNNAME_C_Department_ID, Integer.valueOf(C_Department_ID));
	}

	/** Get Department.
		@return Department	  */
	public int getC_Department_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Department_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getC_Employee() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_Employee_ID(), get_TrxName());	}

	/** Set Employee.
		@param C_Employee_ID 
		Identifies a Business Partner
	  */
	public void setC_Employee_ID (int C_Employee_ID)
	{
		if (C_Employee_ID < 1) 
			set_Value (COLUMNNAME_C_Employee_ID, null);
		else 
			set_Value (COLUMNNAME_C_Employee_ID, Integer.valueOf(C_Employee_ID));
	}

	/** Get Employee.
		@return Identifies a Business Partner
	  */
	public int getC_Employee_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Employee_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_InvoiceLine getC_InvoiceLine() throws RuntimeException
    {
		return (org.compiere.model.I_C_InvoiceLine)MTable.get(getCtx(), org.compiere.model.I_C_InvoiceLine.Table_Name)
			.getPO(getC_InvoiceLine_ID(), get_TrxName());	}

	/** Set Invoice Line.
		@param C_InvoiceLine_ID 
		Invoice Detail Line
	  */
	public void setC_InvoiceLine_ID (int C_InvoiceLine_ID)
	{
		if (C_InvoiceLine_ID < 1) 
			set_Value (COLUMNNAME_C_InvoiceLine_ID, null);
		else 
			set_Value (COLUMNNAME_C_InvoiceLine_ID, Integer.valueOf(C_InvoiceLine_ID));
	}

	/** Get Invoice Line.
		@return Invoice Detail Line
	  */
	public int getC_InvoiceLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_InvoiceLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Project getC_Project() throws RuntimeException
	{
		return (org.compiere.model.I_C_Project)MTable.get(getCtx(), org.compiere.model.I_C_Project.Table_ID)
			.getPO(getC_Project_ID(), get_TrxName());
	}

	/** Set Project.
		@param C_Project_ID Financial Project
	*/
	public void setC_Project_ID (int C_Project_ID)
	{
		if (C_Project_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Project_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Project_ID, Integer.valueOf(C_Project_ID));
	}

	/** Get Project.
		@return Financial Project
	  */
	public int getC_Project_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Project_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair()
    {
        return new KeyNamePair(get_ID(), String.valueOf(getC_Project_ID()));
    }

	/** Set Project Issue.
		@param C_ProjectIssue_ID Project Issues (Material, Labor)
	*/
	public void setC_ProjectIssue_ID (int C_ProjectIssue_ID)
	{
		if (C_ProjectIssue_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_ProjectIssue_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_ProjectIssue_ID, Integer.valueOf(C_ProjectIssue_ID));
	}

	/** Get Project Issue.
		@return Project Issues (Material, Labor)
	  */
	public int getC_ProjectIssue_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ProjectIssue_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_ProjectIssue_UU.
		@param C_ProjectIssue_UU C_ProjectIssue_UU
	*/
	public void setC_ProjectIssue_UU (String C_ProjectIssue_UU)
	{
		set_Value (COLUMNNAME_C_ProjectIssue_UU, C_ProjectIssue_UU);
	}

	/** Get C_ProjectIssue_UU.
		@return C_ProjectIssue_UU	  */
	public String getC_ProjectIssue_UU()
	{
		return (String)get_Value(COLUMNNAME_C_ProjectIssue_UU);
	}

	public org.compiere.model.I_C_ProjectLine getC_ProjectLine() throws RuntimeException
    {
		return (org.compiere.model.I_C_ProjectLine)MTable.get(getCtx(), org.compiere.model.I_C_ProjectLine.Table_Name)
			.getPO(getC_ProjectLine_ID(), get_TrxName());	}

	/** Set Project Line.
		@param C_ProjectLine_ID 
		Task or step in a project
	  */
	public void setC_ProjectLine_ID (int C_ProjectLine_ID)
	{
		if (C_ProjectLine_ID < 1) 
			set_Value (COLUMNNAME_C_ProjectLine_ID, null);
		else 
			set_Value (COLUMNNAME_C_ProjectLine_ID, Integer.valueOf(C_ProjectLine_ID));
	}

	/** Get Project Line.
		@return Task or step in a project
	  */
	public int getC_ProjectLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ProjectLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** DocAction AD_Reference_ID=135 */
	public static final int DOCACTION_AD_Reference_ID=135;
	/** &lt;None&gt; = -- */
	public static final String DOCACTION_None = "--";
	/** Approve = AP */
	public static final String DOCACTION_Approve = "AP";
	/** Close = CL */
	public static final String DOCACTION_Close = "CL";
	/** Complete = CO */
	public static final String DOCACTION_Complete = "CO";
	/** Invalidate = IN */
	public static final String DOCACTION_Invalidate = "IN";
	/** Post = PO */
	public static final String DOCACTION_Post = "PO";
	/** Prepare = PR */
	public static final String DOCACTION_Prepare = "PR";
	/** Reverse - Accrual = RA */
	public static final String DOCACTION_Reverse_Accrual = "RA";
	/** Reverse - Correct = RC */
	public static final String DOCACTION_Reverse_Correct = "RC";
	/** Re-activate = RE */
	public static final String DOCACTION_Re_Activate = "RE";
	/** Reject = RJ */
	public static final String DOCACTION_Reject = "RJ";
	/** Void = VO */
	public static final String DOCACTION_Void = "VO";
	/** Wait Complete = WC */
	public static final String DOCACTION_WaitComplete = "WC";
	/** Unlock = XL */
	public static final String DOCACTION_Unlock = "XL";
	/** Set Document Action.
		@param DocAction The targeted status of the document
	*/
	public void setDocAction (String DocAction)
	{

		set_Value (COLUMNNAME_DocAction, DocAction);
	}

	/** Get Document Action.
		@return The targeted status of the document
	  */
	public String getDocAction()
	{
		return (String)get_Value(COLUMNNAME_DocAction);
	}

	/** DocStatus AD_Reference_ID=131 */
	public static final int DOCSTATUS_AD_Reference_ID=131;
	/** Unknown = ?? */
	public static final String DOCSTATUS_Unknown = "??";
	/** Approved = AP */
	public static final String DOCSTATUS_Approved = "AP";
	/** Closed = CL */
	public static final String DOCSTATUS_Closed = "CL";
	/** Completed = CO */
	public static final String DOCSTATUS_Completed = "CO";
	/** Drafted = DR */
	public static final String DOCSTATUS_Drafted = "DR";
	/** Invalid = IN */
	public static final String DOCSTATUS_Invalid = "IN";
	/** In Progress = IP */
	public static final String DOCSTATUS_InProgress = "IP";
	/** Not Approved = NA */
	public static final String DOCSTATUS_NotApproved = "NA";
	/** Reversed = RE */
	public static final String DOCSTATUS_Reversed = "RE";
	/** Voided = VO */
	public static final String DOCSTATUS_Voided = "VO";
	/** Waiting Confirmation = WC */
	public static final String DOCSTATUS_WaitingConfirmation = "WC";
	/** Waiting Payment = WP */
	public static final String DOCSTATUS_WaitingPayment = "WP";
	/** Set Document Status.
		@param DocStatus The current status of the document
	*/
	public void setDocStatus (String DocStatus)
	{

		set_Value (COLUMNNAME_DocStatus, DocStatus);
	}

	/** Get Document Status.
		@return The current status of the document
	  */
	public String getDocStatus()
	{
		return (String)get_Value(COLUMNNAME_DocStatus);
	}

	/** Set Approved.
		@param IsApproved Indicates if this document requires approval
	*/
	public void setIsApproved (boolean IsApproved)
	{
		set_Value (COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}

	/** Get Approved.
		@return Indicates if this document requires approval
	  */
	public boolean isApproved()
	{
		Object oo = get_Value(COLUMNNAME_IsApproved);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Line No.
		@param Line Unique line for this document
	*/
	public void setLine (int Line)
	{
		set_Value (COLUMNNAME_Line, Integer.valueOf(Line));
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public int getLine()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException
	{
		return (I_M_AttributeSetInstance)MTable.get(getCtx(), I_M_AttributeSetInstance.Table_ID)
			.getPO(getM_AttributeSetInstance_ID(), get_TrxName());
	}

	/** Set Attribute Set Instance.
		@param M_AttributeSetInstance_ID Product Attribute Set Instance
	*/
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID)
	{
		if (M_AttributeSetInstance_ID < 0)
			set_Value (COLUMNNAME_M_AttributeSetInstance_ID, null);
		else
			set_Value (COLUMNNAME_M_AttributeSetInstance_ID, Integer.valueOf(M_AttributeSetInstance_ID));
	}

	/** Get Attribute Set Instance.
		@return Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeSetInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_InOutLine getM_InOutLine() throws RuntimeException
	{
		return (org.compiere.model.I_M_InOutLine)MTable.get(getCtx(), org.compiere.model.I_M_InOutLine.Table_ID)
			.getPO(getM_InOutLine_ID(), get_TrxName());
	}

	/** Set Shipment/Receipt Line.
		@param M_InOutLine_ID Line on Shipment or Receipt document
	*/
	public void setM_InOutLine_ID (int M_InOutLine_ID)
	{
		if (M_InOutLine_ID < 1)
			set_Value (COLUMNNAME_M_InOutLine_ID, null);
		else
			set_Value (COLUMNNAME_M_InOutLine_ID, Integer.valueOf(M_InOutLine_ID));
	}

	/** Get Shipment/Receipt Line.
		@return Line on Shipment or Receipt document
	  */
	public int getM_InOutLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_InOutLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public I_M_Locator getM_Locator() throws RuntimeException
	{
		return (I_M_Locator)MTable.get(getCtx(), I_M_Locator.Table_ID)
			.getPO(getM_Locator_ID(), get_TrxName());
	}

	/** Set Locator.
		@param M_Locator_ID Warehouse Locator
	*/
	public void setM_Locator_ID (int M_Locator_ID)
	{
		if (M_Locator_ID < 1)
			set_Value (COLUMNNAME_M_Locator_ID, null);
		else
			set_Value (COLUMNNAME_M_Locator_ID, Integer.valueOf(M_Locator_ID));
	}

	/** Get Locator.
		@return Warehouse Locator
	  */
	public int getM_Locator_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Locator_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
			set_Value (COLUMNNAME_M_Warehouse_ID, null);
		else 
			set_Value (COLUMNNAME_M_Warehouse_ID, Integer.valueOf(M_Warehouse_ID));
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

	/** Set Movement Date.
		@param MovementDate Date a product was moved in or out of inventory
	*/
	public void setMovementDate (Timestamp MovementDate)
	{
		set_Value (COLUMNNAME_MovementDate, MovementDate);
	}

	/** Get Movement Date.
		@return Date a product was moved in or out of inventory
	  */
	public Timestamp getMovementDate()
	{
		return (Timestamp)get_Value(COLUMNNAME_MovementDate);
	}

	/** Set Movement Quantity.
		@param MovementQty Quantity of a product moved.
	*/
	public void setMovementQty (BigDecimal MovementQty)
	{
		set_Value (COLUMNNAME_MovementQty, MovementQty);
	}

	/** Get Movement Quantity.
		@return Quantity of a product moved.
	  */
	public BigDecimal getMovementQty()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_MovementQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
	{
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_ID)
			.getPO(getM_Product_ID(), get_TrxName());
	}

	/** Set Product.
		@param M_Product_ID Product, Service, Item
	*/
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1)
			set_Value (COLUMNNAME_M_Product_ID, null);
		else
			set_Value (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Posted.
		@param Posted Posting status
	*/
	public void setPosted (boolean Posted)
	{
		set_Value (COLUMNNAME_Posted, Boolean.valueOf(Posted));
	}

	/** Get Posted.
		@return Posting status
	  */
	public boolean isPosted()
	{
		Object oo = get_Value(COLUMNNAME_Posted);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Processed.
		@param Processed The document has been processed
	*/
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed()
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Processed On.
		@param ProcessedOn The date+time (expressed in decimal format) when the document has been processed
	*/
	public void setProcessedOn (BigDecimal ProcessedOn)
	{
		set_Value (COLUMNNAME_ProcessedOn, ProcessedOn);
	}

	/** Get Processed On.
		@return The date+time (expressed in decimal format) when the document has been processed
	  */
	public BigDecimal getProcessedOn()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_ProcessedOn);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Process Now.
		@param Processing Process Now
	*/
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing()
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	public org.compiere.model.I_C_ProjectIssue getReversal() throws RuntimeException
	{
		return (org.compiere.model.I_C_ProjectIssue)MTable.get(getCtx(), org.compiere.model.I_C_ProjectIssue.Table_ID)
			.getPO(getReversal_ID(), get_TrxName());
	}

	/** Set Reversal ID.
		@param Reversal_ID ID of document reversal
	*/
	public void setReversal_ID (int Reversal_ID)
	{
		if (Reversal_ID < 1)
			set_ValueNoCheck (COLUMNNAME_Reversal_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Reversal_ID, Integer.valueOf(Reversal_ID));
	}

	/** Get Reversal ID.
		@return ID of document reversal
	  */
	public int getReversal_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Reversal_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_S_TimeExpenseLine getS_TimeExpenseLine() throws RuntimeException
	{
		return (org.compiere.model.I_S_TimeExpenseLine)MTable.get(getCtx(), org.compiere.model.I_S_TimeExpenseLine.Table_ID)
			.getPO(getS_TimeExpenseLine_ID(), get_TrxName());
	}

	/** Set Expense Line.
		@param S_TimeExpenseLine_ID Time and Expense Report Line
	*/
	public void setS_TimeExpenseLine_ID (int S_TimeExpenseLine_ID)
	{
		if (S_TimeExpenseLine_ID < 1)
			set_Value (COLUMNNAME_S_TimeExpenseLine_ID, null);
		else
			set_Value (COLUMNNAME_S_TimeExpenseLine_ID, Integer.valueOf(S_TimeExpenseLine_ID));
	}

	/** Get Expense Line.
		@return Time and Expense Report Line
	  */
	public int getS_TimeExpenseLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_S_TimeExpenseLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}
