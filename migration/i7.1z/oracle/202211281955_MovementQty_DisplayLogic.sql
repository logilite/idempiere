SET SQLBLANKLINES ON
SET DEFINE OFF

-- Updated Movement Line's Movement Qty field's display logic 
-- Nov 28, 2022, 7:07:00 PM IST
UPDATE AD_Field SET DisplayLogic='@UOMConversion@=Y | @Processed@=Y', AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2022-11-28 19:07:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2738
;

SELECT register_migration_script('202211281955_MovementQty_DisplayLogic.sql') FROM dual
;