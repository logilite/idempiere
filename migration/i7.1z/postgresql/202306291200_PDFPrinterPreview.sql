-- Printer print preview zoom directly
-- Jun 15, 2023, 7:17:28 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203813,0,0,'Y',TO_TIMESTAMP('2023-06-15 19:17:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-15 19:17:27','YYYY-MM-DD HH24:MI:SS'),100,'IsPrinterPreview','Direct Printer Print Preview','Open Printer Print Preview dialog box directly if the report is PDF type','If flag is true indicates that the printer print preview dialog box opens directly if the report is PDF type','Direct Printer Print Preview','D','c3f2b5ea-abc0-48b4-bca6-6826557f3c0e')
;

-- Jun 15, 2023, 7:17:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215851,0,'Direct Printer Print Preview','Open Printer Print Preview dialog box directly if the report is PDF type','If flag is true indicates that the printer print preview dialog box opens directly if the report is PDF type',493,'IsPrinterPreview','N',5,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-06-15 19:17:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-15 19:17:28','YYYY-MM-DD HH24:MI:SS'),100,203813,'Y','N','D','Y','N','N','Y','96b9bab7-2406-4c89-a449-d1de3343fdba','Y',0,'N','N','N','N')
;

-- Jun 15, 2023, 7:17:29 PM IST
ALTER TABLE AD_PrintFormat ADD COLUMN IsPrinterPreview CHAR(1) DEFAULT 'N' CHECK (IsPrinterPreview IN ('Y','N')) NOT NULL
;

-- Jun 15, 2023, 7:17:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207652,'Direct Printer Print Preview','Open Printer Print Preview dialog box directly if the report is PDF type','If flag is true indicates that the printer print preview dialog box opens directly if the report is PDF type',425,215851,'Y',0,280,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-15 19:17:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-15 19:17:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','03902e1b-00e2-41db-ba3d-886ec0e451f4','Y',270,5,2,1,'N','N','N','N')
;

-- Jun 15, 2023, 7:17:30 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215852,0,'Direct Printer Print Preview','Open Printer Print Preview dialog box directly if the report is PDF type','If flag is true indicates that the printer print preview dialog box opens directly if the report is PDF type',284,'IsPrinterPreview','N',5,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-06-15 19:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-15 19:17:30','YYYY-MM-DD HH24:MI:SS'),100,203813,'Y','N','D','Y','N','N','Y','98b4c1e3-bf78-4e71-8417-68f601869cb9','Y',0,'N','N','N','N')
;

-- Jun 15, 2023, 7:17:30 PM IST
ALTER TABLE AD_Process ADD COLUMN IsPrinterPreview CHAR(1) DEFAULT 'N' CHECK (IsPrinterPreview IN ('Y','N')) NOT NULL
;

-- Jun 15, 2023, 7:17:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207653,'Direct Printer Print Preview','Open Printer Print Preview dialog box directly if the report is PDF type','If flag is true indicates that the printer print preview dialog box opens directly if the report is PDF type',245,215852,'Y','@IsReport@=''Y''',0,220,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-15 19:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-15 19:17:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8471c42c-2f7d-46f5-af6c-06cda7d4769e','Y',250,5,2,1,'N','N','N','N')
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=230, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50155
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5850
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5851
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=260, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50156
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=270, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201809
;

-- Jun 15, 2023, 7:17:31 PM IST
UPDATE AD_Field SET SeqNo=280, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-06-15 19:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57342
;

SELECT register_migration_script('202306291200_PDFPrinterPreview.sql') FROM dual
;