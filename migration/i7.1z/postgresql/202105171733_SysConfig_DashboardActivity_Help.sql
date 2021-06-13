-- Configuration time interval to slow query help suggestion in activity dashboard panel
-- May 17, 2021, 5:02:08 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200173,0,0,TO_TIMESTAMP('2021-05-17 17:02:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-05-17 17:02:06','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DASHBOARD_SLOW_QUERY_TIME_INTERVAL','500','Configuration time interval to slow query help suggestion in activity dashboard panel. Count on millisecond and can set at client level. default is 500 milliseconds.','D','C','88b4580f-a5d4-430b-8eea-47611f505b97')
;

SELECT register_migration_script('202105171733_SysConfig_DashboardActivity_Help.sql') FROM dual
;