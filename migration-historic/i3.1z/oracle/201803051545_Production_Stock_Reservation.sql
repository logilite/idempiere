SET SQLBLANKLINES ON
SET DEFINE OFF

-- Production Reservation
-- Mar 5, 2018 5:35:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213393,0,'Reserved Quantity','Reserved Quantity','The Reserved Quantity indicates the quantity of a product that is currently reserved.',326,'QtyReserved',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_DATE('2018-03-05 17:35:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-03-05 17:35:42','YYYY-MM-DD HH24:MI:SS'),100,532,'Y','N','D','N','N','N','Y','7b20ce50-fb4d-474f-88a8-e766d5467042','N',0,'N','N')
;

-- Mar 5, 2018 5:35:46 PM IST
ALTER TABLE M_ProductionLine ADD QtyReserved NUMBER DEFAULT NULL 
;

-- Mar 5, 2018 5:40:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205351,'Reserved Quantity','Reserved Quantity','The Reserved Quantity indicates the quantity of a product that is currently reserved.',53345,213393,'Y',0,150,0,'N','N','N','N',0,0,'Y',TO_DATE('2018-03-05 17:40:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-03-05 17:40:37','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','76af37f9-a3a1-4984-8c5c-04e3263ad2d0','Y',150,1,1,1,'N','N','N','N')
;

-- Mar 5, 2018 5:41:29 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-03-05 17:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205351
;

-- Mar 5, 2018 5:41:29 PM IST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-03-05 17:41:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59763
;

SELECT register_migration_script('201803051545_Production_Stock_Reservation.sql') FROM dual
;