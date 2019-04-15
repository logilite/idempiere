SET SQLBLANKLINES ON
SET DEFINE OFF

-- Delete access in attachment by Role
-- Feb 27, 2018 5:05:40 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203175,0,0,'Y',TO_DATE('2018-02-27 17:05:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-27 17:05:39','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowDeleteAttachment','Allow Delete Attachment','Allow Delete File In Attachment Dialog ','Allow Delete Attachment','D','946bc227-a4e0-4b27-a3d0-747a47af0888')
;

-- Feb 27, 2018 5:06:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213392,0,'Allow Delete Attachment','Allow Delete File In Attachment Dialog ',156,'IsAllowDeleteAttachment','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2018-02-27 17:06:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-27 17:06:57','YYYY-MM-DD HH24:MI:SS'),100,203175,'Y','N','D','N','N','N','Y','5c485d5f-02c5-4855-bddd-3f4a99a4e136','Y',0,'N','N')
;

-- Feb 27, 2018 5:07:03 PM IST
ALTER TABLE AD_Role ADD IsAllowDeleteAttachment CHAR(1) DEFAULT 'Y' CHECK (IsAllowDeleteAttachment IN ('Y','N'))
;

-- Feb 27, 2018 5:09:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205350,'Allow Delete Attachment','Allow Delete File In Attachment Dialog ',119,213392,'Y',0,450,0,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-27 17:08:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-27 17:08:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','170ef3d9-c015-4ea1-b9d5-59e86c32bf4f','Y',450,2,2,1,'N','N','N','N')
;

-- Feb 27, 2018 5:13:22 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200114,0,0,TO_DATE('2018-02-27 17:13:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-02-27 17:13:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ATTACHMENT_AUTO_VERSION_ENABLED','N','If Y then save files by add version as suffix in Attachment dialog.','D','C','b7384fda-03ba-4706-b6d1-35e07a5c511c')
;

SELECT register_migration_script('201802271705_Delete_Access_In_Attachment_By_Role.sql') FROM dual
;
