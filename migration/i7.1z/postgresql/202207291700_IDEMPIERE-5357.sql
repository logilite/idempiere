-- IDEMPIERE-5357: Adding support for Fiscal Year in document sequence
SELECT register_migration_script('202207291700_IDEMPIERE-5357.sql') FROM dual;

-- Jul 29, 2022, 4:50:09 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203634,0,0,'Y',TO_TIMESTAMP('2022-07-29 16:50:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-29 16:50:07','YYYY-MM-DD HH24:MI:SS'),100,'IsUseFiscalYear','Use Fiscal Year','Use Fiscal Year to restart the sequence.','The Use Fiscal Year checkbox indicates that the documents sequencing should return to the starting number on the first day of the Fiscal Year.','Use Fiscal Year','D','89ebb943-bbdc-46f8-95bf-fe68930bbdf8')
;

-- Jul 29, 2022, 4:50:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215096,0,'Use Fiscal Year','Use Fiscal Year to restart the sequence.','The Use Fiscal Year checkbox indicates that the documents sequencing should return to the starting number on the first day of the Fiscal Year.',115,'IsUseFiscalYear','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-29 16:50:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-29 16:50:28','YYYY-MM-DD HH24:MI:SS'),100,203634,'Y','N','D','N','N','N','Y','f839c5e9-8448-4b79-a0fa-f2bc247df945','Y',0,'N','N','N','N')
;

-- Jul 29, 2022, 4:50:36 PM IST
ALTER TABLE AD_Sequence ADD COLUMN IsUseFiscalYear CHAR(1) DEFAULT 'N' CHECK (IsUseFiscalYear IN ('Y','N'))
;

-- Jul 29, 2022, 4:51:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207132,'Use Fiscal Year','Use Fiscal Year to restart the sequence.','The Use Fiscal Year checkbox indicates that the documents sequencing should return to the starting number on the first day of the Fiscal Year.',146,215096,'Y','@StartNewYear@=Y',0,185,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-29 16:51:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-29 16:51:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1a7b36bc-9c5c-4e89-b0d8-d298cd9a1951','Y',185,5,2,1,'N','N','N','N')
;

-- Jul 30, 2022, 1:20:11 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Document Sequence date column invalid, Please select the date type column only.',0,0,'Y',TO_DATE('2022-07-30 13:20:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-30 13:20:11','YYYY-MM-DD HH24:MI:SS'),100,200775,'DateColumnInvalid','D','b0ec3383-be7a-45ba-b4b4-d70e2d3cea4a')
;

UPDATE AD_Column SET FieldLength=10, IsUpdateable='N',Updated=TO_TIMESTAMP('2022-08-02 11:47:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=262
;

-- 02-Aug-2022, 11:48:04 AM IST
INSERT INTO t_alter_column values('ad_sequence_no','CalendarYearMonth','VARCHAR(10)',null,null,null)
;