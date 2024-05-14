-- 
SELECT register_migration_script('202210052003_IDEMPIERE-5349.sql') FROM dual;

-- Jul 18, 2022, 1:03:26 AM IST
UPDATE AD_Element SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Element_ID = 203631;


-- Jul 18, 2022, 1:25:52 AM IST
UPDATE AD_Element SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Element_ID = 215059;

-- Jul 18, 2022, 1:31:52 AM IST
UPDATE AD_Field SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Field_ID = 207127;

-- Jul 18, 2022, 1:34:24 AM IST
UPDATE AD_Column SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Column_ID = 215060;


-- Jul 18, 2022, 1:38:47 AM IST
UPDATE AD_Field SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Field_ID = 207128;

-- Jul 18, 2022, 1:40:40 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-18 01:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207128
;

-- Jul 19, 2022, 12:54:20 PM IST
UPDATE AD_Column SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Column_ID = 215093;

-- Jul 19, 2022, 12:56:35 PM IST
UPDATE AD_Field SET Description = 'Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.', Updated = TO_TIMESTAMP('2022-07-18 01:03:25','YYYY-MM-DD HH24:MI:SS'), UpdatedBy = 100 WHERE AD_Field_ID = 207129;
