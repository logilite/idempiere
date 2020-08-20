SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Oct 29, 2015 3:20:16 PM IST
UPDATE AD_Column SET IsKey='Y', IsMandatory='Y', IsUpdateable='N', IsAllowCopy='N',Updated=TO_DATE('2015-10-29 15:20:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212255
;

-- Oct 29, 2015 3:20:58 PM IST
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,Name,AD_ZoomCondition_UU,entitytype) VALUES (0,0,200178,123,200007,TO_DATE('2015-10-29 15:20:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2015-10-29 15:20:57','YYYY-MM-DD HH24:MI:SS'),100,10,'Contact Activity','7c9fd5a8-18c5-4e42-9a55-e5179e35b37c','D')
;



SELECT register_migration_script('201510291630_IDEMPIERE-2870.sql') FROM dual
;
