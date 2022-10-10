-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209021444_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 2, 2022, 2:44:49 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215126,0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',101,'AD_InfoWindow_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-02 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-02 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,3068,'Y','N','D','N','N','N','Y','a9fef67a-55cf-4a57-ab3a-95457cc3c294','Y',0,'N','N','C','N')
;

-- Sep 2, 2022, 2:45:04 PM SGT
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADColumn', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-09-02 14:45:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 2:45:04 PM SGT
ALTER TABLE AD_Column ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 2, 2022, 2:45:04 PM SGT
ALTER TABLE AD_Column ADD CONSTRAINT ADInfoWindow_ADColumn FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 2, 2022, 2:45:43 PM SGT
UPDATE AD_Column SET FKConstraintType='S',Updated=TO_TIMESTAMP('2022-09-02 14:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column MODIFY AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column DROP CONSTRAINT adinfowindow_adcolumn
;

-- Sep 2, 2022, 2:45:54 PM SGT
ALTER TABLE AD_Column ADD CONSTRAINT ADInfoWindow_ADColumn FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- Sep 2, 2022, 2:47:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207143,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',101,215126,'Y',10,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-02 14:47:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-02 14:47:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','95af860d-1e82-40f6-86b4-520922a86814','Y',470,2)
;

-- Sep 2, 2022, 2:51:22 PM SGT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=28', SeqNo=225, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=175, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-02 14:51:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207143
;

-- Sep 2, 2022, 3:59:35 PM SGT
UPDATE AD_Column SET ReadOnlyLogic='@AD_InfoWindow_ID@!0',Updated=TO_TIMESTAMP('2022-09-02 15:59:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3369
;

-- Sep 2, 2022, 3:59:55 PM SGT
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Column.process',Updated=TO_TIMESTAMP('2022-09-02 15:59:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3369
;

-- Sep 2, 2022, 4:00:53 PM SGT
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Column.infoWindow', ReadOnlyLogic='@AD_Process_ID@!0',Updated=TO_TIMESTAMP('2022-09-02 16:00:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215126
;

-- Sep 2, 2022, 4:19:00 PM SGT
UPDATE AD_Column SET AD_InfoWindow_ID=200022,Updated=TO_TIMESTAMP('2022-09-02 16:19:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215125
;

-- Sep 2, 2022, 4:45:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217521,'bed9be3a-11bc-4712-9b76-7f6e8ec06abc',TO_TIMESTAMP('2022-09-02 16:45:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-02 16:45:03','YYYY-MM-DD HH24:MI:SS'),100,200008,'AD_InfoWindow_ID','t.ad_infowindow_id',710)
;

-- Sep 2, 2022, 4:47:12 PM SGT
UPDATE AD_ViewColumn SET ColumnSQL='c.ad_infowindow_id',Updated=TO_TIMESTAMP('2022-09-02 16:47:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217521
;

-- Sep 2, 2022, 5:15:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217522,'d7b9bf59-e48c-42dc-a8ff-2a26b514b076',TO_TIMESTAMP('2022-09-02 17:15:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-02 17:15:35','YYYY-MM-DD HH24:MI:SS'),100,200009,'AD_InfoWindow_ID','c.ad_infowindow_id',720)
;


