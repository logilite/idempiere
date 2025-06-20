 CREATE OR replace VIEW rv_unposted
(ad_client_id, ad_org_id, created, createdby, updated, updatedby, isactive, documentno, datedoc,
dateacct, ad_table_id, record_id, issotrx, posted, processing, processed, docstatus, processedon,
docbasetype, rv_unposted_uu)
AS
  SELECT gl_journal.ad_client_id  AS AD_Client_ID,
         gl_journal.ad_org_id     AS AD_Org_ID,
         gl_journal.created       AS Created,
         gl_journal.createdby     AS CreatedBy,
         gl_journal.updated       AS Updated,
         gl_journal.updatedby     AS UpdatedBy,
         gl_journal.isactive      AS IsActive,
         gl_journal.documentno    AS DocumentNo,
         gl_journal.datedoc       AS DateDoc,
         gl_journal.dateacct      AS DateAcct,
         224                      AS AD_Table_ID,
         gl_journal.gl_journal_id AS Record_ID,
         'N'                      AS IsSOTrx,
         gl_journal.posted        AS Posted,
         gl_journal.processing    AS Processing,
         gl_journal.processed     AS Processed,
         gl_journal.docstatus     AS DocStatus,
         gl_journal.processedon   AS ProcessedOn,
         dt.docbasetype           AS DocBaseType,
         gl_journal.gl_journal_uu AS RV_UnPosted_UU
  FROM   gl_journal
         join c_doctype dt
           ON ( dt.c_doctype_id = gl_journal.c_doctype_id )
  WHERE  gl_journal.posted NOT IN ( 'Y', 'R' )
         AND gl_journal.docstatus <> 'VO'
  UNION
  SELECT pi.ad_client_id      AS AD_Client_ID,
         pi.ad_org_id         AS AD_Org_ID,
         pi.created           AS Created,
         pi.createdby         AS CreatedBy,
         pi.updated           AS Updated,
         pi.updatedby         AS UpdatedBy,
         pi.isactive          AS IsActive,
         ( p.name
           || '_' )
         || pi.line           AS DocumentNo,
         pi.movementdate      AS DateDoc,
         pi.movementdate      AS DateAcct,
         623                  AS AD_Table_ID,
         pi.c_projectissue_id AS Record_ID,
         'N'                  AS IsSOTrx,
         pi.posted            AS Posted,
         pi.processing        AS Processing,
         pi.processed         AS Processed,
         'CO'                 AS DocStatus,
         pi.processedon       AS ProcessedOn,
         'PJI'                AS DocBaseType,
         pi.c_projectissue_uu AS RV_UnPosted_UU
  FROM   c_projectissue pi
         join c_project p
           ON pi.c_project_id = p.c_project_id
  WHERE  pi.posted NOT IN ( 'Y', 'R' )
  UNION
  SELECT c_invoice.ad_client_id AS AD_Client_ID,
         c_invoice.ad_org_id    AS AD_Org_ID,
         c_invoice.created      AS Created,
         c_invoice.createdby    AS CreatedBy,
         c_invoice.updated      AS Updated,
         c_invoice.updatedby    AS UpdatedBy,
         c_invoice.isactive     AS IsActive,
         c_invoice.documentno   AS DocumentNo,
         c_invoice.dateinvoiced AS DateDoc,
         c_invoice.dateacct     AS DateAcct,
         318                    AS AD_Table_ID,
         c_invoice.c_invoice_id AS Record_ID,
         c_invoice.issotrx      AS IsSOTrx,
         c_invoice.posted       AS Posted,
         c_invoice.processing   AS Processing,
         c_invoice.processed    AS Processed,
         c_invoice.docstatus    AS DocStatus,
         c_invoice.processedon  AS ProcessedOn,
         dt.docbasetype         AS DocBaseType,
         c_invoice.c_invoice_uu AS RV_UnPosted_UU
  FROM   c_invoice
         join c_doctype dt
           ON ( dt.c_doctype_id = c_invoice.c_doctype_id )
  WHERE  c_invoice.posted NOT IN ( 'Y', 'R' )
         AND c_invoice.docstatus <> 'VO'
  UNION
  SELECT m_inout.ad_client_id AS AD_Client_ID,
         m_inout.ad_org_id    AS AD_Org_ID,
         m_inout.created      AS Created,
         m_inout.createdby    AS CreatedBy,
         m_inout.updated      AS Updated,
         m_inout.updatedby    AS UpdatedBy,
         m_inout.isactive     AS IsActive,
         m_inout.documentno   AS DocumentNo,
         m_inout.movementdate AS DateDoc,
         m_inout.dateacct     AS DateAcct,
         319                  AS AD_Table_ID,
         m_inout.m_inout_id   AS Record_ID,
         m_inout.issotrx      AS IsSOTrx,
         m_inout.posted       AS Posted,
         m_inout.processing   AS Processing,
         m_inout.processed    AS Processed,
         m_inout.docstatus    AS DocStatus,
         m_inout.processedon  AS ProcessedOn,
         dt.docbasetype       AS DocBaseType,
         m_inout.m_inout_uu   AS RV_UnPosted_UU
  FROM   m_inout
         join c_doctype dt
           ON ( dt.c_doctype_id = m_inout.c_doctype_id )
  WHERE  m_inout.posted NOT IN ( 'Y', 'R' )
         AND m_inout.docstatus <> 'VO'
  UNION
  SELECT m_inventory.ad_client_id   AS AD_Client_ID,
         m_inventory.ad_org_id      AS AD_Org_ID,
         m_inventory.created        AS Created,
         m_inventory.createdby      AS CreatedBy,
         m_inventory.updated        AS Updated,
         m_inventory.updatedby      AS UpdatedBy,
         m_inventory.isactive       AS IsActive,
         m_inventory.documentno     AS DocumentNo,
         m_inventory.movementdate   AS DateDoc,
         m_inventory.movementdate   AS DateAcct,
         321                        AS AD_Table_ID,
         m_inventory.m_inventory_id AS Record_ID,
         'N'                        AS IsSOTrx,
         m_inventory.posted         AS Posted,
         m_inventory.processing     AS Processing,
         m_inventory.processed      AS Processed,
         m_inventory.docstatus      AS DocStatus,
         m_inventory.processedon    AS ProcessedOn,
         dt.docbasetype             AS DocBaseType,
         m_inventory.m_inventory_uu AS RV_UnPosted_UU
  FROM   m_inventory
         join c_doctype dt
           ON ( dt.c_doctype_id = m_inventory.c_doctype_id )
  WHERE  m_inventory.posted NOT IN ( 'Y', 'R' )
         AND m_inventory.docstatus <> 'VO'
  UNION
  SELECT m_movement.ad_client_id  AS AD_Client_ID,
         m_movement.ad_org_id     AS AD_Org_ID,
         m_movement.created       AS Created,
         m_movement.createdby     AS CreatedBy,
         m_movement.updated       AS Updated,
         m_movement.updatedby     AS UpdatedBy,
         m_movement.isactive      AS IsActive,
         m_movement.documentno    AS DocumentNo,
         m_movement.movementdate  AS DateDoc,
         m_movement.movementdate  AS DateAcct,
         323                      AS AD_Table_ID,
         m_movement.m_movement_id AS Record_ID,
         'N'                      AS IsSOTrx,
         m_movement.posted        AS Posted,
         m_movement.processing    AS Processing,
         m_movement.processed     AS Processed,
         m_movement.docstatus     AS DocStatus,
         m_movement.processedon   AS ProcessedOn,
         dt.docbasetype           AS DocBaseType,
         m_movement.m_movement_uu AS RV_UnPosted_UU
  FROM   m_movement
         join c_doctype dt
           ON ( dt.c_doctype_id = m_movement.c_doctype_id )
  WHERE  m_movement.posted NOT IN ( 'Y', 'R' )
         AND m_movement.docstatus <> 'VO'
  UNION
  SELECT m_production.ad_client_id    AS AD_Client_ID,
         m_production.ad_org_id       AS AD_Org_ID,
         m_production.created         AS Created,
         m_production.createdby       AS CreatedBy,
         m_production.updated         AS Updated,
         m_production.updatedby       AS UpdatedBy,
         m_production.isactive        AS IsActive,
         m_production.documentno      AS DocumentNo,
         m_production.movementdate    AS DateDoc,
         m_production.movementdate    AS DateAcct,
         325                          AS AD_Table_ID,
         m_production.m_production_id AS Record_ID,
         'N'                          AS IsSOTrx,
         m_production.posted          AS Posted,
         m_production.processing      AS Processing,
         m_production.processed       AS Processed,
         m_production.docstatus       AS DocStatus,
         m_production.processedon     AS ProcessedOn,
         'MMP'                        AS DocBaseType,
         m_production.m_production_uu AS RV_UnPosted_UU
  FROM   m_production
  WHERE  m_production.posted NOT IN ( 'Y', 'R' )
         AND m_production.docstatus <> 'VO'
  UNION
  SELECT c_cash.ad_client_id  AS AD_Client_ID,
         c_cash.ad_org_id     AS AD_Org_ID,
         c_cash.created       AS Created,
         c_cash.createdby     AS CreatedBy,
         c_cash.updated       AS Updated,
         c_cash.updatedby     AS UpdatedBy,
         c_cash.isactive      AS IsActive,
         c_cash.name          AS DocumentNo,
         c_cash.statementdate AS DateDoc,
         c_cash.dateacct      AS DateAcct,
         407                  AS AD_Table_ID,
         c_cash.c_cash_id     AS Record_ID,
         'N'                  AS IsSOTrx,
         c_cash.posted        AS Posted,
         c_cash.processing    AS Processing,
         c_cash.processed     AS Processed,
         c_cash.docstatus     AS DocStatus,
         c_cash.processedon   AS ProcessedOn,
         'CMC'                AS DocBaseType,
         c_cash.c_cash_uu     AS RV_UnPosted_UU
  FROM   c_cash
  WHERE  c_cash.posted NOT IN ( 'Y', 'R' )
         AND c_cash.docstatus <> 'VO'
  UNION
  SELECT c_payment.ad_client_id AS AD_Client_ID,
         c_payment.ad_org_id    AS AD_Org_ID,
         c_payment.created      AS Created,
         c_payment.createdby    AS CreatedBy,
         c_payment.updated      AS Updated,
         c_payment.updatedby    AS UpdatedBy,
         c_payment.isactive     AS IsActive,
         c_payment.documentno   AS DocumentNo,
         c_payment.datetrx      AS DateDoc,
         c_payment.dateacct     AS DateAcct,
         335                    AS AD_Table_ID,
         c_payment.c_payment_id AS Record_ID,
         'N'                    AS IsSOTrx,
         c_payment.posted       AS Posted,
         c_payment.processing   AS Processing,
         c_payment.processed    AS Processed,
         c_payment.docstatus    AS DocStatus,
         c_payment.processedon  AS ProcessedOn,
         dt.docbasetype         AS DocBaseType,
         c_payment.c_payment_uu AS RV_UnPosted_UU
  FROM   c_payment
         join c_doctype dt
           ON ( dt.c_doctype_id = c_payment.c_doctype_id )
  WHERE  c_payment.posted NOT IN ( 'Y', 'R' )
         AND c_payment.docstatus <> 'VO'
  UNION
  SELECT c_allocationhdr.ad_client_id       AS AD_Client_ID,
         c_allocationhdr.ad_org_id          AS AD_Org_ID,
         c_allocationhdr.created            AS Created,
         c_allocationhdr.createdby          AS CreatedBy,
         c_allocationhdr.updated            AS Updated,
         c_allocationhdr.updatedby          AS UpdatedBy,
         c_allocationhdr.isactive           AS IsActive,
         c_allocationhdr.documentno         AS DocumentNo,
         c_allocationhdr.datetrx            AS DateDoc,
         c_allocationhdr.dateacct           AS DateAcct,
         735                                AS AD_Table_ID,
         c_allocationhdr.c_allocationhdr_id AS Record_ID,
         'N'                                AS IsSOTrx,
         c_allocationhdr.posted             AS Posted,
         c_allocationhdr.processing         AS Processing,
         c_allocationhdr.processed          AS Processed,
         c_allocationhdr.docstatus          AS DocStatus,
         c_allocationhdr.processedon        AS ProcessedOn,
         dt.docbasetype                     AS DocBaseType,
         c_allocationhdr.c_allocationhdr_uu AS RV_UnPosted_UU
  FROM   c_allocationhdr
         join c_doctype dt
           ON ( dt.c_doctype_id = c_allocationhdr.c_doctype_id )
  WHERE  c_allocationhdr.posted NOT IN ( 'Y', 'R' )
         AND c_allocationhdr.docstatus <> 'VO'
  UNION
  SELECT c_bankstatement.ad_client_id       AS AD_Client_ID,
         c_bankstatement.ad_org_id          AS AD_Org_ID,
         c_bankstatement.created            AS Created,
         c_bankstatement.createdby          AS CreatedBy,
         c_bankstatement.updated            AS Updated,
         c_bankstatement.updatedby          AS UpdatedBy,
         c_bankstatement.isactive           AS IsActive,
         c_bankstatement.name               AS DocumentNo,
         c_bankstatement.statementdate      AS DateDoc,
         c_bankstatement.statementdate      AS DateAcct,
         392                                AS AD_Table_ID,
         c_bankstatement.c_bankstatement_id AS Record_ID,
         'N'                                AS IsSOTrx,
         c_bankstatement.posted             AS Posted,
         c_bankstatement.processing         AS Processing,
         c_bankstatement.processed          AS Processed,
         c_bankstatement.docstatus          AS DocStatus,
         c_bankstatement.processedon        AS ProcessedOn,
         'CMB'                              AS DocBaseType,
         c_bankstatement.c_bankstatement_uu AS RV_UnPosted_UU
  FROM   c_bankstatement
  WHERE  c_bankstatement.posted NOT IN ( 'Y', 'R' )
         AND c_bankstatement.docstatus <> 'VO'
  UNION
  SELECT m_matchinv.ad_client_id  AS AD_Client_ID,
         m_matchinv.ad_org_id     AS AD_Org_ID,
         m_matchinv.created       AS Created,
         m_matchinv.createdby     AS CreatedBy,
         m_matchinv.updated       AS Updated,
         m_matchinv.updatedby     AS UpdatedBy,
         m_matchinv.isactive      AS IsActive,
         m_matchinv.documentno    AS DocumentNo,
         m_matchinv.datetrx       AS DateDoc,
         m_matchinv.dateacct      AS DateAcct,
         472                      AS AD_Table_ID,
         m_matchinv.m_matchinv_id AS Record_ID,
         'N'                      AS IsSOTrx,
         m_matchinv.posted        AS Posted,
         m_matchinv.processing    AS Processing,
         m_matchinv.processed     AS Processed,
         'CO'                     AS DocStatus,
         m_matchinv.processedon   AS ProcessedOn,
         'MXI'                    AS DocBaseType,
         m_matchinv.m_matchinv_uu AS RV_UnPosted_UU
  FROM   m_matchinv
  WHERE  m_matchinv.posted NOT IN ( 'Y', 'R' )
  UNION
  SELECT m_matchpo.ad_client_id AS AD_Client_ID,
         m_matchpo.ad_org_id    AS AD_Org_ID,
         m_matchpo.created      AS Created,
         m_matchpo.createdby    AS CreatedBy,
         m_matchpo.updated      AS Updated,
         m_matchpo.updatedby    AS UpdatedBy,
         m_matchpo.isactive     AS IsActive,
         m_matchpo.documentno   AS DocumentNo,
         m_matchpo.datetrx      AS DateDoc,
         m_matchpo.dateacct     AS DateAcct,
         473                    AS AD_Table_ID,
         m_matchpo.m_matchpo_id AS Record_ID,
         'N'                    AS IsSOTrx,
         m_matchpo.posted       AS Posted,
         m_matchpo.processing   AS Processing,
         m_matchpo.processed    AS Processed,
         'CO'                   AS DocStatus,
         m_matchpo.processedon  AS ProcessedOn,
         'MXP'                  AS DocBaseType,
         m_matchpo.m_matchpo_uu AS RV_UnPosted_UU
  FROM   m_matchpo
  WHERE  m_matchpo.posted NOT IN ( 'Y', 'R' )
  UNION
  SELECT c_order.ad_client_id AS AD_Client_ID,
         c_order.ad_org_id    AS AD_Org_ID,
         c_order.created      AS Created,
         c_order.createdby    AS CreatedBy,
         c_order.updated      AS Updated,
         c_order.updatedby    AS UpdatedBy,
         c_order.isactive     AS IsActive,
         c_order.documentno   AS DocumentNo,
         c_order.dateordered  AS DateDoc,
         c_order.dateacct     AS DateAcct,
         259                  AS AD_Table_ID,
         c_order.c_order_id   AS Record_ID,
         c_order.issotrx      AS IsSOTrx,
         c_order.posted       AS Posted,
         c_order.processing   AS Processing,
         c_order.processed    AS Processed,
         c_order.docstatus    AS DocStatus,
         c_order.processedon  AS ProcessedOn,
         dt.docbasetype       AS DocBaseType,
         c_order.c_order_uu   AS RV_UnPosted_UU
  FROM   c_order
         join c_doctype dt
           ON ( dt.c_doctype_id = c_order.c_doctype_id )
  WHERE  c_order.posted NOT IN ( 'Y', 'R' )
         AND c_order.docstatus <> 'VO'
  UNION
  SELECT m_requisition.ad_client_id     AS AD_Client_ID,
         m_requisition.ad_org_id        AS AD_Org_ID,
         m_requisition.created          AS Created,
         m_requisition.createdby        AS CreatedBy,
         m_requisition.updated          AS Updated,
         m_requisition.updatedby        AS UpdatedBy,
         m_requisition.isactive         AS IsActive,
         m_requisition.documentno       AS DocumentNo,
         m_requisition.datedoc          AS DateDoc,
         m_requisition.datedoc          AS DateAcct,
         702                            AS AD_Table_ID,
         m_requisition.m_requisition_id AS Record_ID,
         'N'                            AS IsSOTrx,
         m_requisition.posted           AS Posted,
         m_requisition.processing       AS Processing,
         m_requisition.processed        AS Processed,
         m_requisition.docstatus        AS DocStatus,
         m_requisition.processedon      AS ProcessedOn,
         dt.docbasetype                 AS DocBaseType,
         m_requisition.m_requisition_uu AS RV_UnPosted_UU
  FROM   m_requisition
         join c_doctype dt
           ON ( dt.c_doctype_id = m_requisition.c_doctype_id )
  WHERE  m_requisition.posted NOT IN ( 'Y', 'R' )
         AND m_requisition.docstatus <> 'VO'
  UNION
  SELECT m_matchinvhdr.ad_client_id     AS AD_Client_ID,
         m_matchinvhdr.ad_org_id        AS AD_Org_ID,
         m_matchinvhdr.created          AS Created,
         m_matchinvhdr.createdby        AS CreatedBy,
         m_matchinvhdr.updated          AS Updated,
         m_matchinvhdr.updatedby        AS UpdatedBy,
         m_matchinvhdr.isactive         AS IsActive,
         m_matchinvhdr.documentno       AS DocumentNo,
         m_matchinvhdr.datetrx          AS DateDoc,
         m_matchinvhdr.dateacct         AS DateAcct,
         200196                         AS AD_Table_ID,
         m_matchinvhdr.m_matchinvhdr_id AS Record_ID,
         'N'                            AS IsSOTrx,
         m_matchinvhdr.posted           AS Posted,
         m_matchinvhdr.processing       AS Processing,
         m_matchinvhdr.processed        AS Processed,
         m_matchinvhdr.docstatus        AS DocStatus,
         m_matchinvhdr.processedon      AS ProcessedOn,
         dt.docbasetype                 AS DocBaseType,
         m_matchinvhdr.m_matchinvhdr_uu AS RV_UnPosted_UU
  FROM   m_matchinvhdr
         join c_doctype dt
           ON ( dt.c_doctype_id = m_matchinvhdr.c_doctype_id )
  WHERE  m_matchinvhdr.posted NOT IN ( 'Y', 'R' );  
