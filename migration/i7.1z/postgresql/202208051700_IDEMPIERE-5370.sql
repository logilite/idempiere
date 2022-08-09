-- On Attribute Window, show reference key and dynamic validation field for chosen multiple type
-- Aug 5, 2022, 4:33:03 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 & @AttributeValueType@=''R''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-05 16:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Aug 5, 2022, 4:33:16 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 & @AttributeValueType@=''R''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-05 16:33:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

SELECT register_migration_script('202208051700_IDEMPIERE-5370.sql') FROM dual
;
