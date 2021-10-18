-- IDEMPIERE-3413 Implement multi-select support in the info window
-- Oct 11, 2021 2:29:34 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200522,'IN',200061,'<<<',0,0,'Y',TO_TIMESTAMP('2021-10-11 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-11 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,'D','8ec827fb-e992-49eb-bddf-69dc96d09b5f')
;

-- Oct 11, 2021 2:30:03 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200523,'HAVE',200061,'>>>',0,0,'Y',TO_TIMESTAMP('2021-10-11 14:30:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-11 14:30:02','YYYY-MM-DD HH24:MI:SS'),100,'D','60db1f45-548f-4e34-9ba9-7df42721b447')
;

-- Oct 11, 2021 2:30:31 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200524,'OVERLAP',200061,'&&',0,0,'Y',TO_TIMESTAMP('2021-10-11 14:30:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-11 14:30:30','YYYY-MM-DD HH24:MI:SS'),100,'D','93b92440-3e5a-4a49-85a3-40525da95987')
;

-- Oct 11, 2021 2:30:53 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200525,'EXCLUDE',200061,'-&&',0,0,'Y',TO_TIMESTAMP('2021-10-11 14:30:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-11 14:30:52','YYYY-MM-DD HH24:MI:SS'),100,'D','6ffb0740-c1b2-4ef6-8933-06bb2cf71e15')
;

-- Oct 11, 2021 2:32:05 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200152,'Info Query Operators','S','(( AD_Ref_List.Value IN (''='', ''!='', ''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ IN (200138, 200139)) OR ( AD_Ref_List.Value NOT IN (''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ NOT IN (200138, 200139))) AND  AD_Reference_ID=200061',0,0,'Y',TO_TIMESTAMP('2021-10-11 14:32:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-11 14:32:04','YYYY-MM-DD HH24:MI:SS'),100,'D','471ae812-7063-448a-b050-0ec1f3f53f84')
;

-- Oct 11, 2021 2:32:14 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200152,Updated=TO_TIMESTAMP('2021-10-11 14:32:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208363
;

-- Oct 11, 2021 2:35:33 PM IST
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y & @AD_Reference_ID@!200138 & @AD_Reference_ID@!200139 & @AD_Reference_ID@!200161 & @AD_Reference_ID@!200162 & @AD_Reference_ID@!200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-11 14:35:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Oct 11, 2021 2:37:24 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-11 14:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Oct 11, 2021 2:38:07 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-11 14:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

ALTER TABLE T_Selection_InfoWindow ADD COLUMN VALUE_NUMBER_ARRAY NUMERIC(10)[] DEFAULT NULL 
;

ALTER TABLE T_Selection_InfoWindow ADD COLUMN VALUE_STRING_ARRAY VARCHAR(30)[] DEFAULT NULL 
;

SELECT register_migration_script('202110121100_IDEMPIERE-3413_InfoWindow.sql') FROM dual
;
