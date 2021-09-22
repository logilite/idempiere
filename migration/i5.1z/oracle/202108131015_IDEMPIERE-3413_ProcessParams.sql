SET SQLBLANKLINES ON
SET DEFINE OFF

-- Support for multiselect record in process param.
-- Aug 13, 2021 7:25:27 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200139 & @AD_Reference_ID@!200138', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-08-13 19:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2544
;

SELECT register_migration_script('202108131015_IDEMPIERE-3413_ProcessParams.sql') FROM dual
;
