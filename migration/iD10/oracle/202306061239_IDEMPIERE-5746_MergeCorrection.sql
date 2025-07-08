-- IDEMPIERE-5746 Bank Statement and Production cannot use Overwrite Date/Seq on Complete [ iD10 ]
SELECT register_migration_script('202306061239_IDEMPIERE-5746_MergeCorrection.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 6, 2023, 12:46:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) SELECT 207647,'BOM & Formula','BOM & Formula',319,213948,'Y',22,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','250832f7-f0b8-4b59-a371-506ff5ab1f29','Y',370,2 FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM AD_Field WHERE AD_Field_ID = 207647
);

-- Jun 6, 2023, 12:46:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) SELECT 207648,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',319,214619,'Y',22,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-06 12:46:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','addbf796-6d3b-4029-8c3f-159f8abc87f5','Y',380,2 FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM AD_Field WHERE AD_Field_ID = 207648
);

-- Jun 6, 2023, 12:47:34 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-06 12:47:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207648
;

-- Jun 6, 2023, 12:48:08 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2023-06-06 12:48:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207648
;