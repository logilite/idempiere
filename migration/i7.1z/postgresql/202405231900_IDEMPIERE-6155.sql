-- Add Invoice Vendor support in Issue Project Process
-- 23-May-2024, 6:39:07 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200190,'Invoice Line','Vendor Invoice Line as Document Completed or Closed','S','C_InvoiceLine.C_InvoiceLine_ID In (SELECT cil.C_InvoiceLine_ID FROM C_InvoiceLine cil Inner Join C_Invoice ci On ci.C_Invoice_ID=cil.C_Invoice_ID Where ci.DocStatus In ( ''CL'', ''CO'') And ci.IsSOTrx=''N'' And cil.C_Charge_ID IS Not Null Except Select C_InvoiceLine_ID FROM C_ProjectIssue)',0,0,'Y',TO_TIMESTAMP('2024-05-23 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-23 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'D','ab71eb7a-e64d-4c68-887e-14b46a3809c1')
;

-- 23-May-2024, 6:43:00 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200483,0,0,'Y',TO_TIMESTAMP('2024-05-23 18:42:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-23 18:42:59','YYYY-MM-DD HH24:MI:SS'),100,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',224,35,19,'N',200190,0,'N','C_InvoiceLine_ID','Y','D',1076,'5021cb15-2b9e-428b-ac02-0bb4d27c3fdf','N')
;

-- 23-May-2024, 6:44:29 PM IST
UPDATE AD_Process SET Help='Select a project and one of the following items to process
<br>- Material Receipt
<br>- Expense Report
<br>- Vendor Invoice Line
<br>- Inventory Location and Project Line Which is not issued yet
<br>- Inventory Location, Product and Quantity
<br>- The default Movement Date is today''s date.',Updated=TO_TIMESTAMP('2024-05-23 18:44:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=224
;

-- May 27, 2024, 4:10:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross) VALUES (216608,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',623,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-05-27 16:10:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:10:10','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','N','N','Y','faad5d09-99a7-4c22-8a47-2a7769872d5c','Y',0,'N','N','N','N')
;

-- May 27, 2024, 4:10:53 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216609,0,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',623,'C_InvoiceLine_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-05-27 16:10:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:10:52','YYYY-MM-DD HH24:MI:SS'),100,1076,'N','N','D','N','N','N','Y','379fb39b-67aa-47bf-a289-bfd62d5c6f34','Y',0,'N','N','N','N','N')
;

-- May 27, 2024, 4:11:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross) VALUES (216610,0,'Amount','Amount','Amount',623,'Amt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2024-05-27 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,160,'Y','N','D','N','N','N','Y','c897c6fc-1f32-457c-ae6d-72b5b812a500','Y',0,'N','N','N','N')
;

-- May 27, 2024, 4:11:22 PM IST
ALTER TABLE C_ProjectIssue ADD COLUMN Amt NUMERIC DEFAULT NULL
;

-- May 27, 2024, 4:11:27 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-05-27 16:11:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216608
;

-- May 27, 2024, 4:11:27 PM IST
ALTER TABLE C_ProjectIssue ADD COLUMN C_Charge_ID NUMERIC(10) DEFAULT NULL
;

-- May 27, 2024, 4:11:27 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CCharge_CProjectIssue FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 27, 2024, 4:11:31 PM IST
UPDATE AD_Column SET FKConstraintName='cinvoiceline_cprojectissue', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-05-27 16:11:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216609
;

-- May 27, 2024, 4:11:31 PM IST
ALTER TABLE C_ProjectIssue ADD COLUMN C_InvoiceLine_ID NUMERIC(10) DEFAULT NULL
;

-- May 27, 2024, 4:11:31 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CInvoiceLine_CProjectIssue FOREIGN KEY (C_InvoiceLine_ID) REFERENCES c_invoiceline(c_invoiceline_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 27, 2024, 4:12:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208489,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',558,216608,'Y',10,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7bf21ed-15ae-4ddc-929d-7c9a6fba5ef3','Y',180,2)
;

-- May 27, 2024, 4:12:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208490,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',558,216609,'Y',22,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5dd58128-ea00-4d31-b4ef-ccbf08f1dc8c','Y',190,2)
;

-- May 27, 2024, 4:12:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208491,'Amount','Amount','Amount',558,216610,'Y',22,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-05-27 16:12:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-27 16:12:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ece669f-4aa1-4e71-b0b5-79403751aa84','Y',200,2)
;

-- May 27, 2024, 4:13:18 PM IST
UPDATE AD_Field SET SeqNo=115, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=115, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- May 27, 2024, 4:14:12 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=110, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:14:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:14:23 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:14:42 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:15:14 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@!0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:15:28 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Charge_ID@!0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:15:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- May 27, 2024, 4:15:41 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@>0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:15:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8225
;

-- May 27, 2024, 4:17:34 PM IST
UPDATE AD_Field SET SeqNo=154, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=154, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:17:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- May 27, 2024, 4:18:04 PM IST
UPDATE AD_Field SET SeqNo=157, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=157, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-27 16:18:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@M_Product_ID@>0',Updated=TO_TIMESTAMP('2024-05-28 12:55:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9854
;

-- May 28, 2024, 12:56:00 PM IST
INSERT INTO t_alter_column values('c_projectissue','M_Locator_ID','NUMERIC(10)',null,'NULL',null)
;

-- May 28, 2024, 12:56:00 PM IST
INSERT INTO t_alter_column values('c_projectissue','M_Locator_ID',null,'NULL',null,null)
;

-- May 28, 2024, 12:56:24 PM IST
UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@C_Charge_ID@!0',Updated=TO_TIMESTAMP('2024-05-28 12:56:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9852
;

-- May 28, 2024, 12:56:26 PM IST
INSERT INTO t_alter_column values('c_projectissue','M_Product_ID','NUMERIC(10)',null,'NULL',null)
;

-- May 28, 2024, 12:56:26 PM IST
INSERT INTO t_alter_column values('c_projectissue','M_Product_ID',null,'NULL',null,null)
;

-- May 28, 2024, 6:11:14 PM IST
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8212
;

-- May 28, 2024, 6:13:17 PM IST
UPDATE AD_Field SET SeqNo=135, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=135, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-05-28 18:13:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8212
;

-- Update Reference Id for Invoice Parameter of Issue Project Process
-- Jun 5, 2024, 7:03:56 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2024-06-05 19:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200483
;

SELECT register_migration_script('202405231900_IDEMPIERE-6155.sql') FROM dual
;