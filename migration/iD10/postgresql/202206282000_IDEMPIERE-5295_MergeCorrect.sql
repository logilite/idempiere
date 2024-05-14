-- IDEMPIERE-5295 Trial Balance Report creates wrong Opening Balance
SELECT register_migration_script('202206282000_IDEMPIERE-5295_MergeCorrect.sql') FROM dual;

-- Jun 28, 2022, 7:53:01 PM IST
UPDATE AD_Process_Para SET IsAutocomplete = 'N', Updated = TO_TIMESTAMP('2022-06-28 19:53:00','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Process_Para_ID = 200386;

-- Jul 4, 2022, 8:03:29 PM MYT
UPDATE AD_PrintFormat SET AD_ReportView_ID=153,Updated=TO_TIMESTAMP('2022-07-04 20:03:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200014
;
