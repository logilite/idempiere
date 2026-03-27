-- IDEMPIERE-6824  Stack overflow on login if user substitute exists and role has non master role as included role
SELECT register_migration_script('202602261445_IDEMPIERE-6824.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 26/02/2026 14:45:30 IST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','This role cannot be unmarked as a Master Role because it is currently included in the following roles: {0}.','All included role references must be removed before this role can be unmarked as Master.',0,0,'Y',TO_TIMESTAMP('2026-02-26 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-26 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,200991,'RoleHasIncludedRoles','D','4d5a0471-aed5-4e1b-8e35-18ae51e77a88')
;

