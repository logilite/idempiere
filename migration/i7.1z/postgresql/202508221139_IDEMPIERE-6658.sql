-- IDEMPIERE-6658 Reactivate completed Movement feature
-- Aug 19, 2025, 12:17:19 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Transaction From record not deleted (MA) {0}',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:17:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:17:18','YYYY-MM-DD HH24:MI:SS'),100,200963,'InventoryMoveTransactionFromFailedToDelete','D','d14b9c43-943d-4d1c-9e5e-14c1ed3005f2')
;

-- Aug 19, 2025, 12:18:34 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Transaction To record not deleted (MA) {0}',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:18:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:18:33','YYYY-MM-DD HH24:MI:SS'),100,200964,'InventoryMoveTransactionToFailedToDelete','D','19c55bf6-6f46-45f5-bfa3-0a0c09a0a2a4')
;

-- Aug 19, 2025, 12:20:01 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Cannot correct Inventory OnHand (MA) [{0}] - {1}',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:20:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:20:01','YYYY-MM-DD HH24:MI:SS'),100,200965,'InventoryMoveStorageNotCorrect','D','4b6fa749-90f5-4cf3-aa18-dc12ead0679c')
;

-- Aug 19, 2025, 12:22:41 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Unable to delete Movement Line Allocation (MA) of Product- {0}, ASI ID- {1}, Date Material Policy- {2}',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:22:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:22:41','YYYY-MM-DD HH24:MI:SS'),100,200966,'InventoryMoveLineMAFailedToDelete','D','4ac474a4-64c8-4b5d-b2e2-548d185f9186')
;

-- Aug 19, 2025, 12:23:41 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Transaction From record not found for [{0}]',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,200967,'InventoryMoveTransactionFromNotFound','D','b56c1e8f-5376-419d-85b4-9223aab4cbed')
;

-- Aug 19, 2025, 12:25:43 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Transaction To record not found for [{0}]',0,0,'Y',TO_TIMESTAMP('2025-08-19 12:25:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-19 12:25:43','YYYY-MM-DD HH24:MI:SS'),100,200968,'InventoryMoveTransactionToNotFound','D','e53062fd-d0cb-4b2e-a766-9df803078788')
;

-- Aug 22, 2025, 11:24:36 AM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2025-08-22 11:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214579
;

SELECT register_migration_script('202508221139_IDEMPIERE-6658.sql') FROM dual;
;

