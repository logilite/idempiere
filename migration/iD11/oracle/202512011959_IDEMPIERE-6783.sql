-- #6783: Add Account Date column on Project Issue table
SELECT register_migration_script('202512011959_IDEMPIERE-6783.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 01-Dec-2025, 7:59:46 pm IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217172,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',623,'DateAcct',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2025-12-01 19:59:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-01 19:59:45','YYYY-MM-DD HH24:MI:SS'),100,263,'Y','N','D','N','N','N','Y','4e7b9a09-58d2-4a6f-95ef-c3e8a274f3b1','Y',0,'N','N','N','N','N')
;

-- 01-Dec-2025, 7:59:49 pm IST
ALTER TABLE C_ProjectIssue ADD DateAcct DATE DEFAULT NULL 
;

-- 01-Dec-2025, 8:00:28 pm IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208979,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',558,217172,'Y',7,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-12-01 20:00:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-01 20:00:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','70d0b25f-08a2-4267-8b00-d96459cfe6c3','Y',260,2)
;

-- 01-Dec-2025, 8:00:28 pm IST
UPDATE AD_Field SET MandatoryLogic='1=1',Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208979
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208979
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8224
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8229
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8218
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8225
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8236
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8235
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208503
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8216
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206738
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206739
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8220
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8215
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8219
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208824
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208826
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208825
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208827
;

-- 01-Dec-2025, 8:00:37 pm IST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2025-12-01 20:00:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208828
;

-- Populate DateAcct from MovementDate
UPDATE C_ProjectIssue SET DateAcct = MovementDate WHERE DateAcct IS NULL
;

