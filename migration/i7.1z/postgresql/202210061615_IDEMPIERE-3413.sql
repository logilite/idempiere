-- Updating Display Logic of Reference Key field
-- 06-Oct-2022, 4:10:49 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-10-06 16:10:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

SELECT register_migration_script('202210061615_IDEMPIERE-3413.sql') FROM dual
