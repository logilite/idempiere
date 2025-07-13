SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5346  SSO Support
-- Jul 10, 2025, 4:19:01 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200284,0,0,TO_DATE('2025-07-10 16:19:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2025-07-10 16:19:00','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SSO_SHOWSSO_OPTION','Y','This configuration flag determines whether the SSO (Single Sign-On) login option is displayed on the standard iDempiere login page.','D','S','dca70792-7a9f-4f37-b0bf-0ac51536d3a2')
;

SELECT register_migration_script('202507101700_IDEMPIERE-5346.sql') FROM dual;
;
