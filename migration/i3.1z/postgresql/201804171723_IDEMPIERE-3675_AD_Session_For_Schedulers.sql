-- IDEMPIERE-3675  Creating AD_Session for scheduler
-- 12-Apr-2018 19:09:15 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213397,0,'Session','User Session Online or Web','Online or Web Session Information',688,'AD_Session_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2018-04-12 19:09:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-04-12 19:09:14','YYYY-MM-DD HH24:MI:SS'),100,2029,'N','N','U','N','N','N','Y','019b1c99-ef8e-4bef-838c-4efc11b52736','Y',0,'N','N','N')
;

-- 12-Apr-2018 19:09:39 IST
UPDATE AD_Column SET AD_Reference_ID=30, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213397
;

-- 12-Apr-2018 19:09:50 IST
UPDATE AD_Column SET FKConstraintName='ADSession_ADScheduler', FKConstraintType='N',Updated=TO_TIMESTAMP('2018-04-12 19:09:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213397
;

-- 12-Apr-2018 19:09:50 IST
ALTER TABLE AD_Scheduler ADD COLUMN AD_Session_ID NUMERIC(10) DEFAULT NULL 
;

-- 12-Apr-2018 19:09:50 IST
ALTER TABLE AD_Scheduler ADD CONSTRAINT ADSession_ADScheduler FOREIGN KEY (AD_Session_ID) REFERENCES ad_session(ad_session_id) DEFERRABLE INITIALLY DEFERRED
;

-- 12-Apr-2018 19:10:33 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205355,'Session','User Session Online or Web','Online or Web Session Information',589,213397,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-04-12 19:10:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-04-12 19:10:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','054cdf9b-242b-4dd1-8f2c-5592ca52647d','Y',160,2)
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205355
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9432
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9442
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9443
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9438
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60991
;

-- 12-Apr-2018 19:11:04 IST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-12 19:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60992
;

SELECT register_migration_script('201804171723_IDEMPIERE-3675_AD_Session_For_Schedulers.sql') FROM dual
;