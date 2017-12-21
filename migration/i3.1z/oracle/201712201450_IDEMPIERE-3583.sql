SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3583 : Allow Document Controlled Entry in GL Journal From Adaxa
-- Dec 20, 2017 2:31:27 PM PST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203148,0,0,'Y',TO_DATE('2017-12-20 14:31:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-12-20 14:31:26','YYYY-MM-DD HH24:MI:SS'),100,'IsOverrideDocControl','Override Doc Control','Allow posting to Document Controlled accounts from GL Journal','Override Doc Control','D','09492d8a-f641-4a60-90d4-694c205ad671')
;

-- Dec 20, 2017 2:32:41 PM PST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213304,0,'Override Doc Control','Allow posting to Document Controlled accounts from GL Journal',217,'IsOverrideDocControl','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-12-20 14:32:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-12-20 14:32:40','YYYY-MM-DD HH24:MI:SS'),100,203148,'Y','N','U','N','N','N','Y','3093463f-e36b-40ea-8718-59730510de29','Y',0,'N','N')
;

-- Dec 20, 2017 2:32:54 PM PST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2017-12-20 14:32:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213304
;

-- Dec 20, 2017 2:32:57 PM PST
ALTER TABLE C_DocType ADD IsOverrideDocControl CHAR(1) DEFAULT 'N' CHECK (IsOverrideDocControl IN ('Y','N'))
;

-- Dec 20, 2017 2:33:27 PM PST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205278,'Override Doc Control','Allow posting to Document Controlled accounts from GL Journal',167,213304,'Y',0,340,0,'N','N','N','N',0,0,'Y',TO_DATE('2017-12-20 14:33:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-12-20 14:33:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','57cdb402-0d04-46c0-a40e-92c75080df17','Y',330,1,1,1,'N','N','N','N')
;

-- Dec 20, 2017 2:34:01 PM PST
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-12-20 14:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205278
;

-- Dec 20, 2017 2:35:39 PM PST
UPDATE AD_Field SET SeqNo=315, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2017-12-20 14:35:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205278
;

SELECT register_migration_script('201712201450_IDEMPIERE-3583.sql') FROM dual
;

