SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Sep 14, 2021, 2:37:18 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203537,0,0,'Y',TO_DATE('2021-09-14 14:37:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-14 14:37:17','YYYY-MM-DD HH24:MI:SS'),100,'Tooltip_InfoColumn_ID','Tooltip Column','To show tooltip on the column.','This column is used to show tooltip on info column.','Tooltip Column','D','52251f12-7f21-4516-8f36-f6a29ba63e33')
;

-- Sep 14, 2021, 2:39:42 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203538,0,0,'Y',TO_DATE('2021-09-14 14:39:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-09-14 14:39:41','YYYY-MM-DD HH24:MI:SS'),100,'IsHideInfoColumn','Hide Column','Determines, if this field is hide but it will render its data.','If this field is marked then the info window column/field will be invisible and the data will be rendered.','Hide Column','D','29563cd0-ac00-4717-a2af-565135790ecf')
;

-- Sep 14, 2021, 3:18:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214586,0,'Tooltip Column','To show tooltip on the column.','This column is used to show tooltip on info column.',897,200065,'Tooltip_InfoColumn_ID',10,'N','N','N','N','N',0,'N',18,200072,0,0,'Y',TO_TIMESTAMP('2021-09-14 15:18:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-14 15:18:07','YYYY-MM-DD HH24:MI:SS'),100,203537,'Y','N','D','N','N','N','Y','61d9c46f-0db2-4663-ae88-0d29a5416499','Y',0,'N','N','N','N')
;

-- Sep 14, 2021, 3:18:26 PM IST
UPDATE AD_Column SET FKConstraintName='TooltipInfoColumn_ADInfoColumn', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-09-14 15:18:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214586
;

-- Sep 14, 2021, 3:18:26 PM IST
ALTER TABLE AD_InfoColumn ADD COLUMN Tooltip_InfoColumn_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 14, 2021, 3:18:26 PM IST
ALTER TABLE AD_InfoColumn ADD CONSTRAINT TooltipInfoColumn_ADInfoColumn FOREIGN KEY (Tooltip_InfoColumn_ID) REFERENCES ad_infocolumn(ad_infocolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 14, 2021, 3:20:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214587,0,'Hide Column','Determines, if this field is hide but it will render its data.','If this field is marked then the info window column/field will be invisible and the data will be rendered.',897,'IsHideInfoColumn','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-09-14 15:20:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-14 15:20:08','YYYY-MM-DD HH24:MI:SS'),100,203538,'Y','N','D','N','N','N','Y','4f03f44b-dabe-494a-8413-f75d5cccc9d5','Y',0,'N','N','N','N')
;

-- Sep 14, 2021, 3:20:11 PM IST
ALTER TABLE AD_InfoColumn ADD COLUMN IsHideInfoColumn CHAR(1) DEFAULT 'N' CHECK (IsHideInfoColumn IN ('Y','N'))
;

-- Sep 14, 2021, 3:20:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206748,'Tooltip Column','To show tooltip on the column.','This column is used to show tooltip on info column.',844,214586,'Y',10,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-09-14 15:20:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-14 15:20:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2437855d-3329-47fd-a37f-1e6415912634','Y',10290,2)
;

-- Sep 14, 2021, 3:20:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206749,'Hide Column','Determines, if this field is hide but it will render its data.','If this field is marked then the info window column/field will be invisible and the data will be rendered.',844,214587,'Y',1,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-09-14 15:20:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-14 15:20:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fd8b9ff4-295b-4aa9-a9cd-534c12d6ef5a','Y',10300,2,2)
;

-- Sep 14, 2021, 3:22:59 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-14 15:22:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206748
;

-- Sep 14, 2021, 3:22:59 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=8, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-09-14 15:22:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206749
;

SELECT register_migration_script('202108151541_InfoColumn_Tooltip.sql') FROM dual
;