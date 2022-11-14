-- IDEMPIERE-5346 SSO Support
-- Nov 4, 2022, 4:29:25 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203725,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:29:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:29:24','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationDomain','Application Domain','SSO Application Domain','Application Domain','D','e5ed0a02-4eaf-4713-9107-ccc79f1e0cb1')
;

-- Nov 4, 2022, 4:30:18 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203727,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:30:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:30:18','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationDiscoveryURI','Application Discovery URI','SSO Application Discovery URI','Application Discovery URI','D','999d76d2-1744-457d-bac9-3134f750874f')
;

-- Nov 4, 2022, 4:30:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215637,0,'Application Discovery URI','SSO Application Discovery URI',200360,'SSO_ApplicationDiscoveryURI',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:30:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:30:44','YYYY-MM-DD HH24:MI:SS'),100,203727,'Y','N','D','N','Y','N','Y','f806a488-6dfc-4fee-aa15-9794aa9eafe0','Y',0,'N','N','N','N')
;

-- Nov 4, 2022, 4:30:46 PM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN SSO_ApplicationDiscoveryURI VARCHAR(4000) DEFAULT NULL 
;

-- Nov 4, 2022, 4:31:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215638,0,'Application Domain','SSO Application Domain',200360,'SSO_ApplicationDomain',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:06','YYYY-MM-DD HH24:MI:SS'),100,203725,'Y','N','D','N','Y','N','Y','2dbe8818-b3c5-470d-885f-7d5cb2eb0c50','Y',0,'N','N','N','N')
;

-- Nov 4, 2022, 4:31:07 PM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN SSO_ApplicationDomain VARCHAR(4000) DEFAULT NULL 
;

-- Nov 4, 2022, 4:31:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207414,'Application Discovery URI','SSO Application Discovery URI',200328,215637,'Y',4000,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','24573116-ea2f-4cc2-86d5-19abee762b99','Y',110,5)
;

-- Nov 4, 2022, 4:31:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207415,'Application Domain','SSO Application Domain',200328,215638,'Y',4000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3b760acd-467f-42ad-9d9c-2bc1887185b8','Y',120,5)
;

-- Nov 4, 2022, 4:31:38 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-04 16:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207415
;

-- Nov 4, 2022, 4:31:38 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-04 16:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Nov 7, 2022, 4:32:56 PM IST
UPDATE AD_Column SET Help='A directory of the OIDC architecture of your user pool.',Updated=TO_TIMESTAMP('2022-11-07 16:32:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215637
;

-- Nov 7, 2022, 4:37:19 PM IST
UPDATE AD_Column SET Help='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.',Updated=TO_TIMESTAMP('2022-11-07 16:37:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215638
;

-- Nov 7, 2022, 4:43:08 PM IST
UPDATE AD_Column SET Help='SSO provider unique app client id',Updated=TO_TIMESTAMP('2022-11-07 16:43:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Nov 7, 2022, 4:45:25 PM IST
UPDATE AD_Column SET Help='SSO provider client secret key to access this user info',Updated=TO_TIMESTAMP('2022-11-07 16:45:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Nov 7, 2022, 4:57:57 PM IST
UPDATE AD_Column SET Help='SSO provider Tenant ID is a globally unique identifier (GUID)',Updated=TO_TIMESTAMP('2022-11-07 16:57:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Nov 7, 2022, 4:58:39 PM IST
UPDATE AD_Column SET Description='SSO provider Tenant ID is a globally unique identifier (GUID)',Updated=TO_TIMESTAMP('2022-11-07 16:58:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Nov 7, 2022, 4:59:04 PM IST
UPDATE AD_Column SET Description='SSO provider unique app client id',Updated=TO_TIMESTAMP('2022-11-07 16:59:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Nov 7, 2022, 4:59:12 PM IST
UPDATE AD_Column SET Description='A directory of the OIDC architecture of your user pool.',Updated=TO_TIMESTAMP('2022-11-07 16:59:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215637
;

-- Nov 7, 2022, 4:59:22 PM IST
UPDATE AD_Column SET Description='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.',Updated=TO_TIMESTAMP('2022-11-07 16:59:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215638
;

-- Nov 7, 2022, 4:59:29 PM IST
UPDATE AD_Column SET Description='This is where SSO provider sends a request to have the application clear the user''s session data',Updated=TO_TIMESTAMP('2022-11-07 16:59:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215301
;

-- Nov 7, 2022, 4:59:36 PM IST
UPDATE AD_Column SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.',Updated=TO_TIMESTAMP('2022-11-07 16:59:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Nov 7, 2022, 4:59:40 PM IST
UPDATE AD_Column SET Description='SSO provider client secret key to access this user info',Updated=TO_TIMESTAMP('2022-11-07 16:59:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Nov 8, 2022, 3:50:10 PM IST
UPDATE AD_Field SET Description='SSO provider unique app client id', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207197
;

-- Nov 8, 2022, 3:50:29 PM IST
UPDATE AD_Field SET Description='A directory of the OIDC architecture of your user pool.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207414
;

-- Nov 8, 2022, 3:50:41 PM IST
UPDATE AD_Field SET Description='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207415
;

-- Nov 8, 2022, 3:51:17 PM IST
UPDATE AD_Field SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

-- Nov 8, 2022, 3:51:30 PM IST
UPDATE AD_Field SET Description='SSO provider client secret key to access this user info', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207201
;

-- Nov 8, 2022, 3:51:44 PM IST
UPDATE AD_Field SET Description='SSO provider Tenant ID is a globally unique identifier (GUID)', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207196
;

-- Nov 8, 2022, 4:06:57 PM IST
UPDATE AD_Column SET Help='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.',Updated=TO_TIMESTAMP('2022-11-08 16:06:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Nov 8, 2022, 4:07:07 PM IST
UPDATE AD_Field SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 16:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

SELECT register_migration_script('202211041830_IDEMPIERE-5346.sql') FROM dual
;

