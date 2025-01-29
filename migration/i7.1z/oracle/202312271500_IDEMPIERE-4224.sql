SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4224  Decluttering configuration
-- Dec 27, 2023, 2:31:52 PM IST
INSERT INTO AD_Wlistbox_Customization (AD_Client_ID,AD_Org_ID,AD_Wlistbox_Customization_ID,WlistboxName,AD_User_ID,Created,CreatedBy,Custom,IsActive,Updated,UpdatedBy,AD_Wlistbox_Customization_UU) VALUES (0,0,200000,'AD_InfoPanel|AD_Element',100,TO_DATE('2023-12-27 14:31:52','YYYY-MM-DD HH24:MI:SS'),100,'AD_Element_ID=null,AD_Client_ID=null,AD_Org_ID=null,ColumnName=null,Name=null,PrintName=null,Description=null,Help=null,Placeholder=null,IsActive=null,EntityType=null,PO_Name=null,PO_PrintName=null,PO_Description=null,PO_Help=null','Y',TO_DATE('2023-12-27 14:31:52','YYYY-MM-DD HH24:MI:SS'),100,'8a63367f-1acf-4e6f-acbf-c364fab40cd4')
;

-- Dec 27, 2023, 2:32:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216309,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',560,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2023-12-27 14:32:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:32:10','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','852977a0-72a9-4bc5-8e2b-2d7542d97532','Y',0,'N','N','N','N','N')
;

-- Dec 27, 2023, 2:32:14 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeSet', FKConstraintType='N',Updated=TO_DATE('2023-12-27 14:32:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216309
;

-- Dec 27, 2023, 2:32:14 PM IST
ALTER TABLE M_AttributeSet ADD EntityType VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Dec 27, 2023, 2:32:14 PM IST
ALTER TABLE M_AttributeSet ADD CONSTRAINT EntityType_MAttributeSet FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:35:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208099,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',461,216309,'Y',40,230,'N','N','N','N',0,0,'Y',TO_DATE('2023-12-27 14:35:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:35:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6b299959-5f2b-4ae5-8d0e-2798fc8accc1','Y',220,2)
;

-- Dec 27, 2023, 2:36:08 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208099
;

-- Dec 27, 2023, 2:36:08 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12370
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12369
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6351
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8376
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6347
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12372
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12371
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6350
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8377
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6404
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201617
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10419
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204081
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204432
;

-- Dec 27, 2023, 2:36:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216310,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',563,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2023-12-27 14:36:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:36:50','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','bfdc9b7c-89ba-475a-9bf4-2fcc5185584a','Y',0,'N','N','N','N','N')
;

-- Dec 27, 2023, 2:36:52 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeUse', FKConstraintType='N',Updated=TO_DATE('2023-12-27 14:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216310
;

-- Dec 27, 2023, 2:36:52 PM IST
ALTER TABLE M_AttributeUse ADD EntityType VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Dec 27, 2023, 2:36:52 PM IST
ALTER TABLE M_AttributeUse ADD CONSTRAINT EntityType_MAttributeUse FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:37:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208100,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',467,216310,'Y',40,80,'N','N','N','N',0,0,'Y',TO_DATE('2023-12-27 14:37:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:37:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','585aef9d-37f1-4d2d-aaef-0edca5b13891','Y',80,2)
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208100
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6408
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6407
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6428
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207832
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202903
;

-- Dec 27, 2023, 2:38:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216311,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',562,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2023-12-27 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','6d07a1a8-67f5-48fa-90b0-ee9bdf62a308','Y',0,'N','N','N','N','N')
;

-- Dec 27, 2023, 2:38:22 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttribute', FKConstraintType='N',Updated=TO_DATE('2023-12-27 14:38:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216311
;

-- Dec 27, 2023, 2:38:22 PM IST
ALTER TABLE M_Attribute ADD EntityType VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Dec 27, 2023, 2:38:22 PM IST
ALTER TABLE M_Attribute ADD CONSTRAINT EntityType_MAttribute FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:39:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208101,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',462,216311,'Y',40,140,'N','N','N','N',0,0,'Y',TO_DATE('2023-12-27 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5eb26e5-805b-448c-bee6-a6eb6d4987d8','Y',140,2)
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208101
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6364
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6366
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10645
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6360
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204143
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203472
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207748
;

-- Dec 27, 2023, 3:09:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216312,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',558,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_DATE('2023-12-27 15:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 15:09:16','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','cd354f0b-2778-45e2-ae86-7908c397fb8d','Y',0,'N','N','N','N','N')
;

-- Dec 27, 2023, 3:09:21 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeValue', FKConstraintType='N',Updated=TO_DATE('2023-12-27 15:09:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216312
;

-- Dec 27, 2023, 3:09:21 PM IST
ALTER TABLE M_AttributeValue ADD EntityType VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Dec 27, 2023, 3:09:21 PM IST
ALTER TABLE M_AttributeValue ADD CONSTRAINT EntityType_MAttributeValue FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 3:09:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208102,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',463,216312,'Y',40,90,'N','N','N','N',0,0,'Y',TO_DATE('2023-12-27 15:09:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-12-27 15:09:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','549ffc5f-de53-4f8e-a0b2-24472dbe0908','Y',90,2)
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6370
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6367
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6371
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208102
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6374
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204871
;

-- Update existing record Entity Type
UPDATE M_AttributeSet SET EntityType = 'D' WHERE M_AttributeSet_ID < 1000000;

UPDATE M_AttributeUse SET EntityType = 'D' WHERE  M_AttributeSet_ID  < 1000000 AND M_Attribute_ID < 1000000;

UPDATE M_Attribute SET EntityType = 'D' WHERE M_Attribute_ID < 1000000;

UPDATE M_AttributeValue SET EntityType = 'D' WHERE M_AttributeValue_ID < 1000000;

SELECT register_migration_script('202312271500_IDEMPIERE-4224.sql') FROM dual
;