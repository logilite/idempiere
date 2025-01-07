-- Adding Display logic to show Approval Column for User Task
-- 31-Dec-2024, 1:22:51 PM IST
UPDATE AD_Field SET DisplayLogic='@Action@=V | @Action@=C | @Action@=U', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-12-31 13:27:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10088
;

SELECT register_migration_script('202412311327_IDEMPIERE-6246.sql') FROM dual
;