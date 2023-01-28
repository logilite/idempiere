SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5541 - Adding predefined context variables on zoom condition.
-- Jan 11, 2023, 12:42:19 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215740,0,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',200066,'PredefinedContextVariables',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2023-01-11 12:42:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2023-01-11 12:42:17','YYYY-MM-DD HH24:MI:SS'),0,203475,'Y','N','D','N','N','N','Y','8d804773-1dc5-4b80-8849-188db40c27d7','Y',0,'N','N','N','N')
;

-- Jan 11, 2023, 12:42:24 PM IST
ALTER TABLE AD_ZoomCondition ADD PredefinedContextVariables VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- Jan 11, 2023, 12:42:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207525,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',200077,215740,'Y',4000,120,'N','N','N','N',0,0,'Y',TO_DATE('2023-01-11 12:42:36','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2023-01-11 12:42:36','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','1fbcabcd-f744-49cf-8096-837f78db6a9d','Y',110,5)
;

-- Jan 11, 2023, 12:58:03 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-01-11 12:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=207525
;

