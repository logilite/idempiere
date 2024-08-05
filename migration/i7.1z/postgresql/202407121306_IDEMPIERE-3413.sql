-- NOT IN multiple selection field in info window

-- Jul 12, 2024, 2:52:03 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200711,'NOT IN',200061,'!IN',0,0,'Y',TO_TIMESTAMP('2024-07-12 14:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-12 14:52:02','YYYY-MM-DD HH24:MI:SS'),100,'D','a2c1d2c8-027f-45ed-a4d7-a4827b296d03')
;

-- Jul 12, 2024, 2:52:35 PM IST
UPDATE AD_Val_Rule SET Code='(( AD_Ref_List.Value IN (''='', ''!='', ''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ IN (200138, 200139)) OR ( AD_Ref_List.Value NOT IN (''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ NOT IN (200138, 200139)  AND ''@IsMultiSelectCriteria:N@''=''N'') OR( AD_Ref_List.Value IN (''!IN'',  ''<<<'') AND ''@IsMultiSelectCriteria:N@''=''Y''  ) ) AND  AD_Reference_ID=200061',Updated=TO_TIMESTAMP('2024-07-12 14:52:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200152
;

SELECT register_migration_script('202407121306_IDEMPIERE-3413.sql') FROM dual
;