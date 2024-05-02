-- IDEMPIERE-4882 : On Inventory Move, Adding Warehouse and Warehouse To field on header
-- Nov 15, 2021, 1:05:33 PM CET
UPDATE AD_Column SET DefaultValue='NULL', Callout=NULL, IsUpdateable='Y',Updated=TO_TIMESTAMP('2021-11-15 13:05:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:06:49 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=189,Updated=TO_TIMESTAMP('2021-11-15 13:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:11:53 PM CET
UPDATE AD_Column SET ReadOnlyLogic='@SQL=SELECT 1 FROM M_MovementLine WHERE M_Movement_ID=@M_Movement_ID:0@',Updated=TO_TIMESTAMP('2021-11-15 13:11:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:13:03 PM CET
UPDATE AD_Column SET ReadOnlyLogic='@SQL=SELECT 1 FROM M_MovementLine WHERE M_Movement_ID=@M_Movement_ID:0@',Updated=TO_TIMESTAMP('2021-11-15 13:13:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214566
;

SELECT register_migration_script('202107272210_IDEMPIERE-4882_MergeCorrect.sql') FROM dual
;
