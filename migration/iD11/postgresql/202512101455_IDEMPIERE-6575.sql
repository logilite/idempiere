-- IDEMPIERE-6575: Make start No Field editable for Document Sequence Window. 
SELECT register_migration_script('202512101455_IDEMPIERE-6575.sql') FROM dual;

-- Dec 10, 2025, 2:55:29 PM IST
UPDATE AD_Column SET ReadOnlyLogic=NULL,Updated=TO_TIMESTAMP('2025-12-10 14:55:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2746
;

-- Dec 10, 2025, 2:55:39 PM IST
INSERT INTO t_alter_column values('ad_sequence','StartNo','NUMERIC(10)',null,'1000000',null)
;

-- Dec 10, 2025, 2:55:39 PM IST
UPDATE AD_Sequence SET StartNo=1000000 WHERE StartNo IS NULL
;

