-- Merge Correction script against IDEMPIERE-5598
-- \i7.1z\*\202405141359_IDEMPIERE-5598.sql
-- \iD13\*\202405141359_IDEMPIERE-5598.sql [ Removed ]


-- IDEMPIERE-5598 Add new Accounting Dimensions
SELECT register_migration_script('202405141400_IDEMPIERE-5598_MergeCorrection.sql') FROM dual;


UPDATE AD_Column SET AD_Reference_ID=200231, UPDATED=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Column_ID = 216353
;

UPDATE AD_Column SET AD_Reference_ID=200231, UPDATED=TO_TIMESTAMP('2024-01-23 15:30:55','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Column_ID = 216361
;

-- Jan 23, 2024, 5:32:05 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (2,'Delete Confirmation Logic',TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),'N',0,'Delete Confirmation Logic',0,0,214937,'N','Y',100,0,200415,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:04','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ea90cb03-330b-4041-b023-f0a08f896f62')
;

-- Jan 23, 2024, 5:32:19 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (27,'High Volume',TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),'N',0,'High Volume',0,0,214663,'N','Y',100,0,200440,100,'N',0,TO_TIMESTAMP('2024-01-23 17:32:18','YYYY-MM-DD HH24:MI:SS'),200018,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','51337c23-8622-4d9a-a4f3-d18c6a2972a1')
;

-- May 10, 2024, 3:09:27 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_CAcctSchemaElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-05-10 15:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

-- May 10, 2024, 3:09:27 PM IST
ALTER TABLE C_AcctSchema_Element ADD CONSTRAINT MAttributeSetInstance_CAcctSchemaElement FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 6, 2024, 1:18:53 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_FactAcctSummary', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-06 13:18:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216925
;

-- Dec 6, 2024, 1:18:53 PM IST
ALTER TABLE Fact_Acct_Summary ADD CONSTRAINT MAttributeSetInstance_FactAcctSummary FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 6:57:52 PM IST
ALTER TABLE C_PaymentTransaction ADD CONSTRAINT CDepartment_CPaymentTransaction FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 19, 2024, 6:58:27 PM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CPaymentTransaction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-19 18:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216940
;

-- Dec 19, 2024, 6:58:27 PM IST
ALTER TABLE C_PaymentTransaction ADD CONSTRAINT CCostCenter_CPaymentTransaction FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 24, 2024, 6:11:17 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-24 18:11:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216993
;

-- Dec 24, 2024, 6:11:17 PM IST
ALTER TABLE GL_Distribution ADD CONSTRAINT MAttributeSetInstance_GLDistribution FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 12:20:08 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 12:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216997
;

-- Dec 26, 2024, 12:20:08 PM IST
ALTER TABLE GL_DistributionLine ADD CONSTRAINT MAttributeSetInstance_GLDistributionLine FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 26, 2024, 3:25:37 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-26 15:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217010
;

-- Dec 26, 2024, 3:25:37 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT MAttributeSetInstance_GLJournalLine FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;



-- Feb 17, 2025, 11:46:08 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217041,0,'Custom FieldText 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText1',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:46:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:46:07','YYYY-MM-DD HH24:MI:SS'),100,203894,'Y','N','D','N','N','N','Y','21808c30-4093-420a-a6ad-4fa98046444f','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:46:10 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN CustomFieldText1 VARCHAR(255) DEFAULT NULL 
;

-- Feb 17, 2025, 11:46:18 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217042,0,'Text Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText2',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:46:18','YYYY-MM-DD HH24:MI:SS'),100,203895,'Y','N','D','N','N','N','Y','6d88b10c-6a3f-4b83-a7f4-0842c19daa9b','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:46:20 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN CustomFieldText2 VARCHAR(255) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:34 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217034,0,'Text Column 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText3',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:33','YYYY-MM-DD HH24:MI:SS'),100,203896,'Y','N','D','N','N','N','Y','bd6cb537-fdec-44e8-b2a2-83c386198a8c','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:36 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN CustomFieldText3 VARCHAR(255) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:57 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217040,0,'Text Column 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'CustomFieldText4',255,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,203897,'Y','N','D','N','N','N','Y','c95447de-8006-44c3-a270-98689358403e','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:59 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN CustomFieldText4 VARCHAR(255) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:46 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217035,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200420,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:46','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','N','N','N','Y','f7cf511f-4b14-408f-b9ac-eb2d909ef94b','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:50 AM IST
UPDATE AD_Column SET FKConstraintName='CCharge_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217035
;

-- Feb 17, 2025, 11:44:50 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN C_Charge_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:50 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CCharge_TFactAcctHistory FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:15 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217037,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200420,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:15','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','5871e09b-0dd7-4bd1-ab29-5bcd48100177','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:18 AM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217037
;

-- Feb 17, 2025, 11:45:18 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN M_Warehouse_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:18 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT MWarehouse_TFactAcctHistory FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:41 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217039,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200420,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:40','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','386cacb5-ec16-4f81-ac00-20a893e95f26','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:43 AM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217039
;

-- Feb 17, 2025, 11:45:43 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN C_Employee_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:43 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CEmployee_TFactAcctHistory FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:28 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217038,0,'Department',200420,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:27','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','443830dc-dab8-4fd6-aa3e-6d69c8a5d12c','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:30 AM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217038
;

-- Feb 17, 2025, 11:45:30 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN C_Department_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:30 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CDepartment_TFactAcctHistory FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:44:05 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217033,0,'Cost Center',200420,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','15e2f7e3-74ed-49c1-85ea-6eb8203678f4','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:44:08 AM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:44:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217033
;

-- Feb 17, 2025, 11:44:08 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN C_CostCenter_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:44:08 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT CCostCenter_TFactAcctHistory FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 17, 2025, 11:45:01 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217036,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200420,'M_AttributeSetInstance_ID',22,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2025-02-17 11:45:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-02-17 11:45:01','YYYY-MM-DD HH24:MI:SS'),100,2019,'Y','N','D','N','N','N','Y','dd26f228-fd33-40a8-951f-eed7b78b5839','Y',0,'N','N','N','N','N')
;

-- Feb 17, 2025, 11:45:03 AM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_TFactAcctHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-02-17 11:45:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217036
;

-- Feb 17, 2025, 11:45:03 AM IST
ALTER TABLE T_Fact_Acct_History ADD COLUMN M_AttributeSetInstance_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 17, 2025, 11:45:03 AM IST
ALTER TABLE T_Fact_Acct_History ADD CONSTRAINT MAttributeSetInstance_TFactAcctHistory FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

