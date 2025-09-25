-- Multiple Payments against single Bank/Cash statement line
SELECT register_migration_script('202404301200_IDEMPERIE-5329.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- NOTE some part of below scripts already applied from 
-- 202207041916_IDEMPIERE-5329.sql, 
-- 202301111205_IDEMPIERE-5329.sql, 
-- 202404051926_IDEMPIERE-5329.sql,
-- 202307041724_IDEMPIERE-5329.sql 

-- Jul 6, 2022, 4:28:52 PM IST
UPDATE AD_Message
SET MsgText = 'Payment and Deposit Batch both should not be entered',
	Value = 'EitherPaymentOrDepositBatch',
	UPDATED = TO_DATE('2025-09-23 19:19:19','YYYY-MM-DD HH24:MI:SS')
WHERE AD_Message_ID = 200769
;

UPDATE AD_Message
SET Value = 'MissingPaymentIntoBatch',
	UPDATED = TO_DATE('2025-09-23 19:19:19','YYYY-MM-DD HH24:MI:SS')
WHERE AD_Message_ID = 200772
;

-- 
UPDATE AD_Field
SET EntityType = 'D', 
	Updated = TO_TIMESTAMP('2025-09-25:11:55','YYYY-MM-DD HH24:MI:SS')
WHERE AD_Field_ID = 207524
;

-- Jan 10, 2023, 5:40:58 PM IST
UPDATE AD_Message 
SET MsgText = 'Can not reactivate reconciled Payment.',
	EntityType = 'D',
	Updated = TO_TIMESTAMP('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS')
WHERE AD_Message_ID = 200815
;

-- * org must not allowed in deposit batch
-- Feb 8, 2023, 6:32:32 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=130, ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-02-08 18:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208399
;


-- Adding C_DepositBatch_ID column on C_Payment_v view

-- Jul 4, 2023, 5:52:38 PM IST
CREATE OR REPLACE VIEW C_Payment_v(c_payment_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, documentno, datetrx, isreceipt, c_doctype_id, trxtype, c_bankaccount_id, c_bpartner_id, c_invoice_id, c_bp_bankaccount_id, c_paymentbatch_id, tendertype, creditcardtype, creditcardnumber, creditcardvv, creditcardexpmm, creditcardexpyy, micr, routingno, accountno, checkno, a_name, a_street, a_city, a_state, a_zip, a_ident_dl, a_ident_ssn, a_email, voiceauthcode, orig_trxid, ponum, c_currency_id, c_conversiontype_id, payamt, discountamt, writeoffamt, taxamt, overunderamt, multiplierap, isoverunderpayment, isapproved, r_pnref, r_result, r_respmsg, r_authcode, r_avsaddr, r_avszip, r_info, processing, oprocessing, docstatus, docaction, isprepayment, c_charge_id, isreconciled, isallocated, isonline, processed, posted, c_campaign_id, c_project_id, c_activity_id, ad_orgtrx_id, chargeamt, c_order_id, dateacct, description, isselfservice, processedon, reversal_id, currencyrate, convertedamt, isoverridecurrencyrate, c_depositbatch_id) AS SELECT c_payment.c_payment_id AS c_payment_id, c_payment.ad_client_id AS ad_client_id, c_payment.ad_org_id AS ad_org_id, c_payment.isactive AS isactive, c_payment.created AS created, c_payment.createdby AS createdby, c_payment.updated AS updated, c_payment.updatedby AS updatedby, c_payment.documentno AS documentno, c_payment.datetrx AS datetrx, c_payment.isreceipt AS isreceipt, c_payment.c_doctype_id AS c_doctype_id, c_payment.trxtype AS trxtype, c_payment.c_bankaccount_id AS c_bankaccount_id, c_payment.c_bpartner_id AS c_bpartner_id, c_payment.c_invoice_id AS c_invoice_id, c_payment.c_bp_bankaccount_id AS c_bp_bankaccount_id, c_payment.c_paymentbatch_id AS c_paymentbatch_id, c_payment.tendertype AS tendertype, c_payment.creditcardtype AS creditcardtype, c_payment.creditcardnumber AS creditcardnumber, c_payment.creditcardvv AS creditcardvv, c_payment.creditcardexpmm AS creditcardexpmm, c_payment.creditcardexpyy AS creditcardexpyy, c_payment.micr AS micr, c_payment.routingno AS routingno, c_payment.accountno AS accountno, c_payment.checkno AS checkno, c_payment.a_name AS a_name, c_payment.a_street AS a_street, c_payment.a_city AS a_city, c_payment.a_state AS a_state, c_payment.a_zip AS a_zip, c_payment.a_ident_dl AS a_ident_dl, c_payment.a_ident_ssn AS a_ident_ssn, c_payment.a_email AS a_email, c_payment.voiceauthcode AS voiceauthcode, c_payment.orig_trxid AS orig_trxid, c_payment.ponum AS ponum, c_payment.c_currency_id AS c_currency_id, c_payment.c_conversiontype_id AS c_conversiontype_id, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.payamt ELSE c_payment.payamt * (-1) END AS payamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.discountamt ELSE c_payment.discountamt * (-1) END AS discountamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.writeoffamt ELSE c_payment.writeoffamt * (-1) END AS writeoffamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.taxamt ELSE c_payment.taxamt * (-1) END AS taxamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.overunderamt ELSE c_payment.overunderamt * (-1) END AS overunderamt, CASE c_payment.isreceipt WHEN 'Y' THEN 1 ELSE (-1) END AS multiplierap, c_payment.isoverunderpayment AS isoverunderpayment, c_payment.isapproved AS isapproved, c_payment.r_pnref AS r_pnref, c_payment.r_result AS r_result, c_payment.r_respmsg AS r_respmsg, c_payment.r_authcode AS r_authcode, c_payment.r_avsaddr AS r_avsaddr, c_payment.r_avszip AS r_avszip, c_payment.r_info AS r_info, c_payment.processing AS processing, c_payment.oprocessing AS oprocessing, c_payment.docstatus AS docstatus, c_payment.docaction AS docaction, c_payment.isprepayment AS isprepayment, c_payment.c_charge_id AS c_charge_id, c_payment.isreconciled AS isreconciled, c_payment.isallocated AS isallocated, c_payment.isonline AS isonline, c_payment.processed AS processed, c_payment.posted AS posted, c_payment.c_campaign_id AS c_campaign_id, c_payment.c_project_id AS c_project_id, c_payment.c_activity_id AS c_activity_id, c_payment.ad_orgtrx_id AS ad_orgtrx_id, c_payment.chargeamt AS chargeamt, c_payment.c_order_id AS c_order_id, c_payment.dateacct AS dateacct, c_payment.description AS description, c_payment.isselfservice AS isselfservice, c_payment.processedon AS processedon, c_payment.reversal_id AS reversal_id, c_payment.currencyrate AS currencyrate, c_payment.convertedamt AS convertedamt, c_payment.isoverridecurrencyrate AS isoverridecurrencyrate, c_payment.c_depositbatch_id AS c_depositbatch_id FROM c_payment
;

-- May 20, 2024, 11:18:41 AM IST
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2024-05-20 11:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201705
;

-- May 20, 2024, 11:18:48 AM IST
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2024-05-20 11:18:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208421
;

-- May 20, 2024, 11:18:58 AM IST
UPDATE AD_Process SET IsActive='N',Updated=TO_DATE('2024-05-20 11:18:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200031
;

-- Nov 21, 2024, 9:34:08 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Deposit Batch is Processed: ',0,0,'Y',TO_DATE('2024-11-21 21:34:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-11-21 21:34:07','YYYY-MM-DD HH24:MI:SS'),100,200913,'DepositBatchProcessed','D','eba95ca0-4549-4094-8297-262c591bcdce')
;

-- Dec 16, 2024, 2:16:35 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Create Line Per Payment',0,0,'Y',TO_DATE('2024-12-16 14:16:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-12-16 14:16:34','YYYY-MM-DD HH24:MI:SS'),100,200919,'CreateLinePerPayment','D','f0a3b8c0-f6d6-4900-a952-576a9da068cc')
;

-- Dec 16, 2024, 2:16:36 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate deposit batch: deposit batch is used on a bank statement line',0,0,'Y',TO_DATE('2024-12-16 14:16:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-12-16 14:16:35','YYYY-MM-DD HH24:MI:SS'),100,200920,'DepositBatchReactivationFailedBankStatementLine','D','ad7c18ca-4354-49de-a9f7-ea55ce4e970c')
;

-- Dec 16, 2024, 2:16:36 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not void deposit batch: deposit batch is used on a bank statement line',0,0,'Y',TO_DATE('2024-12-16 14:16:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-12-16 14:16:36','YYYY-MM-DD HH24:MI:SS'),100,200921,'DepositBatchVoidFailedBankStatementLine','D','2cd760c5-5ce1-47d0-8c51-387eebe0b953')
;

-- Dec 16, 2024, 2:16:57 PM IST
UPDATE AD_Val_Rule SET Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus <>''VO'') AND NOT EXISTS (SELECT * FROM C_DepositBatchLine dbl INNER JOIN C_BankStatementLine bsl ON (dbl.C_Payment_ID = bsl.C_Payment_ID) INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE dbl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus <> ''VO'') AND C_DepositBatch.processed = ''Y'' AND C_DepositBatch.docstatus IN (''CO'',''CL'') AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_DATE('2024-12-17 12:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;