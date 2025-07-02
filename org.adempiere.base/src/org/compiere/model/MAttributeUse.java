/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;


/**
 *	Attribute Use Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MAttributeUse.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MAttributeUse extends X_M_AttributeUse
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3727204159034073907L;

	private static final String	SQL_GET_TA_DUPLICATE_ATTRIBSET	= "SELECT st.Name FROM M_AttributeSet st "
																	+ "	INNER JOIN M_AttributeUse 	u ON (u.M_AttributeSet_ID  = st.M_AttributeSet_ID)	"
																	+ "	INNER JOIN M_Attribute 		a ON (a.M_Attribute_ID = u.M_Attribute_ID 			"
																	+ "									  AND a.AD_Client_ID IN (0, ?) AND UPPER(a.Name) = UPPER(?) )"
																	+ "	WHERE st.M_AttributeSet_Type = 'TA' ";

	/**
	 * 	Persistency Constructor
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MAttributeUse (Properties ctx, int ignored, String trxName)
	{
		super (ctx, ignored, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MAttributeUse

	/**
	 * 	Load Cosntructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAttributeUse (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAttributeUse

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true if can be saved
	 */
	@Override
	protected boolean beforeSave(boolean newRecord) {
		if ((newRecord || is_ValueChanged(COLUMNNAME_M_Attribute_ID))
				&& ! MRole.getDefault().isAccessAdvanced()) {
			// not advanced roles cannot assign for use a reference attribute
			MAttribute att = MAttribute.get(getCtx(), getM_Attribute_ID());
			if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equals(att.getAttributeValueType())) {
				log.saveError("Error", Msg.getMsg(getCtx(), "ActionNotAllowedHere"));
				return false;
			}
		}

		if (getM_Attribute_ID() > 0 && getM_AttributeSet_ID() > 0
			&& MAttributeSet.M_ATTRIBUTESET_TYPE_TableAttribute.equals(getM_AttributeSet().getM_AttributeSet_Type()))
		{
			String dupAttribSetName = DB.getSQLValueString(get_TrxName(), SQL_GET_TA_DUPLICATE_ATTRIBSET, getAD_Client_ID(), getM_Attribute().getName());
			if (!Util.isEmpty(dupAttribSetName, true))
			{
				log.saveError("Error", Msg.getMsg(getCtx(), "UniqueAttribute", new Object[] { getM_Attribute().getName(), dupAttribSetName }));
				return false;
			}
		}
		return true;
	}

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//	also used for afterDelete
		StringBuilder sql = new StringBuilder("UPDATE M_AttributeSet mas")
			.append(" SET IsInstanceAttribute='Y' ")
			.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
			.append(" AND IsInstanceAttribute='N'")
			.append(" AND (IsSerNo='Y' OR IsLot='Y' OR IsGuaranteeDate='Y'")
				.append(" OR EXISTS (SELECT * FROM M_AttributeUse mau")
					.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
					.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
					.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
					.append(" AND ma.IsInstanceAttribute='Y')")
					.append(")");
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("afterSave - Set Instance Attribute");
		//
		sql = new StringBuilder("UPDATE M_AttributeSet mas")
			.append(" SET IsInstanceAttribute='N' ")
			.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
			.append(" AND IsInstanceAttribute='Y'")
			.append("	AND IsSerNo='N' AND IsLot='N' AND IsGuaranteeDate='N'")
			.append(" AND NOT EXISTS (SELECT * FROM M_AttributeUse mau")
				.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
				.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
				.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
				.append(" AND ma.IsInstanceAttribute='Y')");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("afterSave - Reset Instance Attribute");
		
		return success;
	}	//	afterSave
	
	
	/**
	 * 	After Delete
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterDelete (boolean success)
	{
		afterSave(false, success);
		return success;
	}	//	afterDelete
	
}	//	MAttributeUse
