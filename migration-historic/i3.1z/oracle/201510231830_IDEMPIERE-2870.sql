SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 21, 2015 4:07:30 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200182,'ContactActivity Attendees','C_ContactActivity_Attendees',0,'3',0,0,'Y',TO_DATE('2015-10-21 16:07:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:07:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','42cdead6-bbf8-499c-aa7f-4b0b3c078a08','N','N')
;

-- Oct 21, 2015 4:07:31 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_ContactActivity_Attendees',1000000,'N','N','Table C_ContactActivity_Attendees','Y','Y',0,0,TO_DATE('2015-10-21 16:07:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:07:30','YYYY-MM-DD HH24:MI:SS'),100,200239,'Y',1000000,1,200000,'89791055-5c7e-4fb5-8134-1c8b82ca6eeb')
;

-- Oct 21, 2015 4:07:46 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212320,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200182,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-21 16:07:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:07:45','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','1e84b797-7b91-4c15-acc0-ea7485e2d52d','N',0,'N','N')
;

-- Oct 21, 2015 4:07:55 PM IST
UPDATE AD_Column SET FKConstraintName='ADClient_CContactActivityAtten', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212320
;

-- Oct 21, 2015 4:07:55 PM IST
CREATE TABLE C_ContactActivity_Attendees (AD_Client_ID NUMBER(10) DEFAULT NULL )
;

-- Oct 21, 2015 4:07:55 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT ADClient_CContactActivityAtten FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2015 4:08:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212321,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200182,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-21 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','89bc5d53-8442-4069-a722-3f23da2ff3a3','N',0,'N','N')
;

-- Oct 21, 2015 4:08:21 PM IST
UPDATE AD_Column SET FKConstraintName='ADOrg_CContactActivityAttendee', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:08:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212321
;

-- Oct 21, 2015 4:08:21 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:08:21 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT ADOrg_CContactActivityAttendee FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2015 4:08:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212322,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200182,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-10-21 16:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:08:36','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','e212a095-a4ec-4d3f-aff0-c0dd46c06394','N',0,'N','N')
;

-- Oct 21, 2015 4:08:45 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD Created DATE DEFAULT SYSDATE
;

-- Oct 21, 2015 4:09:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212323,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200182,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-10-21 16:09:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:09:04','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','642cce33-f02e-48e6-acc3-1c2e1c120a7a','N',0,'N','N')
;

-- Oct 21, 2015 4:09:16 PM IST
UPDATE AD_Column SET FKConstraintName='CreatedBy_CContactActivityAtte', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212323
;

-- Oct 21, 2015 4:09:16 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CreatedBy NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:09:16 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT CreatedBy_CContactActivityAtte FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2015 4:09:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212324,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200182,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-10-21 16:09:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:09:34','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','feac6849-fc87-4db2-a4bf-210e775c9f14','N',0,'N','N')
;

-- Oct 21, 2015 4:09:41 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD Updated DATE DEFAULT SYSDATE
;

-- Oct 21, 2015 4:09:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212325,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200182,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-10-21 16:09:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:09:57','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','44f2f75f-a257-4726-8663-10d48f72c27c','N',0,'N','N')
;

-- Oct 21, 2015 4:10:05 PM IST
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CContactActivityAtte', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212325
;

-- Oct 21, 2015 4:10:05 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD UpdatedBy NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:10:06 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT UpdatedBy_CContactActivityAtte FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2015 4:10:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212326,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200182,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-21 16:10:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:10:23','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','b6388186-f6c4-48c6-ac9b-e8495d4b061e','N',0,'N','N')
;

-- Oct 21, 2015 4:10:27 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- Oct 21, 2015 4:11:20 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202919,0,0,'Y',TO_DATE('2015-10-21 16:11:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:11:19','YYYY-MM-DD HH24:MI:SS'),100,'C_ContactActivity_Attendees_ID','C_ContactActivity_Attendees_ID','C_ContactActivity_Attendees_ID','D','02362746-73fa-419f-b48e-f24aea186505')
;

-- Oct 21, 2015 4:11:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212327,0,'C_ContactActivity_Attendees_ID',200182,'C_ContactActivity_Attendees_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_DATE('2015-10-21 16:11:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:11:34','YYYY-MM-DD HH24:MI:SS'),100,202919,'N','N','D','N','N','N','Y','8a088009-7653-4fe0-af5f-a3cf3a603e44','N',0,'N','N')
;

-- Oct 21, 2015 4:11:37 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD C_ContactActivity_Attendees_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:11:37 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT C_ContactActivity_Attendee_Key PRIMARY KEY (C_ContactActivity_Attendees_ID)
;

-- Oct 21, 2015 4:11:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212328,0,'Contact Activity','Events, tasks, communications related to a contact',200182,'C_ContactActivity_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-21 16:11:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:11:58','YYYY-MM-DD HH24:MI:SS'),100,55353,'N','N','D','N','N','N','Y','1116ea8e-e796-4030-9b5c-104784f8181f','Y',0,'N','N')
;

-- Oct 21, 2015 4:12:08 PM IST
UPDATE AD_Column SET FKConstraintName='CContactActivity_CContactActiv', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212328
;

-- Oct 21, 2015 4:12:08 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD C_ContactActivity_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:12:08 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT CContactActivity_CContactActiv FOREIGN KEY (C_ContactActivity_ID) REFERENCES c_contactactivity(c_contactactivity_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2015 4:12:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212329,0,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200182,'SalesRep_ID',22,'N','N','N','N','N',0,'N',18,190,0,0,'Y',TO_DATE('2015-10-21 16:12:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:12:25','YYYY-MM-DD HH24:MI:SS'),100,1063,'N','N','D','N','N','N','Y','2d1b6fc1-5035-4cb9-8964-068a57fe558d','Y',0,'N','N')
;

-- Oct 21, 2015 4:12:28 PM IST
UPDATE AD_Column SET FKConstraintName='SalesRep_CContactActivityAtten', FKConstraintType='N',Updated=TO_DATE('2015-10-21 16:12:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212329
;

-- Oct 21, 2015 4:12:28 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD SalesRep_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2015 4:12:28 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT SalesRep_CContactActivityAtten FOREIGN KEY (SalesRep_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;


-- Oct 21, 2015 4:14:48 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Attendees',0,0,'Y',TO_DATE('2015-10-21 16:14:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-21 16:14:47','YYYY-MM-DD HH24:MI:SS'),100,200360,'Attendees','D','1f2e5252-4bf2-499e-bc67-504347312668')
;

SELECT register_migration_script('201510231830_IDEMPIERE-2870.sql') FROM dual
;
