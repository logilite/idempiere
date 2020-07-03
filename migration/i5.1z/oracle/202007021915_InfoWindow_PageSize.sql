SET SQLBLANKLINES ON
SET DEFINE OFF

-- Pagination page size setup for info window.
-- Jul 3, 2020 5:51:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214214,0,'Page Size','Page size of the tab in the grid view',895,'PageSize','0',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2020-07-03 17:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-07-03 17:51:23','YYYY-MM-DD HH24:MI:SS'),100,203408,'Y','N','D','N','Y','N','Y','cf91f977-457f-4972-aeb7-44ac3a636de0','Y',0,'N','N')
;

-- Jul 3, 2020 5:52:06 PM IST
ALTER TABLE AD_InfoWindow ADD COLUMN PageSize NUMERIC(10) DEFAULT '0';

-- Jul 3, 2020 5:57:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206418,'Page Size','Page size of the tab in the grid view',842,214214,'Y',120,230,'N','N','N','N',0,0,'Y',TO_DATE('2020-07-03 17:57:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-07-03 17:57:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','934d78e2-4aee-4431-b7cd-f9fb33f7f666','Y',130,1,2,1,'N','N','N','N')
;


SELECT register_migration_script('202007021915_InfoWindow_PageSize.sql') FROM dual
;
