/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.compiere.grid;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public abstract class CreateFromBatch extends CreateFrom 
{
	public CreateFromBatch(GridTab gridTab) 
	{
		super(gridTab);
	}
	
	public String getSQLWhere(Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, Object Currency)
	{
		return getSQLWhere(BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode, Currency, 0);
	}
	
	public String getSQLWhere(Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, Object Currency, int AD_Org_ID)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("WHERE p.Processed='Y' AND p.C_BankAccount_ID = ? ");
	    	    
	    if(DocType != null)
			sql.append(" AND p.C_DocType_ID=?");
	    if(TenderType != null && TenderType.toString().length() > 0)
			sql.append(" AND p.TenderType=?");
		if(BPartner != null)
			sql.append(" AND p.C_BPartner_ID=?");
		
		if (Currency != null && Currency.toString().length() > 0 )
			sql.append(" AND p.C_Currency_ID=?");
		
		if(DocumentNo.length() > 0)
			sql.append(" AND UPPER(p.DocumentNo) LIKE ?");
		if(AuthCode.length() > 0)
			sql.append(" AND UPPER(p.R_AuthCode) LIKE ?");
		
		if(AmtFrom != null || AmtTo != null)
		{
			BigDecimal from = (BigDecimal) AmtFrom;
			BigDecimal to = (BigDecimal) AmtTo;
			if(from == null && to != null)
				sql.append(" AND p.PayAmt <= ?");
			else if(from != null && to == null)
				sql.append(" AND p.PayAmt >= ?");
			else if(from != null && to != null)
				sql.append(" AND p.PayAmt BETWEEN ? AND ?");
		}
		
		if(DateFrom != null || DateTo != null)
		{
			Timestamp from = (Timestamp) DateFrom;
			Timestamp to = (Timestamp) DateTo;
			if(from == null && to != null)
				sql.append(" AND TRUNC(p.DateTrx) <= ?");
			else if(from != null && to == null)
				sql.append(" AND TRUNC(p.DateTrx) >= ?");
			else if(from != null && to != null)
				sql.append(" AND TRUNC(p.DateTrx) BETWEEN ? AND ?");
		}
		
		if(AD_Org_ID > 0)
			sql.append(" AND p.AD_Org_ID = ?");

		if (log.isLoggable(Level.FINE)) log.fine(sql.toString());
		return sql.toString();
	}
	
	protected void setParameters(PreparedStatement pstmt, Object BankAccount, Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, Object Currency)
	throws SQLException
	{
		setParameters(pstmt, BankAccount, BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode, Currency, 0);
	}
	
	protected void setParameters(PreparedStatement pstmt, Object BankAccount, Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, Object Currency, int AD_Org_ID)
	throws SQLException
	{
		//  Get StatementDate
		//Timestamp ts = (Timestamp) getGridTab().getValue("StatementDate");
		//if (ts == null)
			//ts = new Timestamp(System.currentTimeMillis());

		int index = 1;
		
		//pstmt.setTimestamp(index++, ts);		
		pstmt.setInt(index++, BankAccount != null ? (Integer) BankAccount : (Integer) getGridTab().getValue("C_BankAccount_ID"));
		
		if(DocType != null)
			pstmt.setInt(index++, (Integer) DocType);
		
		if(TenderType != null && TenderType.toString().length() > 0)
			pstmt.setString(index++, (String) TenderType);
		
		if(BPartner != null)
			pstmt.setInt(index++, (Integer) BPartner);
		
		if(Currency != null)
			pstmt.setInt(index++, (Integer) Currency);
		
		if(DocumentNo.length() > 0)
			pstmt.setString(index++, getSQLText(DocumentNo));
		
		if(AuthCode.length() > 0)
			pstmt.setString(index++, getSQLText(AuthCode));
		
		if(AmtFrom != null || AmtTo != null)
		{
			BigDecimal from = (BigDecimal) AmtFrom;
			BigDecimal to = (BigDecimal) AmtTo;
			if (log.isLoggable(Level.FINE)) log.fine("Amt From=" + from + ", To=" + to);
			if(from == null && to != null)
				pstmt.setBigDecimal(index++, to);
			else if(from != null && to == null)
				pstmt.setBigDecimal(index++, from);
			else if(from != null && to != null)
			{
				pstmt.setBigDecimal(index++, from);
				pstmt.setBigDecimal(index++, to);
			}
		}
		
		if(DateFrom != null || DateTo != null)
		{
			Timestamp from = (Timestamp) DateFrom;
			Timestamp to = (Timestamp) DateTo;
			if (log.isLoggable(Level.FINE)) log.fine("Date From=" + from + ", To=" + to);
			if(from == null && to != null)
				pstmt.setTimestamp(index++, to);
			else if(from != null && to == null)
				pstmt.setTimestamp(index++, from);
			else if(from != null && to != null)
			{
				pstmt.setTimestamp(index++, from);
				pstmt.setTimestamp(index++, to);
			}
		}
		
		if(AD_Org_ID > 0)
			pstmt.setInt(index++, (Integer) AD_Org_ID);
		
	}
	
	protected String getSQLText(String text)
	{
		String s = text.toUpperCase();
		if(!s.endsWith("%"))
			s += "%";
		if (log.isLoggable(Level.FINE)) log.fine( "String=" + s);
		return s;
	}
	
	protected abstract Vector<Vector<Object>> getBankAccountData(Object BankAccount, Object BPartner, String DocumentNo, 
			Object DateFrom, Object DateTo, Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, Object CurrencyType);
	
	public void info(IMiniTable miniTable, IStatusBar statusBar)
	{		
		DecimalFormat format = DisplayType.getNumberFormat(DisplayType.Amount);
		BigDecimal total = Env.ZERO;
		int rows = miniTable.getRowCount();
		int count = 0;
		for(int i = 0; i < rows; i++)
		{
			if(((Boolean) miniTable.getValueAt(i, 0)).booleanValue())
			{
				total = total.add((BigDecimal) miniTable.getValueAt(i, 4));
				count++;
			}
		}
		statusBar.setStatusLine(String.valueOf(count) + " - " + Msg.getMsg(Env.getCtx(), "Sum") + "  " + format.format(total));
	}
}