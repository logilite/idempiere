-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Sep 26, 2015 6:55:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212249,0,'Content Color','Content color of calendar dashlet',581,'ContentColor',7,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2015-09-26 18:55:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 18:55:31','YYYY-MM-DD HH24:MI:SS'),100,200078,'Y','N','D','N','N','N','Y','e25f6c03-13a2-4697-9a2d-7458bb91eeb7','Y',0,'N','N')
;

-- Sep 26, 2015 6:55:42 PM IST
ALTER TABLE S_TimeType ADD COLUMN ContentColor VARCHAR(7) DEFAULT NULL 
;

-- Sep 26, 2015 6:56:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212250,0,'Header Color','Header color of calendar dashlet',581,'HeaderColor',7,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2015-09-26 18:56:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 18:56:48','YYYY-MM-DD HH24:MI:SS'),100,200077,'Y','N','D','N','N','N','Y','cff3226d-07e8-46f3-965e-a744d3f45812','Y',0,'N','N')
;

-- Sep 26, 2015 7:13:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203868,'Content Color','Content color of calendar dashlet',495,212249,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:13:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:13:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','52aec245-74e4-4242-a2e4-d7f555020a8c','Y',80,1,1,1,'N','N','N')
;

-- Sep 26, 2015 7:15:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203869,'Header Color','Header color of calendar dashlet',495,212250,'Y',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:15:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:15:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8492bf0-b07b-41c2-be1c-c672b9d35fdf','Y',90,1,1,1,'N','N','N')
;

-- Sep 26, 2015 7:19:29 PM IST
--INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203870,'S_TimeType_UU',495,61042,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:19:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:19:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0267ac70-6570-4b02-8182-95a90fbf4a17','N',2)
--;

-- Sep 26, 2015 7:20:39 PM IST
ALTER TABLE S_TimeType ADD COLUMN HeaderColor VARCHAR(7) DEFAULT NULL 
;

-- Sep 26, 2015 7:21:43 PM IST
INSERT INTO t_alter_column values('s_timetype','ContentColor','VARCHAR(7)',null,'NULL')
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=6835
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=6833
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=6831
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=6832
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=6830
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=6836
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=203870
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=6834
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=203868
;

-- Sep 26, 2015 7:24:37 PM IST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=203869
;

-- Sep 26, 2015 7:25:08 PM IST
UPDATE AD_Field SET SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2015-09-26 19:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203870
;

-- Sep 26, 2015 7:31:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212251,0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',53354,'C_Project_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2015-09-26 19:31:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:31:58','YYYY-MM-DD HH24:MI:SS'),100,208,'Y','N','D','N','N','N','Y','126fdb62-dae9-47d2-ac8c-f9091cc9f4a7','Y',0,'N','N','N')
;

-- Sep 26, 2015 7:32:21 PM IST
UPDATE AD_Column SET FKConstraintName='CProject_CContactActivity', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-09-26 19:32:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212251
;

-- Sep 26, 2015 7:32:21 PM IST
ALTER TABLE C_ContactActivity ADD COLUMN C_Project_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 26, 2015 7:32:21 PM IST
ALTER TABLE C_ContactActivity ADD CONSTRAINT CProject_CContactActivity FOREIGN KEY (C_Project_ID) REFERENCES c_project(c_project_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 26, 2015 7:45:05 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202906,0,0,'Y',TO_TIMESTAMP('2015-09-26 19:45:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:45:03','YYYY-MM-DD HH24:MI:SS'),100,'C_ContactActivityRelatedTo','Related To','Related To','D','730952d3-c663-4b15-9d11-de2f66139321')
;

-- Sep 26, 2015 7:50:25 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200107,'C_ContactActivity Related To','Contact Activity Related To','L',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:50:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:50:24','YYYY-MM-DD HH24:MI:SS'),100,'D','N','2cf8d236-87b3-46c0-8476-4fc1d6ca4a05')
;

-- Sep 26, 2015 7:53:12 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200312,'Contact',200107,'CO',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:53:11','YYYY-MM-DD HH24:MI:SS'),100,'D','c8fde19c-9613-436f-9f22-b955859120df')
;

-- Sep 26, 2015 7:54:20 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200313,'Lead',200107,'LE',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:54:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:54:19','YYYY-MM-DD HH24:MI:SS'),100,'D','e61c4837-ebe9-43c0-aeba-17946ae196d3')
;

-- Sep 26, 2015 7:55:27 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200314,'Sales Opportunity',200107,'SO',0,0,'Y',TO_TIMESTAMP('2015-09-26 19:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:55:26','YYYY-MM-DD HH24:MI:SS'),100,'D','f3678cbf-21cd-49fe-b128-49d2772ec962')
;

-- Sep 26, 2015 7:59:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212252,0,'Related To',53354,'C_ContactActivityRelatedTo',2,'N','N','N','N','N',0,'N',17,200107,0,0,'Y',TO_TIMESTAMP('2015-09-26 19:59:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-26 19:59:56','YYYY-MM-DD HH24:MI:SS'),100,202906,'Y','N','D','Y','N','N','Y','447458d7-6948-412c-b46f-f2a44160ca24','Y',0,'N','N')
;

ALTER TABLE C_ContactActivity ADD COLUMN C_ContactActivityRelatedTo VARCHAR(2) DEFAULT NULL;

INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Create Activity',0,0,'Y',TO_TIMESTAMP('2015-09-29 18:39:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-29 18:39:17','YYYY-MM-DD HH24:MI:SS'),100,523854,'ActivityNew','D','1b2aff9d-0398-45fc-b164-8a21d1f45b8d')
;

-- Sep 29, 2015 6:39:38 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Assign Resource',0,0,'Y',TO_TIMESTAMP('2015-09-29 18:39:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-29 18:39:38','YYYY-MM-DD HH24:MI:SS'),100,523855,'ResourceAssignemntNew','D','e850e156-c9c1-4127-b64b-7b6d9a8fc517')
;

INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Create Request',0,0,'Y',TO_TIMESTAMP('2015-09-29 18:51:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-29 18:51:01','YYYY-MM-DD HH24:MI:SS'),100,523856,'CreateNew2','D','7f4eaae4-ae17-4489-b248-38650a101f62')
;

INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Activity',0,0,'Y',TO_TIMESTAMP('2015-09-29 19:03:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-29 19:03:45','YYYY-MM-DD HH24:MI:SS'),100,523858,'Activity','D','176bf41c-7f9a-4166-9c47-e2818be55592')
;

INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Request',0,0,'Y',TO_TIMESTAMP('2015-09-29 19:26:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-29 19:26:43','YYYY-MM-DD HH24:MI:SS'),100,523859,'NewRequest','D','8c814142-c9ab-47c0-abfa-a93414a3c4a9')
;

SELECT register_migration_script('201509301100_IDEMPIERE-2870.sql') FROM dual
;
