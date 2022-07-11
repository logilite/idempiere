-- Updated reference of parameter of table in Client Accounting Processor Process
-- 06-May-2022, 3:43:47 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=18, AD_Reference_Value_ID=206, AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2022-05-06 15:43:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53346
;

SELECT register_migration_script('202205061602_UpdateTableParaOfCliAccProc.sql') FROM dual
;

