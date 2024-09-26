SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5653  Print format access and restriction
-- Oct 9, 2023, 1:27:15 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200391,'Print Format Access','AD_PrintFormat_Access',0,'7',0,0,'Y',TO_DATE('2023-10-09 13:27:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:27:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','7d266589-1e8b-49f2-bb17-ada99feaaf1c','N','N','N')
;

-- Oct 9, 2023, 1:27:16 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_PrintFormat_Access',1000000,'N','N','Table AD_PrintFormat_Access','Y','Y',0,0,TO_DATE('2023-10-09 13:27:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:27:15','YYYY-MM-DD HH24:MI:SS'),100,200462,'Y',1000000,1,200000,'e88a6fa1-e12d-4f08-9164-629045546951')
;

-- Oct 9, 2023, 1:27:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215949,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200391,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2023-10-09 13:27:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:27:34','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','ef3d80e6-a5e1-4dff-b371-cf7d44de6959','N',0,'N','N','D','N')
;

-- Oct 9, 2023, 1:27:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215950,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200391,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2023-10-09 13:27:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:27:57','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','45a9d7ad-c6c9-42f8-9548-3c92a20f1569','N',0,'N','N','D','N')
;

-- Oct 9, 2023, 1:28:37 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203840,0,0,'Y',TO_DATE('2023-10-09 13:28:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:28:14','YYYY-MM-DD HH24:MI:SS'),100,'AD_PrintFormat_Access_ID','Print Format Access ID',NULL,NULL,'Print Format Access ID','D','1a62e853-59d2-4181-b96d-7313bfbdb6af')
;

-- Oct 9, 2023, 1:28:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215951,0,'Print Format Access ID',200391,'AD_PrintFormat_Access_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_DATE('2023-10-09 13:28:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:28:50','YYYY-MM-DD HH24:MI:SS'),100,203840,'N','N','D','N','N','N','Y','5bf2648e-68fb-482b-9ba7-419ce83dc039','N',0,'N','N','N','N')
;

-- Oct 9, 2023, 1:29:22 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203841,0,0,'Y',TO_DATE('2023-10-09 13:28:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:28:59','YYYY-MM-DD HH24:MI:SS'),100,'AD_PrintFormat_Access_UU','AD_PrintFormat_Access_UU',NULL,NULL,'AD_PrintFormat_Access_UU','D','e3af80b6-25c4-4116-bb3b-d0cac74b597e')
;

-- Oct 9, 2023, 1:29:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215952,0,'AD_PrintFormat_Access_UU',200391,'AD_PrintFormat_Access_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2023-10-09 13:29:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:29:33','YYYY-MM-DD HH24:MI:SS'),100,203841,'N','N','D','N','N','N','Y','b37d78e5-41be-43bf-835b-cb585310ddba','N',0,'N','N','N','N')
;

-- Oct 9, 2023, 1:31:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215953,0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200391,'AD_PrintFormat_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2023-10-09 13:31:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:31:23','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','N','N','N','Y','27ded2cc-57a8-4d30-b2a4-c11b089a02af','Y',0,'N','N','N','N')
;

-- Oct 9, 2023, 1:32:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215954,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200391,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2023-10-09 13:32:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:32:01','YYYY-MM-DD HH24:MI:SS'),100,123,'N','N','D','N','N','N','Y','57f35ecb-fb70-4bb5-bffd-99644f1e71c7','Y',0,'N','N','C','N')
;

-- Oct 9, 2023, 1:32:18 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215955,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200391,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2023-10-09 13:32:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:32:17','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','N','N','Y','f39c5191-d3ae-4003-bf89-3587df4ca294','Y',0,'N','N','N')
;

-- Oct 9, 2023, 1:32:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215956,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200391,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2023-10-09 13:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:32:34','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','92cdd5c7-852c-44a7-84a0-1aa08418ce7f','N',0,'N','N','N')
;

-- Oct 9, 2023, 1:32:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215957,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200391,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2023-10-09 13:32:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:32:49','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','21e6e375-42ac-42f5-887d-4731c83a98de','N',0,'N','N','D','N')
;

-- Oct 9, 2023, 1:33:03 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215958,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200391,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2023-10-09 13:33:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:33:03','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','c0511c22-f366-4df3-b19c-38d352e7d934','N',0,'N','N','N')
;

-- Oct 9, 2023, 1:33:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215959,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200391,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2023-10-09 13:33:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:33:19','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','65d2f523-fba0-44b6-8dd2-7f45bd74e60c','N',0,'N','N','N')
;

-- Oct 9, 2023, 1:33:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215960,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200391,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2023-10-09 13:33:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 13:33:49','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','32b91b1a-8000-49f0-a517-6ff2e38164aa','N',0,'N','N','D','N')
;

