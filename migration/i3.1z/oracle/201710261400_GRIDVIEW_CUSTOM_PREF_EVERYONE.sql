SET SQLBLANKLINES ON
SET DEFINE OFF

-- On Grid view save default customized column width/order for everyone
-- Oct 26, 2017 1:00:59 PM IST
UPDATE AD_Message SET MsgText='Do you want to save preferences for everyone?',Updated=TO_DATE('2017-10-26 13:00:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200434
;

-- Oct 26, 2017 1:01:20 PM IST
UPDATE AD_Message SET MsgText='Do you want to reset default preference for everyone?',Updated=TO_DATE('2017-10-26 13:01:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200433
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_Element SET ColumnName='IsCanSaveGridCustPrefEveryone', Description='On Grid view, Allow to save column width and order preference for everyone',Updated=TO_DATE('2017-10-26 13:33:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203141
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_Column SET ColumnName='IsCanSaveGridCustPrefEveryone', Name='Can Save Grid Customize Preference for Everyone', Description='On Grid view, Allow to save column width and order preference for everyone', Help=NULL WHERE AD_Element_ID=203141
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_Process_Para SET ColumnName='IsCanSaveGridCustPrefEveryone', Name='Can Save Grid Customize Preference for Everyone', Description='On Grid view, Allow to save column width and order preference for everyone', Help=NULL, AD_Element_ID=203141 WHERE UPPER(ColumnName)='ISCANSAVEGRIDCUSTPREFEVERYONE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_Process_Para SET ColumnName='IsCanSaveGridCustPrefEveryone', Name='Can Save Grid Customize Preference for Everyone', Description='On Grid view, Allow to save column width and order preference for everyone', Help=NULL WHERE AD_Element_ID=203141 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_InfoColumn SET ColumnName='IsCanSaveGridCustPrefEveryone', Name='Can Save Grid Customize Preference for Everyone', Description='On Grid view, Allow to save column width and order preference for everyone', Help=NULL WHERE AD_Element_ID=203141 AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2017 1:33:37 PM IST
UPDATE AD_Field SET Name='Can Save Grid Customize Preference for Everyone', Description='On Grid view, Allow to save column width and order preference for everyone', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203141) AND IsCentrallyMaintained='Y'
;

-- Oct 26, 2017 2:19:51 PM IST
ALTER TABLE AD_Role ADD IsCanSaveGridCustPrefEveryone CHAR(1) DEFAULT 'N' CHECK (IsCanSaveGridCustPrefEveryone IN ('Y','N')) NOT NULL
;

ALTER TABLE AD_Role DROP COLUMN IsCanSaveColumnWidthEveryone
;

-- Oct 26, 2017 3:05:37 PM IST
UPDATE AD_Column SET DefaultValue='N', EntityType='D',Updated=TO_DATE('2017-10-26 15:05:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213256
;

-- Oct 26, 2017 3:09:54 PM IST
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-10-26 15:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205243
;

SELECT register_migration_script('201710261400_GRIDVIEW_CUSTOM_PREF_EVERYONE.sql') FROM dual
;
