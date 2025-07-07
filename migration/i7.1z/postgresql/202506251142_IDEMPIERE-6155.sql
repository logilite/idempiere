-- IDEMPIERE-6155: On Project Issue Tab add read only logic for Product and Charge Fields. 
SELECT register_migration_script('202506251142_IDEMPIERE-6155.sql') FROM dual;

-- Jun 25, 2025, 11:25:37 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@ > 0 | @M_InOutLine_ID@ > 0 | @C_Charge_ID@ > 0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-25 11:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- Jun 25, 2025, 11:25:44 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@ > 0 | @M_InOutLine_ID@ > 0 | @M_Product_ID@ > 0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-25 11:25:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- Jun 25, 2025, 4:16:13 PM IST
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2025-06-25 16:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216609
;

-- Jun 25, 2025, 4:16:17 PM IST
INSERT INTO t_alter_column values('c_projectissue','C_InvoiceLine_ID','NUMERIC(10)',null,'NULL',null)
;

