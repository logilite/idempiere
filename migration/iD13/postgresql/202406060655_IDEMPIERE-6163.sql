
-- Same Script applied \migration-historic\i3.1z\postgresql\201903261700_Added_Columns_In_AD_Ref_Table.sql

ALTER TABLE AD_Ref_Table ALTER COLUMN DisplaySQL TYPE VARCHAR(4000)
;

SELECT register_migration_script('202406060655_IDEMPIERE-6163.sql') FROM dual
;
