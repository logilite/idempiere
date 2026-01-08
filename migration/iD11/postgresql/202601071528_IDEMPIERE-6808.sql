--Makig Window Data order by system configurable
SELECT register_migration_script('202601071528_IDEMPIERE-6808.sql') FROM dual;

-- Jan 7, 2026, 3:28:26 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200291,0,0,TO_TIMESTAMP('2026-01-07 15:28:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-07 15:28:25','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DEFAULT_ORDERBY','Created','Ssystem Configuration where a globle order by configured','D','S','f30f97fb-45fa-4403-baf5-4839ac84a3f9')
;

