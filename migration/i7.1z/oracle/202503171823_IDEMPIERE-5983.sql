SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5983  Not posting Reverse Corrected Document
-- 17-Mar-2025, 7:16:23 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200716,'No Posting Required',234,'R',0,0,'Y',TO_DATE('2025-03-17 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-03-17 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,'D','def573d1-07ae-4b61-8c45-756ae7353596')
;

-- View: rv_unposted

-- DROP VIEW rv_unposted;

CREATE OR REPLACE VIEW rv_unposted
 AS
 SELECT gl_journal.ad_client_id,
    gl_journal.ad_org_id,
    gl_journal.created,
    gl_journal.createdby,
    gl_journal.updated,
    gl_journal.updatedby,
    gl_journal.isactive,
    gl_journal.documentno,
    gl_journal.datedoc,
    gl_journal.dateacct,
    224 AS ad_table_id,
    gl_journal.gl_journal_id AS record_id,
    'N' AS issotrx,
    gl_journal.posted,
    gl_journal.processing,
    gl_journal.processed,
    gl_journal.docstatus,
    gl_journal.processedon
   FROM gl_journal
  WHERE gl_journal.posted NOT IN ('Y', 'R') AND gl_journal.docstatus <> 'VO'
UNION
 SELECT pi.ad_client_id,
    pi.ad_org_id,
    pi.created,
    pi.createdby,
    pi.updated,
    pi.updatedby,
    pi.isactive,
    (p.name || '_') || pi.line AS documentno,
    pi.movementdate AS datedoc,
    pi.movementdate AS dateacct,
    623 AS ad_table_id,
    pi.c_projectissue_id AS record_id,
    'N' AS issotrx,
    pi.posted,
    pi.processing,
    pi.processed,
    'CO' AS docstatus,
    pi.processedon
   FROM c_projectissue pi
     JOIN c_project p ON pi.c_project_id = p.c_project_id
  WHERE pi.posted NOT IN ('Y', 'R')
UNION
 SELECT c_invoice.ad_client_id,
    c_invoice.ad_org_id,
    c_invoice.created,
    c_invoice.createdby,
    c_invoice.updated,
    c_invoice.updatedby,
    c_invoice.isactive,
    c_invoice.documentno,
    c_invoice.dateinvoiced AS datedoc,
    c_invoice.dateacct,
    318 AS ad_table_id,
    c_invoice.c_invoice_id AS record_id,
    c_invoice.issotrx,
    c_invoice.posted,
    c_invoice.processing,
    c_invoice.processed,
    c_invoice.docstatus,
    c_invoice.processedon
   FROM c_invoice
  WHERE c_invoice.posted NOT IN ('Y', 'R') AND c_invoice.docstatus <> 'VO'
UNION
 SELECT m_inout.ad_client_id,
    m_inout.ad_org_id,
    m_inout.created,
    m_inout.createdby,
    m_inout.updated,
    m_inout.updatedby,
    m_inout.isactive,
    m_inout.documentno,
    m_inout.movementdate AS datedoc,
    m_inout.dateacct,
    319 AS ad_table_id,
    m_inout.m_inout_id AS record_id,
    m_inout.issotrx,
    m_inout.posted,
    m_inout.processing,
    m_inout.processed,
    m_inout.docstatus,
    m_inout.processedon
   FROM m_inout
  WHERE m_inout.posted NOT IN ('Y', 'R') AND m_inout.docstatus <> 'VO'
UNION
 SELECT m_inventory.ad_client_id,
    m_inventory.ad_org_id,
    m_inventory.created,
    m_inventory.createdby,
    m_inventory.updated,
    m_inventory.updatedby,
    m_inventory.isactive,
    m_inventory.documentno,
    m_inventory.movementdate AS datedoc,
    m_inventory.movementdate AS dateacct,
    321 AS ad_table_id,
    m_inventory.m_inventory_id AS record_id,
    'N' AS issotrx,
    m_inventory.posted,
    m_inventory.processing,
    m_inventory.processed,
    m_inventory.docstatus,
    m_inventory.processedon
   FROM m_inventory
  WHERE m_inventory.posted NOT IN ('Y', 'R') AND m_inventory.docstatus <> 'VO'
UNION
 SELECT m_movement.ad_client_id,
    m_movement.ad_org_id,
    m_movement.created,
    m_movement.createdby,
    m_movement.updated,
    m_movement.updatedby,
    m_movement.isactive,
    m_movement.documentno,
    m_movement.movementdate AS datedoc,
    m_movement.movementdate AS dateacct,
    323 AS ad_table_id,
    m_movement.m_movement_id AS record_id,
    'N' AS issotrx,
    m_movement.posted,
    m_movement.processing,
    m_movement.processed,
    m_movement.docstatus,
    m_movement.processedon
   FROM m_movement
  WHERE m_movement.posted NOT IN ('Y', 'R') AND m_movement.docstatus <> 'VO'
UNION
 SELECT m_production.ad_client_id,
    m_production.ad_org_id,
    m_production.created,
    m_production.createdby,
    m_production.updated,
    m_production.updatedby,
    m_production.isactive,
    m_production.documentno,
    m_production.movementdate AS datedoc,
    m_production.movementdate AS dateacct,
    325 AS ad_table_id,
    m_production.m_production_id AS record_id,
    'N' AS issotrx,
    m_production.posted,
    m_production.processing,
    m_production.processed,
    m_production.docstatus,
    m_production.processedon
   FROM m_production
  WHERE m_production.posted NOT IN ('Y', 'R') AND m_production.docstatus <> 'VO'
UNION
 SELECT c_cash.ad_client_id,
    c_cash.ad_org_id,
    c_cash.created,
    c_cash.createdby,
    c_cash.updated,
    c_cash.updatedby,
    c_cash.isactive,
    c_cash.name AS documentno,
    c_cash.statementdate AS datedoc,
    c_cash.dateacct,
    407 AS ad_table_id,
    c_cash.c_cash_id AS record_id,
    'N' AS issotrx,
    c_cash.posted,
    c_cash.processing,
    c_cash.processed,
    c_cash.docstatus,
    c_cash.processedon
   FROM c_cash
  WHERE c_cash.posted NOT IN ('Y', 'R') AND c_cash.docstatus <> 'VO'
UNION
 SELECT c_payment.ad_client_id,
    c_payment.ad_org_id,
    c_payment.created,
    c_payment.createdby,
    c_payment.updated,
    c_payment.updatedby,
    c_payment.isactive,
    c_payment.documentno,
    c_payment.datetrx AS datedoc,
    c_payment.dateacct,
    335 AS ad_table_id,
    c_payment.c_payment_id AS record_id,
    'N' AS issotrx,
    c_payment.posted,
    c_payment.processing,
    c_payment.processed,
    c_payment.docstatus,
    c_payment.processedon
   FROM c_payment
  WHERE c_payment.posted NOT IN ('Y', 'R') AND c_payment.docstatus <> 'VO'
UNION
 SELECT c_allocationhdr.ad_client_id,
    c_allocationhdr.ad_org_id,
    c_allocationhdr.created,
    c_allocationhdr.createdby,
    c_allocationhdr.updated,
    c_allocationhdr.updatedby,
    c_allocationhdr.isactive,
    c_allocationhdr.documentno,
    c_allocationhdr.datetrx AS datedoc,
    c_allocationhdr.dateacct,
    735 AS ad_table_id,
    c_allocationhdr.c_allocationhdr_id AS record_id,
    'N' AS issotrx,
    c_allocationhdr.posted,
    c_allocationhdr.processing,
    c_allocationhdr.processed,
    c_allocationhdr.docstatus,
    c_allocationhdr.processedon
   FROM c_allocationhdr
  WHERE c_allocationhdr.posted NOT IN ('Y', 'R') AND c_allocationhdr.docstatus <> 'VO'
UNION
 SELECT c_bankstatement.ad_client_id,
    c_bankstatement.ad_org_id,
    c_bankstatement.created,
    c_bankstatement.createdby,
    c_bankstatement.updated,
    c_bankstatement.updatedby,
    c_bankstatement.isactive,
    c_bankstatement.name AS documentno,
    c_bankstatement.statementdate AS datedoc,
    c_bankstatement.statementdate AS dateacct,
    392 AS ad_table_id,
    c_bankstatement.c_bankstatement_id AS record_id,
    'N' AS issotrx,
    c_bankstatement.posted,
    c_bankstatement.processing,
    c_bankstatement.processed,
    c_bankstatement.docstatus,
    c_bankstatement.processedon
   FROM c_bankstatement
  WHERE c_bankstatement.posted NOT IN ('Y', 'R') AND c_bankstatement.docstatus <> 'VO'
UNION
 SELECT m_matchinv.ad_client_id,
    m_matchinv.ad_org_id,
    m_matchinv.created,
    m_matchinv.createdby,
    m_matchinv.updated,
    m_matchinv.updatedby,
    m_matchinv.isactive,
    m_matchinv.documentno,
    m_matchinv.datetrx AS datedoc,
    m_matchinv.dateacct,
    472 AS ad_table_id,
    m_matchinv.m_matchinv_id AS record_id,
    'N' AS issotrx,
    m_matchinv.posted,
    m_matchinv.processing,
    m_matchinv.processed,
    'CO' AS docstatus,
    m_matchinv.processedon
   FROM m_matchinv
  WHERE m_matchinv.posted NOT IN ('Y', 'R') AND COALESCE(m_matchinv.m_matchinvhdr_id, 0::numeric) = 0::numeric
UNION
 SELECT m_matchinvhdr.ad_client_id,
    m_matchinvhdr.ad_org_id,
    m_matchinvhdr.created,
    m_matchinvhdr.createdby,
    m_matchinvhdr.updated,
    m_matchinvhdr.updatedby,
    m_matchinvhdr.isactive,
    m_matchinvhdr.documentno,
    m_matchinvhdr.datetrx AS datedoc,
    m_matchinvhdr.dateacct,
    200196 AS ad_table_id,
    m_matchinvhdr.m_matchinvhdr_id AS record_id,
    'N' AS issotrx,
    m_matchinvhdr.posted,
    m_matchinvhdr.processing,
    m_matchinvhdr.processed,
    m_matchinvhdr.docstatus,
    m_matchinvhdr.processedon
   FROM m_matchinvhdr
  WHERE m_matchinvhdr.posted NOT IN ('Y', 'R')
UNION
 SELECT m_matchpo.ad_client_id,
    m_matchpo.ad_org_id,
    m_matchpo.created,
    m_matchpo.createdby,
    m_matchpo.updated,
    m_matchpo.updatedby,
    m_matchpo.isactive,
    m_matchpo.documentno,
    m_matchpo.datetrx AS datedoc,
    m_matchpo.dateacct,
    473 AS ad_table_id,
    m_matchpo.m_matchpo_id AS record_id,
    'N' AS issotrx,
    m_matchpo.posted,
    m_matchpo.processing,
    m_matchpo.processed,
    'CO' AS docstatus,
    m_matchpo.processedon
   FROM m_matchpo
  WHERE m_matchpo.posted NOT IN ('Y', 'R')
UNION
 SELECT c_order.ad_client_id,
    c_order.ad_org_id,
    c_order.created,
    c_order.createdby,
    c_order.updated,
    c_order.updatedby,
    c_order.isactive,
    c_order.documentno,
    c_order.dateordered AS datedoc,
    c_order.dateacct,
    259 AS ad_table_id,
    c_order.c_order_id AS record_id,
    c_order.issotrx,
    c_order.posted,
    c_order.processing,
    c_order.processed,
    c_order.docstatus,
    c_order.processedon
   FROM c_order
  WHERE c_order.posted NOT IN ('Y', 'R') AND c_order.docstatus <> 'VO'
UNION
 SELECT m_requisition.ad_client_id,
    m_requisition.ad_org_id,
    m_requisition.created,
    m_requisition.createdby,
    m_requisition.updated,
    m_requisition.updatedby,
    m_requisition.isactive,
    m_requisition.documentno,
    m_requisition.datedoc,
    m_requisition.datedoc AS dateacct,
    702 AS ad_table_id,
    m_requisition.m_requisition_id AS record_id,
    'N' AS issotrx,
    m_requisition.posted,
    m_requisition.processing,
    m_requisition.processed,
    m_requisition.docstatus,
    m_requisition.processedon
   FROM m_requisition
  WHERE m_requisition.posted NOT IN ('Y', 'R') AND m_requisition.docstatus <> 'VO';

SELECT register_migration_script('202503171823_IDEMPIERE-5983.sql') FROM dual
;
