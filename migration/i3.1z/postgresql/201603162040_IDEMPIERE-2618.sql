-- IDEMPIERE-2618 : Matching PO-Receipt-Invoice do not respect Credit Memo

-- 18-Nov-2015 16:59:37 IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200196,'Match Invoice Header','M_MatchInvHdr',0,'3',0,0,'Y',TO_DATE('2015-11-18 16:59:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-11-18 16:59:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','c8d35b21-9307-4f8a-936c-73bac0c4de7a','N','N')
;

-- 18-Nov-2015 16:59:38 IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('M_MatchInvHdr',1000000,'N','N','Table M_MatchInvHdr','Y','Y',0,0,TO_DATE('2015-11-18 16:59:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-11-18 16:59:38','YYYY-MM-DD HH24:MI:SS'),100,200260,'Y',1000000,1,200000,'20b301b5-3922-4724-bafb-098f7013a330')
;

-- Mar 13, 2016 3:34:11 PM IST
CREATE TABLE m_matchinvhdr ( ad_client_id numeric(10,0), ad_org_id numeric(10,0) NOT NULL, created timestamp without time zone NOT NULL DEFAULT statement_timestamp(), createdby numeric(10,0) NOT NULL, description character varying(255), documentno character varying(30), isactive character(1) DEFAULT 'Y'::bpchar, m_matchinvhdr_id numeric(10,0) NOT NULL, m_matchinvhdr_uu character varying(36), updated timestamp without time zone NOT NULL DEFAULT statement_timestamp(), updatedby numeric(10,0) NOT NULL, posted character(1) NOT NULL DEFAULT 'N'::bpchar, docaction character(2) NOT NULL DEFAULT 'CO'::bpchar, dateacct timestamp without time zone, docstatus character varying(2) DEFAULT 'DR'::character varying, processed character(1) NOT NULL DEFAULT 'N'::bpchar, datetrx timestamp without time zone, processing character(1) DEFAULT 'N'::bpchar, reversal_id numeric(10,0) DEFAULT NULL::numeric, CONSTRAINT m_matchinvhdr_key PRIMARY KEY (m_matchinvhdr_id ), CONSTRAINT adclient_mmatchinvhdr FOREIGN KEY (ad_client_id) REFERENCES ad_client (ad_client_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED, CONSTRAINT adorg_mmatchinvhdr FOREIGN KEY (ad_org_id) REFERENCES ad_org (ad_org_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED, CONSTRAINT createdby_mmatchinvhdr FOREIGN KEY (createdby) REFERENCES ad_user (ad_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED, CONSTRAINT updatedby_mmatchinvhdr FOREIGN KEY (updatedby) REFERENCES ad_user (ad_user_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED, CONSTRAINT m_matchinvhdr_uu_idx UNIQUE (m_matchinvhdr_uu ), CONSTRAINT m_matchinvhdr_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])), CONSTRAINT m_matchinvhdr_processed_check CHECK (processed = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])) ) WITH ( OIDS=FALSE );


-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200081,'Match Invoice Header',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','5a20c4a8-bf27-4aa5-bbe8-e6c8cd536099')
;

-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200136,'Match Invoice Header','W',200081,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','ef800042-6ba0-484f-a0a0-0281a6944f00')
;

-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 0,999, 10, 200136)
;

-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202950,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,'M_MatchInvHdr_ID','Match Invoice Header','Match Invoice Header','D','7d5a58db-4b71-4d0f-a243-7526bce17b74')
;

-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212548,0,'Match Invoice Header',200196,'M_MatchInvHdr_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:11','YYYY-MM-DD HH24:MI:SS'),100,202950,'N','N','D','Y','N','N','Y','91401ee7-c757-411b-bea3-c197eb2544b9','N',0,'N','N','N')
;

-- Mar 13, 2016 3:34:11 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','M_MatchInvHdr_ID','NUMERIC(10)',null,null)
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212540,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200196,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','f2c3cb0f-1ff3-446b-8271-009aeb713a5f','N',0,'N','N','ADClient_MMatchInvHdr','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','AD_Client_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212541,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200196,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','833afc06-c36d-4766-8957-d945430d0b6e','N',0,'N','N','ADOrg_MMatchInvHdr','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','AD_Org_ID','NUMERIC(10)',null,null)
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212542,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200196,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','cf0d3c93-dade-4fe2-882e-9d44aeaab22a','N',0,'N','N','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Created','TIMESTAMP',null,'statement_timestamp()')
;

