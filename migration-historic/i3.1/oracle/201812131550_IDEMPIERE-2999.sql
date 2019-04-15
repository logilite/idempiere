SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2999 Attribute, List field support
-- Dec 13, 2018 3:51:24 PM IST
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=''R'' & @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-13 15:51:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

SELECT register_migration_script('201812131550_IDEMPIERE-2999.sql') FROM dual
;


