SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2840 : Tokens for login into web services
-- Oct 10, 2015 10:49:50 AM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200179,'AD_AuthorizationToken','AD_AuthorizationToken',0,'6',0,0,'Y',TO_DATE('2015-10-10 10:49:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 10:49:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','cc40d4b3-f26d-4481-ae1b-22663f236d9d','N','N')
;

-- Oct 10, 2015 10:49:50 AM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AuthorizationToken',1000000,'N','N','Table AD_AuthorizationToken','Y','Y',0,0,TO_DATE('2015-10-10 10:49:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 10:49:50','YYYY-MM-DD HH24:MI:SS'),100,200234,'Y',1000000,1,200000,'0b51ea62-fa88-4330-9702-e23071fd8038')
;

-- Oct 10, 2015 10:56:38 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212277,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200179,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-10 10:56:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 10:56:37','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','U','N','N','N','Y','93509e08-4a86-4ad6-8c6b-70572412dec1','N',0,'N','N','D')
;

-- Oct 10, 2015 10:57:52 AM IST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2015-10-10 10:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212277
;

-- Oct 10, 2015 11:07:59 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212278,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200179,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2015-10-10 11:07:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:07:58','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','N','N','Y','411721e7-465a-4390-a6bf-e45d5bf0f405','Y',0,'N','N')
;

-- Oct 10, 2015 11:12:10 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212279,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200179,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-10-10 11:12:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:12:10','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','025c5432-f7b3-412e-a739-2fa3a1b0461b','N',0,'N','N')
;

-- Oct 10, 2015 11:14:03 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212280,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200179,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-10-10 11:14:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:14:03','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','bf961310-9b75-4451-b246-0efde7f75300','N',0,'N','N','D')
;

-- Oct 10, 2015 11:14:36 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212281,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200179,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-10-10 11:14:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:14:36','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','53189b91-8d27-47a5-b826-24797ada8331','N',0,'N','N')
;

-- Oct 10, 2015 11:15:31 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212282,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200179,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-10-10 11:15:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:15:31','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','aa962acd-3dbe-40cc-a7c7-b4c5d7870150','N',0,'N','N','D')
;

-- Oct 10, 2015 11:18:38 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212283,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200179,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-10 11:18:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:18:37','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','8d3cd19d-c1af-40bd-82cc-90d562a5be2e','N',0,'N','N')
;

-- Oct 10, 2015 11:21:22 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212284,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200179,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-10 11:21:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:21:21','YYYY-MM-DD HH24:MI:SS'),100,123,'N','N','D','N','N','N','Y','d2a4af2f-8cd4-4b39-ac9d-f856a553ff97','Y',0,'N','N','C')
;

-- Oct 10, 2015 11:22:47 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212285,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200179,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-10 11:22:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:22:46','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','N','N','Y','5ff2043e-036c-4924-989a-735e7a65b8a2','Y',0,'N','N')
;

-- Oct 10, 2015 11:26:42 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202910,0,0,'Y',TO_DATE('2015-10-10 11:26:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:26:41','YYYY-MM-DD HH24:MI:SS'),100,'Token','Token','Token','D','3a8b430b-0ee9-47bc-9bcd-43037134e8ce')
;

-- Oct 10, 2015 11:31:42 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212286,0,'Token',200179,'Token',50,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-10-10 11:31:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:31:42','YYYY-MM-DD HH24:MI:SS'),100,202910,'Y','N','D','N','N','N','Y','12caa13d-8ffa-4538-83d7-9ed0a19a06ed','Y',0,'N','N')
;

-- Oct 10, 2015 11:32:29 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202911,0,0,'Y',TO_DATE('2015-10-10 11:32:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:32:28','YYYY-MM-DD HH24:MI:SS'),100,'isWebservice','isWebservice','isWebservice','D','245edac5-5fa7-43c3-94f0-995890820434')
;

-- Oct 10, 2015 11:36:36 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212287,0,'isWebservice',200179,'isWebservice','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-10 11:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:36:36','YYYY-MM-DD HH24:MI:SS'),100,202911,'Y','N',NULL,'D','N','N','N','Y','e75313e5-b6b6-4f3f-9c17-b1292e530893','Y',0,'N','N')
;

-- Oct 10, 2015 11:38:16 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202912,0,0,'Y',TO_DATE('2015-10-10 11:38:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:38:15','YYYY-MM-DD HH24:MI:SS'),100,'ValidForSameClient','ValidForSameClient','ValidForSameClient','D','1fe598fc-393c-421c-a691-be7782a3774f')
;

