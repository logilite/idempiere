-- 
SELECT register_migration_script('202207180104_PlaceholderForTicket.sql') FROM dual;

-- Jul 18, 2022, 2:12:30 AM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217380,'210fc421-54d7-452c-b054-00517ab2a85a',TO_TIMESTAMP('2022-07-18 02:12:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 02:12:24','YYYY-MM-DD HH24:MI:SS'),100,200008,'alwaysupdatablelogic','COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic)',710)
;

-- Jul 18, 2022, 2:14:15 AM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217381,'5303286c-ad9f-4d49-89ad-5db70a48e11c',TO_TIMESTAMP('2022-07-18 02:14:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 02:14:08','YYYY-MM-DD HH24:MI:SS'),100,200009,'alwaysupdatablelogic','COALESCE(f.alwaysupdatablelogic, c.alwaysupdatablelogic)',720)
;
