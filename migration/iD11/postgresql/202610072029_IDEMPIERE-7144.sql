-- IDEMPIERE-7144: Pack out - Enhancing to export all element of entity type
SELECT register_migration_script('202610072029_IDEMPIERE-7144.sql') FROM dual;

-- 07-Oct-2026, 8:29:45 pm IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204131,0,0,'Y',TO_TIMESTAMP('2026-10-07 20:29:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 20:29:44','YYYY-MM-DD HH24:MI:SS'),100,'IsExportFullEntityChange','Export Full Entity Change','Export all dictionary records of the entity type','When ticked, all application dictionary records of the selected entity type are included in the 2pack. With Date From set, only records updated since then. Otherwise only the entity type record is exported.','Export Full Entity Change','D','4c09c282-6692-4063-bad6-9e10a1256677')
;

-- 07-Oct-2026, 8:30:12 pm IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217665,0,'Export Full Entity Change','Export all dictionary records of the entity type','When ticked, all application dictionary records of the selected entity type are included in the 2pack. With Date From set, only records updated since then. Otherwise only the entity type record is exported.',50006,'IsExportFullEntityChange','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-10-07 20:30:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 20:30:11','YYYY-MM-DD HH24:MI:SS'),100,204131,'Y','N','D','N','N','N','Y','49149c70-9fa1-4624-bc79-a0e72155212c','Y',0,'N','N','N','N','N')
;

-- 07-Oct-2026, 8:31:01 pm IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (209250,'Export Full Entity Change','Export all dictionary records of the entity type','When ticked, all application dictionary records of the selected entity type are included in the 2pack. With Date From set, only records updated since then. Otherwise only the entity type record is exported.',50006,217665,'Y','@Type@=ET',0,65,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-07 20:31:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-07 20:31:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fc804b3b-04ef-42d1-b733-4af5f47aed9c','Y',350,2,1,1,'N','N','N','N','N')
;

-- 07-Oct-2026, 8:42:51 pm IST
ALTER TABLE AD_Package_Exp_Detail ADD COLUMN IsExportFullEntityChange CHAR(1) DEFAULT 'N' CHECK (IsExportFullEntityChange IN ('Y','N')) NOT NULL
;

