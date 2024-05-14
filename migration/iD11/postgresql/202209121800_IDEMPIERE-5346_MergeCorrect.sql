-- IDEMPIERE-5346 SSO Support
-- Oct 18, 2022, 11:37:28 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Oct 18, 2022, 11:37:45 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Oct 18, 2022, 11:37:55 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Oct 18, 2022, 11:38:12 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Oct 18, 2022, 11:38:28 AM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-10-18 11:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Oct 19, 2022, 3:54:46 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationClientID','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:54:46 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationClientID',null,'NULL',null)
;

-- Oct 19, 2022, 3:54:58 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationLogoutURL','VARCHAR(1000)',null,'NULL')
;

-- Oct 19, 2022, 3:55:09 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationRedirectURIs','VARCHAR(1000)',null,'NULL')
;

-- Oct 19, 2022, 3:55:22 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationSecretKey','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:55:28 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_AuthorizationTenantID','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:55:28 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_AuthorizationTenantID',null,'NULL',null)
;

SELECT register_migration_script('202209121800_IDEMPIERE-5346_MergeCorrect.sql') FROM dual
;