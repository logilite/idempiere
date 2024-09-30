-- Update Project Issue Tab related changes
-- Jul 19, 2024, 11:14:49 AM IST
UPDATE AD_Tab SET IsInsertRecord='Y',Updated=TO_TIMESTAMP('2024-07-19 11:14:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=558
;

-- Jul 19, 2024, 11:17:28 AM IST
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@S_TimeExpenseLine_ID@!0 | @C_InvoiceLine_ID@!0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:17:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8236
;

-- Jul 19, 2024, 11:17:47 AM IST
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@!0 | @M_InOutLine_ID@!0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:17:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8235
;

-- Jul 19, 2024, 11:18:05 AM IST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:18:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206738
;

-- Jul 19, 2024, 11:18:36 AM IST
UPDATE AD_Field SET SeqNo=134, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@S_TimeExpenseLine_ID@!0 | @M_InOutLine_ID@!0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:18:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- Jul 19, 2024, 11:18:54 AM IST
UPDATE AD_Field SET SeqNo=137, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:18:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

-- Jul 19, 2024, 11:18:58 AM IST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 11:18:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8215
;

-- Jul 19, 2024, 11:22:19 AM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200190, Callout='org.compiere.model.CalloutProjectIssue.setData', IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-07-19 11:22:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216609
;

-- Jul 19, 2024, 11:22:22 AM IST
INSERT INTO t_alter_column values('c_projectissue','C_InvoiceLine_ID','NUMERIC(10)',null,'NULL',null)
;

-- Jul 19, 2024, 11:22:56 AM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutProjectIssue.setData',Updated=TO_TIMESTAMP('2024-07-19 11:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9863
;

-- Jul 19, 2024, 11:23:00 AM IST
INSERT INTO t_alter_column values('c_projectissue','S_TimeExpenseLine_ID','NUMERIC(10)',null,'NULL',null)
;

-- Jul 19, 2024, 11:24:42 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200191,'M_InOutLine Receipts of Project','S','(M_InOutLine.C_Project_ID IS NULL OR M_InOutLine.C_Project_ID=@C_Project_ID@) AND M_InOutLine.Processed=''Y'' AND M_InOut_ID In (Select M_InOut_ID From M_InOut Where IsSOTrx=''N'') And M_InOutLine.M_Product_ID > 0 AND M_InOutLine_ID NOT IN (SELECT DISTINCT M_InOutLine_ID FROM C_ProjectIssue WHERE DocStatus NOT IN (''VO'',''RE'') AND M_InOutLine_ID IS NOT NULL)',0,0,'Y',TO_TIMESTAMP('2024-07-19 11:24:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-19 11:24:42','YYYY-MM-DD HH24:MI:SS'),100,'D','be447241-7154-4d7c-a3f6-385c18ebcc3e')
;

-- Jul 19, 2024, 11:25:42 AM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200191, Callout='org.compiere.model.CalloutProjectIssue.setData',Updated=TO_TIMESTAMP('2024-07-19 11:25:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9864
;

-- Jul 19, 2024, 6:02:45 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@S_TimeExpenseLine_ID@>0 | @M_InOut_ID@>0 | @C_InvoiceLine_ID@>0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-07-19 18:02:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

-- Jul 19, 2024, 7:52:11 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200197,'ExpenseLine for Issue Project','S','S_TimeExpenseLine_ID IN (SELECT DISTINCT S_TimeExpenseLine_ID FROM C_ProjectIssue WHERE DocStatus NOT IN (''VO'',''RE'') AND S_TimeExpenseLine_ID IS NOT NULL) AND (C_Project_ID = @C_Project_ID@ OR C_Project_ID is Null)',0,0,'Y',TO_TIMESTAMP('2024-07-19 19:52:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-19 19:52:10','YYYY-MM-DD HH24:MI:SS'),100,'D','4b8d14eb-cee2-4e85-bded-7b15daa4b32a')
;

-- Jul 19, 2024, 7:52:54 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200197,Updated=TO_TIMESTAMP('2024-07-19 19:52:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9863
;

-- Jul 22, 2024, 4:35:02 PM IST
UPDATE AD_Val_Rule SET Code='(M_InOut.C_Project_ID IS NULL OR M_InOut.C_Project_ID=@C_Project_ID@) AND M_InOut.Processed=''Y'' AND M_InOut.IsSOTrx=''N'' AND M_InOut_ID NOT IN (Select i.M_InOut_ID From M_InOut i WHERE i.M_InOut_ID = (SELECT DISTINCT il.M_InOut_ID FROM M_InOutLine il Where il.M_InOut_ID =i.M_InOut_ID AND (il.C_Project_ID!=@C_Project_ID@ AND il.C_Project_ID is NOT null)))',Updated=TO_TIMESTAMP('2024-07-22 16:35:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=178
;

-- Jul 24, 2024, 4:18:23 PM IST
UPDATE AD_Val_Rule SET Code='C_InvoiceLine.C_InvoiceLine_ID In ((SELECT cil.C_InvoiceLine_ID from C_InvoiceLine cil Inner Join C_Invoice ci On ci.C_Invoice_ID=cil.C_Invoice_ID Where ci.DocStatus In ( ''CL'', ''CO'') And ci.IsSOTrx=''N'' And cil.C_Charge_ID Is Not Null And cil.A_CreateAsset!=''Y'') EXCEPT (SELECT DISTINCT C_INVOICELINE_ID from C_PROJECTISSUE Where C_INVOICELINE_ID Is Not Null AND DocStatus NOT IN (''VO'',''RE'')))',Updated=TO_TIMESTAMP('2024-07-24 16:18:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200190
;

SELECT register_migration_script('202407221712_IDEMPIERE-3494.sql') FROM dual
;