-- Mar 13, 2016 3:34:12 PM IST
UPDATE M_MatchInvHdr SET Created=statement_timestamp() WHERE Created IS NULL
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212543,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200196,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','879de29e-9f29-4329-a013-0b918cffb5e7','N',0,'N','N','CreatedBy_MMatchInvHdr','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','CreatedBy','NUMERIC(10)',null,null)
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212545,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200196,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','70f5fc13-9072-4f82-a166-947e9500fc7c','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Description','VARCHAR(255)',null,'NULL')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212546,0,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200196,'DocumentNo',30,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),100,290,'N','Y','D','Y','N','N','Y','355d9fe0-235d-482e-8c8d-1fc73ef3dc05','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:12 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','DocumentNo','VARCHAR(30)',null,'NULL')
;

-- Mar 13, 2016 3:34:12 PM IST
UPDATE AD_Element SET Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',Updated=TO_TIMESTAMP('2016-03-13 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=348
;

-- Mar 13, 2016 3:34:12 PM IST
UPDATE AD_Column SET ColumnName='IsActive', Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.' WHERE AD_Element_ID=348
;

-- Mar 13, 2016 3:34:13 PM IST
UPDATE AD_Process_Para SET ColumnName='IsActive', Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', AD_Element_ID=348 WHERE UPPER(ColumnName)='ISACTIVE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 13, 2016 3:34:13 PM IST
UPDATE AD_Process_Para SET ColumnName='IsActive', Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.' WHERE AD_Element_ID=348 AND IsCentrallyMaintained='Y'
;

-- Mar 13, 2016 3:34:13 PM IST
UPDATE AD_InfoColumn SET ColumnName='IsActive', Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.' WHERE AD_Element_ID=348 AND IsCentrallyMaintained='Y'
;

-- Mar 13, 2016 3:34:13 PM IST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=348) AND IsCentrallyMaintained='Y'
;

-- Mar 13, 2016 3:34:14 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212547,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200196,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:14','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','01d83eef-a649-478e-ada7-a5f048e2a13e','N',0,'N','N','N')
;

-- Mar 13, 2016 3:34:14 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','IsActive','CHAR(1)',null,'Y')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202951,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,'M_MatchInvHdr_UU','M_MatchInvHdr_UU','M_MatchInvHdr_UU','D','941da594-fb13-47b4-9c8b-7b02db347c8f')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212549,0,'M_MatchInvHdr_UU',200196,'M_MatchInvHdr_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,202951,'Y','N','D','Y','N','N','Y','5da33c69-8350-4a8c-865c-e00af3c52796','N',0,'N','N','N')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','M_MatchInvHdr_UU','VARCHAR(36)',null,'NULL')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212550,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200196,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','0e5e601d-f46d-4138-9969-e61554530ece','N',0,'N','N','N')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Updated','TIMESTAMP',null,'statement_timestamp()')
;

-- Mar 13, 2016 3:34:15 PM IST
UPDATE M_MatchInvHdr SET Updated=statement_timestamp() WHERE Updated IS NULL
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212551,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200196,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','385a4de7-e517-43de-b10b-be5ade0bf104','N',0,'N','N','UpdatedBy_MMatchInvHdr','N')
;

-- Mar 13, 2016 3:34:15 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','UpdatedBy','NUMERIC(10)',null,null)
;

-- Mar 13, 2016 3:34:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212678,0,'Posted','Posting status','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ',200196,'Posted','N',1,'N','N','Y','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:15','YYYY-MM-DD HH24:MI:SS'),100,1308,'N','N','D','Y','N','N','Y','55c9ee70-3215-4f64-b3ee-7bc6a00143c8','Y',0,'N','N')
;

-- Mar 13, 2016 3:34:16 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Posted','CHAR(1)',null,'N')
;

-- Mar 13, 2016 3:34:16 PM IST
UPDATE M_MatchInvHdr SET Posted='N' WHERE Posted IS NULL
;

-- Mar 13, 2016 3:34:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212679,0,'Document Status','The current status of the document','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',200196,'DocStatus','DR',2,'N','N','N','N','N',0,'N',17,131,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:16','YYYY-MM-DD HH24:MI:SS'),100,289,'Y','N','D','Y','N','N','Y','31bb62ce-bf68-47d4-8d27-2516ee47dc49','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:17 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','DocStatus','VARCHAR(2)',null,'DR')
;

