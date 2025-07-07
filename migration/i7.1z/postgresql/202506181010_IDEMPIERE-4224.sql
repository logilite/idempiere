-- Merge Migration script from Master 

-- Oct 5, 2023, 7:00:24 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:00:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=562
;

-- Oct 5, 2023, 7:04:17 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=558
;

-- Oct 5, 2023, 7:04:30 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=560
;

-- Oct 5, 2023, 7:04:53 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=563
;

UPDATE M_AttributeSet SET EntityType = 'U' WHERE M_AttributeSet_ID >= 1000000;

UPDATE M_AttributeUse SET EntityType = 'U' WHERE  M_AttributeSet_ID  >= 1000000 OR M_Attribute_ID >= 1000000;

UPDATE M_Attribute SET EntityType = 'U' WHERE M_Attribute_ID >= 1000000;

UPDATE M_AttributeValue SET EntityType = 'U' WHERE M_AttributeValue_ID >= 1000000;

-- 01-Oct-2024, 11:32:59 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Table Attributes',0,0,'Y',TO_TIMESTAMP('2024-10-01 23:32:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-01 23:32:58','YYYY-MM-DD HH24:MI:SS'),100,200906,'TableAttribute','D','b4a225ad-d48b-4cf2-a9c8-a3ce54406c6d')
;

