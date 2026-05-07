-- IDEMPIERE-6978  Sales order line mandatory on shipment line should be configurable per document type
SELECT register_migration_script('202604271611_IDEMPIERE-6978.sql') FROM dual;

-- Apr 27, 2026, 4:11:21 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204099,0,0,'Y',TO_TIMESTAMP('2026-04-27 16:11:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-27 16:11:20','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowShipmentWithoutOrder','Allow Shipment without Sales Order','Indicates whether shipment (material delivery) documents can be created without referencing a Sales Order line.','When this option is enabled, users are allowed to create Shipment (Material Delivery) lines without linking them to a Sales Order Line (C_OrderLine_ID).','Allow Shipment without Sales Order','D','1a32e2cd-204e-473e-bf5d-968a411c0e20')
;

-- Apr 27, 2026, 4:13:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217571,0,'Allow Shipment without Sales Order','Indicates whether shipment (material delivery) documents can be created without referencing a Sales Order line.','When this option is enabled, users are allowed to create Shipment (Material Delivery) lines without linking them to a Sales Order Line (C_OrderLine_ID).',217,'IsAllowShipmentWithoutOrder','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-04-27 16:13:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-27 16:13:36','YYYY-MM-DD HH24:MI:SS'),100,204099,'Y','N','D','N','N','N','Y','ca9a1b98-d642-4fab-9bc8-93f0b1404b22','N',0,'N','N','N','N','N')
;

-- Apr 27, 2026, 4:13:39 PM IST
ALTER TABLE C_DocType ADD COLUMN IsAllowShipmentWithoutOrder CHAR(1) DEFAULT 'N' CHECK (IsAllowShipmentWithoutOrder IN ('Y','N')) NOT NULL
;

-- Apr 27, 2026, 4:17:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (209174,'Allow Shipment without Sales Order','Indicates whether shipment (material delivery) documents can be created without referencing a Sales Order line.','When this option is enabled, users are allowed to create Shipment (Material Delivery) lines without linking them to a Sales Order Line (C_OrderLine_ID).',167,217571,'Y','@DocBaseType@=''MMS''',0,365,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-04-27 16:17:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-27 16:17:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1112f499-3d3c-4752-b1f5-05f73f5f792c','Y',355,5,2,1,'N','N','N','N','N')
;

