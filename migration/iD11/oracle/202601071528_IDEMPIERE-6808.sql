--Making Window Data order by system configurable
SELECT register_migration_script('202601071528_IDEMPIERE-6808.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 7, 2026, 3:28:26 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200291,0,0,TO_TIMESTAMP('2026-01-07 15:28:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-07 15:28:25','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DEFAULT_ORDERBY','Created','Apply global default ORDER BY clause for tab headers using common fields or {_ID} / {_UU}, Configuration format: "Column1 ASC, Column2 DESC, {_ID}, {_UU}". Special tokens: {_ID} - Resolves to TableName_ID, {_UU} - Resolves to TableName_UU','D','C','f30f97fb-45fa-4403-baf5-4839ac84a3f9')
;

