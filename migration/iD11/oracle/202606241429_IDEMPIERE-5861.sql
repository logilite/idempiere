-- IDEMPIERE-5861  Tab specific readonly logic and display logic for toolbar button
SELECT register_migration_script('202606241429_IDEMPIERE-5861.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 24/06/2026 14:29:30 IST
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2026-06-24 14:29:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209224
;

-- 24/06/2026 14:29:33 IST
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2026-06-24 14:29:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209225
;

-- 24/06/2026 14:29:46 IST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-06-24 14:29:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217634
;

-- 24/06/2026 14:29:54 IST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-06-24 14:29:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217635
;

-- 24/06/2026 14:30:40 IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201324,'c964e88d-b601-44f4-8314-64a36d16a24f',TO_TIMESTAMP('2026-06-24 14:30:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_toolbarbuttonrestric_unique',TO_TIMESTAMP('2026-06-24 14:30:39','YYYY-MM-DD HH24:MI:SS'),100,200004,'Y','Y','N','N')
;

-- 24/06/2026 14:30:47 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201825,'ae127129-386e-4562-9983-882312d09630',TO_TIMESTAMP('2026-06-24 14:30:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:30:47','YYYY-MM-DD HH24:MI:SS'),100,200100,201324,10)
;

-- 24/06/2026 14:31:08 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201826,'7a50afb5-c568-41c3-8813-e4d2510049f0',TO_TIMESTAMP('2026-06-24 14:31:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:31:07','YYYY-MM-DD HH24:MI:SS'),100,200105,201324,20)
;

-- 24/06/2026 14:31:20 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201827,'e959b999-6459-4114-bf56-d14f82e79376',TO_TIMESTAMP('2026-06-24 14:31:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:31:19','YYYY-MM-DD HH24:MI:SS'),100,200108,201324,30)
;

-- 24/06/2026 14:31:25 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201828,'8ead1846-6e4c-4b06-9949-f21c019d301a',TO_TIMESTAMP('2026-06-24 14:31:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:31:25','YYYY-MM-DD HH24:MI:SS'),100,200111,201324,40)
;

-- 24/06/2026 14:31:46 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201829,'555dad5b-4bb8-4949-aecd-1c99f6ff60a3',TO_TIMESTAMP('2026-06-24 14:31:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:31:46','YYYY-MM-DD HH24:MI:SS'),100,200817,201324,50)
;

-- 24/06/2026 14:31:50 IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201830,'248dec78-8bdf-4ef4-bf39-c2907b83bccd',TO_TIMESTAMP('2026-06-24 14:31:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-24 14:31:49','YYYY-MM-DD HH24:MI:SS'),100,200104,201324,60)
;

-- 24/06/2026 14:32:10 IST
ALTER TABLE AD_ToolBarButtonRestrict ADD CONSTRAINT ad_toolbarbuttonrestric_unique UNIQUE (AD_Client_ID,Action,AD_Role_ID,AD_Window_ID,AD_Tab_ID,AD_ToolBarButton_ID)
;

-- 24/06/2026 15:01:45 IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Duplicate Toolbar Button Access record exists.',0,0,'Y',TO_TIMESTAMP('2026-06-24 15:01:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-24 15:01:45','YYYY-MM-DD HH24:MI:SS'),100,201043,'Duplicate_ToolBarButtonRestrict','D','da10cf2e-9730-493c-acec-21e1e6d296a8')
;

-- 24/06/2026 16:01:49 IST
UPDATE AD_Field SET ReadOnlyLogic=NULL,Updated=TO_TIMESTAMP('2026-06-24 16:01:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200730
;

