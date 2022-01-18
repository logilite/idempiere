-- Show Summary Multiple Row Only In Print Format
-- Jan 5, 2022, 12:43:02 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203553,0,0,'Y',TO_TIMESTAMP('2022-01-05 12:43:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-01-05 12:43:00','YYYY-MM-DD HH24:MI:SS'),100,'IsShowSummaryMultipleRowOnly','Show Summary Multiple Row Only','Show Summary Line For Multiple Row Only','Show Summary Multiple Row Only','D','6ba877c8-7298-4140-a7ef-65b3802a7de2')
;

-- Jan 5, 2022, 12:43:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214660,0,'Show Summary Multiple Row Only','Show Summary Line For Multiple Row Only',493,'IsShowSummaryMultipleRowOnly','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-01-05 12:43:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-01-05 12:43:33','YYYY-MM-DD HH24:MI:SS'),100,203553,'Y','N','D','N','N','N','Y','adafebbf-eefb-4224-8ae0-ef591cfe2991','Y',0,'N','N','N','N')
;

-- Jan 5, 2022, 12:43:36 PM IST
ALTER TABLE AD_PrintFormat ADD COLUMN IsShowSummaryMultipleRowOnly CHAR(1) DEFAULT 'N' CHECK (IsShowSummaryMultipleRowOnly IN ('Y','N')) NOT NULL
;

-- Jan 5, 2022, 12:51:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206832,'Show Summary Multiple Row Only','Show Summary Line For Multiple Row Only',425,214660,'Y','@IsForm @ = N',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-05 12:51:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-01-05 12:51:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fee58018-d4fd-43c5-bc7c-71f00b12de83','Y',260,2,2,1,'N','N','N','N')
;

SELECT register_migration_script('202201051630_IDEMPIERE-5143.sql') FROM dual
;