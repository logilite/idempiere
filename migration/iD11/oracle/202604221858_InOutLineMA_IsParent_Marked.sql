-- Missed Parent Link Column flag on M_InOutLineMA table
SELECT register_migration_script('202604221858_InOutLineMA_IsParent_Marked.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 22, 2026, 6:58:52 PM IST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-04-22 18:58:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13322
;

-- Apr 22, 2026, 6:59:12 PM IST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-04-22 18:59:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13323
;

