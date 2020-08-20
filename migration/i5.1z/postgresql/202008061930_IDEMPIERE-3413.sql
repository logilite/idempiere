-- IDEMPIERE-3413: Enhancement of Overlap and Exclude operator for Array type content
-- Aug 6, 2020 7:34:58 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200156,0,0,TO_TIMESTAMP('2020-08-06 19:34:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2020-08-06 19:34:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MULTISELECT_DEFAULT_LOOKUP_OPERATOR','=','For lookup window, Multiple selection field default lookup to use operator from ( =, <>, <<<, >>>, &&, -&& )','D','C','1ad6c66c-6729-4160-8c7e-44f201f2555c')
;

SELECT register_migration_script('202008061930_IDEMPIERE-3413.sql') FROM dual
;
