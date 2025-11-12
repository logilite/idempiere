-- IDEMPIERE-3413 Multi-Select Default Value support
SELECT register_migration_script('202511121736_IDEMPIERE-3413.sql') FROM dual;

-- Nov 12, 2025, 5:36:36 PM IST
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2025-11-12 17:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

