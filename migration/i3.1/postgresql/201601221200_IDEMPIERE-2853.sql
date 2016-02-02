-- IDEMPIERE-2853: Panel tab as a factory
-- Jan 22, 2016 11:47:02 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202974,0,0,'Y',TO_TIMESTAMP('2016-01-22 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,'AD_TabType','Tab Type','Defines Tab Type','Tab Type','D','5c68092e-e403-4013-8c0f-ae3f1266d989')
;

-- Jan 22, 2016 11:50:50 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200117,'TabTypeList','List of tab type','L',0,0,'Y',TO_TIMESTAMP('2016-01-22 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,'D','N','5cc837cc-e950-4a01-8044-4aa6a69d9515')
;

-- Jan 22, 2016 11:51:22 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200347,'Data Grid',200117,'FORM',0,0,'Y',TO_TIMESTAMP('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,'D','590c7ccd-4400-4208-aca4-d86e508e0f4d')
;

-- Jan 22, 2016 11:51:36 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200348,'Order Tab',200117,'SORT',0,0,'Y',TO_TIMESTAMP('2016-01-22 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,'D','47729861-5eed-4209-8228-7858e0ae7c13')
;

-- Jan 22, 2016 11:52:05 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212616,0,'Tab Type','Defines Tab Type',106,'AD_TabType',40,'N','N','N','N','N',0,'N',17,200117,0,0,'Y',TO_TIMESTAMP('2016-01-22 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,202974,'Y','N','D','N','N','N','Y','41054b6a-58eb-427a-9748-a192f20f6efb','Y',0,'N','N')
;

-- Jan 22, 2016 11:52:18 AM IST
ALTER TABLE AD_Tab ADD COLUMN AD_TabType VARCHAR(40) DEFAULT NULL 
;

-- Jan 22, 2016 11:52:41 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204121,'Tab Type','Defines Tab Type',106,212616,'Y',40,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-22 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-22 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','644e396b-717a-4f99-a0d3-4007862a59c2','Y',330,2)
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, XPosition=1,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204121
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57266
;

-- Jan 22, 2016 11:53:08 AM IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2016-01-22 11:53:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11265
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

-- Jan 22, 2016 11:53:09 AM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2016-01-22 11:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

-- Jan 22, 2016 11:53:09 AM IST
SELECT register_migration_script('201601221200_IDEMPIERE-2853.sql') FROM dual
;