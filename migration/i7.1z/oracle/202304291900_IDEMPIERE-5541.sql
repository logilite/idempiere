SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding Predefined variables field in Document Status
-- 29-Apr-2023, 7:01:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215836,0,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',200216,'PredefinedContextVariables',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2023-04-29 19:01:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-04-29 19:01:49','YYYY-MM-DD HH24:MI:SS'),100,203475,'Y','N','D','N','N','N','Y','4725f98a-04e6-43a4-b287-9abc9465be3c','Y',0,'N','N','N','N')
;

-- 29-Apr-2023, 7:02:05 PM IST
ALTER TABLE PA_DocumentStatus ADD PredefinedContextVariables VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- 29-Apr-2023, 7:02:21 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207621,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',200222,215836,'Y',4000,190,'N','N','N','N',0,0,'Y',TO_DATE('2023-04-29 19:02:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-04-29 19:02:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3daba85a-171c-4f98-abe6-10162b3af1c1','Y',190,5)
;

-- 29-Apr-2023, 7:06:43 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-04-29 19:06:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207621
;

SELECT register_migration_script('202304291900_IDEMPIERE-5541.sql') FROM dual;
