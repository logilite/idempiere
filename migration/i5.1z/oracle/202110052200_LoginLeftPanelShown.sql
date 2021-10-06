SET SQLBLANKLINES ON
SET DEFINE OFF

-- Login_LeftPanel_Shown
-- Oct 5, 2021 9:43:44 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200185,0,0,TO_DATE('2021-10-05 21:43:43','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-10-05 21:43:43','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_LOGIN_LEFTPANEL_SHOWN','Y','Login window show left side panel','D','S','29335a99-23a6-4ae9-bcb1-967d13c6ecda')
;

SELECT register_migration_script('202110052200_LoginLeftPanelShown.sql') FROM dual
;
