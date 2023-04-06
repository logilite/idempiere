SET SQLBLANKLINES ON
SET DEFINE OFF

-- * org must not allowed in deposit batch
-- Feb 8, 2023, 6:32:32 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=130, ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-02-08 18:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208399
;

SELECT register_migration_script('202302081905_IDEMPIERE-5329.sql') FROM dual
;