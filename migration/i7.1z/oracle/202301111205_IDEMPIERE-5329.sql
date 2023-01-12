SET SQLBLANKLINES ON
SET DEFINE OFF

-- DocAction on Payments into Batch
-- Jan 10, 2023, 5:40:55 PM IST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,AD_Process_UU) VALUES (200148,0,0,'Y',TO_DATE('2023-01-10 17:40:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:54','YYYY-MM-DD HH24:MI:SS'),100,'Process Deposit Batch','N','C_DepositBatch_Process','N','1','D',0,0,'N','N','Y','e0b1e41b-3df9-4ad2-8651-19831e5a8c88')
;

-- Jan 10, 2023, 5:40:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215739,0,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200056,'DocAction','CO',2,'N','N','N','N','N',0,'N',28,135,0,0,'Y',TO_DATE('2023-01-10 17:40:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:55','YYYY-MM-DD HH24:MI:SS'),100,287,'Y',200148,'N','D','Y','N','N','Y','4ebc56d7-9ec7-403b-b420-41601d596703','Y',0,'B','N','N','N')
;

-- Jan 10, 2023, 5:40:56 PM IST
ALTER TABLE C_DepositBatch ADD DocAction CHAR(2) DEFAULT 'CO'
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET Name='Deposit Batch Close', IsDisplayed='N', DisplayLogic='@DepositAmt@!0', SeqNo=0, IsCentrallyMaintained='Y', AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, XPosition=1, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201705
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, IsReadOnly='Y', AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsAllowCopy='N', IsDisplayedGrid='Y', XPosition=4, ColumnSpan=2, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201702
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET SeqNo=120, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201692
;

-- Jan 10, 2023, 5:40:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207524,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200067,215739,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','6c80ff6d-aef6-47cc-af76-24bbb214672f','Y',140,5,2,1,'N','N','N','N')
;

-- Jan 10, 2023, 5:40:57 PM IST
UPDATE AD_Field SET SeqNo=140, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201706
;

-- Jan 10, 2023, 5:40:58 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Payments that have been reconciled cannot be reactivated.',0,0,'Y',TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),100,200815,'NotAllowReActivationOfReconciledPaymentsIntoBatch','U','81de985a-e9f0-42a3-9546-d837058f5144')
;

-- Jan 10, 2023, 5:40:58 PM IST
update c_depositbatch set docstatus = 'CO', docaction = 'CL' where processed = 'Y'
;

-- Jan 10, 2023, 5:40:58 PM IST
UPDATE AD_Val_Rule SET Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus NOT IN (''VO'')) AND C_DepositBatch.processed = ''Y'' AND C_DepositBatch.docstatus NOT IN (''VO'') AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_DATE('2023-01-11 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;

-- 10-Jan-2023, 7:25:59 PM IST
INSERT INTO AD_Workflow (Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AccessLevel,EntityType,Author,WorkingTime,Duration,Version,Cost,DurationUnit,WaitingTime,PublishStatus,IsDefault,AD_Table_ID,Value,WorkflowType,IsValid,DocumentNo,QtyBatchSize,IsBetaFunctionality,Yield,AD_Workflow_UU,IsTemplate) VALUES ('Process_DepositBatch','(Standard Process Deposit Batch)',200012,0,0,'Y',TO_DATE('2023-01-10 19:25:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:25:58','YYYY-MM-DD HH24:MI:SS'),100,'1','D','Logilite',0,1,0,0,'D',0,'R','N',200056,'Process_DepositBatch','P','N','10000000',1,'N',100,'d82b7be1-3e7c-454f-a575-36e93dc871bd','N')
;

-- 10-Jan-2023, 7:26:00 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID,isAllowMore,isMFGDateReq) VALUES (200033,'(Start)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:25:59','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(Start)',0,'N','N',0,0,100,'e14fa3f8-11c7-4487-b238-24b778cfd6a0',200002,'N','N')
;

-- 10-Jan-2023, 7:26:01 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID,isAllowMore,isMFGDateReq) VALUES (200034,'(DocPrepare)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,'X','X',0,'PR','(DocPrepare)',0,'N','N',0,0,100,'1d45b0f0-df4a-40ee-b2d3-6e0a70eec66f',200002,'N','N')
;

-- 10-Jan-2023, 7:26:02 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID,isAllowMore,isMFGDateReq) VALUES (200035,'(DocComplete)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(DocComplete)',0,'N','N',0,0,100,'67dd1b28-ec9a-445b-9430-7ef6ffa8317f',200002,'N','N')
;

-- 10-Jan-2023, 7:26:03 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID,isAllowMore,isMFGDateReq) VALUES (200036,'(DocAuto)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'--','(DocAuto)',0,'N','N',0,0,100,'159a3542-64ea-475e-a9c2-6feadac39b7f',200002,'N','N')
;

-- 10-Jan-2023, 7:26:03 PM IST
UPDATE AD_Workflow SET AD_WF_Node_ID=200033, IsValid='Y',Updated=TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200012
;

-- 10-Jan-2023, 7:26:04 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200033,'Y',TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,200034,'D',10,'(Standard Approval)',200031,'Y','d7b15e20-ef42-4ab6-9960-1a366ee8d102')
;

-- 10-Jan-2023, 7:26:04 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200033,'Y',TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,0,0,200036,'D',100,'(Standard Transition)',200032,'N','e32796ad-f155-4af8-9723-f1002fdd9691')
;

-- 10-Jan-2023, 7:26:05 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200034,'Y',TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,0,0,200035,'D',10,'(Standard Transition)',200033,'N','bad45235-9dfc-4ba0-b04e-be6bae193884')
;

-- 10-Jan-2023, 7:56:14 PM IST
UPDATE AD_Process SET AD_Workflow_ID=200012,Updated=TO_DATE('2023-01-10 19:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200148
;

SELECT register_migration_script('202301111205_DepositBatchDocAction.sql') FROM dual
;