-- Bank statement posting with line date, allow same year.
-- 25-Sep-2022, 10:00:36 AM IST
UPDATE AD_Field SET DisplayLogic='@IsUpdateable@=Y', Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-25 10:00:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207127
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_Element SET Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.',Updated=TO_TIMESTAMP('2022-09-25 10:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203631
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_Column SET  Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.' WHERE AD_Element_ID=203631
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_Process_Para SET  Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', AD_Element_ID=203631 WHERE UPPER(ColumnName)='ALWAYSUPDATABLELOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_Process_Para SET Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.'  WHERE AD_Element_ID=203631 AND IsCentrallyMaintained='Y'
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_InfoColumn SET Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.' WHERE AD_Element_ID=203631 AND IsCentrallyMaintained='Y'
;

-- 25-Sep-2022, 10:00:54 AM IST
UPDATE AD_Field SET Description='Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203631) AND IsCentrallyMaintained='Y'
;

-- 25-Sep-2022, 10:03:57 AM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-25 10:03:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207128
;

SELECT register_migration_script('202209251715_IDEMPIERE-5349.sql') FROM dual
;
