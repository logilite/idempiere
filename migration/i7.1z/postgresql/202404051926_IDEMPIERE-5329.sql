-- Adding Currency field on Deposit batch window
-- Apr 4, 2024, 6:01:37 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='C_BankAccount_ID', AD_Reference_Value_ID=NULL, Callout='org.compiere.model.CalloutDepositBatch.bankAccount', AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208412
;

-- Apr 4, 2024, 6:01:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216588,0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200056,'C_Currency_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','Y','N','N','Y','0cec46ff-7504-42bf-a823-90399ce75d81','Y',0,'N','N','CCurrency_CDepositBatch','N','N','N')
;

-- Apr 4, 2024, 6:01:38 PM IST
ALTER TABLE C_DepositBatch ADD COLUMN C_Currency_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 4, 2024, 6:01:38 PM IST
UPDATE AD_Field SET SeqNo=0, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201697
;

-- Apr 4, 2024, 6:01:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (208478,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200067,216588,'Y',22,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e4cf1144-8ef6-4fa0-a6c8-942cde6ac240','Y',150,4,2,1,'N','N','N','N','N')
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=90, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201699
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=100, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201696
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=110, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201695
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=120, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201702
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=130, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201692
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=140, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207524
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=150, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201706
;

-- Apr 4, 2024, 6:01:39 PM IST
ALTER TABLE C_DepositBatch ADD CONSTRAINT CCurrency_CDepositBatch FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 4, 2024, 6:01:44 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Could not modify the currency once batch line has been added',0,0,'Y',TO_TIMESTAMP('2024-04-04 18:01:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-04 18:01:43','YYYY-MM-DD HH24:MI:SS'),100,200883,'ErrorCurrencyCouldNotModify','D','364c0fa3-a697-4fab-b978-aa52ede0e591')
;

-- Apr 4, 2024, 6:01:44 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Multiple currency payments are not allowed in a single batch. All batch line payments must be in the {0} currency',0,0,'Y',TO_TIMESTAMP('2024-04-04 18:01:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-04 18:01:44','YYYY-MM-DD HH24:MI:SS'),100,200884,'ErrorMultipleCurrencyPaymentsRestricted','D','d9a2d982-22d8-4c26-b820-e0894411da3b')
;

-- Apr 4, 2024, 6:01:48 PM IST
UPDATE C_DepositBatch SET C_Currency_ID = (SELECT C_Currency_ID FROM C_BankAccount WHERE C_BankAccount_ID = ba.C_BankAccount_ID) FROM C_BankAccount ba WHERE ba.C_BankAccount_ID = C_DepositBatch.C_BankAccount_ID
;

-- Apr 4, 2024, 6:01:48 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='C_Currency_ID', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2024-04-04 18:01:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216588
;

-- Apr 4, 2024, 6:01:49 PM IST
INSERT INTO t_alter_column values('c_depositbatch','C_Currency_ID','NUMERIC(10)',null,null,null)
;

-- Apr 4, 2024, 6:01:49 PM IST
INSERT INTO t_alter_column values('c_depositbatch','C_Currency_ID',null,'NOT NULL',null,null)
;

SELECT register_migration_script('202404051926_IDEMPIERE-5329.sql') FROM dual
;
