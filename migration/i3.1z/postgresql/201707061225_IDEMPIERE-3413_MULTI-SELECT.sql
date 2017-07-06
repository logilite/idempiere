-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Jul 5, 2017 1:00:33 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-05 13:00:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Jul 6, 2017 12:20:46 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200138 & @AD_Reference_ID@!200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-06 12:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11264
;

SELECT register_migration_script('201707061225_IDEMPIERE-3413_MULTI-SELECT.sql') FROM dual
;