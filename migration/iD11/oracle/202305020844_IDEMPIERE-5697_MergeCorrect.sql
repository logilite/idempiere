-- IDEMPIERE-5697
-- add PInstanceLogType to AD_PInstance_Log
SELECT register_migration_script('202305020844_IDEMPIERE-5697_MergeCorrect.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 2, 2023, 8:45:02 AM CEST
UPDATE AD_Reference SET ShowInactive='N' ,Updated=TO_DATE('2023-05-02 08:45:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200242
;

-- May 15, 2023, 10:49:33 AM CEST
UPDATE AD_TableIndex SET Name='ad_pinstance_log_uu', IsKey='Y',Updated=TO_TIMESTAMP('2023-05-15 10:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200138
;

-- May 15, 2023, 10:49:54 AM CEST
ALTER TABLE AD_PInstance_Log DROP CONSTRAINT ad_pinstance_log_uu_idx CASCADE
;
