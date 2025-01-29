SET SQLBLANKLINES ON
SET DEFINE OFF

-- Update Mandatory logic of Product and Charge fields in Issue Project Tab and UpdateBalanceAmt method change in MprojectIssue
-- Jul 16, 2024, 6:49:53 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Charge_ID@=0', IsToolbarButton=NULL,Updated=TO_DATE('2024-07-16 18:49:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- Jul 16, 2024, 6:49:59 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@=0 ', IsToolbarButton=NULL,Updated=TO_DATE('2024-07-16 18:49:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

SELECT register_migration_script('202407171124_IDEMPIERE-6155.sql') FROM dual
;

