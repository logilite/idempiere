-- Workflow responsible SQL Support
SELECT register_migration_script('202509031618_IDEMPIERE-6674.sql') FROM dual;

-- 03-Sep-2025, 4:18:25 pm IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217160,0,'Sql FROM','SQL FROM clause','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.',646,'FromClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-09-03 16:18:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-03 16:18:25','YYYY-MM-DD HH24:MI:SS'),100,2101,'Y','N','D','N','N','N','Y','764db959-18d1-4480-888c-e8a39b4d3253','Y',0,'N','N','N','N','N')
;

-- 03-Sep-2025, 4:18:27 pm IST
ALTER TABLE AD_WF_Responsible ADD COLUMN FromClause VARCHAR(2000) DEFAULT NULL 
;

-- 03-Sep-2025, 4:18:46 pm IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217161,0,'Sql SELECT','SQL SELECT clause','The Select Clause indicates the SQL SELECT clause to use for selecting the record for a measure calculation. Do not include the SELECT itself.',646,'SelectClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-09-03 16:18:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-03 16:18:45','YYYY-MM-DD HH24:MI:SS'),100,1599,'Y','N','D','N','N','N','Y','c5e36ecf-c043-4e52-b212-65f1f2b54aa2','Y',0,'N','N','N','N','N')
;

-- 03-Sep-2025, 4:18:49 pm IST
ALTER TABLE AD_WF_Responsible ADD COLUMN SelectClause VARCHAR(2000) DEFAULT NULL 
;

-- 03-Sep-2025, 4:21:17 pm IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208846,'Sql FROM','SQL FROM clause','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.',578,217160,'Y',2000,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-09-03 16:21:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-03 16:21:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfbf0ba6-cadd-46b9-bc04-7908254b48fb','Y',120,5,3)
;

-- 03-Sep-2025, 4:21:17 pm IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208847,'Sql SELECT','SQL SELECT clause','The Select Clause indicates the SQL SELECT clause to use for selecting the record for a measure calculation. Do not include the SELECT itself.',578,217161,'Y',2000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-09-03 16:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-03 16:21:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9395a74f-d001-4774-85a8-ed0f7b9a355e','Y',130,5,3)
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8853
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8854
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8849
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8852
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8847
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8863
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8848
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8851
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8850
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208378
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208847
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204633
;

-- 03-Sep-2025, 4:21:38 pm IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-09-03 16:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8855
;

-- 03-Sep-2025, 4:22:31 pm IST
UPDATE AD_Field SET DisplayLogic='@ResponsibleType@=M', SeqNo=110,Updated=TO_TIMESTAMP('2025-09-03 16:22:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208847
;

-- 03-Sep-2025, 4:22:31 pm IST
UPDATE AD_Field SET DisplayLogic='@ResponsibleType@=M', SeqNo=120,Updated=TO_TIMESTAMP('2025-09-03 16:22:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208846
;

