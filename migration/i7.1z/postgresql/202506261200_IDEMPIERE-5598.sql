-- IDEMPIERE-5598 : Add accounting dimension fields (A_Asset_ID, C_Employee_ID, C_CostCenter_ID, C_Department_ID, M_Warehouse_ID) to C_ProjectIssue table
-- Jun 26, 2025, 11:59:07 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217134,0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',623,'A_Asset_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2025-06-26 11:59:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 11:59:07','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','N','N','N','Y','fedc058b-8e8c-430f-a05e-f6031b38e2ae','Y',0,'N','N','N','N','N')
;

-- Jun 26, 2025, 11:59:10 AM IST
UPDATE AD_Column SET FKConstraintName='AAsset_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-06-26 11:59:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217134
;

-- Jun 26, 2025, 11:59:10 AM IST
ALTER TABLE C_ProjectIssue ADD COLUMN A_Asset_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 26, 2025, 11:59:10 AM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT AAsset_CProjectIssue FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 26, 2025, 11:59:33 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217135,0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',623,'C_Employee_ID',10,'N','N','N','N','N',0,'N',18,252,0,0,'Y',TO_TIMESTAMP('2025-06-26 11:59:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 11:59:30','YYYY-MM-DD HH24:MI:SS'),100,203893,'Y','N','D','N','N','N','Y','8ee1ebc1-b5ce-4472-9fe1-38e168a27f9c','Y',0,'N','N','N','N','N')
;

-- Jun 26, 2025, 11:59:34 AM IST
UPDATE AD_Column SET FKConstraintName='CEmployee_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-06-26 11:59:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217135
;

-- Jun 26, 2025, 11:59:34 AM IST
ALTER TABLE C_ProjectIssue ADD COLUMN C_Employee_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 26, 2025, 11:59:34 AM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CEmployee_CProjectIssue FOREIGN KEY (C_Employee_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 26, 2025, 11:59:45 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217136,0,'Cost Center',623,'C_CostCenter_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-06-26 11:59:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 11:59:44','YYYY-MM-DD HH24:MI:SS'),100,203903,'Y','N','D','N','N','N','Y','eef2a9d2-00a9-412f-b8b7-5c707d447295','Y',0,'N','N','N','N','N')
;

-- Jun 26, 2025, 11:59:46 AM IST
UPDATE AD_Column SET FKConstraintName='CCostCenter_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-06-26 11:59:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217136
;

-- Jun 26, 2025, 11:59:46 AM IST
ALTER TABLE C_ProjectIssue ADD COLUMN C_CostCenter_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 26, 2025, 11:59:46 AM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CCostCenter_CProjectIssue FOREIGN KEY (C_CostCenter_ID) REFERENCES c_costcenter(c_costcenter_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 26, 2025, 11:59:56 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217137,0,'Department',623,'C_Department_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-06-26 11:59:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 11:59:56','YYYY-MM-DD HH24:MI:SS'),100,203901,'Y','N','D','N','N','N','Y','e53235ff-0705-4aae-968c-671af206b56b','Y',0,'N','N','N','N','N')
;

-- Jun 26, 2025, 11:59:58 AM IST
UPDATE AD_Column SET FKConstraintName='CDepartment_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-06-26 11:59:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217137
;

-- Jun 26, 2025, 11:59:58 AM IST
ALTER TABLE C_ProjectIssue ADD COLUMN C_Department_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 26, 2025, 11:59:58 AM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CDepartment_CProjectIssue FOREIGN KEY (C_Department_ID) REFERENCES c_department(c_department_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 26, 2025, 12:00:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217138,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',623,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:11','YYYY-MM-DD HH24:MI:SS'),100,459,'Y','N','D','N','N','N','Y','0f7360b2-9fda-42e1-a30e-ec6c13b5cf8c','Y',0,'N','N','N','N','N')
;

-- Jun 26, 2025, 12:00:13 PM IST
UPDATE AD_Column SET FKConstraintName='MWarehouse_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-06-26 12:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217138
;

-- Jun 26, 2025, 12:00:13 PM IST
ALTER TABLE C_ProjectIssue ADD COLUMN M_Warehouse_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 26, 2025, 12:00:13 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT MWarehouse_CProjectIssue FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 26, 2025, 12:00:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208824,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',558,217134,'Y',22,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','42c511b4-fc71-44e1-966f-0fcdee8ed0f0','Y',210,2)
;

-- Jun 26, 2025, 12:00:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208825,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',558,217135,'Y',10,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','32c147d4-daee-4355-9cd7-19ae1018ad56','Y',220,2)
;

-- Jun 26, 2025, 12:00:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208826,'Cost Center',558,217136,'Y','@$Element_CC@=Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3b4b84e-7885-4e11-9821-1f2544994663','Y',230,2)
;

-- Jun 26, 2025, 12:00:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208827,'Department',558,217137,'Y','@$Element_DP@=Y',22,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63205c56-eeca-4aba-bb78-e80dd5738183','Y',240,2)
;

-- Jun 26, 2025, 12:00:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208828,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',558,217138,'Y',22,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-26 12:00:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-26 12:00:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0d2e199-ed82-4435-a955-035741c2ef9d','Y',250,2)
;

-- Jun 26, 2025, 12:03:58 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_AS@=Y', AD_FieldGroup_ID=200032, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:03:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208824
;

-- Jun 26, 2025, 12:05:22 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_EP@=Y', AD_FieldGroup_ID=200032, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:05:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208825
;

-- Jun 26, 2025, 12:05:52 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:05:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208826
;

-- Jun 26, 2025, 12:06:01 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=200032, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208827
;

-- Jun 26, 2025, 12:06:21 PM IST
UPDATE AD_Field SET DisplayLogic='@$Element_WH@=Y', AD_FieldGroup_ID=200032, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:06:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208828
;

-- Jun 26, 2025, 12:06:46 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:06:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208826
;

-- Jun 26, 2025, 12:06:46 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:06:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208825
;

-- Jun 26, 2025, 12:06:46 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-26 12:06:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208827
;

SELECT register_migration_script('202506261200_IDEMPIERE-5598.sql') FROM dual;
;
