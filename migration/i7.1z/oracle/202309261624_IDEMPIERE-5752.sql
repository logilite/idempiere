-- IDEMPIERE-5752  on Financial Report, Adding way to report lines per accounting dimensions
SELECT register_migration_script('202309261624_IDEMPIERE-5752.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 26, 2023, 4:24:54 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203835,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:50','YYYY-MM-DD HH24:MI:SS'),100,'DimensionGroup','Dimension Group','Dimension Group for report line and source.','Mention dimension by which this report line/source needs to group','Dimension Group','D','f1617b12-a25a-4a0a-a0fa-ba2e19fb27b7')
;

-- Sep 26, 2023, 4:24:55 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,Help,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,VFormat,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200249,'Dimension Group Type','Dimension Group Type for Accounting Elements','Hardcoded Dimension Group Type','L',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:54','YYYY-MM-DD HH24:MI:SS'),100,'AA','D','N','8faa03dc-28bc-47fb-b3c6-43d910444a5e')
;

-- Sep 26, 2023, 4:24:56 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200649,'Organization','Owning Organization',200249,'OO',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:55','YYYY-MM-DD HH24:MI:SS'),100,'D','c4d1b75c-ba1d-4278-ab41-c26ca695d8e3')
;

-- Sep 26, 2023, 4:24:56 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200650,'Product','Product',200249,'PR',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:56','YYYY-MM-DD HH24:MI:SS'),100,'D','198421b1-41a6-4f7d-aca8-ec34577356a2')
;

-- Sep 26, 2023, 4:24:57 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200651,'Sales Region','Sales Region',200249,'SR',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:56','YYYY-MM-DD HH24:MI:SS'),100,'D','2544bad5-2c2b-4b73-b7dd-d3cee11c1d0e')
;

-- Sep 26, 2023, 4:24:57 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200652,'Project','Project',200249,'PJ',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:57','YYYY-MM-DD HH24:MI:SS'),100,'D','744fddd1-dd66-4abf-9c40-a56deb0a6537')
;

-- Sep 26, 2023, 4:24:58 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200653,'Campaign','Marketing Campaign',200249,'MC',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:57','YYYY-MM-DD HH24:MI:SS'),100,'D','26f08728-4b60-4fc7-8d5f-022bdd9df664')
;

-- Sep 26, 2023, 4:24:59 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200654,'Activity','Business Activity',200249,'AY',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:58','YYYY-MM-DD HH24:MI:SS'),100,'D','a9ab1fe5-b9b5-4791-b794-87e7aba4d04a')
;

-- Sep 26, 2023, 4:24:59 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200655,'Business Partner','Business Partner',200249,'BP',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:59','YYYY-MM-DD HH24:MI:SS'),100,'D','0c44b739-75bd-426a-80f2-ff5168d8855f')
;

-- Sep 26, 2023, 4:25:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215927,0,'Dimension Group','Dimension Group for report line and source.','Mention dimension by which this report line/source needs to group',448,'DimensionGroup',2,'N','N','N','N','N',0,'N',17,200249,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:24:59','YYYY-MM-DD HH24:MI:SS'),100,203835,'Y','N','D','Y','N','N','Y','d1142f38-61e7-4a11-839a-8155df0c0577','Y',0,'N','N','N','N')
;

-- Sep 26, 2023, 4:25:00 PM IST
ALTER TABLE PA_ReportLine ADD DimensionGroup VARCHAR2(2 CHAR) DEFAULT NULL 
;

-- Sep 26, 2023, 4:25:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207724,'Dimension Group','Dimension Group for report line and source.','Mention dimension by which this report line/source needs to group',376,215927,'Y','@LineType@=''S''',2,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','163bb4c2-3bc3-48c2-a345-37eed89b9586','Y',255,4,2,1,'N','N','N','N')
;

-- Sep 26, 2023, 4:25:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215928,0,'Dimension Group','Dimension Group for report line and source.','Mention dimension by which this report line/source needs to group',450,'DimensionGroup',2,'N','N','N','N','N',0,'N',17,200249,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:00','YYYY-MM-DD HH24:MI:SS'),100,203835,'Y','N','D','Y','N','N','Y','cd34f013-f1c4-4276-8829-0c4a31f5718c','Y',0,'N','N','N','N')
;

-- Sep 26, 2023, 4:25:01 PM IST
ALTER TABLE PA_ReportSource ADD DimensionGroup VARCHAR2(2 CHAR) DEFAULT NULL 
;

-- Sep 26, 2023, 4:25:02 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207725,'Dimension Group','Dimension Group for report line and source.','Mention dimension by which this report line/source needs to group',377,215928,'Y','@ElementType@=''AC''',2,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3df55562-839c-4375-8450-204866811ba3','Y',310,4,2,1,'N','N','N','N')
;

-- Sep 26, 2023, 4:25:02 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203836,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:02','YYYY-MM-DD HH24:MI:SS'),100,'DimensionGroupRecord_ID','Dimension Group Record ID ','Dimension Group Record ID for report line and source.','Mention the dimension by which this report line/source needs to group','Dimension Group Record ID ','D','114fa992-05d5-4fd7-a2e4-a2bbb03eda4a')
;

-- Sep 26, 2023, 4:25:03 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215929,0,'Dimension Group Record ID ','Dimension Group Record ID for report line and source.','Mention the dimension by which this report line/source needs to group',544,'DimensionGroupRecord_ID',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:02','YYYY-MM-DD HH24:MI:SS'),100,203836,'Y','N','D','Y','N','N','Y','01f7718f-b6c0-4866-937a-d195c06c40db','Y',0,'N','N','N','N')
;

-- Sep 26, 2023, 4:25:03 PM IST
ALTER TABLE T_Report ADD DimensionGroupRecord_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 26, 2023, 4:25:03 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203837,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:03','YYYY-MM-DD HH24:MI:SS'),100,'DimensionGroupName','Dimension Group Name','Dimension Group Name for report line and source.','Dimension Group Name for report line and source.','Dimension Group Name','D','49d1a613-13bf-46ef-80ad-032acec46452')
;

-- Sep 26, 2023, 4:25:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215930,0,'Dimension Group Name','Dimension Group Name for report line and source.','Dimension Group Name for report line and source.',544,'DimensionGroupName',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-09-26 16:25:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-26 16:25:03','YYYY-MM-DD HH24:MI:SS'),100,203837,'Y','N','D','Y','N','N','Y','1da39c5e-3d0f-4c3e-b17e-04bd8d4438ed','Y',0,'N','N','N')
;

-- Sep 26, 2023, 4:25:04 PM IST
ALTER TABLE T_Report ADD DimensionGroupName VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Sep 26, 2023, 4:25:04 PM IST
ALTER TABLE T_Report DROP CONSTRAINT t_report_pkey
;

