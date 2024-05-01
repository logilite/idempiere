SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding Access tab on Document Status (Activity)
-- Nov 23, 2021, 8:28:12 PM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_DATE('2021-11-23 20:28:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- Nov 23, 2021, 8:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_DATE('2021-11-23 20:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

SELECT register_migration_script('202106282230_IDEMPIERE-4836_MergeCorrect.sql') FROM dual
;
