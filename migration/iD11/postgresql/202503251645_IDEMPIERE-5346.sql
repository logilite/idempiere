-- IDEMPIERE-5346 Multiple SSO Login and User Identity
SELECT register_migration_script('202503251645_IDEMPIERE-5346.sql') FROM dual;

-- Mar 10, 2025, 7:34:03 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200429,'User Identity','AD_UserIdentity',0,'7',0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','6ed3ecde-460d-4010-90a8-33fb16a8a394','N','N','N','N','N','N','N')
;

-- Mar 10, 2025, 7:34:03 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserIdentity',1000000,'N','N','Table AD_UserIdentity','Y','Y',0,0,TO_TIMESTAMP('2025-03-10 19:34:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:03','YYYY-MM-DD HH24:MI:SS'),100,200519,'Y',1000000,1,200000,'605cd66f-8c29-47da-8390-6a2378880d95')
;

-- Mar 10, 2025, 7:34:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217074,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200429,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:35','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','73cd63f1-1275-4ab9-8c7d-b92f7e16fc1a','N')
;

-- Mar 10, 2025, 7:34:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217075,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200429,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:36','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','282e57f3-d22d-4457-a299-7aa410a8cbde','N')
;

-- Mar 10, 2025, 7:34:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217076,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200429,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:37','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','c5efee77-eb0c-484d-9395-f821ffbd3c5e','N')
;

-- Mar 10, 2025, 7:34:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217077,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200429,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:37','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','2d8e42ee-f03d-4942-a4f0-81a26979b61f','N')
;

-- Mar 10, 2025, 7:34:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217078,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200429,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:38','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','2b5be570-175c-4173-9341-5dafc5764244','N')
;

-- Mar 10, 2025, 7:34:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217079,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200429,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:39','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','6ceba04d-6efa-465f-9328-3ac0af8212b3','N')
;

-- Mar 10, 2025, 7:34:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217080,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200429,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:39','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','5d2cc015-5f2b-4df9-bf6f-e8e13f38f522','N')
;

-- Mar 10, 2025, 7:34:41 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203996,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:40','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserIdentity_ID','User Identity','User Identity','D','1cd58b11-6b82-4d30-a893-e25c737fab56')
;

-- Mar 10, 2025, 7:34:41 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217081,0.0,'User Identity',200429,'AD_UserIdentity_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:41','YYYY-MM-DD HH24:MI:SS'),100,203996,'N','N','D','N','d0182e60-20d1-4f8b-af00-fc00013136b4','N')
;

-- Mar 10, 2025, 7:34:42 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203997,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:41','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserIdentity_UU','AD_UserIdentity_UU','AD_UserIdentity_UU','D','a0cfdfa7-9085-49ec-8a5a-f08386cf4214')
;

-- Mar 10, 2025, 7:34:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217082,0.0,'AD_UserIdentity_UU',200429,'AD_UserIdentity_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:42','YYYY-MM-DD HH24:MI:SS'),100,203997,'Y','N','D','N','4de0716b-228f-42a6-b721-ed2030c330cc','N')
;

-- Mar 10, 2025, 7:34:44 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201283,'1dac823f-9bcb-4834-af68-a1fddb254d25',TO_TIMESTAMP('2025-03-10 19:34:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserIdentity_UU_idx',TO_TIMESTAMP('2025-03-10 19:34:43','YYYY-MM-DD HH24:MI:SS'),100,200429,'Y','Y','N','N')
;

-- Mar 10, 2025, 7:34:44 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201749,'db6a59d8-9e30-4979-b40d-7d2dfbd6ad93',TO_TIMESTAMP('2025-03-10 19:34:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-10 19:34:44','YYYY-MM-DD HH24:MI:SS'),100,217082,201283,10)
;

-- Mar 10, 2025, 7:34:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217083,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200429,'AD_User_ID',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:34:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:34:44','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','N','e097294e-0f6e-4009-966f-d12d113e49fa','N')
;

