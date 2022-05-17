-- Logilite-9 Multi-select fields visibility correction after merging with 9 version
UPDATE AD_Val_Rule SET Code='AD_Reference.ValidationType=CASE WHEN  @AD_Reference_ID@ IN (17,28,200152,200161,200139) THEN ''L'' ELSE ''T'' END',Updated=TO_TIMESTAMP('2022-05-13 11:11:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=115
;

UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-13 11:11:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-13 11:11:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-13 11:11:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- May 13, 2022, 4:16:29 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138 | @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-13 16:16:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206091
;

-- May 13, 2022, 4:18:56 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200138| @AD_Reference_ID@=200139', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-13 16:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

SELECT register_migration_script('202205131212_Merging_Correction.sql') FROM dual
;
