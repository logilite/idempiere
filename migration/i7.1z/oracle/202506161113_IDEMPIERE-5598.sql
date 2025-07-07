-- IDEMPIERE-5598: Add new Accounting Dimensions related changes for Add Department field to Asset table and update related process parameters.
SELECT register_migration_script('202506161113_IDEMPIERE-5598.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 16, 2025, 11:15:08 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217124,0,'Department',539,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2025-06-16 11:15:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-06-16 11:15:07','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','cda9a591-334f-430d-89db-378ad84a9ab3','Y',0,'N','N','N','N','N')
;

-- Jun 16, 2025, 11:15:48 AM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_AAsset', FKConstraintType='N',Updated=TO_DATE('2025-06-16 11:15:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217124
;

-- Jun 16, 2025, 11:15:48 AM IST
ALTER TABLE A_Asset ADD C_Department_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 16, 2025, 11:15:48 AM IST
ALTER TABLE A_Asset ADD CONSTRAINT CDepartment_AAsset FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 16, 2025, 11:17:11 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (208787,'Department',450,217124,'Y',0,225,0,'N','N','N','N',0,0,'Y',TO_DATE('2025-06-16 11:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-06-16 11:17:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5e2a8dcf-ea09-4ef6-818f-50d07eee1e9c','Y',225,1,1,1,'N','N','N','N','N')
;

-- Jun 16, 2025, 11:19:25 AM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2025-06-16 11:19:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200487
;

-- Jun 16, 2025, 11:19:35 AM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2025-06-16 11:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=299
;

-- Jun 16, 2025, 11:19:48 AM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2025-06-16 11:19:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=458
;

-- Jun 16, 2025, 11:22:09 AM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200205,'M_AttributeSet (Active)','S','M_AttributeSet.IsActive=''Y''',0,0,'Y',TO_DATE('2025-06-16 11:22:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-06-16 11:22:09','YYYY-MM-DD HH24:MI:SS'),100,'D','624bdf55-f676-4860-8d55-9de59b1bc1d2')
;

-- Jun 16, 2025, 11:22:29 AM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30, AD_Val_Rule_ID=200205,Updated=TO_DATE('2025-06-16 11:22:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200493
;