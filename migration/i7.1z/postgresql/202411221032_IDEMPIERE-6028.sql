-- IDEMPIERE-6028 : Overriding workflow responsible
-- 21-Nov-2024, 4:22:37 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The workflow configuration is incomplete, the responsible "{0}" must be overridden in tenant',0,0,'Y',TO_TIMESTAMP('2024-11-21 16:22:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-21 16:22:36','YYYY-MM-DD HH24:MI:SS'),100,200912,'IncompeteWorkflowResponsible','D','d8ef68ec-492c-4ee1-87a1-da65413197ce')
;

SELECT register_migration_script('202411221032_IDEMPIERE-6028.sql') FROM dual
;