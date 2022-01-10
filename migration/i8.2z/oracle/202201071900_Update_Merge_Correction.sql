SET SQLBLANKLINES ON
SET DEFINE OFF

-- Logilite 9 version merge view compatible

-- 1) 202105091048_IDEMPIERE-4771.sql  
-- Looks function definition execute properly in PGadmin board


-- 2) 202106031340_IDEMPIERE-4479.sql [ 2 view correction ]
-- Ingore error due to VIEW ad_field_v and ad_field_vt


-- 3) 202111141400_IDEMPIERE-4900.sql
-- Looks like "SQLReadOnly" msg created in i3.1z "201801241015_IDEMPIERE-1832.sql" with entitytype = U
-- Same msg with entitytype = D created in i8.2z "202111141400_IDEMPIERE-4900.sql"
-- Logilite version showing entityType=U so updating here

UPDATE AD_Message
SET EntityType = 'D'
WHERE AD_Message_ID=200259
;


-- 4) 202111161449_IDEMPIERE-2620.sql
-- Ingore error due to VIEW M_INOUT_CANDIDATE_V 


-- 5) 202111282319_IDEMPIERE-5059.sql
-- View compatible with logilite version ad_field_v, ad_field_vt, ad_tab_v, ad_tab_vt, ad_window_vt, m_inout_candidate_v

-- View: ad_field_v
DROP VIEW IF EXISTS ad_field_v;

CREATE OR REPLACE VIEW ad_field_v AS
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline,
f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue,
c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable,
COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable,
c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype,
fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid,
f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus,
c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(f.placeholder, c.placeholder) AS placeholder, c.ishtml, f.isquickform, COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id, vrf.code AS validationcodeLookup, f.entitytype
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
   LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;


-- View: ad_field_vt
DROP VIEW IF EXISTS ad_field_vt;

CREATE OR REPLACE VIEW ad_field_vt AS
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno,
 f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue,
 c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
 c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable,
 c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable,
 c.isencrypted AS isencryptedcolumn, COALESCE(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype,
 fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid,
 f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(trl.placeholder, ct.placeholder) AS placeholder, c.ishtml, f.isquickform, COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id, vrf.code AS validationcodeLookup, f.entitytype
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language = ct.ad_language
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
   LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE(f.ad_val_rule_Lookup_id, c.ad_val_rule_Lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;


-- View: ad_tab_v
DROP VIEW IF EXISTS ad_tab_v;

CREATE OR REPLACE VIEW AD_TAB_V
(AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, DESCRIPTION, 
 HELP, SEQNO, ISSINGLEROW, HASTREE, ISINFOTAB, 
 REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, ISDELETEABLE, 
 ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, ISREADONLY, 
 AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, COMMITWARNING, 
 READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, ISSORTTAB, 
 ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType,
 PageSize, DetailPageSize, EntityType)
AS 
SELECT t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, t.Name, t.Description, 
    t.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, t.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection, t.AD_TabType,
    t.PageSize, t.DetailPageSize, t.EntityType
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;


-- View: ad_tab_vt
DROP VIEW IF EXISTS ad_tab_vt;

CREATE OR REPLACE VIEW AD_TAB_VT
(AD_LANGUAGE, AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, 
 DESCRIPTION, HELP, SEQNO, ISSINGLEROW, HASTREE, 
 ISINFOTAB, REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, 
 ISDELETEABLE, ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, 
 ISREADONLY, AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, 
 COMMITWARNING, READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, 
 ISSORTTAB, ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType,
 PageSize, DetailPageSize, EntityType)
AS 
SELECT trl.AD_Language, t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, trl.Name, trl.Description, 
    trl.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, trl.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection, t.AD_TabType,
    t.PageSize, t.DetailPageSize, t.EntityType
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
	INNER JOIN AD_Tab_Trl trl ON (t.AD_Tab_ID = trl.AD_Tab_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;


-- View: ad_window_vt
DROP VIEW IF EXISTS ad_window_vt;

CREATE OR REPLACE VIEW AD_WINDOW_VT
(AD_LANGUAGE, AD_WINDOW_ID, NAME, DESCRIPTION, HELP, 
 WINDOWTYPE, AD_COLOR_ID, AD_IMAGE_ID, ISACTIVE, WINWIDTH, 
 WINHEIGHT, ISSOTRX, AD_Window_UU, EntityType)
AS 
SELECT trl.AD_Language, 
	bt.AD_Window_ID, trl.Name, trl.Description, trl.Help, bt.WindowType, 
	bt.AD_Color_ID, bt.AD_Image_ID, bt.IsActive, bt.WinWidth, bt.WinHeight,
    bt.IsSOTrx, bt.AD_Window_UU, bt.EntityType
FROM AD_Window bt
	INNER JOIN AD_Window_Trl trl ON (bt.AD_Window_ID=trl.AD_Window_ID)
WHERE bt.IsActive='Y';


-- View: m_inout_candidate_v
DROP VIEW IF EXISTS m_inout_candidate_v;

CREATE OR REPLACE VIEW M_INOUT_CANDIDATE_V
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, C_ORDER_ID, DOCUMENTNO, 
 DATEORDERED, C_DOCTYPE_ID, POREFERENCE, DESCRIPTION, SALESREP_ID, 
 M_WAREHOUSE_ID, OrderLine_OrgID, TOTALLINES)
AS 
SELECT	
	o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID, 
    o.POReference, o.Description, o.SalesRep_ID,
    l.M_Warehouse_ID,
    l.AD_Org_ID AS OrderLine_OrgID,
	SUM((l.QtyOrdered-l.QtyDelivered)*l.PriceActual) AS TotalLines
FROM C_Order o
  INNER JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID)
WHERE	(o.DocStatus = 'CO' AND o.IsDelivered='N')  --  Status must be CO - not CL/RE
	--	not Offers and open Walkin-Receipts
	AND o.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType
		WHERE DocBaseType='SOO' AND DocSubTypeSO NOT IN ('ON','OB','WR'))
    --  Delivery Rule - not manual
    AND o.DeliveryRule<>'M'
    AND (l.M_Product_ID IS NULL OR EXISTS 
        (SELECT 1 FROM M_Product p 
        WHERE l.M_Product_ID=p.M_Product_ID AND p.IsExcludeAutoDelivery='N'))
	--	we need to ship
	AND	l.QtyOrdered <> l.QtyDelivered
	AND o.IsDropShip='N'
    AND (l.M_Product_ID IS NOT NULL OR l.C_Charge_ID IS NOT NULL)
    --  Not confirmed shipment
    AND NOT EXISTS (SELECT 1 FROM M_InOutLine iol 
        INNER JOIN M_InOut io ON (iol.M_InOut_ID=io.M_InOut_ID)
        WHERE iol.C_OrderLine_ID=l.C_OrderLine_ID AND io.DocStatus IN ('DR','IN','IP','WC'))
	--
