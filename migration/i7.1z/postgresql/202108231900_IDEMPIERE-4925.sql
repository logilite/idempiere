-- IDEMPIERE-4925 : Adding column for UOM and QtyEntered on movement line
-- 23-Aug-2021, 9:50:42 AM GMT-04:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214579,0,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',324,'QtyEntered',NULL,22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-08-23 09:50:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-23 09:50:43','YYYY-MM-DD HH24:MI:SS'),100,'org.compiere.model.CalloutMovement.qty',2589,'N','N','D','Y','N','N','Y','8bd89644-4396-4013-9bf8-7e44002ebfc6','Y',0,'N','N','N','N')
;

-- 23-Aug-2021, 9:50:44 AM GMT-04:00
ALTER TABLE M_MovementLine ADD COLUMN QtyEntered NUMERIC DEFAULT NULL 
;

-- 23-Aug-2021, 9:50:46 AM GMT-04:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214580,0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',324,210,'C_UOM_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-08-23 09:50:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-23 09:50:45','YYYY-MM-DD HH24:MI:SS'),100,'org.compiere.model.CalloutMovement.qty',215,'Y','N','D','Y','N','N','Y','aa0f974a-55b4-4113-ba55-a532a1fbcdd0','Y',0,'N','N','CUOM_MMovementLine','N','N')
;

-- 23-Aug-2021, 9:50:46 AM GMT-04:00
ALTER TABLE M_MovementLine ADD COLUMN C_UOM_ID NUMERIC(10) DEFAULT NULL 
;

-- 23-Aug-2021, 9:50:47 AM GMT-04:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206741,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',260,214579,'Y',22,125,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-23 09:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-23 09:50:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',102,'D','7f3ea95a-cae2-48b1-881c-bbd2339877dc','Y',170,1,2,1,'N','N','N','N')
;

-- 23-Aug-2021, 9:50:48 AM GMT-04:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206742,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',260,214580,'Y',22,126,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-23 09:50:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-23 09:50:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',102,'D','6d2a7e5f-a7a1-48d3-81d6-f4577020756b','Y',126,4,2,1,'N','N','N','N')
;

-- 23-Aug-2021, 9:50:48 AM GMT-04:00
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2021-08-23 09:50:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2738
;

-- 23-Aug-2021, 9:50:48 AM GMT-04:00
ALTER TABLE M_MovementLine ADD CONSTRAINT CUOM_MMovementLine FOREIGN KEY (C_UOM_ID) REFERENCES c_uom(c_uom_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('202108231900_IDEMPIERE-4925.sql') FROM dual
;
