SET SQLBLANKLINES ON
SET DEFINE OFF

-- M_MovementLine and M_MovementLineMA update same constraint name
-- Aug 20, 2020 2:13:12 PM IST
UPDATE AD_Column SET FKConstraintName='MMovementLine_MASITo',Updated=TO_DATE('2020-08-20 14:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14006
;

-- Aug 20, 2020 2:13:15 PM IST
ALTER TABLE M_MovementLine DROP CONSTRAINT mattributesetinstanceto_mmovem
;

-- Aug 20, 2020 2:15:33 PM IST
UPDATE AD_Column SET FKConstraintName='MMovementLineMA_MASITo',Updated=TO_DATE('2020-08-20 14:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212226
;

-- Aug 20, 2020 2:15:40 PM IST
ALTER TABLE M_MovementLineMA DROP CONSTRAINT mattributesetinstanceto_mmovem
;

SELECT register_migration_script('202008311613_IDEMPIERE-2615_1.sql') FROM dual
;