-- 
SELECT register_migration_script('202307041724_IDEMPIERE-5329.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 4, 2023, 5:49:39 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217705,'42f92d96-2ce3-47cc-bdc6-d02c82a9aefc',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_depositbatch_id','c_payment.c_depositbatch_id',820)
;

-- Jul 4, 2023, 5:52:38 PM IST
CREATE OR REPLACE VIEW C_Payment_v(c_payment_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, documentno, datetrx, isreceipt, c_doctype_id, trxtype, c_bankaccount_id, c_bpartner_id, c_invoice_id, c_bp_bankaccount_id, c_paymentbatch_id, tendertype, creditcardtype, creditcardnumber, creditcardvv, creditcardexpmm, creditcardexpyy, micr, routingno, accountno, checkno, a_name, a_street, a_city, a_state, a_zip, a_ident_dl, a_ident_ssn, a_email, voiceauthcode, orig_trxid, ponum, c_currency_id, c_conversiontype_id, payamt, discountamt, writeoffamt, taxamt, overunderamt, multiplierap, isoverunderpayment, isapproved, r_pnref, r_result, r_respmsg, r_authcode, r_avsaddr, r_avszip, r_info, processing, oprocessing, docstatus, docaction, isprepayment, c_charge_id, isreconciled, isallocated, isonline, processed, posted, c_campaign_id, c_project_id, c_activity_id, ad_orgtrx_id, chargeamt, c_order_id, dateacct, description, isselfservice, processedon, reversal_id, currencyrate, convertedamt, isoverridecurrencyrate, c_depositbatch_id) AS SELECT c_payment.c_payment_id AS c_payment_id, c_payment.ad_client_id AS ad_client_id, c_payment.ad_org_id AS ad_org_id, c_payment.isactive AS isactive, c_payment.created AS created, c_payment.createdby AS createdby, c_payment.updated AS updated, c_payment.updatedby AS updatedby, c_payment.documentno AS documentno, c_payment.datetrx AS datetrx, c_payment.isreceipt AS isreceipt, c_payment.c_doctype_id AS c_doctype_id, c_payment.trxtype AS trxtype, c_payment.c_bankaccount_id AS c_bankaccount_id, c_payment.c_bpartner_id AS c_bpartner_id, c_payment.c_invoice_id AS c_invoice_id, c_payment.c_bp_bankaccount_id AS c_bp_bankaccount_id, c_payment.c_paymentbatch_id AS c_paymentbatch_id, c_payment.tendertype AS tendertype, c_payment.creditcardtype AS creditcardtype, c_payment.creditcardnumber AS creditcardnumber, c_payment.creditcardvv AS creditcardvv, c_payment.creditcardexpmm AS creditcardexpmm, c_payment.creditcardexpyy AS creditcardexpyy, c_payment.micr AS micr, c_payment.routingno AS routingno, c_payment.accountno AS accountno, c_payment.checkno AS checkno, c_payment.a_name AS a_name, c_payment.a_street AS a_street, c_payment.a_city AS a_city, c_payment.a_state AS a_state, c_payment.a_zip AS a_zip, c_payment.a_ident_dl AS a_ident_dl, c_payment.a_ident_ssn AS a_ident_ssn, c_payment.a_email AS a_email, c_payment.voiceauthcode AS voiceauthcode, c_payment.orig_trxid AS orig_trxid, c_payment.ponum AS ponum, c_payment.c_currency_id AS c_currency_id, c_payment.c_conversiontype_id AS c_conversiontype_id, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.payamt ELSE c_payment.payamt * (-1) END AS payamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.discountamt ELSE c_payment.discountamt * (-1) END AS discountamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.writeoffamt ELSE c_payment.writeoffamt * (-1) END AS writeoffamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.taxamt ELSE c_payment.taxamt * (-1) END AS taxamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.overunderamt ELSE c_payment.overunderamt * (-1) END AS overunderamt, CASE c_payment.isreceipt WHEN 'Y' THEN 1 ELSE (-1) END AS multiplierap, c_payment.isoverunderpayment AS isoverunderpayment, c_payment.isapproved AS isapproved, c_payment.r_pnref AS r_pnref, c_payment.r_result AS r_result, c_payment.r_respmsg AS r_respmsg, c_payment.r_authcode AS r_authcode, c_payment.r_avsaddr AS r_avsaddr, c_payment.r_avszip AS r_avszip, c_payment.r_info AS r_info, c_payment.processing AS processing, c_payment.oprocessing AS oprocessing, c_payment.docstatus AS docstatus, c_payment.docaction AS docaction, c_payment.isprepayment AS isprepayment, c_payment.c_charge_id AS c_charge_id, c_payment.isreconciled AS isreconciled, c_payment.isallocated AS isallocated, c_payment.isonline AS isonline, c_payment.processed AS processed, c_payment.posted AS posted, c_payment.c_campaign_id AS c_campaign_id, c_payment.c_project_id AS c_project_id, c_payment.c_activity_id AS c_activity_id, c_payment.ad_orgtrx_id AS ad_orgtrx_id, c_payment.chargeamt AS chargeamt, c_payment.c_order_id AS c_order_id, c_payment.dateacct AS dateacct, c_payment.description AS description, c_payment.isselfservice AS isselfservice, c_payment.processedon AS processedon, c_payment.reversal_id AS reversal_id, c_payment.currencyrate AS currencyrate, c_payment.convertedamt AS convertedamt, c_payment.isoverridecurrencyrate AS isoverridecurrencyrate, c_payment.c_depositbatch_id AS c_depositbatch_id FROM c_payment
;
