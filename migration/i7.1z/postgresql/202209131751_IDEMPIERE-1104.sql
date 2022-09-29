-- Bank statement posting with line date, allow same year.
-- 13-Sep-2022, 5:37:48 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200206,0,0,TO_TIMESTAMP('2022-09-13 17:37:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-09-13 17:37:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','BANK_STATEMENT_POST_WITH_LINE_DATE_YEARLY','N','When post with line on bank statement enabled, Considering header and line should have same year instead of same period. ','D','C','8c5631f4-6d38-403b-9a51-6053f0d5887f')
;

SELECT register_migration_script('202209131751_IDEMPIERE-1104.sql') FROM dual
;