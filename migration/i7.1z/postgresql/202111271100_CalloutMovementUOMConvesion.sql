-- Adding column UOM and QtyEntered on Movement Confirmation Line
-- 27-Nov-2021, 10:42:42 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214645,0,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',737,'QtyEntered',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-11-27 10:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 10:42:42','YYYY-MM-DD HH24:MI:SS'),100,2589,'Y','N','D','N','N','N','Y','aa456956-ea06-4d03-b00b-9cd9693d7547','Y',0,'N','N','N')
;

-- 27-Nov-2021, 10:42:45 AM IST
ALTER TABLE M_MovementLineConfirm ADD COLUMN QtyEntered NUMERIC DEFAULT NULL 
;

-- 27-Nov-2021, 10:43:23 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214646,0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',737,210,'C_UOM_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-11-27 10:43:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 10:43:23','YYYY-MM-DD HH24:MI:SS'),100,215,'Y','N','D','N','N','N','Y','4026ed42-874e-4491-9a80-f9cbf6f364c3','Y',0,'N','N','N','N')
;

-- 27-Nov-2021, 10:43:27 AM IST
UPDATE AD_Column SET FKConstraintName='CUOM_MMovementLineConfirm', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-11-27 10:43:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214646
;

-- 27-Nov-2021, 10:43:27 AM IST
ALTER TABLE M_MovementLineConfirm ADD COLUMN C_UOM_ID NUMERIC(10) DEFAULT NULL 
;

-- 27-Nov-2021, 10:43:27 AM IST
ALTER TABLE M_MovementLineConfirm ADD CONSTRAINT CUOM_MMovementLineConfirm FOREIGN KEY (C_UOM_ID) REFERENCES c_uom(c_uom_id) DEFERRABLE INITIALLY DEFERRED
;

-- 27-Nov-2021, 10:43:37 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206811,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',667,214645,'Y',22,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-11-27 10:43:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 10:43:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b8b37341-05eb-42ce-940b-2c0d49d9fe88','Y',120,2)
;

-- 27-Nov-2021, 10:43:38 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206812,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',667,214646,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-11-27 10:43:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 10:43:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf5178ee-f9fa-499a-89d2-a8f96affc8de','Y',130,2)
;

-- 27-Nov-2021, 10:43:57 AM IST
UPDATE AD_Field SET Name='QtyEntered', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-27 10:43:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206811
;

INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214650,0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',737,'M_Product_ID',22,'N','N','N','N','N',0,'N',30,171,0,0,'Y',TO_TIMESTAMP('2021-11-27 19:18:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 19:18:34','YYYY-MM-DD HH24:MI:SS'),100,454,'Y','N','D','N','N','N','Y','ed67c3e2-bb21-4911-a5cc-3929430b87b5','Y',0,'N','N','N','N')
;

-- 27-Nov-2021, 7:18:38 PM IST
UPDATE AD_Column SET FKConstraintName='MProduct_MMovementLineConfirm', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-11-27 19:18:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214650
;

-- 27-Nov-2021, 7:18:38 PM IST
ALTER TABLE M_MovementLineConfirm ADD COLUMN M_Product_ID NUMERIC(10) DEFAULT NULL 
;

-- 27-Nov-2021, 7:18:38 PM IST
ALTER TABLE M_MovementLineConfirm ADD CONSTRAINT MProduct_MMovementLineConfirm FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) DEFERRABLE INITIALLY DEFERRED
;

-- 27-Nov-2021, 7:19:33 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206813,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',667,214650,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-11-27 19:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-27 19:19:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d808c94f-c045-4373-9d30-79f1010cbee0','Y',140,2)
;

-- 30-Nov-2021, 1:39:23 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203550,0,0,'Y',TO_TIMESTAMP('2021-11-30 13:39:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:39:22','YYYY-MM-DD HH24:MI:SS'),100,'ConfirmedQtyEntered','Confirmed Quantity Entered','Confirmation of a received quantity','Confirmation of a received quantity','Confirmed Qty Entered','D','708ae89a-d10f-4b72-be71-914d3c6b0f43')
;

-- 30-Nov-2021, 1:40:47 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203551,0,0,'Y',TO_TIMESTAMP('2021-11-30 13:40:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:40:47','YYYY-MM-DD HH24:MI:SS'),100,'ScrappedQtyEntered','Scrapped Quantity Entered','The Quantity scrapped due to QA issues','Scrapped Qty Entered','D','66335e7d-f04a-4319-bd01-76a9e6069743')
;

-- 30-Nov-2021, 1:51:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214652,0,'Confirmed Quantity Entered','Confirmation of a received quantity','Confirmation of a received quantity',737,'ConfirmedQtyEntered',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-11-30 13:51:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:51:33','YYYY-MM-DD HH24:MI:SS'),100,203550,'Y','N','D','N','N','N','Y','47b120b2-27ea-415a-9274-ad78e9474cb1','Y',0,'N','N','N','N')
;

-- 30-Nov-2021, 1:51:36 PM IST
ALTER TABLE M_MovementLineConfirm ADD COLUMN ConfirmedQtyEntered NUMERIC DEFAULT NULL 
;

-- 30-Nov-2021, 1:52:08 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214653,0,'Scrapped Quantity Entered','The Quantity scrapped due to QA issues',737,'ScrappedQtyEntered',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-11-30 13:52:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:52:08','YYYY-MM-DD HH24:MI:SS'),100,203551,'Y','N','D','N','N','N','Y','92b544b4-6d6b-47ff-81ac-95b4b8b06bd0','Y',0,'N','N','N','N')
;

-- 30-Nov-2021, 1:52:11 PM IST
ALTER TABLE M_MovementLineConfirm ADD COLUMN ScrappedQtyEntered NUMERIC DEFAULT NULL 
;

-- 30-Nov-2021, 1:55:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206815,'Confirmed Quantity Entered','Confirmation of a received quantity','Confirmation of a received quantity',667,214652,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-11-30 13:55:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:55:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec02385b-edab-41e3-b8ba-b8afcbaf6d3e','Y',150,2)
;

-- 30-Nov-2021, 1:55:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206816,'Scrapped Quantity Entered','The Quantity scrapped due to QA issues',667,214653,'Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-11-30 13:55:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 13:55:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0fc132b-b30e-4554-8678-3f9b4612c2ee','Y',160,2)
;

-- 30-Nov-2021, 1:59:40 PM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2021-11-30 13:59:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214646
;

-- 30-Nov-2021, 1:59:53 PM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2021-11-30 13:59:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214645
;

-- 01-Dec-2021, 4:38:43 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.quantity',Updated=TO_TIMESTAMP('2021-12-01 16:38:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214653
;

-- 01-Dec-2021, 4:39:05 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.quantity',Updated=TO_TIMESTAMP('2021-12-01 16:39:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214652
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10584
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206813
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206812
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206811
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10583
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206815
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10581
;

-- 01-Dec-2021, 6:55:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206816
;

-- 01-Dec-2021, 6:55:54 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10578
;

-- 01-Dec-2021, 6:55:54 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10574
;

-- 01-Dec-2021, 6:55:54 PM IST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-01 18:55:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10576
;

-- 02-Dec-2021, 12:05:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-02 12:05:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10573
;

-- 02-Dec-2021, 12:05:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-12-02 12:05:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10575
;

SELECT register_migration_script('202111271100_CalloutMovementUOMConvesion.sql') FROM dual
;
