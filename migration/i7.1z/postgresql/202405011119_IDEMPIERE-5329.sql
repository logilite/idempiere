-- Adding C_DepositBatch_ID column on c_payment_v
-- Apr 30, 2024, 4:42:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216591,0.0,'Deposit Batch',554,'C_DepositBatch_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-04-30 16:42:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-30 16:42:57','YYYY-MM-DD HH24:MI:SS'),100,202195,'N','N','D','Y','N','N','Y','d7bec526-2235-40f0-90f0-306876842ca4','Y','N','N','N','N','N')
;

SELECT register_migration_script('202405011119_IDEMPIERE-5329.sql') FROM dual
;
