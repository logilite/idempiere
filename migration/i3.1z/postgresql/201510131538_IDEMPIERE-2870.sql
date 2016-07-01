-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 6, 2015 6:41:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212254,0,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',53354,'C_BPartner_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2015-10-06 18:41:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:41:42','YYYY-MM-DD HH24:MI:SS'),100,187,'Y','N','D','N','N','N','Y','7bca4d9e-a8fe-4e0a-8f44-33b1cf593693','Y',0,'N','N')
;

-- Oct 6, 2015 6:42:09 PM IST
UPDATE AD_Column SET FKConstraintName='CBPartner_CContactActivity', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-10-06 18:42:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212254
;

-- Oct 6, 2015 6:42:09 PM IST
ALTER TABLE C_ContactActivity ADD COLUMN C_BPartner_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 6, 2015 6:42:09 PM IST
ALTER TABLE C_ContactActivity ADD CONSTRAINT CBPartner_CContactActivity FOREIGN KEY (C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 6, 2015 6:43:16 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203875,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',53454,212254,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:43:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:43:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1382f530-e3b0-4ed8-b47e-0ac3f636cfbe','Y',120,1,1,1,'N','N','N')
;

-- Oct 6, 2015 6:44:34 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2015-10-06 18:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203875
;

-- Oct 6, 2015 6:44:34 PM IST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2015-10-06 18:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62690
;

-- Oct 6, 2015 6:44:34 PM IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2015-10-06 18:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62691
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62692
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62693
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62694
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62695
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62696
;

-- Oct 6, 2015 6:44:35 PM IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2015-10-06 18:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62697
;

-- Oct 6, 2015 6:45:59 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200193,'Activity',123,140,'Y',53354,0,0,'Y',TO_TIMESTAMP('2015-10-06 18:45:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:45:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','5b0f4a1b-4627-48a4-95a5-a4dcddb047a9','B')
;

