SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add a Project Line field to the Project Issue tab and implement the necessary changes related to Project Issue.
-- Aug 28, 2024, 4:58:49 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200270,'C_ProjectLine_Line','T',0,0,'Y',TO_DATE('2024-08-28 16:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-08-28 16:58:48','YYYY-MM-DD HH24:MI:SS'),100,'D','N','3af18ca0-10a0-4b06-90d2-e164992f402f')
;

-- Aug 28, 2024, 5:00:19 PM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU,IsDisplayIdentifier) VALUES (200270,434,5758,5767,0,0,'Y',TO_DATE('2024-08-28 17:00:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-08-28 17:00:19','YYYY-MM-DD HH24:MI:SS'),100,'N','D','a46f2bf3-6aef-472e-a022-9c700e411fd9','N')
;

-- Aug 28, 2024, 5:01:06 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200201,'C_ProjectLine of Project Issue','Project line that was not created by a project issue.','S','C_ProjectLine.C_Project_ID=@C_Project_ID@ AND C_ProjectLine.C_ProjectIssue_ID IS NULL',0,0,'Y',TO_DATE('2024-08-28 17:01:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-08-28 17:01:05','YYYY-MM-DD HH24:MI:SS'),100,'D','fe473ac9-3d11-4e26-ac99-2e11a5fc0a05')
;

-- Aug 28, 2024, 5:01:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross) VALUES (216627,0,'Project Line','Task or step in a project','The Project Line indicates a unique project line.',623,200201,'C_ProjectLine_ID',22,'N','N','N','N','N',0,'N',30,200270,0,0,'Y',TO_DATE('2024-08-28 17:01:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-08-28 17:01:16','YYYY-MM-DD HH24:MI:SS'),100,1552,'Y','N','D','N','N','N','Y','f3bfcca3-706e-4996-a9d0-f0aafe7748ea','Y',0,'N','N','N','N')
;

-- Aug 28, 2024, 5:01:19 PM IST
UPDATE AD_Column SET FKConstraintName='CProjectLine_CProjectIssue', FKConstraintType='N',Updated=TO_DATE('2024-08-28 17:01:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216627
;

-- Aug 28, 2024, 5:01:19 PM IST
ALTER TABLE C_ProjectIssue ADD C_ProjectLine_ID NUMBER(10) DEFAULT NULL
;

-- Aug 28, 2024, 5:01:19 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CProjectLine_CProjectIssue FOREIGN KEY (C_ProjectLine_ID) REFERENCES c_projectline(c_projectline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 28, 2024, 5:01:46 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutProjectIssue.setData',Updated=TO_DATE('2024-08-28 17:01:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216627
;

-- Aug 28, 2024, 5:01:49 PM IST
ALTER TABLE C_ProjectIssue MODIFY C_ProjectLine_ID NUMBER(10) DEFAULT NULL
;

-- Aug 28, 2024, 5:02:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208503,'Project Line','Task or step in a project','The Project Line indicates a unique project line.',558,216627,'Y',22,180,'N','N','N','N',0,0,'Y',TO_DATE('2024-08-28 17:02:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-08-28 17:02:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2aa3cadb-a1fa-473e-ad29-485798c360be','Y',210,2)
;

-- Aug 28, 2024, 5:02:20 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:02:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- Aug 28, 2024, 5:03:24 PM IST
UPDATE AD_Field SET SeqNo=117, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=117, IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:03:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

-- Aug 28, 2024, 5:04:02 PM IST
UPDATE AD_Field SET SeqNo=137, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=137, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208503
;

-- Aug 28, 2024, 5:05:38 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@S_TimeExpenseLine_ID@!0 | @C_InvoiceLine_ID@!0 | @C_ProjectLine_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:05:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8236
;

-- Aug 28, 2024, 5:05:45 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@!0 | @M_InOutLine_ID@!0 | @C_ProjectLine_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:05:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8235
;

-- Aug 28, 2024, 5:05:52 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@S_TimeExpenseLine_ID@!0 | @M_InOutLine_ID@!0 | @C_ProjectLine_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:05:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- Aug 28, 2024, 5:06:32 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@!0 | @S_TimeExpenseLine_ID@!0 | @M_InOutLine_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-08-28 17:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208503
;

-- Sep 10, 2024, 11:40:13 AM IST
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@ > 0', IsToolbarButton=NULL,Updated=TO_DATE('2024-09-10 11:40:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- 26-Sep-2024, 3:30:45 PM IST
UPDATE AD_Val_Rule SET Code='S_TimeExpenseLine_ID NOT IN (SELECT DISTINCT S_TimeExpenseLine_ID FROM C_ProjectIssue WHERE DocStatus NOT IN (''VO'',''RE'') AND S_TimeExpenseLine_ID IS NOT NULL) AND (C_Project_ID = @C_Project_ID@ OR C_Project_ID is Null)',Updated=TO_DATE('2024-09-26 15:30:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200197
;

-- Oct 24, 2024, 11:34:20 AM IST
UPDATE AD_Val_Rule SET Code='(M_InOutLine.C_Project_ID IS NULL OR M_InOutLine.C_Project_ID=@C_Project_ID@) AND M_InOutLine.Processed=''Y'' AND M_InOut_ID IN (Select M_InOut_ID From M_InOut WHERE IsSOTrx=''N'' AND DocStatus IN (''CO'',''CL'')) AND M_InOutLine.M_Product_ID > 0 AND M_InOutLine_ID NOT IN (SELECT DISTINCT M_InOutLine_ID FROM C_ProjectIssue WHERE DocStatus NOT IN (''VO'',''RE'') AND M_InOutLine_ID IS NOT NULL)',Updated=TO_DATE('2024-10-24 11:34:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200191
;

-- Oct 24, 2024, 2:48:26 PM IST
UPDATE AD_Val_Rule SET Code='(M_InOut.C_Project_ID IS NULL OR M_InOut.C_Project_ID=@C_Project_ID@) AND M_InOut.Processed=''Y'' AND M_InOut.IsSOTrx=''N'' AND M_InOut_ID NOT IN (Select i.M_InOut_ID From M_InOut i WHERE i.M_InOut_ID = (SELECT DISTINCT il.M_InOut_ID FROM M_InOutLine il Where il.M_InOut_ID =i.M_InOut_ID AND (il.C_Project_ID!=@C_Project_ID@ AND il.C_Project_ID is NOT null ) ) ) AND M_InOut.DocStatus IN (''CO'',''CL'')',Updated=TO_DATE('2024-10-24 14:48:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=178
;

-- Oct 25, 2024, 10:37:49 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2024-10-25 10:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9844
;

-- Oct 25, 2024, 10:37:52 AM IST
ALTER TABLE C_ProjectIssue MODIFY M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL
;

SELECT register_migration_script('202409091737_IDEMPIERE-3494.sql') FROM dual
;
