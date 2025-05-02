-- IDEMPIERE-6304 Multiple SSO provider support
-- 09-Apr-2025, 3:26:56 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200262,0,0,TO_TIMESTAMP('2025-04-09 15:26:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-09 15:26:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SSO_SHOW_LOGINPAGE','N','Allows users to access the standard login page alongside SSO, enabling manual login even when SSO is configured.','D','S','be343ea6-d422-4603-8b61-04bf18236797')
;

SELECT register_migration_script('202504091630_IDEMPIERE-6304.sql') FROM dual;
