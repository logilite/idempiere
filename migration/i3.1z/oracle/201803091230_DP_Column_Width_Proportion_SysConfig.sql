SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dashboard panel configures column width as proportional by comma separator
-- Mar 9, 2018 12:30:51 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200115,0,0,TO_DATE('2018-03-09 12:30:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-03-09 12:30:50','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DP_COLUMN_WIDTH_PROPORTION',' ','Dashboard panel configures column width as proportional by comma separator. Eg. 20,50,30','D','C','1621173c-2c70-4877-8735-fe07f8328f44')
;

SELECT register_migration_script('201803091230_DP_Column_Width_Proportion_SysConfig.sql') FROM dual
;
