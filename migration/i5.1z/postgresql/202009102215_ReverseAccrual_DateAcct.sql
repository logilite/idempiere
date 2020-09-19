-- DocAction Reverse-Accrual allow to user selectable accounting date based on DocType
-- Sep 10, 2020 7:03:43 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203432,0,0,'Y',TO_TIMESTAMP('2020-09-10 19:03:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-10 19:03:41','YYYY-MM-DD HH24:MI:SS'),100,'IsRADateSelectable','Reverse Accrual Date Selectable','DocAction Reverse-Accrual allow to user selectable accounting date based on DocType','Reverse Accrual Date Selectable','D','6c402725-2fe3-4eaf-ac65-c8cd9a998b9d')
;

-- Sep 10, 2020 7:04:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214226,0,'Reverse Accrual Date Selectable','DocAction Reverse-Accrual allow to user selectable accounting date based on DocType',217,'IsRADateSelectable','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-09-10 19:04:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-10 19:04:38','YYYY-MM-DD HH24:MI:SS'),100,203432,'Y','N','D','N','N','N','Y','a51b9614-12ce-4fb4-bf1a-d0adb54ab92e','Y',0,'N','N')
;

-- Sep 10, 2020 7:04:42 PM IST
ALTER TABLE C_DocType ADD COLUMN IsRADateSelectable CHAR(1) DEFAULT 'N' CHECK (IsRADateSelectable IN ('Y','N')) NOT NULL
;

-- Sep 10, 2020 7:19:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206430,'Reverse Accrual Date Selectable','DocAction Reverse-Accrual allow to user selectable accounting date based on DocType',167,214226,'Y',0,340,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-10 19:19:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-10 19:19:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1c3bb9a4-0125-4dfd-88ad-20263f641412','Y',340,1,1,1,'N','N','N','N')
;

-- Sep 10, 2020 7:20:09 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-10 19:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205278
;

-- Sep 10, 2020 7:20:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-10 19:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206430
;

-- Sep 10, 2020 7:20:09 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-10 19:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6567
;

-- Sep 10, 2020 7:20:09 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-10 19:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3125
;

-- Sep 10, 2020 7:20:09 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-10 19:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204719
;

SELECT register_migration_script('202009102215_ReverseAccrual_DateAcct.sql') FROM dual
;
