-- IDEMPIERE-5598  Add new Accounting Dimensions
-- Sep 18, 2025, 5:51:05 PM IST
UPDATE AD_Field SET DisplayLogic='@A_CreateAsset@=''Y'' | @$Element_AS@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-09-18 17:51:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200242
;

-- Sep 18, 2025, 6:01:46 PM IST
UPDATE AD_Field SET DisplayLogic='@A_CreateAsset@=''Y''  | @$Element_AS@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-09-18 18:01:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56250
;

-- Sep 18, 2025, 6:22:14 PM IST
UPDATE AD_Field SET DisplayLogic='@A_CreateAsset@=''Y'' | @$Element_AS@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-09-18 18:22:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5825
;

SELECT register_migration_script('202509181800_IDEMPIERE-5598.sql') FROM dual;
;