SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add PrintFormatHeader in Financial Report
-- Sep 27, 2019 7:08:09 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203367,0,0,'Y',TO_DATE('2019-09-27 19:08:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-27 19:08:09','YYYY-MM-DD HH24:MI:SS'),100,'AD_PrintFormatHeader_ID','Header Print Format','Header data print format','Header Print Format','D','96122e72-0ab4-498e-9478-a81fcab9b1d6')
;

-- Sep 30, 2019 11:22:26 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200172,'Header Print Format','T',0,0,'Y',TO_DATE('2019-09-30 11:22:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-30 11:22:25','YYYY-MM-DD HH24:MI:SS'),100,'D','N','4e7e9a15-30d4-4553-8330-553ee52b5332')
;

-- Sep 30, 2019 11:23:15 AM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU,IsDisplayIdentifier) VALUES (200172,493,7026,7019,'AD_PrintFormat.AD_Table_ID=282',0,0,'Y',TO_DATE('2019-09-30 11:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-30 11:23:15','YYYY-MM-DD HH24:MI:SS'),100,'N','D','5cf00270-4a1c-47af-aa8f-9491d471aaf8','N')
;

-- Sep 30, 2019 11:23:55 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214056,0,'Header Print Format','Header data print format',445,'AD_PrintFormatHeader_ID',10,'N','N','N','N','N',0,'N',18,200172,0,0,'Y',TO_DATE('2019-09-30 11:23:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-30 11:23:54','YYYY-MM-DD HH24:MI:SS'),100,203367,'Y','N','D','N','N','N','Y','7cb92131-755d-4b2b-857d-be3012091731','Y',0,'N','N')
;

-- Sep 30, 2019 11:23:59 AM IST
UPDATE AD_Column SET FKConstraintName='ADPrintFormatHeader_PAReport', FKConstraintType='N',Updated=TO_DATE('2019-09-30 11:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214056
;

-- Sep 30, 2019 11:23:59 AM IST
ALTER TABLE PA_Report ADD AD_PrintFormatHeader_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 30, 2019 11:23:59 AM IST
ALTER TABLE PA_Report ADD CONSTRAINT ADPrintFormatHeader_PAReport FOREIGN KEY (AD_PrintFormatHeader_ID) REFERENCES ad_printformat(ad_printformat_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 30, 2019 11:24:43 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206183,'Header Print Format','Header data print format',372,214056,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-09-30 11:24:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-30 11:24:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7eb58d87-7d06-4695-b4ef-769f3a3122d6','Y',170,3,2,1,'N','N','N','N')
;

-- Sep 30, 2019 11:25:38 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-09-30 11:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54235
;

-- Sep 30, 2019 11:25:38 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-09-30 11:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206183
;

-- Sep 30, 2019 11:25:38 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-09-30 11:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6265
;

-- Sep 30, 2019 11:25:38 AM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-09-30 11:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204992
;

SELECT register_migration_script('201909301200_Add_PrintFormatHeader_In_Financial_Report.sql') FROM dual
;