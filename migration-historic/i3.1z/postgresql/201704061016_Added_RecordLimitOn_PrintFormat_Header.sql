-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Apr 4, 2017 3:07:38 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203066,0,0,'Y',TO_TIMESTAMP('2017-04-04 15:07:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-04 15:07:37','YYYY-MM-DD HH24:MI:SS'),100,'RecordLimit','Record Limit','Record Limit','D','619eb263-ef06-4b78-9542-dc180459dc6e')
;

-- Apr 4, 2017 3:08:44 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212973,0,'Record Limit',493,'RecordLimit','0',5,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2017-04-04 15:08:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-04 15:08:43','YYYY-MM-DD HH24:MI:SS'),100,203066,'Y','N','D','N','N','N','Y','19d10b30-7a87-4be0-a04f-f670a8b69377','Y',0,'N','N')
;

-- Apr 4, 2017 3:09:01 PM IST
ALTER TABLE AD_PrintFormat ADD COLUMN RecordLimit NUMERIC(10) DEFAULT '0' 
;

-- Apr 4, 2017 3:10:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204381,'Record Limit',425,212973,'Y',0,240,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-04 15:09:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-04 15:09:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','09a22de4-fb60-4bc9-be92-8e01f8a694e3','Y',240,1,2,1,'N','N','N')
;

-- Apr 4, 2017 3:10:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-04 15:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204381
;

-- Apr 4, 2017 3:10:10 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-04 15:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52009
;

-- Apr 4, 2017 3:10:10 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-04 15:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5660
;

-- Apr 4, 2017 3:10:10 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-04 15:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52008
;

SELECT register_migration_script('201704061016_Added_RecordLimitOn_PrintFormat_Header.sql') FROM dual
;