-- Oct 10, 2015 11:38:35 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202913,0,0,'Y',TO_DATE('2015-10-10 11:38:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:38:34','YYYY-MM-DD HH24:MI:SS'),100,'LastAccessTime','LastAccessTime','LastAccessTime','D','ecb10591-9723-4721-9c4c-3b79b24921c4')
;

-- Oct 10, 2015 11:39:26 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202914,0,0,'Y',TO_DATE('2015-10-10 11:39:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:39:26','YYYY-MM-DD HH24:MI:SS'),100,'TimeOutMins','Timeout in Minutes','Timeout in Minutes','D','ed766148-0f50-4b9c-b87d-bdf3d3d29037')
;

-- Oct 10, 2015 11:39:53 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202915,0,0,'Y',TO_DATE('2015-10-10 11:39:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:39:52','YYYY-MM-DD HH24:MI:SS'),100,'RemoteIP','Remote IP','Remote IP','D','c3d008ea-4f59-462c-9b44-3b88f5d595d6')
;

-- Oct 10, 2015 11:45:19 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212288,0,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200179,'IsManual','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-10 11:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:45:18','YYYY-MM-DD HH24:MI:SS'),100,1474,'Y','N','D','N','N','N','Y','1204a6aa-0958-487b-82a8-7963ec90cb7d','Y',0,'N','N')
;

-- Oct 10, 2015 11:49:34 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212289,0,'ValidForSameClient',200179,'ValidForSameClient','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-10 11:49:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:49:30','YYYY-MM-DD HH24:MI:SS'),100,202912,'Y','N','D','N','N','N','Y','8ea8a772-f7b0-464d-bbcd-5d771231ed09','Y',0,'N','N')
;

-- Oct 10, 2015 11:52:48 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212290,0,'LastAccessTime',200179,'LastAccessTime',22,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-10-10 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,202913,'Y','N','D','N','N','N','Y','7a01d5d5-a0f9-4715-95fa-f5627dcba605','Y',0,'N','N')
;

-- Oct 10, 2015 11:54:01 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212291,0,'Valid to','Valid to including this date (last day)','The Valid To date indicates the last day of a date range',200179,'ValidTo',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_DATE('2015-10-10 11:54:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:54:01','YYYY-MM-DD HH24:MI:SS'),100,618,'Y','N','D','N','N','N','Y','ddad2ae5-cdb3-4da2-83fa-d528a2c8ec65','Y',0,'N','N')
;

-- Oct 10, 2015 11:55:51 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212292,0,'Timeout in Minutes',200179,'TimeOutMins',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2015-10-10 11:55:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:55:50','YYYY-MM-DD HH24:MI:SS'),100,202914,'Y','N','D','N','N','N','Y','3308bcbb-6b15-4cc3-b1e3-51a8a69b6e79','Y',0,'N','N')
;

-- Oct 10, 2015 11:57:34 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212293,0,'Remote IP',200179,'RemoteIP',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-10-10 11:57:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:57:33','YYYY-MM-DD HH24:MI:SS'),100,202915,'Y','N','D','N','N','N','Y','fa294370-c069-464a-8be1-522e333f6c1a','Y',0,'N','N')
;

-- Oct 10, 2015 11:58:49 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212294,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200179,'AD_Language',6,'N','N','N','N','N',0,'N',18,106,0,0,'Y',TO_DATE('2015-10-10 11:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 11:58:48','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','N','N','Y','f498dd7e-5cba-4677-bc7f-180cca1fc942','Y',0,'N','N','N')
;

-- Oct 10, 2015 12:01:08 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202916,0,0,'Y',TO_DATE('2015-10-10 12:01:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 12:01:07','YYYY-MM-DD HH24:MI:SS'),100,'AD_AuthorizationToken_ID','AD_AuthorizationToken_ID','AD_AuthorizationToken_ID','D','b66d944a-641c-4ab3-b327-e1d109f3f319')
;

-- Oct 10, 2015 12:02:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212295,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200179,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-10-10 12:02:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 12:02:42','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','72890b07-aef1-475e-9c32-54cb0459eb8c','N',0,'N','N','D')
;

-- Oct 10, 2015 12:04:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212296,0,'AD_AuthorizationToken_ID',200179,'AD_AuthorizationToken_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2015-10-10 12:04:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-10 12:04:27','YYYY-MM-DD HH24:MI:SS'),100,202916,'N','N','D','N','N','N','Y','667b40b7-1b7b-45c1-9438-2ed3b83cd726','N',0,'N','N')
;

