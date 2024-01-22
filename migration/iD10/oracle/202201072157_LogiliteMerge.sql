--Marking migration script as applied which has only View changes which are already corrected.
SELECT register_migration_script('202201072157_LogiliteMerge.sql') FROM dual;

SELECT register_migration_script('202209141520_IDEMPIERE-5396.sql') FROM dual;

