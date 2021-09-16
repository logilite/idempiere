-- IDEMPIERE-4157 Message for QuickFormPaste
-- Sep 15, 2021, 11:55:34 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Paste clipboard data in form ( Alt+V )',0,0,'Y',TO_TIMESTAMP('2021-09-15 23:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-15 23:55:33','YYYY-MM-DD HH24:MI:SS'),100,200718,'QuickFormPaste','D','9732798d-beb0-4b75-b134-01ed793c4f2c')
;

-- Sep 15, 2021, 11:59:37 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Paste clipboard data to insert in the form',0,0,'Y',TO_TIMESTAMP('2021-09-15 23:59:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-15 23:59:36','YYYY-MM-DD HH24:MI:SS'),100,200719,'PasteInForm','D','7d3c84d6-8938-4517-881d-e366ab1a2916')
;

SELECT register_migration_script('202109160100_IDEMPIERE-4157.sql') FROM dual
;