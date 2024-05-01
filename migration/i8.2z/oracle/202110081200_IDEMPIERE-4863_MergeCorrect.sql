SET SQLBLANKLINES ON
SET DEFINE OFF
-- IDEMPIERE-4863 Enable save column width in WListBox
UPDATE AD_Table SET CreateWindowFromTable='N' ,Updated=TO_DATE('2021-07-03 23:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200279
;

SELECT register_migration_script('202110081200_IDEMPIERE-4863_MergeCorrect.sql') FROM dual;
