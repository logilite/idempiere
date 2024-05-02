SET SQLBLANKLINES ON
SET DEFINE OFF

-- User Favorite Panel
-- Jun 7, 2017 5:16:46 PM IST
UPDATE AD_Table SET AccessLevel = '7', IsChangeLog = 'Y', Updated = TO_DATE('2017-06-07 17:16:44','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Table_ID = 200220;

-- Jun 7, 2017 5:16:46 PM IST
UPDATE AD_Table SET AccessLevel = '7', IsChangeLog = 'Y', Updated = TO_DATE('2017-06-07 17:30:38','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Table_ID = 200221;

-- Jun 7, 2017 5:56:55 PM IST
UPDATE AD_Message SET MsgText = 'Add Root', Updated = TO_DATE('2017-06-07 17:56:54','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Message_ID = 200419;

-- Jun 7, 2017 5:56:55 PM IST
UPDATE AD_Message SET MsgText = 'Edit Folder', Updated = TO_DATE('2017-06-07 17:56:54','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Message_ID = 200425;

SELECT register_migration_script('201706131200_IDEMPIERE-3340_MergeCorrect.sql') FROM dual
;
