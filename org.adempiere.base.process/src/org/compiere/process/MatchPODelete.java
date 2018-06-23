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
package org.compiere.process;

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MInOutLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrderLine;
import org.compiere.model.MStorageReservation;
import org.compiere.model.MTable;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;


/**
 *	Delete PO Match
 *	
 *  @author Jorg Janke
 *  @version $Id: MatchPODelete.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 *  
 *  @author Armen Rizal, Goodwill Consulting
 *  	<li>BF [ 2215840 ] MatchPO Bug Collection
 */
public class MatchPODelete extends SvrProcess
{
	/**	ID					*/
	private int		p_M_MatchPO_ID = 0;

	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		p_M_MatchPO_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt()	throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info ("M_MatchPO_ID=" + p_M_MatchPO_ID);
		MMatchPO po = new MMatchPO (getCtx(), p_M_MatchPO_ID, get_TrxName());
		if (po.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ @M_MatchPO_ID@ " + p_M_MatchPO_ID);
		//
		MOrderLine orderLine = null;
		MInOutLine inOutLine = null;
		boolean isMatchReceipt = (po.getM_InOutLine_ID() != 0);			 
		if (isMatchReceipt)
		{
			orderLine = (MOrderLine) MTable.get(getCtx(), MOrderLine.Table_ID).getPO(po.getC_OrderLine_ID(),
					get_TrxName());
			orderLine.setQtyReserved(orderLine.getQtyReserved().add(po.getQty()));
			
			if (!MStorageReservation.add(getCtx(), orderLine
					.getM_Warehouse_ID(), orderLine.getM_Product_ID(),
					orderLine.getM_AttributeSetInstance_ID(), po.getQty(), false, get_TrxName()))
			{
				String lastError = CLogger.retrieveErrorString("");
				throw new AdempiereException(
						"Cannot correct Inventory Ordered (MA) - ["
								+ orderLine.getM_Product().getValue() + "] "
								+ lastError);
			}
			
			inOutLine = (MInOutLine) MTable.get(getCtx(), MInOutLine.Table_ID).getPO(po.getM_InOutLine_ID(),
					get_TrxName());
			inOutLine.set_ValueOfColumn(MOrderLine.COLUMNNAME_C_OrderLine_ID, null);
			inOutLine.saveEx();
		}
		//
		if (po.delete(true))
		{	
			if (isMatchReceipt)
			{
				if (!orderLine.save(get_TrxName()))
					throw new AdempiereUserError("Delete MatchPO failed to restore PO's On Ordered Qty");
			}
			return "@OK@";
		}
		po.saveEx();
		return "@Error@";
	}	//	doIt

}	//	MatchPODelete
