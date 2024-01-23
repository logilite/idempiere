package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.acct.Doc;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

public class MMatchInvHdr extends X_M_MatchInvHdr implements DocAction
{
	/**
	 * 
	 */
	private static final long	serialVersionUID	= 3114247694087616341L;

	private String				m_processMsg		= null;

	private MMatchInv[]			m_lines; 

	public MMatchInvHdr(Properties ctx, int M_MatchInvHdr_ID, String trxName)
	{
		super(ctx, M_MatchInvHdr_ID, trxName);
		setDateTrx(TimeUtil.getDay(System.currentTimeMillis()));
		setDateAcct(getDateTrx());
		if(MDocType.getDocType(MDocType.DOCBASETYPE_MatchInvHdr) <= 0)
		{
			throw new AdempiereException("Document type not available: 'Match Invoice Header'");
		}
		setC_DocType_ID(MDocType.getDocType(MDocType.DOCBASETYPE_MatchInvHdr));
	}

	public MMatchInvHdr(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		setDateTrx(TimeUtil.getDay(System.currentTimeMillis()));
		setDateAcct(getDateTrx());
	}

	public MMatchInvHdr(Properties ctx, Timestamp date, String trxName)
	{
		super(ctx, 0, trxName);
		setDateTrx(date);
		setDateAcct(date);
	}

	@Override
	public boolean processIt(String action) throws Exception
	{
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine(this, getDocStatus());
		return engine.processIt(action, getDocAction());
	}

	@Override
	public boolean unlockIt()
	{
		return true;
	}

