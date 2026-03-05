-- IDEMPIERE-6892: Show the transitions of the node as options
SELECT register_migration_script('202603031439_IDEMPIERE-6892.sql') FROM dual;

-- 03/03/2026 14:39:34 IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204033,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:39:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:39:13','YYYY-MM-DD HH24:MI:SS'),100,'IsShowTransitionsAsOptions','Show Transitions as Options','If enabled, the transitions of this workflow node will be pr','Enable this option to display all valid outgoing transitions from this node as selectable choices in the user interface.','Show Transitions as Options','D','ed0def34-4992-4ce9-ae69-88fb568c80fd')
;

-- 03/03/2026 14:39:49 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217382,0,'Show Transitions as Options','If enabled, the transitions of this workflow node will be pr','Enable this option to display all valid outgoing transitions from this node as selectable choices in the user interface.',129,'IsShowTransitionsAsOptions','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:39:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:39:48','YYYY-MM-DD HH24:MI:SS'),100,204033,'Y','N','D','N','N','N','Y','3c6d7f3c-3c47-4a12-8651-57b13e1a7d67','N',0,'N','N','N','N','N')
;

-- 03/03/2026 14:39:54 IST
ALTER TABLE AD_WF_Node ADD COLUMN IsShowTransitionsAsOptions CHAR(1) DEFAULT 'N' CHECK (IsShowTransitionsAsOptions IN ('Y','N')) NOT NULL
;

-- 03/03/2026 14:40:39 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209007,'Show Transitions as Options','If enabled, the transitions of this workflow node will be pr','Enable this option to display all valid outgoing transitions from this node as selectable choices in the user interface.',122,217382,'Y',1,186,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:40:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:40:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','512e01cf-6eda-48eb-90b9-8749f547182b','Y',186,2,2)
;

-- 03/03/2026 14:48:21 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217383,0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',131,'Value',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:48:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:48:21','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','N','N','Y','0205cdbf-a312-4591-9ba1-c438f9a54f69','N',10,'N','N','N','N','N')
;

-- 03/03/2026 14:48:24 IST
ALTER TABLE AD_WF_NodeNext ADD COLUMN Value VARCHAR(40) DEFAULT NULL 
;

-- 03/03/2026 14:48:40 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217384,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',131,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-03 14:48:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:48:39','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','1dfc830d-836b-41ff-acc1-cc0a31cf56ac','N',20,'N','N','N','N','N')
;

-- 03/03/2026 14:48:41 IST
ALTER TABLE AD_WF_NodeNext ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- 03/03/2026 14:50:40 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209008,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',124,217383,'Y',40,51,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:50:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:50:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','385ed828-3d29-440b-b5d3-795c9c70c149','Y',51,2)
;

-- 03/03/2026 14:50:40 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209009,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',124,217384,'Y',60,52,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-03 14:50:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-03 14:50:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f756ed0e-2e47-4023-877c-91802cbb7dc1','Y',52,5)
;

UPDATE AD_WF_NodeNext nn
SET 
    Name  = n.Name,
    Value = n.Value
FROM AD_WF_Node n
WHERE nn.AD_WF_Next_ID = n.AD_WF_Node_ID;