-- Oct 9, 2023, 1:34:24 PM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2023-10-09 13:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215954
;

-- Oct 9, 2023, 1:34:33 PM IST
UPDATE AD_Column SET IsUpdateable='Y', IsAlwaysUpdateable='Y',Updated=TO_DATE('2023-10-09 13:34:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215955
;

-- Oct 9, 2023, 1:34:39 PM IST
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_DATE('2023-10-09 13:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215954
;

-- Oct 9, 2023, 1:35:00 PM IST
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_DATE('2023-10-09 13:35:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215953
;

-- Oct 9, 2023, 1:35:08 PM IST
UPDATE AD_Column SET FKConstraintName='ADPrintFormat_ADPrintFormatAcc', FKConstraintType='N',Updated=TO_DATE('2023-10-09 13:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215953
;

-- Oct 9, 2023, 1:35:08 PM IST
UPDATE AD_Column SET FKConstraintName='ADRole_ADPrintFormatAccess', FKConstraintType='C',Updated=TO_DATE('2023-10-09 13:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215954
;

-- Oct 9, 2023, 1:35:08 PM IST
UPDATE AD_Column SET FKConstraintName='ADUser_ADPrintFormatAccess', FKConstraintType='N',Updated=TO_DATE('2023-10-09 13:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215955
;

-- Oct 9, 2023, 1:35:08 PM IST
CREATE TABLE AD_PrintFormat_Access (AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Org_ID NUMBER(10) DEFAULT NULL , AD_PrintFormat_Access_ID NUMBER(10) DEFAULT NULL , AD_PrintFormat_Access_UU VARCHAR2(36 CHAR) DEFAULT NULL , AD_PrintFormat_ID NUMBER(10) DEFAULT NULL , AD_Role_ID NUMBER(10) DEFAULT NULL , AD_User_ID NUMBER(10) DEFAULT NULL , Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), Updated DATE DEFAULT SYSDATE, UpdatedBy NUMBER(10) DEFAULT NULL , CONSTRAINT AD_PrintFormat_Access_Key PRIMARY KEY (AD_PrintFormat_Access_ID), CONSTRAINT AD_PrintFormat_Access_UU_idx UNIQUE (AD_PrintFormat_Access_UU))
;

-- Oct 9, 2023, 1:35:09 PM IST
ALTER TABLE AD_PrintFormat_Access ADD CONSTRAINT ADPrintFormat_ADPrintFormatAcc FOREIGN KEY (AD_PrintFormat_ID) REFERENCES ad_printformat(ad_printformat_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2023, 1:35:09 PM IST
ALTER TABLE AD_PrintFormat_Access ADD CONSTRAINT ADRole_ADPrintFormatAccess FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2023, 1:35:09 PM IST
ALTER TABLE AD_PrintFormat_Access ADD CONSTRAINT ADUser_ADPrintFormatAccess FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 9, 2023, 2:44:20 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200238,0,0,TO_DATE('2023-10-09 14:44:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-10-09 14:44:19','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PRINTFORMAT_AUTOGENERATE_ACCESS','N','Auto generate print format access','D','C','44bd0cda-136a-4a44-af06-f5d9667bbf71')
;

-- Oct 9, 2023, 2:51:12 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords,PageSize,DetailPageSize, WhereClause) VALUES (200357,'Print Format Access',240,80,'Y',200391,0,0,'Y',TO_DATE('2023-10-09 14:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','2c9c8a5f-5bcf-4343-ad9b-539c435184d3','B','N','Y',0,0,0, '(AD_User_ID=@#AD_User_ID:0@ OR AD_User_ID IS NULL) AND (AD_Role_ID =@#AD_Role_ID:0@ OR AD_Role_ID  IS NULL)')
;

-- Oct 9, 2023, 2:51:19 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207750,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200357,215949,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1fcf4e5d-f7e3-4b2a-9867-46db9c69aace','Y',10,2)
;

-- Oct 9, 2023, 2:51:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207751,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200357,215950,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6fa415f2-0266-45e0-bb86-97acab876ede','Y','N',4,2)
;

-- Oct 9, 2023, 2:51:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207752,'Print Format Access ID',200357,215951,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e9d24d38-80b0-4acc-a15e-a9d2d91a8360','N',2)
;

-- Oct 9, 2023, 2:51:21 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207753,'AD_PrintFormat_Access_UU',200357,215952,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a3dd943-57f8-4a65-816c-f1c3d183664b','N',2)
;

-- Oct 9, 2023, 2:51:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207754,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200357,215953,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','062ce8e0-bafe-4214-9041-4edfd774b268','Y',20,2)
;

-- Oct 9, 2023, 2:51:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207755,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200357,215954,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','296720c5-1ddd-4985-9a40-a161027131b6','Y',30,2)
;

-- Oct 9, 2023, 2:51:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207756,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200357,215955,'Y',22,50,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','24d7de9e-0fc4-41a7-85eb-eb22ddad6b02','Y',40,2)
;

-- Oct 9, 2023, 2:51:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207757,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200357,215958,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2023-10-09 14:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-10-09 14:51:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ed568055-63ec-41c3-b380-a6f5bd987eac','Y',50,2,2)
;

-- Oct 9, 2023, 2:51:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2023-10-09 14:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207757
;

-- Oct 9, 2023, 2:51:48 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-10-09 14:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207755
;

-- Oct 9, 2023, 2:51:48 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-10-09 14:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207756
;

-- Oct 9, 2023, 2:51:48 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-10-09 14:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207753
;

-- Oct 9, 2023, 2:51:48 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-10-09 14:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207752
;

-- Dec 18, 2023, 1:52:10 PM IST
UPDATE AD_Column SET DefaultValue='@AD_PrintFormat_ID@', IsParent='Y', IsUpdateable='N', IsAlwaysUpdateable='N',Updated=TO_DATE('2023-12-18 13:52:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215953
;

-- Apr 22, 2024, 4:43:47 PM IST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution,IsPrinterPreview) VALUES (200163,0,0,'Y',TO_DATE('2024-04-22 16:43:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-22 16:43:43','YYYY-MM-DD HH24:MI:SS'),100,'Share Print Format','N','harePrintFormat','N','org.adempiere.process.SharePrintFormat','3','D',0,0,'N','N','Y','N','0955112b-75e0-4087-9346-4b12a5270cf1','P','N')
;

-- Apr 22, 2024, 4:45:32 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200480,0,0,'Y',TO_DATE('2024-04-22 16:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-22 16:45:28','YYYY-MM-DD HH24:MI:SS'),100,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200163,10,18,'N',0,'N','AD_User_ID','Y','D',138,'40c3a093-56cd-42ea-be9f-ec269de92e4a','N')
;

-- Apr 22, 2024, 4:45:58 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200481,0,0,'Y',TO_DATE('2024-04-22 16:45:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-22 16:45:57','YYYY-MM-DD HH24:MI:SS'),100,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200163,20,18,'N',0,'N','AD_Role_ID','Y','D',123,'18797e6c-5494-4695-b8eb-3afb6ffed6d2','N')
;

-- Apr 22, 2024, 6:44:47 PM IST
UPDATE AD_Tab SET DisplayLogic='@#AD_Client_ID@=0',Updated=TO_DATE('2024-04-22 18:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200357
;

INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200187,'AD_User (PF Access)','S','AD_User_ID NOT IN (SELECT AD_User_ID FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = @AD_PrintFormat_ID@ AND IsActive = ''Y'' AND AD_User_ID IS NOT NULL)
',0,0,'Y',TO_DATE('2024-04-23 17:58:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-23 17:58:54','YYYY-MM-DD HH24:MI:SS'),100,'D','aecc1ff4-6643-4c76-9eea-bdbc1e58a451')
;

-- Apr 23, 2024, 5:59:06 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200188,'AD_Role (PF Access)','S','AD_Role_ID NOT IN (SELECT AD_Role_ID FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = @AD_PrintFormat_ID@ AND IsActive = ''Y'' AND AD_Role_ID  IS NOT NULL)',0,0,'Y',TO_DATE('2024-04-23 17:59:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-23 17:59:06','YYYY-MM-DD HH24:MI:SS'),100,'D','153a9f2c-de58-47ee-b9a4-2ef1aecf2769')
;

-- Apr 23, 2024, 5:59:17 PM IST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200187,Updated=TO_DATE('2024-04-23 17:59:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200480
;

-- Apr 23, 2024, 5:59:27 PM IST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200188,Updated=TO_DATE('2024-04-23 17:59:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200481
;

-- May 2, 2024, 2:09:58 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Only the accessed user can create/modify the record.',0,0,'Y',TO_DATE('2024-05-02 14:09:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-02 14:09:57','YYYY-MM-DD HH24:MI:SS'),100,200888,'PFAccessUpdate','D','499ec371-d12e-4be2-ad10-e2298fff526b')
;

-- May 2, 2024, 2:10:15 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Only the accessed user can delete the record.',0,0,'Y',TO_DATE('2024-05-02 14:10:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-02 14:10:14','YYYY-MM-DD HH24:MI:SS'),100,200889,'PFAccessDelete','D','1eef4c70-f9cb-464f-b3fa-c3da99fe8708')
;

-- May 2, 2024, 2:11:08 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','You don''t have access to Share the print format',0,0,'Y',TO_DATE('2024-05-02 14:11:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-02 14:11:07','YYYY-MM-DD HH24:MI:SS'),100,200890,'PFAccessShare','D','e726b4bc-db7f-40f6-b16b-a13ca5857121')
;

-- May 2, 2024, 3:02:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross) VALUES (216592,0,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200391,'IsReadWrite','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2024-05-02 15:02:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-02 15:02:58','YYYY-MM-DD HH24:MI:SS'),100,406,'Y','N','D','N','N','N','Y','2baa71f0-f51d-44ba-8ae2-9c39ca08d356','Y',0,'N','N','N','N')
;

-- May 2, 2024, 3:03:04 PM IST
ALTER TABLE AD_PrintFormat_Access ADD IsReadWrite CHAR(1) DEFAULT 'N' CHECK (IsReadWrite IN ('Y','N')) NOT NULL
;

-- May 6, 2024, 12:15:36 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Print Format Access already exists for the User/Role',0,0,'Y',TO_DATE('2024-05-06 12:15:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-06 12:15:35','YYYY-MM-DD HH24:MI:SS'),100,200891,'PFAccessAlreadyExists','D','b0e8731a-82fa-4453-b1aa-e3122c39e2ac')
;

-- May 6, 2024, 12:20:22 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Successfully shared access to user {0} and role {1}
',0,0,'Y',TO_DATE('2024-05-06 12:20:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-06 12:20:21','YYYY-MM-DD HH24:MI:SS'),100,200892,'PFAccessShareSuccessfully','D','1651fc9c-c746-4c94-8fa4-593869cce910')
;

-- May 7, 2024, 4:21:59 PM IST
UPDATE AD_Tab SET WhereClause='EXISTS (SELECT 1 FROM AD_PrintFormat_Access WHERE (((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID:0@) OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID:0@) OR (AD_Role_ID = @#AD_Role_ID:0@ AND AD_User_ID = @#AD_User_ID:0@)) AND AD_PrintFormat_ID = AD_PrintFormat.AD_PrintFormat_ID)) OR @CreatedBy:0@ = @#AD_User_ID:0@ OR EXISTS (SELECT 1 FROM AD_User where AD_User.AD_User_ID = @#AD_User_ID:0@ AND IsSupportUser = ''Y'')',Updated=TO_DATE('2024-05-07 16:21:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=425
;

-- May 7, 2024, 4:41:06 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted) VALUES (200482,0,0,'Y',TO_DATE('2024-05-07 16:41:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-07 16:41:05','YYYY-MM-DD HH24:MI:SS'),100,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200163,30,20,'N',200187,0,'N','N','IsReadWrite','Y','D',406,'@SQL=(SELECT AD_PrintFormat_Access_ID FROM AD_PrintFormat_Access WHERE (((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID:0@) OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID:0@) OR (AD_Role_ID = @#AD_Role_ID:0@ AND AD_User_ID = @#AD_User_ID:0@)) AND AD_PrintFormat_ID = @AD_PrintFormat_ID@ AND IsReadWrite = ''Y'') OR @CreatedBy:0@ = @#AD_User_ID:0@ OR EXISTS (SELECT 1 FROM AD_User where AD_User.AD_User_ID = @#AD_User_ID:0@ AND IsSupportUser = ''Y''))','a41aa036-c207-462c-a612-04e7b122968b','N')
;

-- May 8, 2024, 3:07:17 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200189,'AD_PrintFormat (Print_Format_Access)','S','AD_PrintFormat.AD_PrintFormat_ID IN (SELECT DISTINCT AD_PrintFormat_ID FROM AD_PrintFormat_Access WHERE ((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID@) OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID@) OR (AD_Role_ID = @#AD_Role_ID@ AND AD_User_ID = @#AD_User_ID@))) OR AD_PrintFormat.CreatedBy = @#AD_User_ID@ OR EXISTS (SELECT 1 FROM AD_User where AD_User.AD_User_ID = @#AD_User_ID:0@ AND IsSupportUser = ''Y'')',0,0,'Y',TO_DATE('2024-05-08 15:07:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-08 15:07:14','YYYY-MM-DD HH24:MI:SS'),100,'D','3d3c41d2-6d71-471f-b699-522bd4e8efdc')
;

-- May 8, 2024, 3:07:44 PM IST
UPDATE AD_Process_Para SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=200189,Updated=TO_DATE('2024-05-08 15:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=253
;

SELECT register_migration_script('202310091430_IDEMPIERE-5653.sql') FROM dual
;
