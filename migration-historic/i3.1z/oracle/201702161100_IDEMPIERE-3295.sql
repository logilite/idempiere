SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Feb 16, 2017 10:47:06 AM IST
UPDATE AD_Field SET Name='Actual Start', Description='Actual Time started', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-02-16 10:47:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11463
;

-- Feb 16, 2017 10:47:22 AM IST
UPDATE AD_Field SET Name='Actual Completion', Description='Actual End of the time span', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-02-16 10:47:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11451
;

-- Feb 16, 2017 10:47:41 AM IST
UPDATE AD_Field SET Name='Ticket Creation', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-02-16 10:47:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11492
;

-- Feb 16, 2017 10:47:55 AM IST
UPDATE AD_Field SET Name='Ticket Closed', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-02-16 10:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11489
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_Element SET Name='Planned Start', PrintName='Planned Start',Updated=TO_DATE('2017-02-16 10:48:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2901
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_Column SET Name='Planned Start', Description='Planned Start Date', Help='Date when you plan to start' WHERE AD_Element_ID=2901
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_Process_Para SET Name='Planned Start', Description='Planned Start Date', Help='Date when you plan to start', AD_Element_ID=2901 WHERE UPPER(ColumnName)='DATESTARTPLAN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_Process_Para SET Name='Planned Start', Description='Planned Start Date', Help='Date when you plan to start' WHERE AD_Element_ID=2901 AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_InfoColumn SET Name='Planned Start', Description='Planned Start Date', Help='Date when you plan to start' WHERE AD_Element_ID=2901 AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_Field SET Name='Planned Start', Description='Planned Start Date', Help='Date when you plan to start' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2901) AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:16 AM IST
UPDATE AD_PrintFormatItem SET PrintName='Planned Start', Name='Planned Start' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2901)
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_Element SET Name='Planned Complete', PrintName='Planned Complete',Updated=TO_DATE('2017-02-16 10:48:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2899
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_Column SET Name='Planned Complete', Description='Planned Completion Date', Help='Date when the task is planned to be complete' WHERE AD_Element_ID=2899
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_Process_Para SET Name='Planned Complete', Description='Planned Completion Date', Help='Date when the task is planned to be complete', AD_Element_ID=2899 WHERE UPPER(ColumnName)='DATECOMPLETEPLAN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_Process_Para SET Name='Planned Complete', Description='Planned Completion Date', Help='Date when the task is planned to be complete' WHERE AD_Element_ID=2899 AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_InfoColumn SET Name='Planned Complete', Description='Planned Completion Date', Help='Date when the task is planned to be complete' WHERE AD_Element_ID=2899 AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_Field SET Name='Planned Complete', Description='Planned Completion Date', Help='Date when the task is planned to be complete' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2899) AND IsCentrallyMaintained='Y'
;

-- Feb 16, 2017 10:48:51 AM IST
UPDATE AD_PrintFormatItem SET PrintName='Planned Complete', Name='Planned Complete' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2899)
;

SELECT register_migration_script('201702161100_IDEMPIERE-3295.sql') FROM dual
;

