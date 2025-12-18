-- IDEMPIERE-6791: Making Line MA creation as system configurable on create inventory count
SELECT register_migration_script('202512171807_IDEMPIERE-6791.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 17/12/2025 18:07:53 IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200288,0,0,TO_TIMESTAMP('2025-12-17 18:07:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-12-17 18:07:53','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','INVENTORYCOUNT_CREATE_LINEMA','N','Used on Create Inventory Count list process on Phy Inventory, If  Configured Value as N then Do not create MA Lines from Inventory Count process Else allow to Create.','D','C','d1433869-6e00-4b29-8d9b-74145acb6a3f')
;

