SET SQLBLANKLINES ON
SET DEFINE OFF

-- Excel 2007 support in idempiere
-- Apr 12, 2018 3:12:17 PM IST
UPDATE AD_Message SET EntityType = 'D', Updated = TO_DATE('2018-04-12 15:12:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Message_ID = 200451;


SELECT register_migration_script('201804121850_Extend_Export_Feature_MergeCorrect.sql') FROM dual
;

