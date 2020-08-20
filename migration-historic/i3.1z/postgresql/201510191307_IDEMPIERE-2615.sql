-- IDEMPIERE-2615 Date Material Policy not respected in movement
-- Sep 18, 2015 6:31:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212226,0,'Attribute Set Instance To','Target Product Attribute Set Instance',764,'M_AttributeSetInstanceTo_ID',10,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2015-09-18 18:31:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-18 18:31:20','YYYY-MM-DD HH24:MI:SS'),100,2799,'N','N','D','N','N','N','Y','e81ba297-f489-4a2b-abc5-92095052a674','Y',0,'N','N')
;

-- Sep 18, 2015 6:31:27 PM IST
--UPDATE AD_Column SET FKConstraintName='MAttributeSetInstanceTo_MMovem', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-09-18 18:31:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212226
--;

-- Sep 18, 2015 6:31:27 PM IST
ALTER TABLE M_MovementLineMA ADD COLUMN M_AttributeSetInstanceTo_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 18, 2015 6:31:28 PM IST
ALTER TABLE M_MovementLineMA ADD CONSTRAINT MAttributeSetInstanceTo_MMovem FOREIGN KEY (M_AttributeSetInstanceTo_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 18, 2015 6:32:44 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (202898,0,0,'Y',TO_TIMESTAMP('2015-09-18 18:32:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-18 18:32:44','YYYY-MM-DD HH24:MI:SS'),100,'DateMaterialPolicyTo','Date  Material Policy To','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy To','D','59cdc657-9c66-43a6-842a-0334c6278da8')
;

-- Sep 18, 2015 6:32:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212227,0,'Date  Material Policy To','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy',764,'DateMaterialPolicyTo',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2015-09-18 18:32:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-18 18:32:56','YYYY-MM-DD HH24:MI:SS'),100,202898,'N','N','D','N','N','N','Y','8f01c1b1-8e93-4377-b8f7-d0817eaff690','Y',0,'N','N','N')
;

-- Sep 18, 2015 6:34:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203866,'Attribute Set Instance To','Target Product Attribute Set Instance',750,212226,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-09-18 18:34:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-18 18:34:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf7a95f9-d23d-4a0b-8b51-c6dcc2eb6373','Y',60,2)
;

-- Sep 18, 2015 6:34:28 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203867,'Date  Material Policy To','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy',750,212227,'Y',7,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-09-18 18:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-09-18 18:34:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','48c0904f-1a85-4a9b-a209-269f4605e542','Y',70,2)
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12191
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12188
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203866
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202288
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203867
;

-- Sep 18, 2015 6:36:03 PM IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2015-09-18 18:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202881
;

-- Oct 14, 2015 5:26:24 PM IST
ALTER TABLE M_MovementLineMA ADD COLUMN DateMaterialPolicyTo TIMESTAMP DEFAULT NULL 
;

-- Oct 14, 2015 5:26:41 PM IST
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2015-10-14 17:26:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210651
;

-- Oct 14, 2015 5:26:46 PM IST
INSERT INTO t_alter_column values('m_movementlinema','DateMaterialPolicy','TIMESTAMP',null,null)
;

SELECT register_migration_script('201510191307_IDEMPIERE-2615.sql') FROM dual
;