-- Mar 13, 2016 3:34:18 PM IST
INSERT INTO AD_Workflow (Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AccessLevel,EntityType,Author,WorkingTime,Duration,Version,Cost,DurationUnit,WaitingTime,PublishStatus,IsDefault,AD_Table_ID,Value,WorkflowType,IsValid,DocumentNo,QtyBatchSize,IsBetaFunctionality,Yield,AD_Workflow_UU) VALUES ('Process_Match_Invoice_Header','(Standard Process Match Invoice Header)',200004,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:17','YYYY-MM-DD HH24:MI:SS'),100,'1','D','iDempiere, Inc.',0,1,0,0,'D',0,'R','N',200196,'Process_Match_Invoice_Header','P','N','10000002',1,'N',100,'f86265cb-fa1b-4dfa-9e4a-2b90ecab6bbb')
;

-- Mar 13, 2016 3:34:18 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU) VALUES (200016,'(Start)','(Standard Node)',200004,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:18','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(Start)',0,'N','N',0,0,100,'2b7b463f-551c-4ebf-93e8-eb2a2753a940')
;

-- Mar 13, 2016 3:34:19 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU) VALUES (200017,'(DocPrepare)','(Standard Node)',200004,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'PR','(DocPrepare)',0,'N','N',0,0,100,'b0135db1-d5da-4682-b9a3-1f32cec2b76d')
;

-- Mar 13, 2016 3:34:20 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU) VALUES (200018,'(DocComplete)','(Standard Node)',200004,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(DocComplete)',0,'N','N',0,0,100,'7915ed2d-826a-4e2a-a022-559804f06104')
;

-- Mar 13, 2016 3:34:20 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU) VALUES (200019,'(DocAuto)','(DocAuto)',200004,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'--','(DocAuto)',0,'N','N',0,0,100,'6630f3ee-788f-482d-b5ae-74bd099ebc31')
;

-- Mar 13, 2016 3:34:21 PM IST
UPDATE AD_Workflow SET AD_WF_Node_ID=200016, IsValid='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200004
;

-- Mar 13, 2016 3:34:21 PM IST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,AD_Workflow_ID,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200091,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:21','YYYY-MM-DD HH24:MI:SS'),100,'Process Match Invoice Header','N','Process_Match_Invoice Header','N','3','D',0,0,200004,'N','N','Y','N','5cee451e-a77c-4d03-86a7-e0fb854448f5')
;

-- Mar 13, 2016 3:34:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212680,0,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200196,'DocAction','CO',2,'N','N','Y','N','N',0,'N',28,135,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:21','YYYY-MM-DD HH24:MI:SS'),100,287,'Y',200091,'N','D','Y','N','N','Y','d8ccaea2-c143-4556-841e-c857d5bc0b9c','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:22 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','DocAction','CHAR(2)',null,'CO')
;

-- Mar 13, 2016 3:34:22 PM IST
UPDATE M_MatchInvHdr SET DocAction='CO' WHERE DocAction IS NULL
;

-- Mar 13, 2016 3:34:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212681,0,'Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.',200196,'Processed','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:22','YYYY-MM-DD HH24:MI:SS'),100,1047,'Y','N','D','Y','N','N','Y','ce3ef0bf-ac16-4874-a334-84648b173eea','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:23 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Processed','CHAR(1)',null,'N')
;

-- Mar 13, 2016 3:34:23 PM IST
UPDATE M_MatchInvHdr SET Processed='N' WHERE Processed IS NULL
;

-- Mar 13, 2016 3:34:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212682,0,'Transaction Date','Transaction Date','The Transaction Date indicates the date of the transaction.',200196,'DateTrx',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:23','YYYY-MM-DD HH24:MI:SS'),100,1297,'N','N','D','Y','N','N','Y','12a8a4a0-b06d-4b65-b13c-6aa9fbcd7163','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:24 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','DateTrx','TIMESTAMP',null,'NULL')
;

-- Mar 13, 2016 3:34:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212683,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200196,'DateAcct',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:24','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','Y','N','N','Y','c1e7de67-dd06-49e2-b722-e1666c605375','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:24 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','DateAcct','TIMESTAMP',null,'NULL')
;

-- Mar 13, 2016 3:34:25 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Processing','CHAR(1)',null,'N')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212685,0,'Reversal ID','ID of document reversal',200196,'Reversal_ID',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:25','YYYY-MM-DD HH24:MI:SS'),100,53457,'N','N','D','Y','N','N','Y','6a32c07c-1186-4dc2-b5d8-af3b97911a7f','Y',0,'N','N','N')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO t_alter_column values('m_matchinvhdr','Reversal_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200205,'Match Invoice Header',200081,10,'Y',200196,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','b23d0207-2a4a-45c2-a538-d1f32029605c','B')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204060,'M_MatchInvHdr_UU',200205,212549,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a5cdfa54-39e4-4000-a23f-1bf90af66f9c','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204061,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200205,212547,'N',1,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bd54354d-1e44-4d08-ad01-a1186284fc3e','Y',50,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204059,'Match Invoice Header',200205,212548,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','02a46139-1cc0-4ea2-9dba-a4d2fa0667a8','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204054,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200205,212540,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5a361033-1267-4815-90fb-713e19e553af','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204055,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200205,212541,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c99e1dcb-08b2-46cc-bc68-71786f5133c0','Y','Y',10,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204058,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200205,212546,'Y',30,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4c17f03f-5573-405c-92a6-0050835852e4','Y',40,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204056,'Description','Optional short description of the record','A description is limited to 255 characters.',200205,212545,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b38b353-747e-48cf-a457-62399e782dd3','Y',20,1,5,1,'N','N','N')
;

