-- IDEMPIERE-4157 Quick Form enhancement
-- Quick Form read only
-- Feb 18, 2020, 6:13:37 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@AD_Column_ID.AD_Reference_ID@=200122 | @AD_Column_ID.AD_Reference_ID@=200127 | @AD_Column_ID.AD_Reference_ID@=200128 | @AD_Column_ID.AD_Reference_ID@=200161 | @AD_Column_ID.AD_Reference_ID@=200162 | @AD_Column_ID.AD_Reference_ID@=200163', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-02-18 18:13:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205244
;

-- Feb 26, 2020, 7:06:38 PM CET
UPDATE AD_ToolBarButton SET SeqNo=300,Updated=TO_TIMESTAMP('2020-02-26 19:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200081
;

-- Feb 26, 2020, 7:06:51 PM CET
UPDATE AD_ToolBarButton SET SeqNo=290,Updated=TO_TIMESTAMP('2020-02-26 19:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200067
;

SELECT register_migration_script('202002261603_IDEMPIERE-4157_MergeCorrect.sql') FROM dual
;