	@Override
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		setDocAction(DOCACTION_Prepare);
		return true;
	}

	@Override
	public String prepareIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		if (!DOCACTION_Complete.equals(getDocAction()))
			setDocAction(DOCACTION_Complete);
		return DocAction.STATUS_InProgress;
	}

	@Override
	public boolean approveIt()
	{
		return true;
	}

	@Override
	public boolean rejectIt()
	{
		return true;
	}

	@Override
	public String completeIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		// User Validation
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
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		// Before Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_VOID);
		if (m_processMsg != null)
			return false;

		if (DOCSTATUS_Closed.equals(getDocStatus()) || DOCSTATUS_Reversed.equals(getDocStatus())
				|| DOCSTATUS_Voided.equals(getDocStatus()))
		{
			m_processMsg = "Document Closed: " + getDocStatus();
			setDocAction(DOCACTION_None);
			return false;
		}

		// Not Processed
		if (DOCSTATUS_Completed.equals(getDocStatus()))
		{
			boolean accrual = false;
			try
			{
				MPeriod.testPeriodOpen(getCtx(), getDateTrx(), Doc.DOCTYPE_MatchInvHdr, getAD_Org_ID());
			}
			catch (PeriodClosedException e)
			{
				accrual = true;
			}

			if (accrual)
				return reverseAccrualIt();
			else
				return reverseCorrectIt();
		}

		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);
		return true;
	}

	@Override
	public boolean closeIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
		setDocAction(DOCACTION_None);

		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;
		return true;
	}

	@Override
	public boolean reverseCorrectIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		MMatchInvHdr reversal = reverse(false);
		if (reversal == null)
			return false;
		
		// delete the fact line of the Match Invoice Hdr after reverse Correct
		Doc.deleteReverseCorrectPosting(getCtx(),getAD_Client_ID(), MMatchInvHdr.Table_ID , getM_MatchInvHdr_ID() ,get_TrxName());

		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();
		return true;
	}

	protected MMatchInvHdr reverse(boolean accural)
	{
		if (this.getReversal_ID() == 0)
		{
			Timestamp reversalDate = accural ? Env.getContextAsDate(getCtx(), "#Date") : getDateAcct();
			if (reversalDate == null)
			{
				reversalDate = new Timestamp(System.currentTimeMillis());
			}

			// TODO MPeriod.testPeriodOpen(getCtx(), reversalDate,
			// Doc.DOCTYPE_MatchInvHdr, getAD_Org_ID());

			MMatchInvHdr reversal = new MMatchInvHdr(getCtx(), 0, get_TrxName());
			PO.copyValues(this, reversal);
			reversal.setAD_Org_ID(this.getAD_Org_ID());
			reversal.setDescription("(->" + this.getDocumentNo() + ")");
			reversal.setDateAcct(reversalDate);
			reversal.setDateTrx(reversalDate);
			reversal.set_ValueNoCheck("DocumentNo", null);
			reversal.setPosted(false);
			reversal.setReversal_ID(getM_MatchInvHdr_ID());
			reversal.saveEx();
			this.setDescription("(" + reversal.getDocumentNo() + "<-)");
			this.setReversal_ID(reversal.getM_MatchInvHdr_ID());
			this.saveEx();

			for (MMatchInv mInv : getLines())
			{
				if (!mInv.reverse(reversalDate))
				{
					m_processMsg = "Reversal ERROR: Failed to reverse match invoice";
					return null;
				}

				MMatchInv miReversal = (MMatchInv) mInv.getReversal();
				miReversal.setM_MatchInvHdr_ID(reversal.get_ID());
				miReversal.saveEx();
			}

			try
			{
				reversal.processIt(DOCACTION_Complete);
				reversal.saveEx();
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "Failed to complete match invoice header reversal", e);
			}

			return reversal;
		}
		else
		{
			return new MMatchInvHdr(getCtx(), this.getReversal_ID(), get_TrxName());
		}
	}

	@Override
	public boolean reverseAccrualIt()
	{
		if (log.isLoggable(Level.INFO))
			log.info(toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		MMatchInvHdr reversal = reverse(true);
		if (reversal == null)
			return false;

		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		m_processMsg = reversal.getDocumentNo();

		return true;
	}

	@Override
	public boolean reActivateIt()
	{

		if (log.isLoggable(Level.INFO))
			log.info("reActivateIt - " + toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;

		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;
		return false;
	}

	/**
	 * Get Lines of Order
	 * 
	 * @param requery requery
	 * @param orderBy optional order by column
	 * @return lines
	 */
	public MMatchInv[] getLines(boolean requery, String orderBy)
	{
		if (m_lines != null && !requery)
		{
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}
		//
		String orderClause = "";
		if (orderBy != null && orderBy.length() > 0)
			orderClause += orderBy;
		else
			orderClause += "M_MatchInvHdr_ID";
		m_lines = getLines(null, orderClause);
		return m_lines;
	} // getLines

	public MMatchInv[] getLines(String whereClause, String orderClause)
	{
		StringBuilder whereClauseFinal = new StringBuilder(MMatchInvHdr.COLUMNNAME_M_MatchInvHdr_ID + "=? ");
		if (!Util.isEmpty(whereClause, true))
		{
			whereClauseFinal.append(" AND ").append(whereClause);
		}

		if (orderClause.length() == 0)
		{
			orderClause = MMatchInv.COLUMNNAME_M_MatchInv_ID;
		}

		List<MMatchInv> matInvList = new Query(getCtx(), MMatchInv.Table_Name, " M_MatchInvHdr_ID = ?", get_TrxName())
				.setParameters(get_ID()).setOrderBy(orderClause).list();

		return matInvList.toArray(new MMatchInv[matInvList.size()]);
	}

	/**
	 * Get Lines of Order. (used by web store)
	 * 
	 * @return lines
	 */
	public MMatchInv[] getLines()
	{
		return getLines(false, null);
	} // getLines

	@Override
	public String getSummary()
	{
		return getDocumentNo();
	}

	@Override
	public String getDocumentInfo()
	{
		return getDocumentNo();
	}

	@Override
	public File createPDF()
	{
		return null;
	}

	@Override
	public String getProcessMsg()
	{
		return m_processMsg;
	}

	@Override
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}

	@Override
	public int getC_Currency_ID()
	{
		return MClient.get(getCtx()).getC_Currency_ID();
	}

	@Override
	public BigDecimal getApprovalAmt()
	{
		return BigDecimal.ZERO;
	}

	@Override
	public String getDocAction()
	{
		return super.getDocAction();
	}

	public MMatchInvHdr getReversal()
	{
		return (MMatchInvHdr) MTable.get(getCtx(), MMatchInvHdr.Table_Name).getPO(getReversal_ID(), get_TrxName());
	}
}