-- Mar 13, 2016 3:34:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204151,'Transaction Date','Transaction Date','The Transaction Date indicates the date of the transaction.',200205,212682,'Y',7,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9ef5c546-aa19-4c75-95ba-2f6fda7aeaed','Y',100,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:28 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204152,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200205,212683,'Y',7,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cbd8342b-a265-44c8-a079-5c725a8d4283','Y',110,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:29 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204153,'Document Status','The current status of the document','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',200205,212679,'Y',2,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ee955b6-bf40-4f49-a639-b1359765d6bd','Y',70,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:29 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204154,'Posted','Posting status','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ',200205,212678,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b6dfd34-4768-4b50-b4c1-431fcf2de8ff','Y',60,2,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204155,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200205,212680,'Y',2,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ff98b472-44f9-40aa-b4d6-17988ab5f7a4','Y',80,5,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204156,'Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.',200205,212681,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','519e322e-ee53-4012-8470-83affde3bb15','Y',90,2,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:30 PM IST
UPDATE AD_Table SET Processing='N',Updated=TO_TIMESTAMP('2016-03-13 15:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=472
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='M_MatchInv_ID', IsUpdateable='N', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6497
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='AD_Client_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6498
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='AD_Org_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6499
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='IsActive', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6500
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='Created', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6501
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='CreatedBy', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6502
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='Updated', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6503
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='UpdatedBy', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6504
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='M_InOutLine_ID', IsMandatory='N', IsSyncDatabase='Y', MandatoryLogic='@M_MatchInvHDR_ID@=NULL | @M_MatchInvHDR_ID@=0',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6505
;

-- Mar 13, 2016 3:34:31 PM IST
INSERT INTO t_alter_column values('m_matchinv','M_InOutLine_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 13, 2016 3:34:31 PM IST
INSERT INTO t_alter_column values('m_matchinv','M_InOutLine_ID',null,'NULL',null)
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='C_InvoiceLine_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6506
;

-- Mar 13, 2016 3:34:31 PM IST
UPDATE AD_Column SET ColumnName='M_Product_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6507
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='DateTrx', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6508
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Processing', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6510
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Processed', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6511
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Posted', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6512
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Qty', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6529
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='DocumentNo', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13086
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='DateAcct', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13200
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='M_AttributeSetInstance_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14198
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Description', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14644
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='ProcessedOn', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59046
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='M_MatchInv_UU', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60908
;

-- Mar 13, 2016 3:34:32 PM IST
UPDATE AD_Column SET ColumnName='Reversal_ID', IsSyncDatabase='Y',Updated=TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200881
;

-- Mar 13, 2016 3:34:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212553,0,'Match Invoice Header',472,'M_MatchInvHdr_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:32','YYYY-MM-DD HH24:MI:SS'),100,202950,'N','N','D','Y','N','N','Y','bca26a73-7a20-49f7-a0b7-f9debbb000b2','Y',0,'N','N','MMatchInvHdr_MMatchInv','N')
;

-- Mar 13, 2016 3:34:32 PM IST
ALTER TABLE M_MatchInv ADD COLUMN M_MatchInvHdr_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 13, 2016 3:34:34 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200206,'Match Invoice',200081,20,'Y',472,0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',212553,'N','N',1,'N','D','Y','N','05f012b9-4870-4cce-b24b-f16a6fc57e59','B')
;

