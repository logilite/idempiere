SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2811 - Add ID Column into Product Puchasing Table
ALTER TABLE M_Product_PO DROP CONSTRAINT m_product_po_pkey
;

-- 21-Feb-2024, 06:02:34 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201139,'2f9c8bb3-6816-445a-8cd0-711915d2d6b2',TO_DATE('2024-02-21 18:02:34','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','unique_product_bpartner',TO_DATE('2024-02-21 18:02:34','YYYY-MM-DD HH24:MI:SS'),0,210,'Y','Y','N','N','N')
;

-- 21-Feb-2024, 06:02:34 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201530,'eec31c99-c6b6-4f5d-9966-7f9b4dfd9bcf',TO_DATE('2024-02-21 18:03:08','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2024-02-21 18:03:08','YYYY-MM-DD HH24:MI:SS'),0,1420,201139,0)
;

-- 21-Feb-2024, 06:02:34 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201531,'b29ee940-7ccb-4e23-ab2a-fcec37c933e6',TO_DATE('2024-02-21 18:03:19','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2024-02-21 18:03:19','YYYY-MM-DD HH24:MI:SS'),0,2705,201139,0)
;

-- 21-Feb-2024, 06:02:34 PM IST
ALTER TABLE M_Product_PO ADD CONSTRAINT unique_product_bpartner UNIQUE (M_Product_ID,C_BPartner_ID)
;

-- 21-Feb-2024, 06:02:34 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203723,0,0,'Y',TO_DATE('2024-02-21 19:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-21 19:28:43','YYYY-MM-DD HH24:MI:SS'),100,'M_Product_PO_ID','Product Purchasing',NULL,NULL,'Product Purchasing','D','767791d6-74e2-43e3-855a-649e54e6a403')
;

-- 21-Feb-2024, 06:02:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215629,0,'Product Purchasing',210,'M_Product_PO_ID',22,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_DATE('2024-02-21 19:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-21 19:28:43','YYYY-MM-DD HH24:MI:SS'),100,203723,'N','N','D','N','N','N','Y','68277485-2aa2-4fda-a2d0-1090a677b21c','N',0,'N','N','N','N')
;

ALTER TABLE M_Product_PO ADD COLUMN M_Product_PO_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_Product_PO SET M_Product_PO_ID=nextidfunc(116,'N')
;

-- 21-Feb-2024, 7:28:43 PM IST
UPDATE AD_Column SET IsKey='Y', IsMandatory='Y', IsUpdateable='N',Updated=TO_DATE('2024-02-21 19:28:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=215629
;

-- 21-Feb-2024, 7:31:15 PM IST
ALTER TABLE M_Product_PO MODIFY M_Product_PO_ID NUMBER(10)
;

-- 21-Feb-2024, 7:31:15 PM IST
ALTER TABLE M_Product_PO MODIFY M_Product_PO_ID NOT NULL
;

ALTER TABLE M_Product_PO ADD PRIMARY KEY(M_Product_PO_ID)
;

-- 21-Feb-2024, 7:31:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207404,'Product Purchasing',239,215629,'N',22,280,'N','N','N','N',0,0,'Y',TO_DATE('2024-02-21 17:38:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-21 17:38:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fd780792-bc1a-4b60-8200-7937f7a18be3','Y',280,2)
;

SELECT register_migration_script('202402212002_IDEMPIERE-2811.sql') FROM dual
;