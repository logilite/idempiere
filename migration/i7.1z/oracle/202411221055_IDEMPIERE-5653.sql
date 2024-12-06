SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5653: Print format access and restriction
-- 23-Nov-2024, 10:01:14 PM IST
UPDATE AD_Tab SET WhereClause=NULL, DisplayLogic='@#ShowAdvanced@=Y',Updated=TO_DATE('2024-11-23 22:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200357
;

SELECT register_migration_script('202411221055_IDEMPIERE-5653.sql') FROM dual
;