-- IDEMPIERE-7135: Pack Out - Add Entity Type Filter
SELECT register_migration_script('202610070942_IDEMPIERE-7135.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 07-Oct-2026, 9:42:28 am IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204130,0,0,'Y',TO_TIMESTAMP('2026-10-07 09:42:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 09:42:28','YYYY-MM-DD HH24:MI:SS'),100,'ExportEntityType','Export Entity Type','Filter by Entity Type','Provide entity type if want to 2pack only provided entity type of element','Export Entity Type','D','04ad3566-1008-4c89-9b41-99b5adfc5ec1')
;

-- 07-Oct-2026, 9:43:02 am IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217664,0,'Export Entity Type','Filter by Entity Type','Provide entity type if want to 2pack only provided entity type of element',50005,'ExportEntityType',255,'N','N','N','N','N',0,'N',200163,389,0,0,'Y',TO_TIMESTAMP('2026-10-07 09:43:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 09:43:02','YYYY-MM-DD HH24:MI:SS'),100,204130,'Y','N','D','N','N','N','Y','8282c475-f433-4975-81de-a9e8c9ae3d14','Y',0,'N','N','N','N','N')
;

-- 07-Oct-2026, 9:43:05 am IST
ALTER TABLE AD_Package_Exp ADD ExportEntityType VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- 07-Oct-2026, 9:44:18 am IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (209249,'Export Entity Type','Filter by Entity Type','Provide entity type if want to 2pack only provided entity type of element',50005,217664,'Y',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-07 09:44:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 09:44:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dadb470e-a3d7-486e-93da-48cd43f36cfb','Y',87,1,2,1,'N','N','N','N','N')
;

-- 07-Oct-2026, 9:46:45 am IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5,Updated=TO_TIMESTAMP('2026-10-07 09:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209248
;

-- 07-Oct-2026, 9:46:45 am IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=1,Updated=TO_TIMESTAMP('2026-10-07 09:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209249
;

-- 07-Oct-2026, 9:46:45 am IST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-10-07 09:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

-- 07-Oct-2026, 9:46:45 am IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-10-07 09:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50085
;

-- 07-Oct-2026, 9:46:45 am IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-10-07 09:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204546
;

-- 07-Oct-2026, 9:47:30 am IST
UPDATE AD_Field SET DisplayLogic='@AD_Client_ID@=0 & @ExportEntityType@=''''',Updated=TO_TIMESTAMP('2026-10-07 09:47:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

