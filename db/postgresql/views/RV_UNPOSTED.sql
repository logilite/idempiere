 CREATE OR replace VIEW rv_unposted
AS
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datedoc,
         dateacct,
         224           AS AD_Table_ID,
         gl_journal_id AS Record_ID,
         'N'           AS IsSOTrx,
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   gl_journal
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT pi.ad_client_id,
         pi.ad_org_id,
         pi.created,
         pi.createdby,
         pi.updated,
         pi.updatedby,
         pi.isactive,
         p.name
         || '_'
         || pi.line,
         pi.movementdate,
         pi.movementdate,
         623,
         pi.c_projectissue_id,
         'N',
         posted,
         pi.processing,
         pi.processed,
         'CO' AS DocStatus,
         processedon
  FROM   c_projectissue pi
         inner join c_project p
                 ON ( pi.c_project_id = p.c_project_id )
  WHERE  posted <> 'Y' --AND DocStatus<>'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         dateinvoiced,
         dateacct,
         318,
         c_invoice_id,
         issotrx,
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_invoice
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         movementdate,
         dateacct,
         319,
         m_inout_id,
         issotrx,
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_inout
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         movementdate,
         movementdate,
         321,
         m_inventory_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_inventory
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         movementdate,
         movementdate,
         323,
         m_movement_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_movement
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         movementdate,
         movementdate,
         325,
         m_production_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_production
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         name,
         statementdate,
         dateacct,
         407,
         c_cash_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_cash
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datetrx,
         dateacct,
         335,
         c_payment_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_payment
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datetrx,
         dateacct,
         735,
         c_allocationhdr_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_allocationhdr
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         name,
         statementdate,
         statementdate,
         392,
         c_bankstatement_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_bankstatement
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datetrx,
         dateacct,
         472,
         m_matchinv_id,
         'N',
         posted,
         processing,
         processed,
         'CO' AS docstatus,
         processedon
  FROM   m_matchinv
  WHERE  posted <> 'Y'
         AND Coalesce(m_matchinvhdr_id, 0) = 0 --AND DocStatus<>'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datetrx,
         dateacct,
         473,
         m_matchpo_id,
         'N',
         posted,
         processing,
         processed,
         'CO' AS docstatus,
         processedon
  FROM   m_matchpo
  WHERE  posted <> 'Y' --AND DocStatus<>'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         dateordered,
         dateacct,
         259,
         c_order_id,
         issotrx,
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   c_order
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datedoc,
         datedoc,
         702,
         m_requisition_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_requisition
  WHERE  posted <> 'Y'
         AND docstatus <> 'VO'
  UNION
  SELECT ad_client_id,
         ad_org_id,
         created,
         createdby,
         updated,
         updatedby,
         isactive,
         documentno,
         datetrx,
         dateacct,
         200196,
         m_matchinvhdr_id,
         'N',
         posted,
         processing,
         processed,
         docstatus,
         processedon
  FROM   m_matchinvhdr
  WHERE  posted <> 'Y';  