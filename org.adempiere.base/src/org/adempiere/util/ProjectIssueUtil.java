package org.adempiere.util;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCost;
import org.compiere.model.MProduct;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class ProjectIssueUtil
{
	protected transient static CLogger			log = CLogger.getCLogger(ProjectIssueUtil.class);
	
	/**
	 * 	Get PO Costs in Currency of AcctSchema
	 *	@param as Account Schema
	 *	@return Unit PO Cost
	 */
	public static BigDecimal getPOCost(MAcctSchema as, int inOutLineID, BigDecimal lineQty)
	{
		BigDecimal retValue = null;
		//	Uses PO Date
		String sql = "SELECT currencyConvert(ol.PriceActual, o.C_Currency_ID, ?, o.DateOrdered, o.C_ConversionType_ID, ?, ?) "
				+ "FROM C_OrderLine ol"
				+ " INNER JOIN M_InOutLine iol ON (iol.C_OrderLine_ID=ol.C_OrderLine_ID)"
				+ " INNER JOIN C_Order o ON (o.C_Order_ID=ol.C_Order_ID) "
				+ "WHERE iol.M_InOutLine_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, as.get_TrxName());
			pstmt.setInt(1, as.getC_Currency_ID());
			pstmt.setInt(2, as.getAD_Client_ID());
			pstmt.setInt(3, as.getAD_Org_ID());
			pstmt.setInt(4, inOutLineID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = rs.getBigDecimal(1);
				if (log.isLoggable(Level.FINE)) log.fine("POCost = " + retValue);
			}
			else
				log.warning("Not found for M_InOutLine_ID=" + inOutLineID);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			pstmt = null; rs = null;
		}
		if (retValue != null)
			retValue = retValue.multiply(lineQty);
		return retValue;
	}	//	getPOCost();
	
	/**
	 * 	Get Labor Cost from Expense Report
	 *	@param as Account Schema
	 *	@return Unit Labor Cost
	 */
	public static BigDecimal getLaborCost(MAcctSchema as, int timeExpLineID)
	{
		// Todor Lulov 30.01.2008
		BigDecimal retValue = Env.ZERO;
		BigDecimal qty = Env.ZERO;

		String sql = "SELECT ConvertedAmt, Qty FROM S_TimeExpenseLine " +
				" WHERE S_TimeExpenseLine.S_TimeExpenseLine_ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, as.get_TrxName());
			pstmt.setInt(1, timeExpLineID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = rs.getBigDecimal(1);
				qty = rs.getBigDecimal(2);
				retValue = retValue.multiply(qty);
				if (log.isLoggable(Level.FINE)) log.fine("ExpLineCost = " + retValue);
			}
			else
				log.warning("Not found for S_TimeExpenseLine_ID=" + timeExpLineID);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			pstmt = null; rs = null;
		}
		return retValue;
	}	//	getLaborCost
	
	/**
	 * Get Total Product Costs
	 * 
	 * @param  as          accounting schema
	 * @param  AD_Org_ID   trx org
	 * @param  zeroCostsOK zero/no costs are OK
	 * @return             costs
	 */
	public static BigDecimal getProductCosts(MAcctSchema as, MProduct product, int asiID, int AD_Org_ID, BigDecimal qty,boolean zeroCostsOK)
	{
		String costingMethod = as.getCostingMethod();
		BigDecimal costs = MCost.getCurrentCost(product, asiID, as, AD_Org_ID, costingMethod, qty, 0, zeroCostsOK, as.get_TrxName());
		if (costs != null)
			return costs;
		return Env.ZERO;
	} // getProductCosts
}
