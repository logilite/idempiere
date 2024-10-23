-- Default Request Event Handler Disabled Configuration
SELECT register_migration_script('202410232126_DefaultRequestHandlerDisabled.sql') FROM dual;

-- Oct 23, 2024, 9:26:34 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200256,0,0,TO_TIMESTAMP('2024-10-23 21:26:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-10-23 21:26:33','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DEFAULT_REQUEST_HANDLER_DISABLED','N','Set this to false (N) to allow the default request event handler to be invoked, or true (Y) to disable it and prevent the handler from being triggered.','D','S','516c09bd-307e-4a56-8da5-d885abcd4e74')
;