-- Mar 13, 2016 3:34:34 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204065,'Match Invoice','Match Shipment/Receipt to Invoice',200206,6497,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c94187a5-b600-4195-8bd5-b342fea19f8a','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:34 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204078,'M_MatchInv_UU',200206,60908,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','750a7050-7fb7-4655-90b0-691ccf382470','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204062,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200206,6498,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6de7ca99-57bd-4f22-af48-59489b6500de','N',1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204063,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200206,6499,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e36b8277-7d8c-49c6-b112-492774841cdd','Y','Y',10,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204157,'Match Invoice Header',200206,212553,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0afd7d2-b4c1-471c-830f-3af161ded77c','Y',170,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204074,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200206,13086,'Y',30,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f55067a2-6bf0-4f22-9731-6d541f0c62bd','Y',110,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204066,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',200206,6505,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f9e198e7-8c61-40f9-974f-4ba02ef1c9ad','Y',30,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204067,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',200206,6506,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7ddebe2-bc50-4697-8280-9cadcc9b7780','Y',40,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204068,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200206,6507,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8491355f-c7bd-41d5-a1f6-57dafd8123e9','Y',50,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204076,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200206,14198,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e807ed76-98dc-451a-aef8-1755b2029bea','Y',130,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204075,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200206,13200,'Y',7,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9d206967-94fa-4999-a888-1963d0a03879','Y',120,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204069,'Transaction Date','Transaction Date','The Transaction Date indicates the date of the transaction.',200206,6508,'Y',7,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e5c585c-86f5-4822-bd10-753ef1b63a9f','Y',60,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204077,'Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',200206,59046,'Y',20,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b3d7c057-7829-4373-b7b7-66626c5b74ae','Y',140,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204079,'Reversal ID','ID of document reversal',200206,200881,'Y',10,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3d778aaf-a528-4dec-8ba9-83ae235d5f48','Y',150,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204064,'Description','Optional short description of the record','A description is limited to 255 characters.',200206,14644,'Y',255,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab48b3e1-9192-4139-aafe-9050a4f32b0f','Y',20,1,5,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204070,'Process Now',200206,6510,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64a54176-298f-45ea-b18c-12b6bb956876','Y',70,2,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204073,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200206,6529,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e6d64df8-a210-465b-8c85-998cd4509cf6','Y',100,1,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204080,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200206,6500,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb86c3e3-0843-446a-8ca4-783b7a2da44e','Y',160,2,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204071,'Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.',200206,6511,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94054218-20fc-4450-80e7-f32f022baad2','Y',80,4,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204072,'Posted','Posting status','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ',200206,6512,'Y',1,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c450d3bf-0c36-4a2d-ad3a-b9fe68f5f4da','Y',90,2,2,1,'N','N','N')
;

-- Mar 13, 2016 3:34:37 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200016,'Y',TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:36','YYYY-MM-DD HH24:MI:SS'),100,0,0,200017,'D',10,'(Standard Approval)',200012,'Y','d53cf14c-1a87-41ec-ad9f-9052ce0eb306')
;

-- Mar 13, 2016 3:34:37 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200016,'Y',TO_TIMESTAMP('2016-03-13 15:34:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:37','YYYY-MM-DD HH24:MI:SS'),100,0,0,200019,'D',100,'(Standard Transition)',200013,'N','3c9375e8-a573-4f2a-8dbc-f988dac23ca0')
;

-- Mar 13, 2016 3:34:38 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200017,'Y',TO_TIMESTAMP('2016-03-13 15:34:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-13 15:34:37','YYYY-MM-DD HH24:MI:SS'),100,0,0,200018,'D',100,'(Standard Transition)',200014,'Y','872effd7-61bd-44f7-b122-5394ce45e361')
;

-- 14-Mar-2016 12:37:14 IST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Create Match Invoice Header','',0,0,'Y',TO_TIMESTAMP('2016-03-14 12:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-14 12:37:14','YYYY-MM-DD HH24:MI:SS'),100,200400,'CreateMatchInvoiceHeader','D','96d63a62-479b-4375-b38c-a379ca2fcb38')
;

-- 15-Mar-2016 15:24:53 IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200355,'Matching Invoice Header',183,'MWB',0,0,'Y',TO_TIMESTAMP('2016-03-15 15:24:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-15 15:24:52','YYYY-MM-DD HH24:MI:SS'),100,'D','19589a87-d734-42af-bf51-f64e4b0a2509')
;

-- 15-Mar-2016 15:32:44 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212687,0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200196,'C_DocType_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2016-03-15 15:32:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-15 15:32:43','YYYY-MM-DD HH24:MI:SS'),100,196,'N','N','D','N','N','N','Y','399c0782-1022-4821-98d9-169dfd6fe0fa','Y',0,'N','N')
;

-- 15-Mar-2016 15:32:46 IST
UPDATE AD_Column SET FKConstraintName='CDocType_MMatchInvHdr', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-15 15:32:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212687
;

-- 15-Mar-2016 15:32:57 IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-03-15 15:32:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212687
;

-- 15-Mar-2016 15:32:58 IST
UPDATE AD_Column SET FKConstraintName='CDocType_MMatchInvHdr', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-15 15:32:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212687
;

-- 15-Mar-2016 15:32:58 IST
ALTER TABLE M_MatchInvHdr ADD
 COLUMN C_DocType_ID NUMERIC(10) DEFAULT NULL 
