-- Added Stock Availability Check field in Document Type Window.
-- 21-May-2024, 12:09:51 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203935,0,0,'Y',TO_TIMESTAMP('2024-05-21 12:09:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-21 12:09:35','YYYY-MM-DD HH24:MI:SS'),100,'isStockAvailabilityCheck','Stock Availability Check',NULL,NULL,'Stock Availability Check','D','b22152f5-f41f-43a5-b1cc-7e1be09a136b')
;

-- 21-May-2024, 12:10:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216602,0,'Stock Availability Check',217,'isStockAvailabilityCheck','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-05-21 12:10:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-21 12:10:04','YYYY-MM-DD HH24:MI:SS'),100,203935,'Y','N','D','N','N','N','Y','a7d6a72a-f24b-45cc-a5c7-a252e61db680','Y',0,'N','N','N','N','N')
;

-- 21-May-2024, 12:10:07 PM IST
ALTER TABLE C_DocType ADD COLUMN isStockAvailabilityCheck CHAR(1) DEFAULT 'Y' CHECK (isStockAvailabilityCheck IN ('Y','N'))
;

-- 21-May-2024, 12:10:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208488,'Stock Availability Check',167,216602,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-21 12:10:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-21 12:10:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','159a9a85-8653-4447-b463-ca2f9521dac5','Y',370,2,2)
;

-- 21-May-2024, 12:10:43 PM IST
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-21 12:10:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208488
;

SELECT register_migration_script('202405211220_IDEMPIERE-6153.sql') FROM dual;
