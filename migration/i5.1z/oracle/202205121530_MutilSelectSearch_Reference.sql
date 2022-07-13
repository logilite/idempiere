SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add new Multi-select Search Reference type
-- May 12, 2022 3:34:10 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200205,'Multi Select Search','Multiple selection among given reference list items from the search dialog','D',0,0,'Y',TO_DATE('2022-05-12 15:34:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-05-12 15:34:09','YYYY-MM-DD HH24:MI:SS'),100,'D','N','7b5992be-d0cb-4aa1-8b11-084ddfc54132')
;

-- May 12, 2022 6:19:15 PM IST
UPDATE AD_Field SET DisplayLogic= DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:19:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206129
;

-- May 12, 2022 6:23:33 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' & @AD_Reference_ID@!200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:23:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11264
;

-- May 12, 2022 6:24:11 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:24:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- May 12, 2022 6:24:30 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:24:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206091
;

-- May 12, 2022 6:24:48 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- May 12, 2022 6:25:36 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' & @AD_Reference_ID@!200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:25:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=162
;

-- May 12, 2022 6:25:44 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' & @AD_Reference_ID@!200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:25:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=161
;

-- May 12, 2022 6:26:16 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' & @AD_Reference_ID@!200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:26:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

-- May 12, 2022 6:44:08 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic=MandatoryLogic || ' | @AD_Reference_ID@=200205', IsToolbarButton=NULL,Updated=TO_DATE('2022-05-12 18:44:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- May 16, 2022 9:56:38 AM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' & @AD_Reference_ID@!200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-16 09:56:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2544
;

-- May 16, 2022 11:08:42 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-16 23:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- May 16, 2022 11:09:04 PM IST
UPDATE AD_Field SET DisplayLogic=DisplayLogic || ' | @AD_Reference_ID@=200205', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-05-16 23:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

SELECT register_migration_script('202205121530_MutilSelectSearch_Reference.sql') FROM dual
;