;

-- 15-Mar-2016 15:32:58 IST
ALTER TABLE M_MatchInvHdr ADD CONSTRAINT CDocType_MMatchInvHdr FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- 15-Mar-2016 15:33:20 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204158,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200205,212687,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-15 15:33:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-15 15:33:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','baeac87f-8b98-426f-bf56-ba4dd67cc16e','Y',120,2)
;

-- 15-Mar-2016 15:33:31 IST
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-03-15 15:33:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212687
;

-- 15-Mar-2016 15:34:01 IST
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2016-03-15 15:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204158
;

-- 15-Mar-2016 15:34:06 IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2016-03-15 15:34:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204158
;

-- 16-Mar-2016 21:52:07 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204168,'Match Invoice Header',408,212553,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-16 21:52:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-16 21:52:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0eb3ca31-7113-411a-9724-54ff2bc62cf8','Y',170,2)
;

-- 16-Mar-2016 21:52:16 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_TIMESTAMP('2016-03-16 21:52:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204168
;

-- 16-Mar-2016 21:54:55 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204169,'Match Invoice Header',690,212553,'Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-16 21:54:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-16 21:54:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d2dd18e7-28c6-4f63-93c9-b08f99e7a39f','Y',140,2)
;

-- 16-Mar-2016 21:55:34 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2016-03-16 21:55:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204169
;

-- 16-Mar-2016 21:55:34 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2016-03-16 21:55:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11095
;

-- 16-Mar-2016 21:55:34 IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2016-03-16 21:55:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11186
;

-- 16-Mar-2016 21:55:34 IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2016-03-16 21:55:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11093
;

-- 16-Mar-2016 21:55:34 IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2016-03-16 21:55:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1001606
;

-- 16-Mar-2016 21:56:32 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204170,'Match Invoice Header',689,212553,'Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-16 21:56:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-16 21:56:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2e1dedeb-4799-4fef-932c-b3bcf3a3f10c','Y',130,2)
;

-- 16-Mar-2016 21:56:54 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2016-03-16 21:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204170
;

-- 16-Mar-2016 21:56:54 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2016-03-16 21:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11132
;

-- 16-Mar-2016 21:56:54 IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2016-03-16 21:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11190
;

-- 16-Mar-2016 21:56:54 IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2016-03-16 21:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11133
;

-- 16-Mar-2016 21:56:54 IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2016-03-16 21:56:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1001611
;

-- 16-Mar-2016 22:25:39 IST
UPDATE AD_Column SET FKConstraintName='Reversal_MMatchInvHdr', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-16 22:25:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212685
;

-- 16-Mar-2016 22:25:39 IST
INSERT INTO t_alter_column values('m_matchinvhdr','Reversal_ID','NUMERIC(10)',null,'NULL')
;

-- 16-Mar-2016 22:27:53 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212692,0,'Process Now',200196,'Processing',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2016-03-16 22:27:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-16 22:27:52','YYYY-MM-DD HH24:MI:SS'),100,524,'Y','N','D','N','N','N','Y','1345876d-6fd3-41cd-9fef-9328760ca8a5','N',0,'Y','N')
;

-- 17-Mar-2016 12:06:18 IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202993,0,0,'Y',TO_TIMESTAMP('2016-03-17 12:06:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-17 12:06:17','YYYY-MM-DD HH24:MI:SS'),100,'C_MatchInv_WriteOff_Acct','Match Invoice WriteOf Acct','Match Invoice WriteOf Acct','D','054f7d9f-7777-4375-9867-3b5d4c0dcc9b')
;

-- 17-Mar-2016 12:06:42 IST
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2016-03-17 12:06:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202993
;

-- 17-Mar-2016 12:06:54 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212693,0,'Match Invoice WriteOf Acct',315,'C_MatchInv_WriteOff_Acct',10,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2016-03-17 12:06:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-17 12:06:54','YYYY-MM-DD HH24:MI:SS'),100,202993,'Y','N','D','N','N','N','Y','7035a618-c7a9-459e-8180-ef7eaeb4582e','Y',0,'N','N')
;

-- 17-Mar-2016 12:07:01 IST
UPDATE AD_Column SET FKConstraintName='CMatchInvWriteOffAcct_CAcctSch', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-17 12:07:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212693
;

-- 17-Mar-2016 12:07:01 IST
ALTER TABLE C_AcctSchema_Default ADD COLUMN C_MatchInv_WriteOff_Acct NUMERIC(10) DEFAULT NULL 
;

