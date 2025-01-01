-- IDEMPIERE-5653: Print format access and restriction
-- Dec 30, 2024, 7:26:24 PM IST
UPDATE AD_Val_Rule SET Code='AD_PrintFormat.AD_PrintFormat_ID IN (SELECT DISTINCT AD_PrintFormat_ID FROM AD_PrintFormat_Access WHERE ((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID@) OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID@) OR (AD_Role_ID = @#AD_Role_ID@ AND AD_User_ID = @#AD_User_ID@))) OR AD_PrintFormat.CreatedBy = @#AD_User_ID@ OR EXISTS (SELECT 1 FROM AD_User where AD_User.AD_User_ID = @#AD_User_ID:0@ AND IsSupportUser = ''Y'') 
OR NOT EXISTS (SELECT 1 FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = AD_PrintFormat.AD_PrintFormat_ID) ',Updated=TO_TIMESTAMP('2024-12-30 19:26:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200189
;

-- Dec 30, 2024, 8:00:46 PM IST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2024-12-30 20:00:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200482
;

SELECT register_migration_script('202412301900_IDEMPIERE-5653.sql') FROM dual
;