-- 
SELECT register_migration_script('202507291808_ZeroQtyIgnoredFlag.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 29-Jul-2025, 6:08:09 pm IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204014,0,0,'Y',TO_TIMESTAMP('2025-07-29 18:08:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-29 18:08:08','YYYY-MM-DD HH24:MI:SS'),100,'isZeroQtyIgnored','Zero Qty Ignored','Zero Qty Ignored','D','5eedbaff-9510-47af-9d5d-f5503c94f4f3')
;

-- 29-Jul-2025, 6:09:16 pm IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217142,0,'Zero Qty Ignored',217,'isZeroQtyIgnored','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-07-29 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-29 18:09:15','YYYY-MM-DD HH24:MI:SS'),100,204014,'Y','N','D','N','N','N','Y','8ac204c4-a335-4329-a7d8-d7a29d951765','Y',0,'N','N','N','N','N')
;

-- 29-Jul-2025, 6:09:54 pm IST
ALTER TABLE C_DocType ADD isZeroQtyIgnored CHAR(1) DEFAULT 'N' CHECK (isZeroQtyIgnored IN ('Y','N')) NOT NULL
;

-- 29-Jul-2025, 6:10:35 pm IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208832,'Zero Qty Ignored',167,217142,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-29 18:10:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-29 18:10:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9835e22c-dac3-4ee4-a251-7ed053c411b8','Y',380,2,2)
;

-- 29-Jul-2025, 6:15:07 pm IST
UPDATE AD_Field SET DisplayLogic='@DocSubTypeInv@=''IU''',Updated=TO_TIMESTAMP('2025-07-29 18:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208832
;