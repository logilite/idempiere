-- IDEMPIERE-2999 Migrate code from Master to Logilite-7.1
-- Sep 18, 2020, 10:02:10 PM IST
UPDATE AD_Tab SET ReadOnlyLogic='@AttributeValueType@!L',Updated=TO_TIMESTAMP('2020-09-18 22:02:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=463
;

-- Sep 21, 2020, 3:02:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214317,0,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',562,'AD_Val_Rule_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2020-09-21 15:02:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-21 15:02:00','YYYY-MM-DD HH24:MI:SS'),100,139,'Y','N','D','N','N','N','Y','6e0bea95-2518-4833-b8c4-3c65f94b07ea','Y',0,'N','N','N','N')
;

-- Sep 21, 2020, 3:02:14 PM IST
UPDATE AD_Column SET FKConstraintName='ADValRule_MAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2020-09-21 15:02:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214317
;

-- Sep 21, 2020, 3:02:14 PM IST
ALTER TABLE M_Attribute ADD COLUMN AD_Val_Rule_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 21, 2020, 3:02:14 PM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADValRule_MAttribute FOREIGN KEY (AD_Val_Rule_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 21, 2020, 3:04:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206510,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',462,214317,'Y','@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 & @AttributeValueType@=''R''',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-21 15:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-21 15:04:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','544966ca-d50d-4481-ae43-cc56b1a0c478','Y',120,4,2,1,'N','N','N')
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Sep 21, 2020, 3:04:50 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-21 15:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204868
;

-- Sep 21, 2020, 3:09:42 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-21 15:09:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Sep 21, 2020, 3:09:42 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-21 15:09:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203472
;

--
-- Migrate data to actual column
--
UPDATE M_AttributeInstance 	SET ValueDate = ValueTimestamp	WHERE ValueTimestamp IS NOT NULL
;

UPDATE M_AttributeInstance 	SET ValueNumber = ValueInt	WHERE ValueInt IS NOT NULL
;

-- IDEMPIERE-2999 Delete ValueInt and ValueTimestamp Column from M_AttributeInstance
-- Dec 12, 2020, 5:51:17 PM IST
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=212645
;

-- Dec 12, 2020, 5:51:17 PM IST
DELETE FROM AD_Column WHERE AD_Column_ID=212645
;

-- Dec 12, 2020, 5:51:48 PM IST
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=212646
;

-- Dec 12, 2020, 5:51:48 PM IST
DELETE FROM AD_Column WHERE AD_Column_ID=212646
;

SELECT register_migration_script('202012121200_IDEMPIERE-2999_Migrate.sql') FROM dual
;