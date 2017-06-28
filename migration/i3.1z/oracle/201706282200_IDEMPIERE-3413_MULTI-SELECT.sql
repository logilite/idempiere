SET SQLBLANKLINES ON
SET DEFINE OFF

-- Multi Select Table and Multi Select List Editor
-- Jun 28, 2017 12:27:45 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200138,'Multi Select Table','Multiple selection among given reference list items from the table','D',0,0,'Y',TO_DATE('2017-06-28 12:27:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-06-28 12:27:44','YYYY-MM-DD HH24:MI:SS'),100,'D','N','8c04f3ef-dbd2-435f-a049-4ea266272ee4')
;

-- Jun 28, 2017 12:29:12 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200139,'Multi Select List','Multiple selection among given reference list items from the List','D',0,0,'Y',TO_DATE('2017-06-28 12:29:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-06-28 12:29:12','YYYY-MM-DD HH24:MI:SS'),100,'D','N','1e4b763f-80df-4701-9465-38db75be1f5f')
;

-- Jun 28, 2017 12:41:04 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-06-28 12:41:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Jun 28, 2017 12:41:57 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-06-28 12:41:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Jun 28, 2017 12:49:04 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200138 & @AD_Reference_ID@!200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-06-28 12:49:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=161
;

-- Jun 28, 2017 12:49:59 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200138 & @AD_Reference_ID@!200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-06-28 12:49:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=162
;

-- Jun 28, 2017 12:50:35 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200138 & @AD_Reference_ID@!200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-06-28 12:50:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

-- Jun 28, 2017 7:45:35 PM IST
UPDATE AD_Val_Rule SET Code='AD_Reference.ValidationType=CASE WHEN  @AD_Reference_ID@ IN (17,28,200139) THEN ''L'' ELSE ''T'' END',Updated=TO_DATE('2017-06-28 19:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=115
;

-- Jun 28, 2017 9:16:51 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','(Please Select)',0,0,'Y',TO_DATE('2017-06-28 21:16:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-06-28 21:16:50','YYYY-MM-DD HH24:MI:SS'),100,200426,'PleaseSelect','D','4475363d-8d51-406a-aa0c-2583479dfd87')
;

SELECT register_migration_script('201706282200_IDEMPIERE-3413_MULTI-SELECT.sql') FROM dual
;
