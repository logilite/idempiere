-- IDEMPIERE-3340 Allow user to create default favorite tree
-- Aug 18, 2020 11:57:49 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203431,0,0,'Y',TO_TIMESTAMP('2020-08-18 11:57:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-18 11:57:47','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowAccessDefaultFavTree','Allow access in default favorite tree','Allow access for changes & configuration for Default Favorite Tree structure','Allow access in default favorite tree','D','f3974715-849c-4332-8542-329ffe0c13d4')
;

-- Aug 18, 2020 11:59:31 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214219,0,'Allow access in default favorite tree','Allow access for changes & configuration for Default Favorite Tree structure',114,'IsAllowAccessDefaultFavTree','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-08-18 11:59:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-18 11:59:30','YYYY-MM-DD HH24:MI:SS'),100,203431,'Y','N','D','N','N','N','Y','e3720a5e-5d1f-4f6c-8139-c35fbf9b4171','Y',0,'N','N')
;

-- Aug 18, 2020 11:59:33 AM IST
ALTER TABLE AD_User ADD COLUMN IsAllowAccessDefaultFavTree CHAR(1) DEFAULT 'N' CHECK (IsAllowAccessDefaultFavTree IN ('Y','N')) NOT NULL
;

-- Aug 18, 2020 12:02:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206422,'Allow access in default favorite tree','Allow access for changes & configuration for Default Favorite Tree structure',118,214219,'Y',0,430,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-08-18 12:02:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-18 12:02:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','759686f6-5fb9-403b-8827-b228e3ea236d','Y',3030,1,1,1,'N','N','N','N')
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206422
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6513
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11525
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6520
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8342
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6519
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Aug 18, 2020 12:04:16 PM IST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-08-18 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Aug 21, 2020 6:53:29 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Copy an entire tree structure',0,0,'Y',TO_TIMESTAMP('2020-08-21 18:53:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-21 18:53:28','YYYY-MM-DD HH24:MI:SS'),100,200636,'CopyTree','D','68ec7277-8041-4306-9a2e-d70d7f4856f0')
;

-- Aug 21, 2020 7:02:25 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Show my favorite tree structure',0,0,'Y',TO_TIMESTAMP('2020-08-21 19:02:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-21 19:02:23','YYYY-MM-DD HH24:MI:SS'),100,200637,'ShowMyTree','D','56fe025c-786b-4fda-9c78-67d75a77d40f')
;

-- Aug 21, 2020 7:03:08 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Show the default tree structure',0,0,'Y',TO_TIMESTAMP('2020-08-21 19:03:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-08-21 19:03:07','YYYY-MM-DD HH24:MI:SS'),100,200638,'ShowDefaultTree','D','375f7835-8cf5-411c-a95b-9ac994d11782')
;

SELECT register_migration_script('202008212100_IDEMPIERE-3340.sql') FROM dual
;