-- 17-Mar-2016 12:07:01 IST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT CMatchInvWriteOffAcct_CAcctSch FOREIGN KEY (C_MatchInv_WriteOff_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 17-Mar-2016 12:07:33 IST
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-03-17 12:07:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212693
;

-- 17-Mar-2016 12:07:42 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204171,'Match Invoice WriteOf Acct',252,212693,'Y',10,680,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-17 12:07:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-17 12:07:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3ff75c42-01d9-4dc1-b503-a804463d4e17','Y',790,2)
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_FieldGroup_ID=113, XPosition=1,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204171
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3822
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3827
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3829
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3828
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2650
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2659
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2649
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2661
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2655
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2657
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12347
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12348
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2656
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2658
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3825
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4860
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4861
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4862
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56527
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58783
;

-- 17-Mar-2016 12:09:35 IST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2016-03-17 12:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202403
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_Element SET Name='Match Invoice WriteOff Acct', PrintName='Match Invoice WriteOff Acct',Updated=TO_TIMESTAMP('2016-03-17 12:09:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202993
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_Column SET ColumnName='C_MatchInv_WriteOff_Acct', Name='Match Invoice WriteOff Acct', Description=NULL, Help=NULL WHERE AD_Element_ID=202993
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_Process_Para SET ColumnName='C_MatchInv_WriteOff_Acct', Name='Match Invoice WriteOff Acct', Description=NULL, Help=NULL, AD_Element_ID=202993 WHERE UPPER(ColumnName)='C_MATCHINV_WRITEOFF_ACCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_Process_Para SET ColumnName='C_MatchInv_WriteOff_Acct', Name='Match Invoice WriteOff Acct', Description=NULL, Help=NULL WHERE AD_Element_ID=202993 AND IsCentrallyMaintained='Y'
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_InfoColumn SET ColumnName='C_MatchInv_WriteOff_Acct', Name='Match Invoice WriteOff Acct', Description=NULL, Help=NULL WHERE AD_Element_ID=202993 AND IsCentrallyMaintained='Y'
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_Field SET Name='Match Invoice WriteOff Acct', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202993) AND IsCentrallyMaintained='Y'
;

-- 17-Mar-2016 12:09:57 IST
UPDATE AD_PrintFormatItem SET PrintName='Match Invoice WriteOff Acct', Name='Match Invoice WriteOff Acct' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202993)
;

-- 18-Mar-2016 10:56:39 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212694,0,'Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',200196,'ProcessedOn',20,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2016-03-18 10:56:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-18 10:56:35','YYYY-MM-DD HH24:MI:SS'),100,54128,'Y','N','D','N','N','N','Y','6a87a247-b115-4b30-8845-5bca316418c8','Y',0,'N','N')
;

-- 18-Mar-2016 10:56:41 IST
ALTER TABLE M_MatchInvHdr ADD COLUMN ProcessedOn NUMERIC DEFAULT NULL 
;

-- 18-Mar-2016 11:08:50 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204172,'Process Now',200205,212692,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-18 11:08:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-18 11:08:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','816f5b38-fe99-4a6d-8728-c42f582d49b3','Y',140,2,2)
;

-- 23-Mar-2016 12:38:15 IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200119,'M_MatchInvHdr','T',0,0,'Y',TO_TIMESTAMP('2016-03-23 12:38:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-23 12:38:11','YYYY-MM-DD HH24:MI:SS'),100,'D','N','e611b9a9-31da-418d-868c-ef9257ca5a6f')
;

-- 23-Mar-2016 12:39:13 IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Window_ID,AD_Ref_Table_UU) VALUES (200119,200196,212548,212546,0,0,'Y',TO_TIMESTAMP('2016-03-23 12:39:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-23 12:39:13','YYYY-MM-DD HH24:MI:SS'),100,'N','D',200081,'3f04716f-75a3-401d-9c9e-85793d270125')
;

