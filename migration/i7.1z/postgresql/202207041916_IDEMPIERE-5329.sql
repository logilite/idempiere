-- Multiple Payments against single Bank/Cash statement line
SELECT register_migration_script('202207041916_IDEMPIERE-5329.sql') FROM dual;

-- 04-Jul-2022, 7:16:06 PM IST
UPDATE AD_Table SET AD_Window_ID=200031, AD_Val_Rule_ID=NULL, PO_Window_ID=NULL, Processing='N',Updated=TO_TIMESTAMP('2022-07-04 19:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200056
;

-- Payment into Batch Info Window
-- 04-Jul-2022, 7:16:56 PM IST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize,PageSize) VALUES (200020,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,'Payment Into Batch Info',200056,'D','C_DepositBatch a','N','7f250d6a-7f8d-4d49-86cd-25a6fb822568','N','N','a.DocumentNo DESC','Y',1760,'Y',0,'Y',0,0)
;

-- 04-Jul-2022, 7:16:57 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200228,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Amount',200020,'D','a.DepositAmt',90,'Y','N',202198,12,'c41c9b30-aa8e-48f3-8b46-3874b2e89761','Y','DepositAmt','N',0,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:16:57 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200229,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Batch',200020,'D','a.C_DepositBatch_ID',10,'N','N',202195,13,'27567c5a-4fba-4b88-98bb-48eb98e727e8','Y','C_DepositBatch_ID','N',0,'N','Y','Y','N','N')
;

-- 04-Jul-2022, 7:16:58 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200230,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200020,'D','a.AD_Org_ID',20,'Y','N',113,19,'d0f2f031-c9b3-42a0-b59b-7f4fe6a01927',104,'Y','AD_Org_ID','N',0,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:16:59 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200231,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:58','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200020,'D','a.C_BankAccount_ID',30,'Y','N',836,19,'6f1fa8aa-551c-48b0-9b14-d04a1df6bae6','Y','C_BankAccount_ID','N',0,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:00 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200232,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:16:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:16:59','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Date',200020,'D','a.DateDeposit',40,'Y','Y',202197,15,'f9df0759-b0b4-4f97-b792-d738507d5bdd','Y','DateDeposit','=','Trunc','Y',10,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:00 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200233,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200020,'D','a.C_DocType_ID',50,'Y','N',196,19,'cfebd86d-1a33-40dd-899c-a61902785694',149,'Y','C_DocType_ID','N',0,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:01 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200234,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200020,'D','a.DocumentNo',60,'Y','Y',290,10,'af50b3a8-b062-428a-9855-81306b658141','Y','DocumentNo','Like','Upper','Y',20,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:02 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200235,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:01','YYYY-MM-DD HH24:MI:SS'),100,'Document Date','Date of the Document','The Document Date indicates the date the document was generated.  It may or may not be the same as the accounting date.',200020,'D','a.DateDoc',70,'Y','N',265,15,'b83406df-a8b2-47a9-8679-8ab09df77f14','Y','DateDoc','N',0,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:03 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsHideInfoColumn,IsMultiSelectCriteria) VALUES (200236,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:02','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200020,'D','a.Description',80,'Y','Y',275,10,'3e83eadb-739b-4567-8683-fa30f9186d4b','Y','Description','Like','Upper','N',30,'N','N','Y','N','N')
;

-- 04-Jul-2022, 7:17:09 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200161,'Deposit Batch (Proccsed)','S','C_DepositBatch.Processed= ''Y'' AND C_DepositBatch.AD_Org_ID = (SELECT AD_Org_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@ )',0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:08','YYYY-MM-DD HH24:MI:SS'),100,'D','ff157c8d-0b2f-4a67-8495-ba65c4a6e92a')
;

-- 04-Jul-2022, 7:17:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215034,0,'Deposit Batch',393,200161,'C_DepositBatch_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:09','YYYY-MM-DD HH24:MI:SS'),100,'org.compiere.model.CalloutBankStatement.paymentIntoBatch',202195,'Y','N','D','Y','N','N','Y','5f21b30b-379f-4a52-89b0-4d861efda1f8','Y',0,'N','N','CDepositBatch_CBankStatementLi','N','N')
;

-- 04-Jul-2022, 7:17:10 PM IST
ALTER TABLE C_BankStatementLine ADD COLUMN C_DepositBatch_ID NUMERIC(10) DEFAULT NULL 
;

-- 04-Jul-2022, 7:17:10 PM IST
UPDATE AD_Field SET SeqNo=105, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4122
;

-- 04-Jul-2022, 7:17:10 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, ReadOnlyLogic='@C_DepositBatch_ID@ > 0', IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4010
;

-- 04-Jul-2022, 7:17:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,ReadOnlyLogic,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207123,'Deposit Batch',329,215034,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc246aa8-5d7a-4c0a-8d3a-59e020be60ca','Y',350,4,2,1,'N','@C_Payment_ID@ > 0 ','N','N','N')
;

-- 04-Jul-2022, 7:17:11 PM IST
ALTER TABLE C_BankStatementLine ADD CONSTRAINT CDepositBatch_CBankStatementLi FOREIGN KEY (C_DepositBatch_ID) REFERENCES c_depositbatch(c_depositbatch_id) DEFERRABLE INITIALLY DEFERRED
;

UPDATE AD_Val_Rule SET Name='C_DepositBatch not in BankStatement', Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus NOT IN (''VO'')) AND C_DepositBatch.processed = ''Y'' AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_TIMESTAMP('2022-07-06 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;

-- Jul 6, 2022, 4:28:52 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Cannot set value of Payment and Deposit Batch field at a time',0,0,'Y',TO_TIMESTAMP('2022-07-06 16:28:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-06 16:28:51','YYYY-MM-DD HH24:MI:SS'),100,200769,'NotSetBothValue_Payment_And_DepositBatch','D','9812b0ad-d789-46dd-8090-4978666c6b8a')
;

-- Jul 6, 2022, 4:28:53 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Deposit Batch is not Processed',0,0,'Y',TO_TIMESTAMP('2022-07-06 16:28:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-06 16:28:52','YYYY-MM-DD HH24:MI:SS'),100,200770,'DepositBatchIsNotProcessed','D','c3985aca-0da4-4bbf-b48b-035a4c9ed823')
;

-- Jul 6, 2022, 4:28:54 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Fail to get Payments Into Batch amount',0,0,'Y',TO_TIMESTAMP('2022-07-06 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-06 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,200772,'BankStmt_PaymentIntoBatch','D','78f49a7e-e646-48b8-a325-a834b1ba1ed1')
;

-- 07-Jul-2022, 6:18:54 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Payment is already Reconciled ',0,0,'Y',TO_TIMESTAMP('2022-07-07 18:18:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-07 18:18:53','YYYY-MM-DD HH24:MI:SS'),100,200773,'PaymentIsAlreadyReconciled','D','7b7ac70e-21fd-49a3-81c8-395cae858331')
;