GROUP BY o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID,
    o.POReference, o.Description, o.SalesRep_ID, l.M_Warehouse_ID,l.AD_Org_ID
;


-- 6) View difference found

create or replace view rv_unposted
as
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateDoc, DateAcct, 224 AS AD_Table_ID,
          GL_Journal_ID AS Record_ID, 'N' AS IsSOTrx, posted, processing,
          processed, docstatus, processedon
     from GL_JOURNAL
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT pi.AD_Client_ID, pi.AD_Org_ID, pi.Created, pi.CreatedBy, pi.Updated,
          pi.UpdatedBy, pi.IsActive, p.NAME || '_' || pi.Line,
          pi.MovementDate, pi.MovementDate, 623, pi.C_ProjectIssue_ID, 'N',
          posted, pi.processing, pi.processed, 'CO' as DocStatus, processedon
     from C_PROJECTISSUE pi INNER JOIN C_PROJECT p
          ON (pi.C_Project_ID = p.C_Project_ID)
    WHERE Posted <> 'Y'                                  --AND DocStatus<>'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateInvoiced, DateAcct, 318, C_Invoice_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from C_INVOICE
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, DateAcct, 319, M_InOut_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from M_INOUT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, MovementDate, 321,
          M_Inventory_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_INVENTORY
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, MovementDate, 323,
          M_Movement_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_MOVEMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, MovementDate, 325, M_Production_ID,
          'N', posted, processing, processed, docstatus, processedon
     from M_PRODUCTION
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, NAME, StatementDate, DateAcct, 407, C_Cash_ID, 'N',
          posted, processing, processed, docstatus, processedon
     from C_CASH
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 335, C_Payment_ID, 'N',
          posted, processing, processed, docstatus, processedon
     from C_PAYMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 735, C_AllocationHdr_ID,
          'N', posted, processing, processed, docstatus, processedon
     from C_ALLOCATIONHDR
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, NAME, StatementDate, StatementDate, 392,
          C_BankStatement_ID, 'N', posted, processing, processed, docstatus, processedon
     from C_BANKSTATEMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 472, M_MatchInv_ID, 'N',
          posted, processing, processed, 'CO' as docstatus, processedon
     from M_MATCHINV
    WHERE Posted <> 'Y' AND NVL(M_MatchInvHdr_ID, 0) = 0                                  --AND DocStatus<>'VO'
UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 200196, M_MatchInvHdr_ID, 'N',
          Posted, Processing, Processed, DocStatus, Processedon
     FROM M_MatchInvHdr
  WHERE Posted <> 'Y'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 473, M_MatchPO_ID, 'N',
          posted, processing, processed, 'CO' as docstatus, processedon
     from M_MATCHPO
    WHERE Posted <> 'Y'                                  --AND DocStatus<>'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateOrdered, DateAcct, 259, C_Order_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from C_ORDER
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateDoc, DateDoc, 702,
          M_Requisition_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_REQUISITION
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
;


SELECT register_migration_script('202201071900_Update_Merge_Correction.sql') FROM dual
;
