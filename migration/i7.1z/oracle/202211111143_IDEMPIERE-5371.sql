SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add Session Audit(AD_Session_ID) reference in Process Audit (AD_PInstance).

-- Nov 11, 2022, 10:47:31 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200225,'AD_Session_ID','Session ID','T',0,0,'Y',TO_DATE('2022-11-11 10:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-11-11 10:47:28','YYYY-MM-DD HH24:MI:SS'),100,'D','N','6d473d9d-e420-4fd8-abaa-994021b6c9bc')
;

-- Nov 11, 2022, 10:49:07 AM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU,DisplaySQL,IsDisplayIdentifier) VALUES (200225,566,8585,8584,0,0,'Y',TO_DATE('2022-11-11 10:49:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-11-11 10:49:07','YYYY-MM-DD HH24:MI:SS'),100,'N','D','b1de4be7-1d66-4f6e-8645-8118f942628b','((select u.Name from AD_User u WHERE u.AD_User_ID = AD_Session.CreatedBy) || ''_''|| AD_Session.WebSession)','N')
;

-- Nov 11, 2022, 10:52:49 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215639,0,'Session','User Session Online or Web','Online or Web Session Information',282,'AD_Session_ID',22,'N','N','N','N','N',0,'N',30,200225,0,0,'Y',TO_DATE('2022-11-11 10:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-11-11 10:52:48','YYYY-MM-DD HH24:MI:SS'),100,2029,'N','N','D','N','N','N','Y','b45ac525-c04b-489b-aa7b-bd895e8a44f1','Y',0,'N','N','N','N')
;

-- Nov 11, 2022, 10:52:55 AM IST
UPDATE AD_Column SET FKConstraintName='ADSession_ADPInstance', FKConstraintType='N',Updated=TO_DATE('2022-11-11 10:52:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215639
;

-- Nov 11, 2022, 10:52:56 AM IST
ALTER TABLE AD_PInstance ADD AD_Session_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 11, 2022, 10:52:56 AM IST
ALTER TABLE AD_PInstance ADD CONSTRAINT ADSession_ADPInstance FOREIGN KEY (AD_Session_ID) REFERENCES ad_session(ad_session_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 11, 2022, 10:55:56 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207416,'Session','User Session Online or Web','Online or Web Session Information',663,215639,'Y',22,140,'N','N','N','N',0,0,'Y',TO_DATE('2022-11-11 10:55:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-11-11 10:55:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13a67a4d-d7b3-4a89-adfb-780d2e2d61f7','Y',130,2)
;

-- Nov 11, 2022, 10:56:38 AM IST
UPDATE AD_Field SET SeqNo=95, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2022-11-11 10:56:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207416
;

SELECT register_migration_script('202211111143_IDEMPIERE-5371.sql') FROM dual;

