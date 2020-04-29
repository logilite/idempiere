-- IDEMPIERE-3786 Add Grid View page size config at tab level
-- Mar 20, 2020 4:26:00 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203408,0,0,'Y',TO_TIMESTAMP('2020-03-20 16:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-20 16:25:59','YYYY-MM-DD HH24:MI:SS'),100,'PageSize','Page Size','Page size of the tab in the grid view','Page Size','D','632ee294-53ef-4986-be72-42c8fd05891a')
;

-- Mar 20, 2020 4:27:32 PM IST
UPDATE AD_Element SET ColumnName='PageSize',Updated=TO_TIMESTAMP('2020-03-20 16:27:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203408
;

-- Mar 20, 2020 4:27:32 PM IST
UPDATE AD_Column SET ColumnName='PageSize', Name='Page Size', Description='Page size of the tab in the grid view', Help=NULL, Placeholder='Page Size' WHERE AD_Element_ID=203408
;

-- Mar 20, 2020 4:30:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214188,0,'Page Size','Page size of the tab in the grid view',106,'PageSize',10,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2020-03-20 16:30:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-20 16:30:55','YYYY-MM-DD HH24:MI:SS'),100,203408,'Y','N','D','N','N','N','Y','bae50c7f-ecda-48a4-a367-e99d507014d1','Y',0,'N','N')
;

-- Mar 20, 2020 4:31:02 PM IST
ALTER TABLE AD_Tab ADD COLUMN PageSize NUMERIC DEFAULT NULL 
;

-- Mar 20, 2020 4:31:11 PM IST
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2020-03-20 16:31:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214188
;

-- Mar 20, 2020 4:32:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206396,'Page Size','Page size of the tab in the grid view',106,214188,'Y',0,345,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-03-20 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-20 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a7ad9c45-a08a-4f2c-801f-207b96f48aa1','Y',315,4,1,1,'N','N','N','N')
;
-- Mar 27, 2020 3:06:57 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203409,0,0,'Y',TO_TIMESTAMP('2020-03-27 15:06:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-27 15:06:57','YYYY-MM-DD HH24:MI:SS'),100,'DetailPageSize','Detail Page Size','Page size of the tab in the detail view','Detail Page Size','D','775434d2-87b4-4e36-b5e1-da9b17eddc14')
;

-- Mar 27, 2020 3:48:53 PM IST
ALTER TABLE AD_Tab ADD COLUMN DetailPageSize NUMERIC DEFAULT NULL 
;

-- Mar 27, 2020 3:08:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214189,0,'Detail Page Size','Page size of the tab in the detail view',106,'DetailPageSize',22,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2020-03-27 15:08:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-27 15:08:06','YYYY-MM-DD HH24:MI:SS'),100,203409,'Y','N','D','N','Y','N','Y','8b9ed62e-7971-434a-af5a-d36973c71518','Y',0,'N','N')
;

-- Mar 27, 2020 3:17:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206397,'Detail Page Size','Page size of the tab in the detail view',106,214189,'Y',0,346,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-03-27 15:17:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-03-27 15:17:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d940be3e-16a6-4b91-a1d5-ff441746251c','Y',315,4,1,1,'N','N','N','N')
;

-- Mar 27, 2020 3:20:51 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-03-27 15:20:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206396
;


CREATE OR REPLACE VIEW AD_TAB_V
(AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, DESCRIPTION, 
 HELP, SEQNO, ISSINGLEROW, HASTREE, ISINFOTAB, 
 REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, ISDELETEABLE, 
 ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, ISREADONLY, 
 AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, COMMITWARNING, 
 READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, ISSORTTAB, 
 ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID,
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON, AD_TabType, PageSize, DetailPageSize)
AS 
SELECT t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, t.Name, t.Description, 
    t.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, t.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.AD_TabType, t.PageSize, t.DetailPageSize
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y';

CREATE OR REPLACE VIEW AD_TAB_VT
(AD_LANGUAGE, AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, 
 DESCRIPTION, HELP, SEQNO, ISSINGLEROW, HASTREE, 
 ISINFOTAB, REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, 
 ISDELETEABLE, ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, 
 ISREADONLY, AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, 
 COMMITWARNING, READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, 
 ISSORTTAB, ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON, AD_TabType, PageSize, DetailPageSize)
AS 
SELECT trl.AD_Language, t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, trl.Name, trl.Description, 
    trl.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, trl.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn,t.AD_TabType, t.PageSize, t.DetailPageSize
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
	INNER JOIN AD_Tab_Trl trl ON (t.AD_Tab_ID = trl.AD_Tab_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y';

SELECT register_migration_script('202003271400_IDEMPIERE-3786.sql') FROM dual
;


