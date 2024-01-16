-- Included Tab Support in iDempiere
-- Dec 11, 2023, 5:07:31 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID.AD_Reference_ID@=200127|@AD_Column_ID.AD_Reference_ID@=200128|@AD_Reference_ID@=200127|@AD_Reference_ID@=200128 | @AD_Column_ID.AD_Reference_ID@=18 | @AD_Reference_ID@=18  | @AD_Column_ID.AD_Reference_ID@=19 | @AD_Reference_ID@=19 | @AD_Column_ID.AD_Reference_ID@=30 | @AD_Reference_ID@=30 | @AD_Column_ID.AD_Reference_ID@=13 | @AD_Reference_ID@=13', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-11 17:07:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6432
;

SELECT register_migration_script('202312111711_IncludedTab.sql') FROM dual
;