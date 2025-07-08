-- Merge corrections
SELECT register_migration_script('202507081620_MergeCorrection.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

UPDATE AD_Column SET AD_Reference_ID=200202,Updated=getDate(),UpdatedBy=100 WHERE AD_Column_ID = 215945
;