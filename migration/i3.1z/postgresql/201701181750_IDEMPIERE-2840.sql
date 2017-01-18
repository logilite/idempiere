-- IDEMPIERE-2840 : Tokens for login into web services
-- Jan 18, 2017 5:51:41 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200085,0,0,TO_TIMESTAMP('2017-01-18 17:51:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-01-18 17:51:38','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','WEBSERVICE_TOKEN_CHECK_CLIENT','Y','D','S','05599162-1b8d-4691-a5ed-df79282a798a')
;

SELECT register_migration_script('201701181750_IDEMPIERE-2840.sql') FROM dual
;
