-- On Grid view save default customized column width/order for everyone
-- Oct 17, 2017 4:57:49 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203141,0,0,'Y',TO_TIMESTAMP('2017-10-17 16:57:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-17 16:57:48','YYYY-MM-DD HH24:MI:SS'),100,'IsCanSaveColumnWidthEveryone','Can Save Column Width to Everyone','On Grid view save default customized column width/order for everyone','Can Save Column Width to Everyone','D','e05f662c-b50d-4cfc-8c2d-45e9649c2e73')
;

-- Oct 17, 2017 4:58:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213256,0,'Can Save Column Width to Everyone','On Grid view save default customized column width/order for everyone',156,'IsCanSaveColumnWidthEveryone','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-10-17 16:58:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-17 16:58:23','YYYY-MM-DD HH24:MI:SS'),100,203141,'Y','N','U','N','N','N','Y','a75acd6d-3f4f-4bea-82f9-5ba8b1882031','Y',0,'N','N')
;

-- Oct 17, 2017 4:58:25 PM IST
ALTER TABLE AD_Role ADD COLUMN IsCanSaveColumnWidthEveryone CHAR(1) DEFAULT 'Y' CHECK (IsCanSaveColumnWidthEveryone IN ('Y','N')) NOT NULL
;

-- Oct 17, 2017 4:59:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205243,'Can Save Column Width to Everyone','On Grid view save default customized column width/order for everyone',119,213256,'Y',0,295,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-10-17 16:59:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-17 16:59:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','d0c1782b-d7c3-42fa-8e7f-bf78ce6e7cb9','Y',440,2,2,1,'N','N','N')
;

-- Oct 18, 2017 10:51:47 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do you want to reset default SuperUser preference?',0,0,'Y',TO_TIMESTAMP('2017-10-18 10:51:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-18 10:51:43','YYYY-MM-DD HH24:MI:SS'),100,200433,'GRIDVIEW_RESET_SUPERUSER_CUSTOM_PREF','D','0f7064cc-5667-40b3-8c7e-eaefc8ceea15')
;

-- Oct 18, 2017 10:53:29 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','This change applies to everyone who has not set their own preference?',0,0,'Y',TO_TIMESTAMP('2017-10-18 10:53:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-10-18 10:53:28','YYYY-MM-DD HH24:MI:SS'),100,200434,'GRIDVIEW_APPLY_CUSTOM_PREF_EVERYONE','D','12a79909-baf8-47b6-aa02-61be5a41c769')
;

SELECT register_migration_script('201710170500_GRIDVIEW_CUSTOM_PREF_EVERYONE.sql') FROM dual
;