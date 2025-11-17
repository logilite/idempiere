-- IDEMPIERE-6726 Option to Do not show total amount in summary lines of financial report
SELECT register_migration_script('202511161426_IDEMPIERE-6726.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 16-Nov-2025, 2:26:34 pm IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200500,0,0,'Y',TO_TIMESTAMP('2025-11-16 14:26:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-16 14:26:33','YYYY-MM-DD HH24:MI:SS'),100,'Do Not Show Total?',202,240,20,'N',1,'N','N','IsHideDimensionSummaryLine','N','D','2c0cf021-df7c-4cfe-a6fc-3e145c7d17b1','N','N','D','N')
;

