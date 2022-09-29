SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5346 SSO Support
-- Sep 19, 2022, 3:49:07 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The user has no access',0,0,'Y',TO_DATE('2022-09-19 15:49:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-09-19 15:49:05','YYYY-MM-DD HH24:MI:SS'),100,200784,'UserNoRoleError','D','241a07d4-4b46-4666-b7a9-277edbcdefa5')
;

-- Sep 19, 2022, 3:49:32 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','User not found',0,0,'Y',TO_DATE('2022-09-19 15:49:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-09-19 15:49:31','YYYY-MM-DD HH24:MI:SS'),100,200785,'UserNotFoundError','D','64499310-0505-4cc3-8089-b6e64011d99a')
;

SELECT register_migration_script('202209191900_IDEMPIERE-5346.sql') FROM dual
;