SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add Attendees Tab In Business Partner > Activity
-- Dec 4, 2019 6:47:06 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200198,'Attendees',123,150,'Y',200182,0,0,'Y',TO_DATE('2019-12-04 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',212328,'N','N',2,'N','D','Y','N','e39d4a47-c8d0-4260-8f6e-0c19efdc1f6e','B')
;

-- Dec 4, 2019 6:47:06 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203937,'C_ContactActivity_Attendees_ID',200198,212327,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5dc81af3-37ad-4c03-b76b-b241ef1ca021','N',1,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:47:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203935,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200198,212320,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9a88c5e9-00b7-4b5f-82e0-2f1801dfe1d5','N',1,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:47:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203936,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200198,212321,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1eba3b64-5e22-4344-acd1-abacd9da2dcd','Y','Y',10,4,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:47:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203938,'Contact Activity','Events, tasks, communications related to a contact',200198,212328,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:07','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','e96d295a-db66-4621-9ff9-37c8bd78cf77','Y',20,1,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:47:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203939,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200198,212329,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cf529ec2-91a0-4c77-863c-00bda961f86c','Y',30,1,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:47:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (203940,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
		There are two reasons for de-activating and not deleting records:
		(1) The system requires the record for audit purposes.
		(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200198,212326,'Y',1,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-12-04 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:47:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba915a52-00ad-43c8-9527-69e0e41436e1','Y',40,2,2,1,'N','N','N','N')
;

-- Dec 4, 2019 6:05:17 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203391,0,0,'Y',TO_DATE('2019-12-04 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-04 18:05:16','YYYY-MM-DD HH24:MI:SS'),100,'C_ContactActivity_Attendees_UU','C_ContactActivity_Attendees_UU','C_ContactActivity_Attendees_UU','D','2c562742-53aa-4781-bba0-b91bfae2639e')
;

-- Dec 4, 2019 6:06:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214128,0,'C_ContactActivity_Attendees_UU',200182,'C_ContactActivity_Attendees_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2019-12-06 18:01:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-12-06 18:01:24','YYYY-MM-DD HH24:MI:SS'),100,203391,'Y','N','D','N','N','N','Y','75130958-6259-4135-8fa5-5471fbffed23','N',0,'N','N')
;

-- Dec 4, 2019 6:06:14 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD C_ContactActivity_Attendees_UU VARCHAR2(36) DEFAULT NULL 
;

-- Dec 4, 2019 6:06:15 PM IST
ALTER TABLE C_ContactActivity_Attendees ADD CONSTRAINT C_ContactActivity_Attendeuuidx UNIQUE (C_ContactActivity_Attendees_UU)
;

SELECT register_migration_script('201912041800_IDEMPIERE-2870.sql') FROM dual
;

