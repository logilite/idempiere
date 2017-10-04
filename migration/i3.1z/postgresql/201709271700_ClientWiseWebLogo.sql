-- Add Web Header Logo
-- Sep 22, 2017 12:38:47 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203138,0,0,'Y',TO_TIMESTAMP('2017-09-22 12:38:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-22 12:38:46','YYYY-MM-DD HH24:MI:SS'),100,'LogoWebHeader_ID','Logo Web Header','Logo Web Header','D','10649799-238b-47bd-bb0c-cb53224fb2a5')
;

-- Sep 22, 2017 12:39:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213253,0,'Logo Web Header',227,'LogoWebHeader_ID',10,'N','N','N','N','N',0,'N',32,0,0,'Y',TO_TIMESTAMP('2017-09-22 12:39:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-22 12:39:10','YYYY-MM-DD HH24:MI:SS'),100,203138,'Y','N','D','N','N','N','Y','909240c5-646a-44f5-bb4a-21b41047f9af','Y',0,'N','N')
;

-- Sep 22, 2017 12:39:15 PM IST
UPDATE AD_Column SET FKConstraintName='LogoWebHeader_ADClientInfo', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-09-22 12:39:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213253
;

-- Sep 22, 2017 12:39:16 PM IST
ALTER TABLE AD_ClientInfo ADD COLUMN LogoWebHeader_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 22, 2017 12:39:16 PM IST
ALTER TABLE AD_ClientInfo ADD CONSTRAINT LogoWebHeader_ADClientInfo FOREIGN KEY (LogoWebHeader_ID) REFERENCES ad_image(ad_image_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 22, 2017 12:40:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205240,'Logo Web Header',169,213253,'Y',40,250,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-09-22 12:40:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-22 12:40:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50012,'D','95765d5a-c242-4371-bcdf-4765a2b1c1e6','Y',220,1,5,1,'N','N','N')
;

-- Sep 27, 2017 3:13:06 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203139,0,0,'Y',TO_TIMESTAMP('2017-09-27 15:13:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-27 15:13:05','YYYY-MM-DD HH24:MI:SS'),100,'ZKHostname','ZK Hostname','Hostname of the ZK webui server','ZK Hostname','D','5bc721a8-e4ce-4653-9d43-a1001e087684')
;

-- Sep 27, 2017 3:13:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213254,0,'ZK Hostname','Hostname of the ZK webui server',227,'ZKHostname',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-09-27 15:13:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-27 15:13:38','YYYY-MM-DD HH24:MI:SS'),100,203139,'Y','N','D','N','N','N','Y','96356123-e337-4a56-b2d3-85433db6e4e8','Y',0,'N','N')
;

-- Sep 27, 2017 3:13:44 PM IST
ALTER TABLE AD_ClientInfo ADD COLUMN ZKHostname VARCHAR(255) DEFAULT NULL 
;

-- Sep 27, 2017 3:23:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205241,'ZK Hostname','Hostname of the ZK webui server',169,213254,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-09-27 15:23:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-27 15:23:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aea9457f-8450-4a6e-8852-3f0b40e28c64','Y',360,1,4,1,'N','N','N')
;

SELECT register_migration_script('201709271700_ClientWiseWebLogo.sql') FROM dual
;