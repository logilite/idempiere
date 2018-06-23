-- CSV Import Enhancement 
-- May 14, 2018 5:22:50 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Fail to Import ERROR_COUNT records out of TOTAL_COUNT',0,0,'Y',TO_TIMESTAMP('2018-05-14 17:22:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-05-14 17:22:49','YYYY-MM-DD HH24:MI:SS'),100,200470,'DataImportErrorMessage','U','36ff33b0-ed64-423d-bbeb-6f9ec467f32e')
;

SELECT register_migration_script('201805141735_CSV_Import_Enhancement.sql') FROM dual
;