-- Oct 10, 2015 12:10:27 PM IST
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200000, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200000)
;

-- Oct 10, 2015 12:10:28 PM IST
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADAuthorizationToke', FKConstraintType='N',Updated=TO_DATE('2015-10-10 12:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212294
;

-- Oct 10, 2015 12:10:28 PM IST
UPDATE AD_Column SET FKConstraintName='ADRole_ADAuthorizationToken', FKConstraintType='C',Updated=TO_DATE('2015-10-10 12:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212284
;

-- Oct 10, 2015 12:10:28 PM IST
UPDATE AD_Column SET FKConstraintName='ADUser_ADAuthorizationToken', FKConstraintType='N',Updated=TO_DATE('2015-10-10 12:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212278
;

-- Oct 10, 2015 12:10:28 PM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_ADAuthorizationToke', FKConstraintType='N',Updated=TO_DATE('2015-10-10 12:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212285
;

-- Oct 10, 2015 12:10:28 PM IST
CREATE TABLE AD_AuthorizationToken (AD_AuthorizationToken_ID NUMBER(10) NOT NULL, AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Language VARCHAR2(6) DEFAULT NULL , AD_Org_ID NUMBER(10) DEFAULT NULL , AD_Role_ID NUMBER(10) DEFAULT NULL , AD_User_ID NUMBER(10) DEFAULT NULL , Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), IsManual CHAR(1) DEFAULT 'Y' CHECK (IsManual IN ('Y','N')) NOT NULL, isWebservice CHAR(1) DEFAULT 'N' CHECK (isWebservice IN ('Y','N')) NOT NULL, LastAccessTime DATE DEFAULT NULL , M_Warehouse_ID NUMBER(10) DEFAULT NULL , RemoteIP VARCHAR2(20) DEFAULT NULL , TimeOutMins NUMBER(10) DEFAULT NULL , Token VARCHAR2(50) DEFAULT NULL , Updated DATE DEFAULT SYSDATE, UpdatedBy NUMBER(10) DEFAULT NULL , ValidForSameClient CHAR(1) DEFAULT 'Y' CHECK (ValidForSameClient IN ('Y','N')) NOT NULL, ValidTo DATE DEFAULT NULL , CONSTRAINT AD_AuthorizationToken_Key PRIMARY KEY (AD_AuthorizationToken_ID))
;

-- Oct 10, 2015 12:10:28 PM IST
ALTER TABLE AD_AuthorizationToken ADD CONSTRAINT ADLanguage_ADAuthorizationToke FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2015 12:10:28 PM IST
ALTER TABLE AD_AuthorizationToken ADD CONSTRAINT ADRole_ADAuthorizationToken FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2015 12:10:28 PM IST
ALTER TABLE AD_AuthorizationToken ADD CONSTRAINT ADUser_ADAuthorizationToken FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2015 12:10:28 PM IST
ALTER TABLE AD_AuthorizationToken ADD CONSTRAINT MWarehouse_ADAuthorizationToke FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2015 12:21:59 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200070,0,0,TO_DATE('2015-10-10 12:21:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-10-10 12:21:58','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','WEBSERVICE_SUPPORT_AUTH_TOKEN','N','D','S','69ac4a48-ad35-45a7-9b32-65704388548d')
;

-- Oct 10, 2015 12:25:02 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200071,0,0,TO_DATE('2015-10-10 12:25:01','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-10-10 12:25:01','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','WEBSERVICE_Token_Timeout','30','D','C','621331bd-d29d-4d82-a404-67329b871de5')
;

-- Oct 13, 2015 5:17:01 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200072,0,0,TO_DATE('2015-10-13 17:16:59','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-10-13 17:16:59','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','WEBSERVICE_LOGIN_RESPONSE_ALL','N','D','C','45ab3b30-60f3-4dc0-973f-f0139cf94877')
;

-- Oct 14, 2015 7:22:56 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200075,'Authorization Token','Authorization Token',0,0,'Y',TO_DATE('2015-10-14 19:22:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:22:55','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','9bb4dbde-93bf-49af-bdb7-fdb2954ea91c')
;

-- Oct 14, 2015 7:23:57 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200194,'Webservice Token',200075,10,'Y',200179,0,0,'Y',TO_DATE('2015-10-14 19:23:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:23:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','b49b0760-d06f-4866-8765-c3adad1b29ce','B')
;

-- Oct 14, 2015 7:24:07 PM IST
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200001, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200001)
;

