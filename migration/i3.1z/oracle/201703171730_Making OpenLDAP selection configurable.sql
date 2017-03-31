SET SQLBLANKLINES ON
SET DEFINE OFF

-- Making OpenLDAP selection configurable
-- Mar 17, 2017 5:13:56 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200094,0,0,TO_DATE('2017-03-17 17:13:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-03-17 17:13:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','LDAP_IS_OPEN_LDAP','N','Added this flag to decide whether to use OpenLDAP or not','U','S','66d11ec9-918b-4c7c-933c-bfb9554c5ee5')
;

SELECT register_migration_script('201703171730_Making OpenLDAP selection configurable.sql') FROM dual
;
