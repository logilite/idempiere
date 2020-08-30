-- IDEMPIERE-4066: When creating new records 'Relative Period To' always null instead of 0 as default
-- Aug 28, 2020 10:42:34 PM IST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2020-08-28 22:42:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214087
;

SELECT register_migration_script('202008282250_IDEMPIERE-4066.sql') FROM dual
;