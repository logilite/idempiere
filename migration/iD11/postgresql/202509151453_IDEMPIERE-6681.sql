-- Workflow responsible type custom sql
SELECT register_migration_script('202509151453_IDEMPIERE-6681.sql') FROM dual;

-- 15-Sep-2025, 2:53:40 pm IST
UPDATE AD_Ref_List SET Name='Supervisor of Initiator',Updated=TO_TIMESTAMP('2025-09-15 14:53:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200715
;

-- 15-Sep-2025, 2:53:59 pm IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200737,'Supervisor of Current User',304,'SC',0,0,'Y',TO_TIMESTAMP('2025-09-15 14:53:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-15 14:53:58','YYYY-MM-DD HH24:MI:SS'),100,'D','249d28d9-a39e-46fd-b257-1dee9c0141fb')
;

