-- IDEMPIERE-2853: Panel tab as a factory
-- Jan 22, 2016 11:47:02 AM IST
UPDATE AD_Ref_List SET Name='Data Grid',Updated=TO_TIMESTAMP('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200347
;

-- Jan 22, 2016 11:50:50 AM IST
UPDATE AD_Ref_List SET Name='Order Tab',Updated=TO_TIMESTAMP('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200348
;

-- Jan 22, 2016 11:53:09 AM IST
SELECT register_migration_script('201601221200_IDEMPIERE-2853_MergeCorrect.sql') FROM dual
;