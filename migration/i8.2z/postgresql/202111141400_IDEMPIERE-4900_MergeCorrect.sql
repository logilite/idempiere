-- 202111141400_IDEMPIERE-4900.sql  
UPDATE AD_Message SET MsgType = 'E',MsgText = 'Please enter read-only SQL expression or statement' ,Updated=TO_TIMESTAMP('2021-11-14 17:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100
WHERE AD_Message_ID=200259;

SELECT register_migration_script('202111141400_IDEMPIERE-4900_MergeCorrect.sql') FROM dual
;
