-- Adding System Configurator BANKSTATEMENT MANUAL OPENING
-- 05-Feb-2024, 5:32:12 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200243,0,0,TO_TIMESTAMP('2024-02-05 17:32:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-02-05 17:32:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','BANKSTATEMENT_MANUAL_OPENING','N','D','C','eb84d0f0-a9a4-4cb0-b173-918ba714034d')
;

SELECT register_migration_script('202402051735_SysConfig_BANKSTATEMENT_MANUAL_OPENING.sql') FROM dual
;