-- Oct 6, 2015 6:46:16 PM IST
UPDATE AD_Tab SET Description='Contact Activity',Updated=TO_TIMESTAMP('2015-10-06 18:46:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200193
;



-- Oct 6, 2015 6:47:03 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203876,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200193,62455,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6b2ee7d8-a65b-4c49-912f-8c88d4a5af88','N',2)
;

-- Oct 6, 2015 6:47:03 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203877,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200193,62456,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2cd5a143-a462-4767-9231-077d77e20951','Y','Y',10,4,2)
;

-- Oct 6, 2015 6:47:04 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203878,'Description','Optional short description of the record','A description is limited to 255 characters.',200193,62460,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','168579b9-8e36-4253-8d8e-4eaf77baeb32','Y',20,5)
;

-- Oct 6, 2015 6:47:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203879,'Contact Activity','Events, tasks, communications related to a contact',200193,62457,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6bb4714c-02e7-4691-a3cc-4de2d1e9bf5b','N',2)
;

-- Oct 6, 2015 6:47:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203880,'Start Date','First effective day (inclusive)','The Start Date indicates the first or starting date',200193,62464,'Y',7,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d0da7a1f-ee3e-4aa6-a014-42de7aac7a00','Y',30,2)
;

-- Oct 6, 2015 6:47:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203881,'End Date','Last effective date (inclusive)','The End Date indicates the last date in this range.',200193,62465,'Y',7,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','24c52856-366f-49c4-b751-c8ad985eedb8','Y',40,2)
;

-- Oct 6, 2015 6:47:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (203882,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200193,62466,'Y',999999,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ef785808-0544-40cf-9ed4-43cc9360698a','Y',50,5,3)
;

-- Oct 6, 2015 6:47:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203883,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200193,62467,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4819e5c-14f2-4feb-9113-61c6f59c2218','Y',60,2)
;

-- Oct 6, 2015 6:47:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203884,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200193,62468,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bd8981da-4423-48ae-8c1a-8cb91d82e589','Y',70,2)
;

-- Oct 6, 2015 6:47:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203885,'Activity Type','Type of activity, e.g. task, email, phone call',200193,62469,'Y',10,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2fde921a-640c-406c-ae74-ab8f786e2a4e','Y',80,2)
;

-- Oct 6, 2015 6:47:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203886,'Complete','It is complete','Indication that this is complete',200193,62470,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f694fad-a52e-4c9e-98c9-a068a8517938','Y',90,2,2)
;

-- Oct 6, 2015 6:47:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203887,'Sales Opportunity',200193,62471,'Y',10,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e202a345-ad4d-4611-a200-f0e01148976d','Y',100,2)
;

-- Oct 6, 2015 6:47:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203888,'C_ContactActivity_UU',200193,210846,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5cc134c1-704d-498b-a2f1-466e280483e9','N',2)
;

-- Oct 6, 2015 6:47:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203889,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200193,212251,'Y','@$Element_PJ@=Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d993fa0b-3c52-4fe3-81a5-b659467add42','Y',110,2)
;

-- Oct 6, 2015 6:47:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203890,'Related To',200193,212252,'Y',2,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c519678b-1d70-4b30-b5e8-b8ddddb5d58c','Y',120,2)
;

-- Oct 6, 2015 6:47:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203891,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200193,212254,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d26a88fb-adbb-4d7e-968c-e6439eb693ec','Y',130,2)
;

-- Oct 6, 2015 6:47:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203892,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200193,62461,'Y',1,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-06 18:47:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-06 18:47:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5320784d-240f-493d-aad6-f4b548286251','Y',140,2,2)
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=203892
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=203890
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=203889
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=203884
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=203891
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=203885
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=203878
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=203887
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=203886
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=203880
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=203881
;

-- Oct 6, 2015 6:49:03 PM IST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=203882
;

UPDATE AD_Tab SET AD_Column_ID=212254, Parent_Column_ID=2893,Updated=TO_TIMESTAMP('2015-10-07 14:53:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200193
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=203891
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=203885
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=203878
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=203883
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=203887
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=203886
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=203880
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=203881
;

-- Oct 7, 2015 2:53:56 PM IST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=203882
;

-- Oct 7, 2015 2:54:56 PM IST
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2015-10-07 14:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203878
;


INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200315,'Business Partner',200107,'BP',0,0,'Y',TO_TIMESTAMP('2015-10-07 12:03:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-07 12:03:37','YYYY-MM-DD HH24:MI:SS'),100,'D','cd7a2dee-912e-4403-9be8-85ff96a80f45')
;

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=203891
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=203884
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=203885
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=203878
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=203883
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=203887
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=203886
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=203880
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=203881
;

-- Oct 7, 2015 3:29:41 PM IST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=203882
;

-- Oct 7, 2015 3:29:54 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2015-10-07 15:29:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203891
;


-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 8, 2015 5:10:18 PM IST

CREATE OR REPLACE VIEW C_ContactActivity_v AS
SELECT c.c_contactactivity_id, c.ad_client_id, c.ad_org_id, c.created, c.createdby, 
       c.description, c.isactive, c.updated, c.updatedby, c.startdate, c.enddate, 
       c.comments, c.salesrep_id, c.ad_user_id, c.contactactivitytype, c.iscomplete, 
       c.c_opportunity_id, c.c_contactactivity_uu, c.c_project_id, c.c_contactactivityrelatedto, 
       COALESCE(c.c_bpartner_id,a.c_bpartner_id)AS c_bpartner_id
  FROM c_contactactivity c
LEFT JOIN ad_user a ON c.ad_user_id=a.ad_user_id order by c.created  desc 
;

INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200178,'C_ContactActivity_v','C_ContactActivity_v',0,'3',0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','N','L','N','Y','372eb0e4-b747-459e-b7ca-922c03a260ce','N','N')
;

-- Oct 8, 2015 5:10:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212255,0.0,'Contact Activity','Events, tasks, communications related to a contact',200178,'C_ContactActivity_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:26','YYYY-MM-DD HH24:MI:SS'),100,55353,'N','N','D','N','fa8f1c85-95a3-4c34-b7ec-4e42f25a9799','N')
;

-- Oct 8, 2015 5:10:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212256,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200178,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:27','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','a4a5c03d-8851-4226-97fc-5c018384afba','N')
;

-- Oct 8, 2015 5:10:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212257,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200178,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:28','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','c5deb776-1770-4921-9293-e7f462de6423','N')
;

-- Oct 8, 2015 5:10:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212258,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200178,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','18cae31c-ca47-4c5d-a15a-5d1d9887769b','N')
;

-- Oct 8, 2015 5:10:30 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212259,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200178,'CreatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:29','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','b43c4d3a-8e3b-41e6-9570-2490edc260a7','N')
;

-- Oct 8, 2015 5:10:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212260,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200178,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:30','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','de2987d5-5c3a-403d-8c26-b2b1fb751260','N')
;

