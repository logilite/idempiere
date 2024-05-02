-- Disable Zoom Across
-- Sep 11, 2023, 4:32:49 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203831,0,0,'Y',TO_TIMESTAMP('2023-09-11 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,'IsDisableZoomAcross','Disable Zoom Across','Used to disable Zoom Across.','Disable Zoom Across','D','628841de-6a05-4124-bd56-d358e88b0dae')
;

-- Sep 11, 2023, 4:33:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215910,0,'Disable Zoom Across','Used to disable Zoom Across.',101,'IsDisableZoomAcross','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-09-11 16:33:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 16:33:55','YYYY-MM-DD HH24:MI:SS'),100,203831,'Y','N','D','N','N','N','Y','e5956dc5-95bd-4e67-bb45-313f3ef8f78d','Y',0,'N','N','N','N')
;

-- Sep 11, 2023, 4:33:58 PM IST
ALTER TABLE AD_Column ADD COLUMN IsDisableZoomAcross CHAR(1) DEFAULT 'N' CHECK (IsDisableZoomAcross IN ('Y','N'))
;

-- Sep 11, 2023, 4:34:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215911,0,'Disable Zoom Across','Used to disable Zoom Across.',107,'IsDisableZoomAcross','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-09-11 16:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 16:34:14','YYYY-MM-DD HH24:MI:SS'),100,203831,'Y','N','D','N','N','N','Y','f393f02b-b375-4e2f-a6d3-06b3a031b50a','Y',0,'N','N','N','N')
;

-- Sep 11, 2023, 4:34:16 PM IST
ALTER TABLE AD_Field ADD COLUMN IsDisableZoomAcross CHAR(1) DEFAULT 'N' CHECK (IsDisableZoomAcross IN ('Y','N'))
;

-- Sep 11, 2023, 4:36:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207718,'Disable Zoom Across','Used to disable Zoom Across.',107,215911,'Y',1,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-11 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7465f90-5f92-4476-bca9-940d8ae3d579','Y',490,2,2)
;

-- Sep 11, 2023, 4:37:25 PM IST
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-09-11 16:37:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Sep 11, 2023, 4:37:25 PM IST
UPDATE AD_Field SET SeqNo=520, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-09-11 16:37:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Sep 11, 2023, 4:37:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-09-11 16:37:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207718
;

-- Sep 11, 2023, 4:38:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207719,'Disable Zoom Across','Used to disable Zoom Across.',101,215910,'Y',1,530,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-11 16:38:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 16:38:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','caf4a20a-ed45-41a9-87f9-fa7994da2d42','Y',480,2,2)
;

-- Sep 11, 2023, 4:38:35 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-09-11 16:38:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207719
;

SELECT register_migration_script('202309111840_DisableZoomAcross_1.sql') FROM dual
;