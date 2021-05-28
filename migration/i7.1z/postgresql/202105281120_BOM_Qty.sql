-- Allowing to specify Libero BOM with quantity

-- 28-May-2021, 7:51:16 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214427,0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',53018,'Qty','1',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-05-28 07:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-28 07:51:10','YYYY-MM-DD HH24:MI:SS'),100,526,'Y','N','EE01','Y','N','N','Y','132e9f44-3da7-49aa-96c0-b6a685c59d96','Y',0,'N','N','N','N')
;

-- 28-May-2021, 7:51:17 AM IST
ALTER TABLE PP_Product_BOM ADD COLUMN Qty NUMERIC DEFAULT '1' 
;

-- 28-May-2021, 7:51:17 AM IST
UPDATE AD_Field SET SeqNo=0, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2021-05-28 07:51:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205015
;

-- 28-May-2021, 7:51:23 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206609,'Quantity','Quantity','Component qty required is in respect to Quantity specified here and UOM on Product BOM',53028,214427,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-05-28 07:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-28 07:51:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','EE01','e6303ec8-ead5-4eae-afd8-7931a928eb89','Y',200,1,2,1,'N','N','N','N')
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53476
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53465
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53466
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53467
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=110, Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53468
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53469
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53470
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53471
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53472
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53473
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53477
;

-- 28-May-2021, 7:51:23 AM IST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2021-05-28 07:51:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53478
;

-- 28-May-2021, 7:51:24 AM IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2021-05-28 07:51:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53479
;

-- 28-May-2021, 7:51:24 AM IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2021-05-28 07:51:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53480
;

-- 28-May-2021, 7:51:29 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214428,0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',53026,'Qty',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-05-28 07:51:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-28 07:51:24','YYYY-MM-DD HH24:MI:SS'),100,526,'Y','N','EE01','Y','N','N','Y','6a6b6f22-60ca-4281-a224-e8ff14c1accb','Y',0,'N','N','N','N')
;

-- 28-May-2021, 7:51:29 AM IST
ALTER TABLE PP_Order_BOM ADD COLUMN Qty NUMERIC DEFAULT NULL 
;

-- 28-May-2021, 7:51:29 AM IST
UPDATE AD_Field SET SeqNo=0, Updated=TO_TIMESTAMP('2021-05-28 07:51:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205003
;

-- 28-May-2021, 7:51:36 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206610,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',53040,214428,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-05-28 07:51:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-28 07:51:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','e1435896-141f-4afb-946a-5df1c5893bc0','Y',190,1,2,1,'N','N','N','N')
;

-- 28-May-2021, 7:51:36 AM IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2021-05-28 07:51:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53798
;

-- 28-May-2021, 7:51:36 AM IST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2021-05-28 07:51:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53799
;

-- 28-May-2021, 7:51:36 AM IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2021-05-28 07:51:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53800
;

SELECT register_migration_script('202105281120_BOM_Qty.sql') FROM dual
;