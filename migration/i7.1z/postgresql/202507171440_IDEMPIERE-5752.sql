-- IDEMPIERE-5752 on Financial Report, Adding way to report lines per accounting dimensions
-- Jul 17, 2025, 1:29:26 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200725,'Charge',200249,'CH',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:29:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:29:25','YYYY-MM-DD HH24:MI:SS'),100,'D','69ce5c6d-42e2-42c1-afc1-9093ab1acf70')
;

-- Jul 17, 2025, 1:30:11 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200726,'Warehouse',200249,'WH',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:30:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:30:10','YYYY-MM-DD HH24:MI:SS'),100,'D','7cc16718-31cd-4049-879b-be92bd752ee1')
;

-- Jul 17, 2025, 1:33:47 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200727,'Employee',200249,'EP',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:33:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:33:46','YYYY-MM-DD HH24:MI:SS'),100,'D','5090445d-9da8-4f3e-a307-1e4c56221ca0')
;

-- Jul 17, 2025, 1:34:19 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200728,'Department',200249,'DP',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:34:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:34:19','YYYY-MM-DD HH24:MI:SS'),100,'D','71882a87-1e43-469c-b57e-9084d01b51b0')
;

-- Jul 17, 2025, 1:34:35 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200729,'Cost Center',200249,'CC',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:34:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:34:34','YYYY-MM-DD HH24:MI:SS'),100,'D','13ddcf9f-542b-46e3-8d29-f08591b86928')
;

-- Jul 17, 2025, 1:35:33 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200730,'Tax',200249,'TX',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:35:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:35:32','YYYY-MM-DD HH24:MI:SS'),100,'D','ac738a6f-28ba-473b-89fe-9103b78d2634')
;

-- Jul 17, 2025, 1:36:00 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200731,'Bank Account',200249,'BA',0,0,'Y',TO_TIMESTAMP('2025-07-17 13:35:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-17 13:35:59','YYYY-MM-DD HH24:MI:SS'),100,'D','914045b2-7581-4fb1-b750-21662b6dca7f')
;


SELECT register_migration_script('202507171440_IDEMPIERE-5752.sql') FROM dual;
;