-- Mar 10, 2025, 7:38:01 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203998,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:35:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:35:31','YYYY-MM-DD HH24:MI:SS'),100,'Identity','Identity','Unique identifier used for Single Sign-On (SSO) authentication',NULL,'Identity','D','4eccbf0c-e16c-4759-8b7a-33d2614e0471')
;

-- Mar 10, 2025, 7:38:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217084,0,'Identity','Unique identifier used for Single Sign-On (SSO) authentication',200429,'Identity',60,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:38:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:38:16','YYYY-MM-DD HH24:MI:SS'),100,203998,'Y','N','D','N','N','N','Y','6afc2620-ac23-49d6-8949-5dcb71e96a27','Y',0,'N','N','N','N','N')
;

-- Mar 10, 2025, 7:38:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217085,0,'SSO Configuration',200429,'SSO_PrincipalConfig_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-03-10 19:38:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 19:38:28','YYYY-MM-DD HH24:MI:SS'),100,203653,'N','N','D','N','N','N','Y','45a3d6f6-01d0-41ec-b3fc-43cd90f75f89','Y',0,'N','N','N','N','N','N')
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217074
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217075
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET FKConstraintName='ADUser_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217083
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217077
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET FKConstraintName='SSOPrincipalConfig_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217085
;

-- Mar 10, 2025, 7:38:45 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADUserIdentity', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-10 19:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217079
;

-- Mar 10, 2025, 7:38:45 PM IST
CREATE TABLE AD_UserIdentity (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_User_ID NUMERIC(10) NOT NULL, AD_UserIdentity_ID NUMERIC(10) NOT NULL, AD_UserIdentity_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Identity VARCHAR(60) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, SSO_PrincipalConfig_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_UserIdentity_Key PRIMARY KEY (AD_UserIdentity_ID), CONSTRAINT AD_UserIdentity_UU_idx UNIQUE (AD_UserIdentity_UU))
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT ADClient_ADUserIdentity FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT ADOrg_ADUserIdentity FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT ADUser_ADUserIdentity FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT CreatedBy_ADUserIdentity FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT SSOPrincipalConfig_ADUserIdentity FOREIGN KEY (SSO_PrincipalConfig_ID) REFERENCES sso_principalconfig(sso_principalconfig_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:38:45 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT UpdatedBy_ADUserIdentity FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 10, 2025, 7:41:46 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201284,'a16070b1-6ff5-49d9-b5a6-10809ec8446d',TO_TIMESTAMP('2025-03-10 19:41:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserIdentity_sso',TO_TIMESTAMP('2025-03-10 19:41:46','YYYY-MM-DD HH24:MI:SS'),100,200429,'Y','Y','N','N','N')
;

-- Mar 10, 2025, 7:41:55 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201750,'c60936c5-11c9-4a69-a2ba-c8a429fc9c82',TO_TIMESTAMP('2025-03-10 19:41:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-10 19:41:54','YYYY-MM-DD HH24:MI:SS'),100,217074,201284,10)
;

-- Mar 10, 2025, 7:42:01 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201751,'9bfc4ab5-704d-4043-bcb2-7f9324e1c17c',TO_TIMESTAMP('2025-03-10 19:42:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-10 19:42:00','YYYY-MM-DD HH24:MI:SS'),100,217083,201284,20)
;

-- Mar 10, 2025, 7:42:12 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201752,'b23428a7-fc6a-4e7a-a63c-76fc6e6c5223',TO_TIMESTAMP('2025-03-10 19:42:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-10 19:42:11','YYYY-MM-DD HH24:MI:SS'),100,217085,201284,30)
;

-- Mar 10, 2025, 7:43:28 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT AD_UserIdentity_sso UNIQUE (AD_Client_ID,AD_User_ID,SSO_PrincipalConfig_ID)
;

