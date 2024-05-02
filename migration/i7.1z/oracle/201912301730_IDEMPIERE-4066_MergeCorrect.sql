SET SQLBLANKLINES ON
SET DEFINE OFF

-- Financial Report Header Print Format - Related Period To
-- Nov 27, 2019 4:51:42 PM IST
UPDATE AD_Field SET DisplayLogic='@ColumnType@=R | @ColumnType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-27 16:51:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4757
;

-- Nov 27, 2019 4:51:47 PM IST
UPDATE AD_Field SET DisplayLogic='@ColumnType@=R | @ColumnType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-27 16:51:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206213
;

SELECT register_migration_script('201912301730_IDEMPIERE-4066_MergeCorrect.sql') FROM dual
;

