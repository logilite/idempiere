SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add Session Audit(AD_Session_ID) reference in Process Audit (AD_PInstance).
-- Nov 21, 2022, 5:17:01 PM IST
UPDATE AD_Column SET IsIdentifier='N', SeqNo=0,Updated=TO_DATE('2022-11-21 17:17:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8579
;

-- Nov 21, 2022, 5:17:46 PM IST
UPDATE AD_Column SET IsIdentifier='Y',Updated=TO_DATE('2022-11-21 17:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8577
;

-- Nov 21, 2022, 5:18:04 PM IST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=2,Updated=TO_DATE('2022-11-21 17:18:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8584
;

SELECT register_migration_script('202211111143_IDEMPIERE-5371_MergeCorrect.sql') FROM dual;

