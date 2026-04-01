-- added User_Searchkey_Case, User_Searchkey_Allowed_Char System Configurator
SELECT register_migration_script('202603231706_UserSearchkey_Related_SysConfig.sql') FROM dual;

-- 23/03/2026 17:06:21 IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200304,0,0,TO_TIMESTAMP('2026-03-23 17:06:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-03-23 17:06:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','USER_SEARCHKEY_CASE','L','U-If want to set upper case Search Key on User,
L-If want to set lower case Search Key on User
N-Otherwise','D','C','6f196eae-91ec-484f-be5f-343367f86990')
;

-- 23/03/2026 17:32:58 IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200307,0,0,TO_TIMESTAMP('2026-03-23 17:32:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-03-23 17:32:58','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','USER_SEARCHKEY_ALLOWED_CHAR',' ','if want to allowed special characters in the User Search Key then define a comma-separated list.','D','C','0946f4f8-8155-469d-b948-449235e5b339')
;