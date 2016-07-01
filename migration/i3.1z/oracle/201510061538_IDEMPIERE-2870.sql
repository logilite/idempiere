SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 5, 2015 6:01:30 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Contact Activity Type',0,0,'Y',TO_DATE('2015-10-05 18:01:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-05 18:01:29','YYYY-MM-DD HH24:MI:SS'),100,200356,'ContactActivityType','D','7cdcb19a-cf26-41cf-871e-c8820aa5b040')
;

-- Oct 5, 2015 6:01:51 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Resource',0,0,'Y',TO_DATE('2015-10-05 18:01:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-05 18:01:50','YYYY-MM-DD HH24:MI:SS'),100,200357,'S_Resource_ID','D','03805628-7c52-4b6e-88bf-886900300407')
;

-- Oct 5, 2015 6:02:04 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Show Resource',0,0,'Y',TO_DATE('2015-10-05 18:02:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-05 18:02:03','YYYY-MM-DD HH24:MI:SS'),100,200358,'ShowResource','D','716d3338-cd92-4fe0-b788-1390edaf1610')
;

SELECT register_migration_script('201510061538_IDEMPIERE-2870') FROM dual
;


