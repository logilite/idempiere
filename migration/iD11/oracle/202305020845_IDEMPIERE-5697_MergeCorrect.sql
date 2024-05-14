-- IDEMPIERE-5697 Improve Process Log for more advanced logging options for Processes
SELECT register_migration_script('202305020845_IDEMPIERE-5697_MergeCorrect.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 14, 2023, 1:55:49 PM CET
ALTER TABLE AD_PInstance_Log ADD CONSTRAINT ad_pinstance_log_uu_idx UNIQUE (AD_PInstance_Log_UU)
;
