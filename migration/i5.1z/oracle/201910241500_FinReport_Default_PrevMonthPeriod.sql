SET SQLBLANKLINES ON
SET DEFINE OFF

-- Default Period configuration in FinReport process dialog
-- Oct 24, 2019 12:38:25 PM IST
UPDATE AD_Process_Para SET DefaultValue='@SQL=(SELECT p.C_Period_ID AS DefaultValue FROM C_Period p JOIN C_Year y ON y.C_Year_ID=p.C_Year_ID WHERE p.StartDate <= now() - interval ''1 month'' AND p.EndDate >= now() - interval ''1 month'' AND y.C_Calendar_ID=@C_Calendar_ID@)',Updated=TO_DATE('2019-10-24 12:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=280
;

SELECT register_migration_script('201910241500_FinReport_Default_PrevMonthPeriod.sql') FROM dual
;