-- Nov 24, 2024, 6:19:50 PM CET
UPDATE AD_ToolBarButton SET SeqNo=230, IsShowMore='Y',Updated=TO_TIMESTAMP('2024-11-24 18:19:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200133
;


-- Dec 30, 2024, 6:34:35 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200423,'Table Attribute Set','AD_TableAttributeSet',0,'4',0,0,'Y',TO_TIMESTAMP('2024-12-30 18:34:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:34:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','7cb38526-36c2-4be0-a6d8-0b7ecbd76182','N','N','N')
;

-- Dec 30, 2024, 6:35:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217014,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200423,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:04','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','dd2d2f32-c886-4fec-8f5c-c56550493c4e','N')
;

-- Dec 30, 2024, 6:35:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217015,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200423,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:05','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','a106f72d-1b3a-486d-a9b9-b0f627b80157','N')
;

-- Dec 30, 2024, 6:35:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217016,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200423,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:09','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','358b5d24-d470-4cbe-9966-00f7804683e8','N')
;

-- Dec 30, 2024, 6:35:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217017,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200423,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','35b38bff-3573-4ed4-af80-c6bbacff0c92','N')
;

-- Dec 30, 2024, 6:35:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217018,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200423,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','e4e9da02-3ca0-41cd-92e0-bbe357eaddea','N')
;

-- Dec 30, 2024, 6:35:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217019,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200423,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','b3cd1409-119a-416f-ad91-85372dc0c08c','N')
;

-- Dec 30, 2024, 6:35:13 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217020,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200423,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','6188f193-9d54-4adc-a979-de925fd48a41','N')
;

-- Dec 30, 2024, 6:35:14 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203981,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttributeSet_ID','Table Attribute Set','Table Attribute Set','D','0aa19adf-e0ff-42a8-9ab7-626351c0d40b')
;

-- Dec 30, 2024, 6:35:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217021,0.0,'Table Attribute Set',200423,'AD_TableAttributeSet_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,203981,'N','N','D','N','a1b8677d-1f38-44a8-bd17-4b40769c116e','N')
;

-- Dec 30, 2024, 6:35:15 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203982,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttributeSet_UU','AD_TableAttributeSet_UU','AD_TableAttributeSet_UU','D','02ac8c7a-0651-435f-a78b-f905e7f35d7a')
;

-- Dec 30, 2024, 6:35:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217022,0.0,'AD_TableAttributeSet_UU',200423,'AD_TableAttributeSet_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,203982,'Y','N','D','N','673ec975-7cd8-4bbf-b373-a5e7d4561439','N')
;

-- Dec 30, 2024, 6:35:17 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201280,'bd771f97-35b1-40e7-b596-acfae67cbb26',TO_TIMESTAMP('2024-12-30 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableAttributeSet_UU_idx',TO_TIMESTAMP('2024-12-30 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,200423,'Y','Y','N','N')
;

-- Dec 30, 2024, 6:35:18 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201744,'9d9113e4-1c01-4d9e-becc-55b4fa66f730',TO_TIMESTAMP('2024-12-30 18:35:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-30 18:35:17','YYYY-MM-DD HH24:MI:SS'),100,217022,201280,10)
;

-- Dec 31, 2024, 12:03:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217023,0,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',200423,'M_AttributeSet_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-31 12:02:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 12:02:58','YYYY-MM-DD HH24:MI:SS'),100,2017,'Y','N','D','N','N','N','Y','37d3699e-e284-4edc-9fbc-23753ff1e61f','Y',0,'N','N','N')
;

-- Dec 31, 2024, 12:03:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217024,0,'Table','Database Table information','The Database Table provides the information of the table definition',200423,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-31 12:03:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 12:03:43','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','e413ec9c-a549-46a8-82eb-6e480a8408f7','Y',0,'N','N','N','N')
;

-- Dec 31, 2024, 12:03:52 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-12-31 12:03:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217014
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217015
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET FKConstraintName='ADTable_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217017
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSet_ADTableAttriSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217023
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217019
;

-- Dec 31, 2024, 12:03:56 PM IST
CREATE TABLE AD_TableAttributeSet (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, AD_TableAttributeSet_ID NUMERIC(10) NOT NULL, AD_TableAttributeSet_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, M_AttributeSet_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_TableAttributeSet_Key PRIMARY KEY (AD_TableAttributeSet_ID), CONSTRAINT AD_TableAttributeSet_UU_idx UNIQUE (AD_TableAttributeSet_UU))
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADClient_ADTableAttributeSet FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADOrg_ADTableAttributeSet FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADTable_ADTableAttributeSet FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT CreatedBy_ADTableAttributeSet FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT MAttributeSet_ADTableAttributeSet FOREIGN KEY (M_AttributeSet_ID) REFERENCES m_attributeset(m_attributeset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT UpdatedBy_ADTableAttributeSet FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:06:50 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201281,'b7d6c286-ac1e-4a41-a659-e8ef70361dc7',TO_TIMESTAMP('2024-12-31 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableAttributeSet_AttributeSet_Table',TO_TIMESTAMP('2024-12-31 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,200423,'N','Y','N','N','N')
;

-- Dec 31, 2024, 12:07:02 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201745,'a5000058-2f8f-4b8c-9b1a-20337922afda',TO_TIMESTAMP('2024-12-31 12:07:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-31 12:07:01','YYYY-MM-DD HH24:MI:SS'),100,217023,201281,10)
;

-- Dec 31, 2024, 12:07:11 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201746,'11c240af-e3c7-4668-b977-b57cbeeffe50',TO_TIMESTAMP('2024-12-31 12:07:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-31 12:07:10','YYYY-MM-DD HH24:MI:SS'),100,217024,201281,20)
;

-- Dec 31, 2024, 12:07:19 PM IST
CREATE UNIQUE INDEX AD_TableAttributeSet_AttributeSet_Table ON AD_TableAttributeSet (M_AttributeSet_ID,AD_Table_ID)
;

-- Dec 31, 2024, 1:29:47 PM IST
UPDATE AD_Table SET Description='Creates a link between tables and attribute sets for flexible extensions. A table can have multiple attribute sets.', Help='Links system tables (AD_Table) with attribute sets (M_AttributeSet) to allow multiple attribute sets per table, enabling extensibility and avoiding plugin conflicts.',Updated=TO_TIMESTAMP('2024-12-31 13:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200423
;

-- Dec 31, 2024, 1:36:32 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200388,'Table Attribute Set',100,130,'Y',200423,0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','81067d1d-af66-4ab4-b564-7e95c15914ab','B','N','Y',0);

-- Dec 31, 2024, 1:36:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208681,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200388,217014,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d227418b-31fd-4aa3-9226-a42e7ae699d3','N',2)
;

-- Dec 31, 2024, 1:36:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208682,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200388,217015,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e6adce9-ffd4-43f0-85e3-62f6155fc0c1','Y','N',4,2)
;

-- Dec 31, 2024, 1:36:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208683,'Table Attribute Set',200388,217021,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','208551a6-2bd2-4014-a629-8f3853b30b89','N',2)
;

-- Dec 31, 2024, 1:36:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208684,'AD_TableAttributeSet_UU',200388,217022,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5aa410f9-1e9e-4cf3-89bc-69009a4cb974','N',2)
;

-- Dec 31, 2024, 1:36:51 PM ISTINSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208684,'AD_TableAttributeSet_UU',200388,217022,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5aa410f9-1e9e-4cf3-89bc-69009a4cb974','N',2)

INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208685,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',200388,217023,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8253d62-00ed-4237-953d-b1db3af7bbca','Y',10,2)
;

-- Dec 31, 2024, 1:36:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208686,'Table','Database Table information','The Database Table provides the information of the table definition',200388,217024,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','75583812-2e5e-4032-90f4-d6d1d8973208','Y',20,2)
;

-- Dec 31, 2024, 1:36:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208687,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200388,217020,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7f6fc0ab-96b7-4c4e-964c-901caa6b8e38','Y',30,2,2)
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208686
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208685
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208684
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208683
;

-- Dec 31, 2024, 2:23:59 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200239, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200239)
;

-- Dec 31, 2024, 2:32:33 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200047,Updated=TO_TIMESTAMP('2024-12-31 14:32:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 3:05:43 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200180,Updated=TO_TIMESTAMP('2024-12-31 15:05:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217023
;

-- Jan 1, 2025, 5:32:10 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_TableAttributeSet',1000000,'N','N','Table AD_TableAttributeSet','Y','Y',0,0,TO_TIMESTAMP('2025-01-01 17:32:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-01 17:32:09','YYYY-MM-DD HH24:MI:SS'),100,200494,'Y',1000000,1,200000,'8e73e118-776a-4f88-9270-076a2120b31a')
;

-- Jan 1, 2025, 5:32:43 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('DocumentNo_AD_TableAttribute',1000000,'N','N','DocumentNo/Value for Table AD_TableAttribute','Y','N',11,0,TO_TIMESTAMP('2025-01-01 17:32:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-01 17:32:42','YYYY-MM-DD HH24:MI:SS'),100,200515,'Y',1000000,1,200000,'5cce385d-98c4-4efc-80a1-6ab2958be900')
;

-- Mar 1, 2025, 1:36:34 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extra Attributes',0,0,'Y',TO_TIMESTAMP('2025-03-01 13:36:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-01 13:36:33','YYYY-MM-DD HH24:MI:SS'),100,200940,'AttributeForm','D','26116a47-860b-43a8-920a-54cface6ade9')
;

-- Mar 1, 2025, 1:55:06 PM CET
UPDATE AD_Column SET IsParent='Y', AD_Reference_ID=30, IsUpdateable='N',Updated=TO_TIMESTAMP('2025-03-01 13:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Apr 4, 2025, 12:21:11 PM  IST
DELETE FROM AD_Field WHERE AD_Field_UU='218bf59a-05d3-498e-a136-ca808b4ea4b3'
;

-- Apr 4, 2025, 12:21:11 PM  IST
ALTER TABLE AD_Table DROP CONSTRAINT MAttributeSet_ADTable
;

-- Apr 4, 2025, 12:21:11 PM  IST
ALTER TABLE AD_Table DROP COLUMN M_AttributeSet_ID
;

-- Apr 4, 2025, 12:21:11 PM  IST
DELETE FROM AD_Column WHERE AD_Column_UU='5965098d-456d-48a2-b05d-e1b8cbc9ec8b'
;

SELECT register_migration_script('202506181010_IDEMPIERE-4224.sql') FROM dual;
;