-- IDEMPIERE-5752  on Financial Report, Adding way to report lines per accounting dimensions
SELECT register_migration_script('202509291200_IDEMPIERE-5752.sql') FROM dual;

-- 29-Sep-2025, 12:00:32 pm IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200738,'Asset','Asset used internally or by customers',200249,'AS',0,0,'Y',TO_TIMESTAMP('2025-09-29 12:00:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-09-29 12:00:31','YYYY-MM-DD HH24:MI:SS'),100,'D','38dcef65-8867-4dfe-a1b6-758cd04456bf')
;

