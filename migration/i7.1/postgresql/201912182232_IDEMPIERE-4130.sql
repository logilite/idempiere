-- IDEMPIERE-4130  MaxQueryRecords by Tab (FHCA-1115)
-- Dec 18, 2019, 10:20:27 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214163,0,'Max Query Records','If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records','Enter the number of records a user will be able to query to avoid unnecessary system load.  If 0, no restrictions are imposed.',106,'MaxQueryRecords','0',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2019-12-18 22:20:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-12-18 22:20:26','YYYY-MM-DD HH24:MI:SS'),100,2854,'Y','N','D','N','N','N','Y','33a4790c-3b91-474d-9c36-0cc85af4b700','Y',0,'N','N','N','N')
;

-- Dec 18, 2019, 10:20:44 PM CET
ALTER TABLE AD_Tab ADD COLUMN MaxQueryRecords NUMERIC(10) DEFAULT '0'
;

-- Dec 18, 2019, 10:21:56 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206373,'Max Query Records','If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records','Enter the number of records a user will be able to query to avoid unnecessary system load.  If 0, no restrictions are imposed.',106,214163,'Y',10,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-12-18 22:21:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-12-18 22:21:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','27fb6d6a-0562-4de7-a9a8-7772daca44a0','Y',330,2)
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206373
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11265
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

-- Dec 18, 2019, 10:23:00 PM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-12-18 22:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

SELECT register_migration_script('201912182232_IDEMPIERE-4130.sql') FROM dual
;

