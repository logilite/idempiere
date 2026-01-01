-- Add a unique index on Dashboard Preference for User Role and Dashboard Content
SELECT register_migration_script('202512311837_PlaceholderForTicket.sql') FROM dual;

-- 31-Dec-2025, 6:37:06 pm IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201292,'a1b97aa4-2852-4e15-a03b-3aa413857174',TO_TIMESTAMP('2025-12-31 18:37:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','pa_dashboardpreference_user_role_dc',TO_TIMESTAMP('2025-12-31 18:37:05','YYYY-MM-DD HH24:MI:SS'),100,200013,'Y','Y','N','N')
;

-- 31-Dec-2025, 6:37:15 pm IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201769,'e896f403-c986-4852-bae4-3d34d0231b98',TO_TIMESTAMP('2025-12-31 18:37:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-31 18:37:14','YYYY-MM-DD HH24:MI:SS'),100,200328,201292,10)
;

-- 31-Dec-2025, 6:37:33 pm IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201770,'249a5206-3a8d-4ffd-a4ed-3eaa68f15055',TO_TIMESTAMP('2025-12-31 18:37:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-31 18:37:32','YYYY-MM-DD HH24:MI:SS'),100,200327,201292,10)
;

-- 31-Dec-2025, 6:37:42 pm IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201771,'24aca515-d12d-4322-9bed-65c50460e1f8',TO_TIMESTAMP('2025-12-31 18:37:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-31 18:37:41','YYYY-MM-DD HH24:MI:SS'),100,200350,201292,10)
;

-- 31-Dec-2025, 6:37:45 pm IST
ALTER TABLE PA_DashboardPreference ADD CONSTRAINT pa_dashboardpreference_user_role_dc UNIQUE (AD_User_ID,AD_Role_ID,PA_DashboardContent_ID)
;
