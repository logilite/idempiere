SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4059 print format editor
-- Dec 17, 2019 5:31:52 PM IST
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200014,0,0,'Y',TO_DATE('2019-12-17 17:31:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-17 17:31:51','YYYY-MM-DD HH24:MI:SS'),100,'Print Format Editor','org.compiere.apps.form.VPrintFormatEditor','7','D','N','f528c5df-ec53-4618-bcf3-814ef0986de8')
;

-- Dec 17, 2019 5:33:42 PM IST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,AD_Form_ID,CopyFromProcess,AD_Process_UU) VALUES (200116,0,0,'Y',TO_DATE('2019-12-17 17:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-17 17:33:42','YYYY-MM-DD HH24:MI:SS'),100,'Print Format Editor','N','Print Format Editor','N','7','D',0,0,'N','N','Y',200014,'N','7bd6aa10-4de6-4837-94d6-7f647214ba0d')
;

-- Dec 17, 2019 5:35:08 PM IST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo) VALUES (0,0,TO_DATE('2019-12-17 17:35:07','YYYY-MM-DD HH24:MI:SS'),100,'Print Format Editor','Y',200100,'Print Format Editor',TO_DATE('2019-12-17 17:35:07','YYYY-MM-DD HH24:MI:SS'),100,'N','9e6e87d2-9f22-440d-8a54-1da2899ca8b5','W',425,200116,'@IsForm@=Y',10)
;

SELECT register_migration_script('201912171730_IDEMPIERE-4059.sql') FROM dual
;
