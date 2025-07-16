-- IDEMPIERE-5752 on Financial Report, Adding way to report lines per accounting dimensions
-- Jun 27, 2025, 7:02:37 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204013,0,0,'Y',TO_TIMESTAMP('2025-06-27 19:02:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-27 19:02:36','YYYY-MM-DD HH24:MI:SS'),100,'DimensionName','Dimension Name','Dimension Name for report line and source.','Mention dimension by which this report line/source needs to group','Dimension Name','D','576374cc-01b8-40ef-a84d-18dd521e95c3')
;

-- Jun 27, 2025, 7:05:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217139,0,'Dimension Name','Dimension Name for report line and source.','Mention dimension by which this report line/source needs to group',544,'DimensionName',22,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2025-06-27 19:05:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-27 19:05:29','YYYY-MM-DD HH24:MI:SS'),100,204013,'Y','Y','D','N','N','N','Y','9aa65732-7075-4b20-80aa-56e4f258b117','Y',10,'N','N','N','N','N')
;

-- Jun 27, 2025, 7:05:35 PM IST
ALTER TABLE T_Report ADD COLUMN DimensionName VARCHAR(22) DEFAULT NULL 
;

-- Jul 3, 2025, 2:03:56 PM IST
UPDATE AD_Column SET FieldLength=1000, AD_Reference_ID=10,Updated=TO_TIMESTAMP('2025-07-03 14:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217139
;

-- Jul 3, 2025, 2:03:59 PM IST
INSERT INTO t_alter_column values('t_report','DimensionName','VARCHAR(1000)',null,'NULL',null)
;

SELECT register_migration_script('202506301660_IDEMPIERE-5752.sql') FROM dual;