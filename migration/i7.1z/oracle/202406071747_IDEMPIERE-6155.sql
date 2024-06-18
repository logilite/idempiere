SET SQLBLANKLINES ON
SET DEFINE OFF

-- Update Reference of Invoice Line parameter of Issue Process and Change into Validation Rule
-- Jun 10, 2024, 10:44:09 AM IST
UPDATE AD_Val_Rule SET Code='C_InvoiceLine.C_InvoiceLine_ID In ((SELECT cil.C_InvoiceLine_ID from C_InvoiceLine cil Inner Join C_Invoice ci On ci.C_Invoice_ID=cil.C_Invoice_ID Where ci.DocStatus In ( ''CL'', ''CO'') And ci.IsSOTrx=''N'' And cil.C_Charge_ID Is Not Null And cil.A_CreateAsset!=''Y'') Minus (SELECT DISTINCT C_INVOICELINE_ID from C_PROJECTISSUE Where C_INVOICELINE_ID Is Not Null))',Updated=TO_DATE('2024-06-10 10:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200190
;

-- Jun 7, 2024, 5:46:39 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2024-06-07 17:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200483
;

SELECT register_migration_script('202406071747_IDEMPIERE-6155.sql') FROM dual
;