-- Mar 10, 2025, 8:06:47 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords,PageSize,DetailPageSize) VALUES (200392,'User Identity',108,120,'Y',200429,0,0,'Y',TO_TIMESTAMP('2025-03-10 20:06:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:06:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','@IsShowUserIdentity@=Y','Y','N','db57f3e9-a054-49fa-b531-a01b2589451c','B','N','Y',0,0,0)
;

-- Mar 10, 2025, 8:09:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208747,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200392,217074,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','280218a3-5dae-46c2-bdfb-10903b1376c0','Y',10,2)
;

-- Mar 10, 2025, 8:09:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208748,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200392,217075,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','67c4354c-8537-4187-a01d-b321b533ddd5','Y','Y',20,4,2)
;

-- Mar 10, 2025, 8:09:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208749,'User Identity',200392,217081,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','54c4e971-9d30-49f8-a57d-4e2d954420cb','N',2)
;

-- Mar 10, 2025, 8:09:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208750,'AD_UserIdentity_UU',200392,217082,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','82436b87-44cb-499f-ac17-d0ca638066aa','N',2)
;

-- Mar 10, 2025, 8:09:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208751,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200392,217083,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f7ffce98-9350-436c-9f87-fc6a56d7c797','Y',30,2)
;

-- Mar 10, 2025, 8:09:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208752,'Identity','Unique identifier used for Single Sign-On (SSO) authentication',200392,217084,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','746d42c9-fbcd-4031-b252-209921d78cb5','Y',40,5)
;

-- Mar 10, 2025, 8:09:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208753,'SSO Configuration',200392,217085,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','efbf2cee-b0fe-476a-b786-8aa0e6173325','Y',50,2)
;

-- Mar 10, 2025, 8:09:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208754,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200392,217080,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-10 20:09:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-10 20:09:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','55245638-5d6a-4280-8668-ab80f1a8a88e','Y',60,2,2)
;

-- Mar 10, 2025, 8:09:47 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2025-03-10 20:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208754
;

-- Mar 10, 2025, 8:09:47 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2025-03-10 20:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208752
;

-- Mar 10, 2025, 8:09:47 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-03-10 20:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208750
;

-- Mar 10, 2025, 8:09:47 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-03-10 20:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208749
;

-- Mar 10, 2025, 8:10:02 PM IST
UPDATE AD_Tab SET AD_Column_ID=217083, MaxQueryRecords=1,Updated=TO_TIMESTAMP('2025-03-10 20:10:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200392
;

-- Mar 10, 2025, 8:14:14 PM IST
UPDATE AD_Tab SET DisplayLogic='@#IsShowUserIdentity@=Y',Updated=TO_TIMESTAMP('2025-03-10 20:14:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200392
;

-- Mar 11, 2025, 3:29:51 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201286,'48f382f8-e5bd-48e7-9d0c-e81c4f456217',TO_TIMESTAMP('2025-03-11 15:29:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserIdentity_SSO_Identity',TO_TIMESTAMP('2025-03-11 15:29:50','YYYY-MM-DD HH24:MI:SS'),100,200429,'Y','Y','N','N','N')
;

-- Mar 11, 2025, 3:29:57 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201755,'d8af86dd-33dd-423a-b45f-f43f4a017425',TO_TIMESTAMP('2025-03-11 15:29:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-11 15:29:56','YYYY-MM-DD HH24:MI:SS'),100,217085,201286,10)
;

-- Mar 11, 2025, 3:30:08 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201756,'510dd6c2-cb8a-4ab0-9262-7217afd6a8a5',TO_TIMESTAMP('2025-03-11 15:30:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-03-11 15:30:07','YYYY-MM-DD HH24:MI:SS'),100,217084,201286,20)
;

-- Mar 11, 2025, 3:30:18 PM IST
ALTER TABLE AD_UserIdentity ADD CONSTRAINT AD_UserIdentity_SSO_Identity UNIQUE (SSO_PrincipalConfig_ID,Identity)
;

