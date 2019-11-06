SET SQLBLANKLINES ON
SET DEFINE OFF

-- MandatoryLogic for Budget reference when Posting type budget in Journal
-- Nov 1, 2019 4:54:13 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@PostingType@=''B''', IsToolbarButton=NULL,Updated=TO_DATE('2019-11-01 16:54:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200194
;

SELECT register_migration_script('201911011700_MandatoryLogic_Budget_In_Journal.sql') FROM dual
;