-- 23-Mar-2016 12:39:34 IST
UPDATE AD_Column SET AD_Reference_Value_ID=200119,Updated=TO_TIMESTAMP('2016-03-23 12:39:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212685
;

-- 23-Mar-2016 12:39:41 IST
INSERT INTO t_alter_column values('m_matchinvhdr','Reversal_ID','NUMERIC(10)',null,'NULL')
;

-- 23-Mar-2016 12:39:41 IST
ALTER TABLE M_MatchInvHdr ADD CONSTRAINT Reversal_MMatchInvHdr FOREIGN KEY (Reversal_ID) REFERENCES m_matchinvhdr(m_matchinvhdr_id) DEFERRABLE INITIALLY DEFERRED
;

-- 29-Mar-2016 18:20:10 IST
UPDATE AD_Tab SET WhereClause='M_MatchInv.M_MatchInvHdr_ID > 0',Updated=TO_TIMESTAMP('2016-03-29 18:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=408
;

-- 29-Mar-2016 18:21:53 IST
UPDATE AD_Tab SET WhereClause='Coalesce(M_MatchInv.M_MatchInvHdr_ID, 0) <= 0',Updated=TO_TIMESTAMP('2016-03-29 18:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=408
;

-- 29-Mar-2016 18:23:00 IST
UPDATE AD_Field SET IsDisplayed='N',Updated=TO_TIMESTAMP('2016-03-29 18:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204168
;

-- 29-Mar-2016 18:33:13 IST
UPDATE AD_Field SET DisplayLogic='@M_MatchInvHdr_ID@=0',Updated=TO_TIMESTAMP('2016-03-29 18:33:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204072
;

-- 29-Mar-2016 18:34:21 IST
UPDATE AD_Field SET DisplayLogic='@Processed@=Y & @#ShowAcct@=Y & @M_MatchInvHdr_ID@=0',Updated=TO_TIMESTAMP('2016-03-29 18:34:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11098
;

-- 29-Mar-2016 18:34:28 IST
UPDATE AD_Field SET DisplayLogic='@M_MatchInvHdr_ID@=0',Updated=TO_TIMESTAMP('2016-03-29 18:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11138
;

-- 29-Mar-2016 18:34:28 IST
create or replace view rv_unposted
as
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateDoc, DateAcct, 224 AS AD_Table_ID,
          GL_Journal_ID AS Record_ID, 'N' AS IsSOTrx, posted, processing,
          processed, docstatus, processedon
     from GL_JOURNAL
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT pi.AD_Client_ID, pi.AD_Org_ID, pi.Created, pi.CreatedBy, pi.Updated,
          pi.UpdatedBy, pi.IsActive, p.NAME || '_' || pi.Line,
          pi.MovementDate, pi.MovementDate, 623, pi.C_ProjectIssue_ID, 'N',
          posted, pi.processing, pi.processed, 'CO' as DocStatus, processedon
     from C_PROJECTISSUE pi INNER JOIN C_PROJECT p
          ON (pi.C_Project_ID = p.C_Project_ID)
    WHERE Posted <> 'Y'                                  --AND DocStatus<>'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateInvoiced, DateAcct, 318, C_Invoice_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from C_INVOICE
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, DateAcct, 319, M_InOut_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from M_INOUT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, MovementDate, 321,
          M_Inventory_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_INVENTORY
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, MovementDate, MovementDate, 323,
          M_Movement_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_MOVEMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, NAME, MovementDate, MovementDate, 325, M_Production_ID,
          'N', posted, processing, processed, 'CO' as docstatus, processedon
     from M_PRODUCTION
    WHERE Posted <> 'Y'                                 -- AND DocStatus<>'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, NAME, StatementDate, DateAcct, 407, C_Cash_ID, 'N',
          posted, processing, processed, docstatus, processedon
     from C_CASH
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 335, C_Payment_ID, 'N',
          posted, processing, processed, docstatus, processedon
     from C_PAYMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 735, C_AllocationHdr_ID,
          'N', posted, processing, processed, docstatus, processedon
     from C_ALLOCATIONHDR
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, NAME, StatementDate, StatementDate, 392,
          C_BankStatement_ID, 'N', posted, processing, processed, docstatus, processedon
     from C_BANKSTATEMENT
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 472, M_MatchInv_ID, 'N',
          posted, processing, processed, 'CO' as docstatus, processedon
     from M_MATCHINV
    WHERE Posted <> 'Y' AND Coalesce(M_MatchInvHdr_ID, 0) = 0                                  --AND DocStatus<>'VO'
	UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 200196, M_MatchInvHdr_ID, 'N',
          posted, processing, processed, docstatus, processedon
     from M_MATCHINVHDR
    WHERE Posted <> 'Y'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateTrx, DateAcct, 473, M_MatchPO_ID, 'N',
          posted, processing, processed, 'CO' as docstatus, processedon
     from M_MATCHPO
    WHERE Posted <> 'Y'                                  --AND DocStatus<>'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateOrdered, DateAcct, 259, C_Order_ID,
          IsSOTrx, posted, processing, processed, docstatus, processedon
     from C_ORDER
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
   UNION
   SELECT AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy,
          IsActive, DocumentNo, DateRequired, DateRequired, 702,
          M_Requisition_ID, 'N', posted, processing, processed, docstatus, processedon
     from M_REQUISITION
    WHERE Posted <> 'Y' AND DocStatus <> 'VO'
;

-- Jan 22, 2016 11:53:09 AM IST
SELECT register_migration_script('201603162040_IDEMPIERE-2618.sql') FROM dual
;