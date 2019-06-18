-- IDEMPIERE-460 Adding 'WebService Type Access'  tab in 'Role' window
-- May 6, 2019 3:31:17 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200267,'WebService Type Access',111,110,'Y',53168,0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','U','Y','N','372abef3-2446-45e9-8adc-bb86531a7d80','B')
;

-- May 6, 2019 3:31:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206066,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200267,56766,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','88fd75fe-6d83-465c-aab8-c6f40965b4e3','Y',20,2)
;

-- May 6, 2019 3:31:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206067,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200267,56767,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','0d9591c6-ee02-4a48-ae34-6217f8044564','Y','N',4,2)
;

-- May 6, 2019 3:31:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206068,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200267,56768,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','aa8f3b48-1205-45ff-9fda-bdce9b04d352','Y',30,2)
;

-- May 6, 2019 3:31:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206069,'Web Service Type',200267,56769,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','54fece74-886d-4a04-b7b0-54a4af8afb91','Y',40,2)
;

-- May 6, 2019 3:31:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206070,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200267,56773,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','d6badc74-50a3-40f7-8065-e26b330a8265','Y',50,2,2)
;

-- May 6, 2019 3:31:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206071,'WS_WebServiceTypeAccess_UU',200267,202050,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','862d8138-8059-4a78-833f-82e61a0b9396','N',2)
;

-- May 6, 2019 3:31:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206072,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200267,56772,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','dae32259-5df8-4132-aa09-434428d2484b','Y',60,2,2)
;

-- May 6, 2019 3:31:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206065,'Valid For Same Client','This flag is to determine that given role can access this web service from single IP or multiple IP address',200267,212970,'Y',1,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-06 15:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-06 15:31:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','c1ad01e8-e596-4062-8e01-ac2ebcd15749','Y',10,2,2)
;

SELECT register_migration_script('201905061532_IDEMPIERE-460.sql') FROM dual
;
