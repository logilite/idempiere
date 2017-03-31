-- IDEMPIERE-2840 : Tokens for login into web services
-- Mar 31, 2017 2:17:51 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203062,0,0,'Y',TO_TIMESTAMP('2017-03-31 14:17:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-03-31 14:17:50','YYYY-MM-DD HH24:MI:SS'),100,'IsValidForSameClient','Valid For Same Client','This flag is to determine that given role can access this web service from single IP or multiple IP address','Valid For Same Client','U','0b4de2a1-7d91-41a6-8979-8dceab1e3903')
;

-- Mar 31, 2017 2:18:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212970,0,'Valid For Same Client','This flag is to determine that given role can access this web service from single IP or multiple IP address',53168,'IsValidForSameClient','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-03-31 14:18:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-03-31 14:18:26','YYYY-MM-DD HH24:MI:SS'),100,203062,'Y','N','U','N','N','N','Y','2a3fcd22-ccda-46e4-a3d1-6828f63bb0a5','Y',0,'N','N')
;

-- Mar 31, 2017 2:18:30 PM IST
ALTER TABLE WS_WebServiceTypeAccess ADD COLUMN IsValidForSameClient CHAR(1) DEFAULT 'Y' CHECK (IsValidForSameClient IN ('Y','N')) NOT NULL
;

-- Mar 31, 2017 2:19:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204375,'Valid For Same Client','This flag is to determine that given role can access this web service from single IP or multiple IP address',53191,212970,'Y',0,45,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-03-31 14:19:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-03-31 14:19:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','0913e8e6-0e48-4acb-9385-ebda3dbe635e','Y',40,5,2,1,'N','N','N')
;

SELECT register_migration_script('201703311420_IDEMPIERE-2840.sql') FROM dual
;
