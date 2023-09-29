SELECT register_migration_script('202309291327_IDEMPIERE-5836.sql') FROM dual;
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Aug 8, 2023, 1:27:56 PM IST
UPDATE AD_Field SET DisplayLogic='@IsSummary@=''N'' & @ProductType@=I | @ProductType@=E', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-08-08 13:27:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1026
;

-- Aug 8, 2023, 1:29:13 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@ProductType@=R | @ProductType@=O',Updated=TO_TIMESTAMP('2023-08-08 13:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1761
;

