-- This Need's to be changed.
-- Jul 16, 2018 6:53:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213617,0,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',472,'IsReversal','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2018-07-16 18:53:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:53:57','YYYY-MM-DD HH24:MI:SS'),100,1476,'Y','N','U','N','N','N','Y','065e5b80-1fb7-4eb1-908c-2d093f3d857e','Y',0,'N','N')
;

-- Jul 16, 2018 6:54:01 PM IST
ALTER TABLE M_MatchInv ADD COLUMN IsReversal CHAR(1) DEFAULT 'N' CHECK (IsReversal IN ('Y','N')) NOT NULL
;

-- Jul 16, 2018 6:54:46 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205656,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',408,213617,'Y',0,150,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:54:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:54:45','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','b7a17eff-4197-4541-ad33-01a4b18f0482','Y',180,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:55:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205657,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',689,213617,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:55:12','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','f7793206-0e9f-4665-b4dd-f99cf17065a5','Y',140,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:55:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205658,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',690,213617,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:55:34','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','0088926f-944d-4f0a-8622-9f88a963a9f0','Y',150,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:55:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205659,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',53275,213617,'Y',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:55:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:55:56','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','ca4c14df-5946-4036-b341-e4e5ce307842','Y',100,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:56:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205660,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',200206,213617,'Y',0,190,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:56:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:56:18','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','808b9472-4870-4d76-b8cb-3062e21a60a5','Y',180,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:57:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213618,0,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',473,'IsReversal','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2018-07-16 18:57:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:57:15','YYYY-MM-DD HH24:MI:SS'),100,1476,'Y','N','U','N','N','N','Y','1e3b1fc0-2c02-4c42-a9f6-729c5e6e61c2','Y',0,'N','N')
;

-- Jul 16, 2018 6:57:18 PM IST
ALTER TABLE M_MatchPO ADD COLUMN IsReversal CHAR(1) DEFAULT 'N' CHECK (IsReversal IN ('Y','N')) NOT NULL
;

-- Jul 16, 2018 6:57:47 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205661,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',409,213618,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:57:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:57:47','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','f1f2cf84-e40a-4f08-85e6-8b434d2aaed4','Y',180,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:58:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205662,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',688,213618,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:58:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:58:07','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','3dc01c3d-a686-4f41-9104-86209b606a0c','Y',110,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:58:30 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205663,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',691,213618,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:58:30','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','470df035-1419-4b59-9709-1305a940fb1e','Y',110,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:59:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205664,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',692,213618,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:59:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:59:16','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','94f23208-e691-481d-84ba-b557ea17111c','Y',120,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 6:59:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205665,'Reversal','This is a reversing transaction','The Reversal check box indicates if this is a reversal of a prior transaction.',53274,213618,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-07-16 18:59:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-07-16 18:59:36','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','U','39e548e1-401f-4cd4-aa5e-ed823cbc399e','Y',110,2,1,1,'N','N','N','N')
;

-- Jul 16, 2018 7:00:16 PM IST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2018-07-16 19:00:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213618
;

-- Jul 16, 2018 7:01:20 PM IST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2018-07-16 19:01:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213617
;

-- Jul 16, 2018 7:01:23 PM IST
INSERT INTO t_alter_column values('m_matchinv','IsReversal','CHAR(1)',null,'N',null)
;

-- Jul 16, 2018 7:01:23 PM IST
UPDATE M_MatchInv SET IsReversal='N' WHERE IsReversal IS NULL
;

-- Jul 16, 2018 7:01:45 PM IST
INSERT INTO t_alter_column values('m_matchpo','IsReversal','CHAR(1)',null,'N',null)
;

-- Jul 16, 2018 7:01:45 PM IST
UPDATE M_MatchPO SET IsReversal='N' WHERE IsReversal IS NULL
;

UPDATE M_MatchInv SET IsReversal = 'Y' WHERE reversal_id > 0 AND reversal_id < M_MatchInv_ID
;

UPDATE M_MatchPO set IsReversal = 'Y' WHERE reversal_id > 0 AND reversal_id < M_MatchPO_ID
;

SELECT register_migration_script('201807191900_IDEMPIERE-3751.sql') FROM dual
;
