SET SQLBLANKLINES ON
SET DEFINE OFF

-- Create some missing messages
-- May 7, 2020 7:13:07 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Opportunity Name',0,0,'Y',TO_DATE('2020-05-07 19:13:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:13:06','YYYY-MM-DD HH24:MI:SS'),100,200603,'OpportunityName','D','3c05fead-2c09-4b0b-9440-b7d2aaa8d68d')
;

-- May 7, 2020 7:13:29 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','New Lead',0,0,'Y',TO_DATE('2020-05-07 19:13:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:13:28','YYYY-MM-DD HH24:MI:SS'),100,200604,'LeadNew','D','ac7edf3e-5179-43d2-9e21-8a0ce9410b87')
;

-- May 7, 2020 7:14:15 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Next Step',0,0,'Y',TO_DATE('2020-05-07 19:14:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:14:14','YYYY-MM-DD HH24:MI:SS'),100,200605,'NextStep','D','db7eb312-06ee-4d4e-b95e-5222428d6296')
;

-- May 7, 2020 7:14:46 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','New Opportunity',0,0,'Y',TO_DATE('2020-05-07 19:14:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:14:45','YYYY-MM-DD HH24:MI:SS'),100,200606,'OpportunityNew','D','792d1dca-4de0-4c8e-9cb4-caf9f465c976')
;

-- May 7, 2020 7:15:10 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Select Lead',0,0,'Y',TO_DATE('2020-05-07 19:15:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:15:09','YYYY-MM-DD HH24:MI:SS'),100,200607,'SelectLead','D','50cdd18e-6982-4e2f-8f10-792cecadf6b8')
;

-- May 7, 2020 7:15:41 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Down',0,0,'Y',TO_DATE('2020-05-07 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,200608,'MoveDown','D','525bf4d4-5ce3-4a7d-9081-2e3b96708cf1')
;

-- May 7, 2020 7:16:04 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Up',0,0,'Y',TO_DATE('2020-05-07 19:16:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:03','YYYY-MM-DD HH24:MI:SS'),100,200609,'MoveUp','D','bdf56785-ce50-49ce-a2c5-d20a1a08ec96')
;

-- May 7, 2020 7:16:17 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Left',0,0,'Y',TO_DATE('2020-05-07 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,200610,'MoveLeft','D','f0082f8f-7ecf-4682-9ee2-593b6b21fe41')
;

-- May 7, 2020 7:16:31 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Right',0,0,'Y',TO_DATE('2020-05-07 19:16:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:30','YYYY-MM-DD HH24:MI:SS'),100,200611,'MoveRight','D','0d2f8a50-350d-43c5-9629-64c3a6ea88d1')
;

-- May 7, 2020 7:29:02 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Contact Person',0,0,'Y',TO_DATE('2020-05-07 19:29:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:29:01','YYYY-MM-DD HH24:MI:SS'),100,200612,'ContactPerson','D','c869c814-6453-4949-ac3d-11069c514328')
;

SELECT register_migration_script('202005071900_MissingMessages.sql') FROM dual
;
