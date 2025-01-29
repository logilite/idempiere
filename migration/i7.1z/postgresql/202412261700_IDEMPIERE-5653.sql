-- IDEMPIERE-5653: Print format access and restriction
-- Dec 26, 2024, 5:44:30 PM IST
UPDATE AD_Tab SET WhereClause='NOT EXISTS (SELECT 1 FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = AD_PrintFormat.AD_PrintFormat_ID) OR EXISTS (SELECT 1 FROM AD_PrintFormat_Access WHERE (((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID:0@) OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID:0@) OR (AD_Role_ID = @#AD_Role_ID:0@ AND AD_User_ID = @#AD_User_ID:0@)) AND AD_PrintFormat_ID = AD_PrintFormat.AD_PrintFormat_ID)) OR @CreatedBy:0@ = @#AD_User_ID:0@ OR EXISTS (SELECT 1 FROM AD_User where AD_User.AD_User_ID = @#AD_User_ID:0@ AND IsSupportUser = ''Y'')',Updated=TO_TIMESTAMP('2024-12-26 17:44:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=425
;

SELECT register_migration_script('202412261700_IDEMPIERE-5653.sql') FROM dual
;
