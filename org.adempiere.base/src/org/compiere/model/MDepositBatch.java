/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Alejandro Falcone                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Alejandro Falcone (afalcone@users.sourceforge.net)                *
*                      http://www.openbiz.com.ar                      *
*                                                                     * 
* Sponsors:                                                           *
* - Idalica Inc. (http://www.idalica.com)                             *
***********************************************************************/

package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *  Deposit Batch Model
 *
 *	@author Alejandro Falcone
 *	@version $Id: MDepositBatch.java,v 1.3 2007/06/28 00:51:03 afalcone Exp $
 */
public class MDepositBatch extends X_C_DepositBatch implements DocAction
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -977397802747749777L;

	/**
	 *  Create and Load existing Persistent Object
	 *  @param ctx context
	 *  @param C_DepositBatch_ID  The unique ID of the object
	 *  @param trxName transaction name	
	 */
	public MDepositBatch (Properties ctx, int C_DepositBatch_ID, String trxName)
	{
		super (ctx, C_DepositBatch_ID, trxName);
		if (C_DepositBatch_ID == 0)
		{
			setDocStatus (DOCSTATUS_Drafted);
			setDocAction (DOCACTION_Complete);
			setProcessed (false);
			setProcessing (false);
			setDepositAmt(Env.ZERO);
		}
	}	//	MDepositBatch
	

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDepositBatch (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDepositBatch

	/**
	 * 	Copy Constructor.
	 * 	Dos not copy: Dates/Period
	 *	@param original original
	 */
	public MDepositBatch (MDepositBatch original)
	{
		this (original.getCtx(), 0, original.get_TrxName());
		setClientOrg(original);
		setC_DepositBatch_ID(original.getC_DepositBatch_ID());

		setDescription(original.getDescription());
		setC_DocType_ID(original.getC_DocType_ID());
		
		setDateDoc(original.getDateDoc());
		setDateDeposit(original.getDateDeposit());
		setDepositAmt(original.getDepositAmt());
	}	//	MDepositBatch

	/**
	 * 	Overwrite Client/Org if required
	 * 	@param AD_Client_ID client
	 * 	@param AD_Org_ID org
	 */
	public void setClientOrg (int AD_Client_ID, int AD_Org_ID)
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}	//	setClientOrg

	/**
	 * 	Set Accounting Date.
	 * 	Set also Period if not set earlier
	 *	@param DateAcct date
	 */
	public void setDateAcct (Timestamp DateAcct)
	{
		super.setDateDeposit(DateAcct);
		if (DateAcct == null)
			return;
	}	//	setDateAcct


	/**	Process Message 			*/
	private String		m_processMsg = null;

	/**
	 * 	Unlock Document.
	 * 	@return true if success 
	 */
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		setProcessing(false);
		return true;
	}	//	unlockIt
	
	/**
	 * 	Invalidate Document
	 * 	@return true if success 
	 */
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + toString());
		setDocAction(DOCACTION_Prepare);
		return true;
	}	//	invalidateIt
	


	/**
	 * 	Void Document.
	 * 	@return false 
	 */
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("voidIt - " + toString());
		// Before Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
		if (m_processMsg != null)
			return false;
		
		if (DOCSTATUS_Closed.equals(getDocStatus())
				|| DOCSTATUS_Reversed.equals(getDocStatus())
				|| DOCSTATUS_Voided.equals(getDocStatus()))
			{
				m_processMsg = "Document Closed: " + getDocStatus();
				setDocAction(DOCACTION_None);
				return false;
			}
		
		MDepositBatchLine[] lines = getLines();			
		for (int i = 0; i < lines.length; i++)
		{
			MDepositBatchLine line = lines[i];
			if (line.getPayAmt().compareTo(Env.ZERO) != 0)
			{

				if (line.getC_Payment_ID() != 0) 
				{
					String sql = "UPDATE C_Payment p SET C_DepositBatch_ID= null WHERE p.C_Payment_ID=?";
					DB.executeUpdateEx(sql, new Object[] {line.getC_Payment_ID()}, get_TrxName());
				}
				line.setPayAmt(Env.ZERO);
				line.setProcessed(true);
				line.saveEx();
			}
		}
		addDescription(Msg.getMsg(getCtx(), "Voided"));
		setDepositAmt(Env.ZERO);
		
		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;
		
		setProcessed(true);
		setDocAction(DOCACTION_None);
		return true;
	}	//	voidIt


	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MDepositBatch[");
		sb.append(get_ID()).append(",").append(getDescription())
			.append(",Amount=").append(getDepositAmt())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	public String getDocumentInfo()
	{
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		return dt.getName() + " " + getDocumentNo();
	}	//	getDocumentInfo

	/**
	 * 	Create PDF
	 *	@return File or null
	 */
	public File createPDF ()
	{
		try
		{
			File temp = File.createTempFile(get_TableName()+get_ID()+"_", ".pdf");
			return createPDF (temp);
		}
		catch (Exception e)
		{
			log.severe("Could not create PDF - " + e.getMessage());
		}
		return null;
	}	//	getPDF

	/**
	 * 	Create PDF file
	 *	@param file output file
	 *	@return file if success
	 */
	public File createPDF (File file)
	{
		return null;
	}	//	createPDF

	
	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 */
	public String getProcessMsg()
	{
		return m_processMsg;
	}	//	getProcessMsg
	
	/**
	 * 	Get Document Owner (Responsible)
	 *	@return AD_User_ID (Created By)
	 */
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}	//	getDoc_User_ID

	/**
	 * 	Get Document Approval Amount
	 *	@return DR amount
	 */
	public BigDecimal getApprovalAmt()
	{
		return getDepositAmt();
	}	//	getApprovalAmt
	
	
	
	/**
	 * 	After Delete
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterDelete (boolean success)
	{
		if (getC_DepositBatch_ID() != 0 )
		{
			String sql = "UPDATE C_Payment p SET C_DepositBatch_ID= 0  WHERE p.C_DepositBatch_ID=?";			
			DB.executeUpdateEx(sql, new Object[] {getC_DepositBatch_ID()}, get_TrxName());
		}
		
		return success;
	}	//	afterDelete
	
	
	/**************************************************************************
	 * 	Get Deposit Batch Lines
	 *	@return Array of lines
	 */
	public MDepositBatchLine[] getLines()
	{
		ArrayList<MDepositBatchLine> list = new ArrayList<MDepositBatchLine>();
		String sql = "SELECT * FROM C_DepositBatchLine WHERE C_DepositBatch_ID=? ORDER BY Line,C_DepositBatchLine_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getC_DepositBatch_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MDepositBatchLine (getCtx(), rs, get_TrxName()));
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, sql, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		//
		MDepositBatchLine[] retValue = new MDepositBatchLine[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getLines


	/**************************************************************************
	 * 	Process document
	 *	@param processAction document action
	 *	@return true if performed
	 */
	@Override
	public boolean processIt(String action) throws Exception {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine (this, getDocStatus());
		return engine.processIt (action, getDocAction());
	}

	/**	Just Prepared Flag			*/
	protected boolean m_justPrepared = false;

	@Override
	public String prepareIt() {
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		
		MDepositBatchLine[] lines = getLines();
		if (lines.length == 0)
		{
			m_processMsg = "@NoLines@";
			return DocAction.STATUS_Invalid;
		}
		
		BigDecimal total = Env.ZERO;
		
		for (int i = 0; i < lines.length; i++)
		{
			MDepositBatchLine line = lines[i];
			if (!line.isActive())
				continue;

			total = total.add(line.getPayAmt());
		}
		
		setDepositAmt(total);
		
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		
		m_justPrepared = true;
		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		
		return DocAction.STATUS_InProgress;
	}


	@Override
	public boolean approveIt() {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public boolean rejectIt() {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public String completeIt() {
		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			m_justPrepared = false;
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}
		
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		
		if (log.isLoggable(Level.INFO)) log.info("completeIt - " + toString());
		
		MDepositBatchLine[] depositbatchLines = getLines();
		//	Close lines
		for (int line = 0; line < depositbatchLines.length; line++)
		{
			depositbatchLines[line].setProcessed(true);
			depositbatchLines[line].saveEx();
		}
		
		//	User Validation
		String valid = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_COMPLETE);
		if (valid != null)
		{
			m_processMsg = valid;
			return DocAction.STATUS_Invalid;
		}
			
		setProcessed(true);
		
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}


	@Override
	public boolean closeIt() {
		if (log.isLoggable(Level.INFO)) log.info("closeIt - " + toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;		

		setDocAction(DOCACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;
	}


	@Override
	public boolean reverseCorrectIt() {
		if (log.isLoggable(Level.INFO)) log.info("reverseCorrectIt - " + toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;
		
		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;
		return false;
	}


	@Override
	public boolean reverseAccrualIt() {
		if (log.isLoggable(Level.INFO)) log.info("reverseAccrualIt - " + toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;
		
		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;
		return false;
	}


	@Override
	public boolean reActivateIt() {
		if (log.isLoggable(Level.INFO)) log.info("reActivateIt - " + toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;		
		
		if (log.isLoggable(Level.INFO)) log.info("ReactivateIt - " + toString());
		// Set Payment reconciled false
		MDepositBatchLine[] depositbatchLines = getLines();

		// Close lines
		for (int line = 0; line < depositbatchLines.length; line++) {
			
			// Throw idempiere exception for payment already reconciled
			if(depositbatchLines[line].getC_Payment().isReconciled()) {
				throw new AdempiereException(Msg.getMsg(getCtx(), "NotAllowReActivationOfReconciledPaymentsIntoBatch"));
			}
			
			depositbatchLines[line].setProcessed(false);
			depositbatchLines[line].saveEx();
		}
		
		setProcessed(false);
		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;		
		return true;
	}
	
 	/**
	 * 	Add to Description
	 *	@param description text
	 */
	public void addDescription (String description)
	{
		String desc = getDescription();
		if (desc == null)
			setDescription(description);
		else{
			StringBuilder msgd = new StringBuilder(desc).append(" | ").append(description);
			setDescription(msgd.toString());
		}	
	}	//	addDescription


	@Override
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		sb.append(": ")
			.append(Msg.translate(getCtx(),"DepositBatchAmt")).append("=").append(getDepositAmt());
		if (getDescription() != null && getDescription().length() > 0)
			sb.append(" - ").append(getDescription());
		return sb.toString();
	}


	@Override
	public int getC_Currency_ID() {
		// TODO Auto-generated method stub
		return 0;
	}

}	//	MDepositBatch