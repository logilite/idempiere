-- Make Payment field search instead of table direct
-- May 23, 2023, 4:26:30 PM IST
UPDATE AD_Column SET ColumnName='C_Payment_ID', AD_Reference_ID=30, AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2023-05-23 16:26:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208437
;

-- May 23, 2023, 4:26:30 PM IST
INSERT INTO t_alter_column values('c_depositbatchline','C_Payment_ID','NUMERIC(10)',null,null,null)
;

SELECT register_migration_script('202305231904_IDEMPIERE-5329.sql') FROM dual
;
