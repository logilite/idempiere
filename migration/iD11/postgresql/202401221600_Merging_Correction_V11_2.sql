-- Logilite-11 Multi-select fields visibility correction after merging with 11 version

SELECT register_migration_script('202401221600_Merging_Correction_V11_2.sql') FROM dual
;

-- Column Name = Dynamic Validation, table = AD_Column
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 172;

-- Column Name = Dynamic Validation (Lookup), table = AD_Column
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 206091;

-- Column Name = Reference Key, table = AD_Column
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 171;

-- Column Name = Dynamic Validation, table = AD_Field
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 54401;

-- Column Name = Reference Key, table = AD_Field
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 201622;

-- Column Name = Dynamic Validation (Lookup), table = AD_Field
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 206129;

-- Column Name = Dynamic Validation, table = AD_UserDef_Field
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 203266;

-- Column Name = Dynamic Validation (Lookup), table = AD_UserDef_Field
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 206130;

-- Column Name = Dynamic Validation, table = AD_InfoColumn
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 201623;

-- Column Name = Reference Key, table = AD_InfoColumn
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 54402;

-- Column Name = Query Function, table = AD_InfoColumn
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' & @AD_Reference_ID@!200205 ' WHERE AD_Field_ID = 201636;

-- Column Name = Reference Key, table = AD_InfoColumn
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 200855;

-- Reference Key = Reference Key, table = WS_WebServiceFieldInput
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 201895;

-- Reference Key = Reference Key, table = A_RegistrationAttribute
UPDATE AD_Field SET DisplayLogic = DisplayLogic || ' | @AD_Reference_ID@=200205 | @AD_Reference_ID@=200139 | @AD_Reference_ID@=200138' WHERE AD_Field_ID = 10225;
