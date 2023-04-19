SET SQLBLANKLINES ON
SET DEFINE OFF

-- Added Session Type field in Session window
-- 27-Mar-2023, 4:19:47 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203797,0,0,'Y',TO_DATE('2023-03-27 16:19:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:19:46','YYYY-MM-DD HH24:MI:SS'),100,'AD_SessionType','Session Type','Session Type','D','070bd967-df56-4acc-8742-9b964f28585f')
;

-- 27-Mar-2023, 4:22:22 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200238,'AD_Session(Session Type)','L',0,0,'Y',TO_DATE('2023-03-27 16:22:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:22:21','YYYY-MM-DD HH24:MI:SS'),100,'D','N','0992dee4-fb8a-4391-8966-3ee2da3bcdf8')
;

-- 27-Mar-2023, 4:23:07 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200630,'Webui',200238,'Webui',0,0,'Y',TO_DATE('2023-03-27 16:23:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:23:07','YYYY-MM-DD HH24:MI:SS'),100,'D','9b672539-ba04-4d99-ae0c-2882287eb4c5')
;

-- 27-Mar-2023, 4:23:33 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200631,'WebService',200238,'WebService',0,0,'Y',TO_DATE('2023-03-27 16:23:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:23:32','YYYY-MM-DD HH24:MI:SS'),100,'D','69673977-5375-476b-b0e3-f04b2516baeb')
;

-- 27-Mar-2023, 4:24:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215807,0,'Session Type',566,'AD_SessionType',25,'N','N','N','N','N',0,'N',17,200238,0,0,'Y',TO_DATE('2023-03-27 16:24:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:24:16','YYYY-MM-DD HH24:MI:SS'),100,203797,'Y','N','D','N','N','N','Y','840766bb-10f9-47fd-9b18-212e4510f66c','Y',0,'N','N','N','N')
;

-- 27-Mar-2023, 4:27:29 PM IST
UPDATE AD_Element SET Description='it indicates from where this session is created  i.e from Webui,Web Service etc.', Help='it indicates from where this session is created  i.e from Webui,Web Service etc.',Updated=TO_DATE('2023-03-27 16:27:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203797
;

-- 27-Mar-2023, 4:27:29 PM IST
UPDATE AD_Column SET ColumnName='AD_SessionType', Name='Session Type', Description='it indicates from where this session is created  i.e from Webui,Web Service etc.', Help='it indicates from where this session is created  i.e from Webui,Web Service etc.', Placeholder=NULL WHERE AD_Element_ID=203797
;

-- 27-Mar-2023, 4:28:07 PM IST
ALTER TABLE AD_Session ADD AD_SessionType VARCHAR2(25 CHAR) DEFAULT NULL 
;

-- 27-Mar-2023, 4:28:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207597,'Session Type','it indicates from where this session is created  i.e from Webui,Web Service etc.','it indicates from where this session is created  i.e from Webui,Web Service etc.',475,215807,'Y',25,150,'N','N','N','N',0,0,'Y',TO_DATE('2023-03-27 16:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-27 16:28:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e73fe82e-feb9-49ef-99ca-aba0926d386d','Y',150,2)
;

-- 28-Mar-2023, 11:45:21 AM IST
UPDATE AD_Ref_List SET Name='Web Service', Value='WBSR',Updated=TO_DATE('2023-03-28 11:45:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200631
;

-- 28-Mar-2023, 11:45:33 AM IST
UPDATE AD_Ref_List SET Value='WBUI',Updated=TO_DATE('2023-03-28 11:45:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200630
;


SELECT register_migration_script('202303272003_IDEMPIERE-5646.sql') FROM dual;






