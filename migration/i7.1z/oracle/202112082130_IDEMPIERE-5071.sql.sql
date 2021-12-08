SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5071 Default Email template per Document type
-- 08-Dec-2021, 9:10:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214654,0,'Default mail template',217,'R_DefaultMailText_ID',10,'N','N','N','N','N',0,'N',18,274,0,0,'Y',TO_DATE('2021-12-08 21:10:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-12-08 21:10:23','YYYY-MM-DD HH24:MI:SS'),100,202698,'Y','N','D','N','N','N','Y','f4013dde-6742-4a60-9715-fb3ea1d15bce','Y',0,'N','N','N','N')
;

-- 08-Dec-2021, 9:10:29 PM IST
UPDATE AD_Column SET FKConstraintName='RDefaultMailText_CDocType', FKConstraintType='N',Updated=TO_DATE('2021-12-08 21:10:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214654
;

-- 08-Dec-2021, 9:10:29 PM IST
ALTER TABLE C_DocType ADD R_DefaultMailText_ID NUMBER(10) DEFAULT NULL 
;

-- 08-Dec-2021, 9:10:29 PM IST
ALTER TABLE C_DocType ADD CONSTRAINT RDefaultMailText_CDocType FOREIGN KEY (R_DefaultMailText_ID) REFERENCES r_mailtext(r_mailtext_id) DEFERRABLE INITIALLY DEFERRED
;

-- 08-Dec-2021, 9:12:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206817,'Default mail template',167,214654,'Y',0,370,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-12-08 21:12:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-12-08 21:12:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','393f5cdc-836d-43aa-be3b-57e9d21dbdcf','Y',360,1,2,1,'N','N','N','N')
;

-- 08-Dec-2021, 9:14:35 PM IST
UPDATE AD_Field SET SeqNo=301, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-12-08 21:14:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206817
;


SELECT register_migration_script('202112082130_IDEMPIERE-5071.sql') FROM dual
;