-- Oct 8, 2015 5:10:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212261,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200178,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:31','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','cca73ada-d821-4f8d-afeb-af975ae764a9','N')
;

-- Oct 8, 2015 5:10:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212262,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200178,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:31','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','76937694-5fd0-45bb-a9ed-d57feebc0f98','N')
;

-- Oct 8, 2015 5:10:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212263,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200178,'UpdatedBy',10,'N','N','N','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:32','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','f71e0d44-99af-461a-89a5-07f1a34c944b','N')
;

-- Oct 8, 2015 5:10:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212264,0.0,'Start Date','First effective day (inclusive)','The Start Date indicates the first or starting date',200178,'StartDate',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:33','YYYY-MM-DD HH24:MI:SS'),100,574,'N','N','D','N','5109df2b-5b5b-491d-8a17-2d5a833b0833','N')
;

-- Oct 8, 2015 5:10:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212265,0.0,'End Date','Last effective date (inclusive)','The End Date indicates the last date in this range.',200178,'EndDate',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:34','YYYY-MM-DD HH24:MI:SS'),100,294,'N','N','D','N','ea6c3c3a-e8fd-455f-b723-549184e7d282','N')
;

-- Oct 8, 2015 5:10:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212266,0.0,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200178,'Comments',2147483647,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:34','YYYY-MM-DD HH24:MI:SS'),100,230,'N','N','D','N','97b793d5-8e2f-4b9d-9ff4-e39cf32b8006','N')
;

-- Oct 8, 2015 5:10:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212267,0.0,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200178,'SalesRep_ID',10,'N','N','N','N','N','N',18,190,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:35','YYYY-MM-DD HH24:MI:SS'),100,1063,'N','N','D','N','13a48e63-191b-4fc5-9e72-a1f680f99206','N')
;

-- Oct 8, 2015 5:10:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212268,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200178,'AD_User_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:36','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','f5ee750b-3fdf-444f-b404-9c032eddf283','N')
;

-- Oct 8, 2015 5:10:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212269,0.0,'Activity Type','Type of activity, e.g. task, email, phone call',200178,'ContactActivityType',10,'N','N','N','N','N','N',17,53423,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:36','YYYY-MM-DD HH24:MI:SS'),100,55354,'N','N','D','N','cee296fb-3d1f-4558-8ed1-47535b7165d9','N')
;

-- Oct 8, 2015 5:10:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212270,0.0,'Complete','It is complete','Indication that this is complete',200178,'IsComplete',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:37','YYYY-MM-DD HH24:MI:SS'),100,2047,'N','N','D','N','dd4f45eb-3dc1-41f4-b8c3-b187bd8407f5','N')
;

-- Oct 8, 2015 5:10:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212271,0.0,'Sales Opportunity',200178,'C_Opportunity_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:38','YYYY-MM-DD HH24:MI:SS'),100,55286,'N','N','D','N','f055d02a-9e3b-4e29-b557-bec380c171dc','N')
;

-- Oct 8, 2015 5:10:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212272,0.0,'C_ContactActivity_UU',200178,'C_ContactActivity_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:38','YYYY-MM-DD HH24:MI:SS'),100,202605,'N','N','D','N','7e817426-841c-4d0f-986e-8c301e0e9512','N')
;

-- Oct 8, 2015 5:10:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212273,0.0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200178,'C_Project_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:39','YYYY-MM-DD HH24:MI:SS'),100,208,'N','N','D','N','75334184-d338-4f24-9fee-c28d692bf17a','N','N')
;

-- Oct 8, 2015 5:10:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212274,0.0,'Related To',200178,'C_ContactActivityRelatedTo',2,'N','N','N','N','N','N',17,200107,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:40','YYYY-MM-DD HH24:MI:SS'),100,202906,'N','N','D','N','6d3aaded-eb68-4d4b-b514-e029a8ece06e','N','N')
;

-- Oct 8, 2015 5:10:44 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212275,0.0,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200178,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2015-10-08 17:10:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 17:10:43','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','7d08fc22-1132-4d58-a337-7144fb290aa3','N')
;

-- Oct 8, 2015 5:11:41 PM IST
UPDATE AD_Tab SET AD_Table_ID=200178, AD_Column_ID=212275,Updated=TO_TIMESTAMP('2015-10-08 17:11:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200193
;


SELECT register_migration_script('201510131538_IDEMPIERE-2870') FROM dual
;

