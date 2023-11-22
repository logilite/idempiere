-- IDEMPIERE-5858  Natural Opening as Period type on Report column set and report line
-- Oct 10, 2023, 1:42:06 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200658,'Natural Year opening','Natural type for year opening is for balance sheet account, it total till starting of finical year. and for P&L it 0',53327,'O',0,0,'Y',TO_TIMESTAMP('2023-10-10 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-10 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,'D','1ec4ebe1-1f1d-4b28-8799-6fba4299c6f6')
;

-- Oct 10, 2023, 2:32:11 PM IST
UPDATE AD_Field SET DisplayLogic='@ColumnType@=R | @ColumnType@=S & @PAPeriodType@!O', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-10-10 14:32:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206213
;

SELECT register_migration_script('202310101430_IDEMPIERE-5858.sql') FROM dual
;