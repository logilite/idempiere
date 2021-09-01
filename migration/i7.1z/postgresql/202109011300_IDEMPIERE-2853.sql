-- Update script based on Core version implemented
UPDATE AD_Ref_List SET Name = 'Form' WHERE AD_Ref_List_ID = 200347;

UPDATE AD_Ref_List SET Name = 'Sort' WHERE AD_Ref_List_ID = 200348;

SELECT register_migration_script('202109011300_IDEMPIERE-2853.sql') FROM dual
;
