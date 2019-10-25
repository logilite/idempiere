-- Default Values
-- Oct 25, 2019 11:48:20 AM IST
UPDATE AD_Process_Para SET DefaultValue='Y',IsCentrallyMaintained='N',Updated=TO_DATE('2019-10-25 11:48:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=547
;

-- Oct 25, 2019 11:48:29 AM IST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2019-10-25 11:48:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8176
;

-- Oct 25, 2019 1:23:22 PM IST
UPDATE AD_Ref_Table SET OrderByClause='C_Period.StartDate DESC',Updated=TO_DATE('2019-10-25 13:23:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=275
;

SELECT register_migration_script('201910251150_DefaultValuesForFinReport.sql') FROM dual
;
