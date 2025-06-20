SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5983  Not posting Reverse Corrected Document
-- 17-Mar-2025, 7:16:23 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200716,'No Posting Required',234,'R',0,0,'Y',TO_DATE('2025-03-17 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-03-17 19:16:22','YYYY-MM-DD HH24:MI:SS'),100,'D','def573d1-07ae-4b61-8c45-756ae7353596')
;

SELECT register_migration_script('202503171823_IDEMPIERE-5983.sql') FROM dual
;