-- Oct 14, 2015 7:24:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203897,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200194,212277,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4424df76-4952-4fb0-b48f-525a9d0cfbb8','N',2)
;

-- Oct 14, 2015 7:24:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203898,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200194,212295,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a91d5e3d-6c5e-41d3-8f9e-811cb6ffa293','Y','Y',10,4,2)
;

-- Oct 14, 2015 7:24:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203899,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200194,212278,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f35d965b-7898-4d74-83a5-ece8a65a6059','Y',20,2)
;

-- Oct 14, 2015 7:24:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203900,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200194,212284,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8b53b611-80a8-4659-95a2-efa2182995e4','Y',30,2)
;

-- Oct 14, 2015 7:24:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203901,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200194,212285,'Y',22,50,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','358c9e21-c84d-4be0-96f8-0ab9d03b7c96','Y',40,2)
;

-- Oct 14, 2015 7:24:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203902,'Token',200194,212286,'Y',50,60,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dd60870b-91d5-4ad4-92bc-2b7397891d8e','Y',50,2)
;

-- Oct 14, 2015 7:24:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203903,'isWebservice',200194,212287,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f4f3c229-5170-4524-af3c-a487ccfca893','Y',60,2,2)
;

-- Oct 14, 2015 7:24:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203904,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200194,212288,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e6d41ba-0c09-4ab6-ba67-8099499d40f7','Y',70,2,2)
;

-- Oct 14, 2015 7:24:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203905,'ValidForSameClient',200194,212289,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7da8261-9714-4c6d-b7cf-c44d318918ac','Y',80,2,2)
;

-- Oct 14, 2015 7:24:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203906,'LastAccessTime',200194,212290,'Y',22,100,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd0ec3ab-dbcc-41cd-b2bf-e092dc5e82c2','Y',90,2)
;

-- Oct 14, 2015 7:24:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203907,'Valid to','Valid to including this date (last day)','The Valid To date indicates the last day of a date range',200194,212291,'Y',7,110,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9694d39a-6258-48fa-b6ac-16f69ca392c0','Y',100,2)
;

-- Oct 14, 2015 7:24:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203908,'Timeout in Minutes',200194,212292,'Y',10,120,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9e6fa4fa-a180-4e3d-a551-6c7e45349dd4','Y',110,2)
;

-- Oct 14, 2015 7:24:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203909,'Remote IP',200194,212293,'Y',20,130,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cdfca3ac-b9c8-4e57-b609-ccdc633623c5','Y',120,2)
;

-- Oct 14, 2015 7:24:16 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203910,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200194,212294,'Y',6,140,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','777258bd-3846-4899-aa64-00f4cdcd6746','Y',130,2)
;

-- Oct 14, 2015 7:24:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203911,'AD_AuthorizationToken_ID',200194,212296,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b29224d8-bedd-4924-b9d6-6eaea744313f','N',2)
;

-- Oct 14, 2015 7:24:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203912,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200194,212283,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-14 19:24:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:24:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8296e399-b58b-40bd-a617-81abc5a85bc2','Y',140,2,2)
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203900
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203902
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203906
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203910
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203907
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203905
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=6,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203904
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=1,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203909
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, XPosition=4,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203903
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=6,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203912
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203908
;

-- Oct 14, 2015 7:26:13 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-10-14 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203911
;

-- Oct 14, 2015 7:27:49 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200127,'Authorization Token','Authorization Token','W',200075,0,0,'Y',TO_DATE('2015-10-14 19:27:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-10-14 19:27:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','5ca4e04a-cada-442b-aadb-ad9ef541b922')
;

-- Oct 14, 2015 7:27:50 PM IST
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200127, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200127)
;

-- Oct 14, 2015 7:27:50 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200127, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200127)
;

-- Oct 14, 2015 7:33:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_DATE('2015-10-14 19:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203900
;

-- Oct 14, 2015 7:33:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_DATE('2015-10-14 19:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203901
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203899
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203910
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203902
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203909
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=3,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203905
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=5,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203904
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=3,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203912
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=5,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203903
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, XPosition=1,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203907
;

-- Oct 14, 2015 7:33:11 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=4,Updated=TO_DATE('2015-10-14 19:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203906
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203909
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=5,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203904
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203902
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=5,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203903
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203908
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=5,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203905
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, XPosition=1,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203906
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=5,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203912
;

-- Oct 14, 2015 7:34:51 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_DATE('2015-10-14 19:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203907
;

SELECT register_migration_script('201510140510_IDEMPIERE-2840.sql') FROM dual
;

