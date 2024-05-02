-- 
SELECT register_migration_script('202307041724_IDEMPIERE-5329.sql') FROM dual;

-- Jul 4, 2023, 5:49:39 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217705,'42f92d96-2ce3-47cc-bdc6-d02c82a9aefc',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_depositbatch_id','c_payment.c_depositbatch_id',820)
;

