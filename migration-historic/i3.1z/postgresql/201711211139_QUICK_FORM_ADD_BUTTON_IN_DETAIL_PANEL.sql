-- Quick Form enhancement
-- Nov 21, 2017 11:39:03 AM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200112,0,0,TO_TIMESTAMP('2017-11-21 11:39:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-11-21 11:39:02','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','QUICKFORM_PAGE_SIZE','25','Default paging size for Quick Form in zk webui','D','C','2ae2e737-285e-4cda-82a6-bbe7efce2cb8')
;

-- Quick Form enhancement
-- Nov 22, 2017 12:48:12 PM IST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2017-11-22 12:48:11','YYYY-MM-DD HH24:MI:SS'),100,'QuickForm','Y',200095,'Detail - QuickForm',TO_TIMESTAMP('2017-11-22 12:48:11','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'93a9a483-ea2f-49b7-8737-a4113b2aa8de','D',50,'N','N')
;

SELECT register_migration_script('201711211139_QUICK_FORM_ADD_BUTTON_IN_DETAIL_PANEL.sql') FROM dual
;
