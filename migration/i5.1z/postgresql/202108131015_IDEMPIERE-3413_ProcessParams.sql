-- Support for multiselect record in process param.
-- Aug 13, 2021 7:25:27 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203531,0,0,'Y',TO_TIMESTAMP('2021-08-13 19:25:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:25:26','YYYY-MM-DD HH24:MI:SS'),100,'P_Number_Array','Process Number Array','Process Parameter','P Number Array','D','9a8c1c50-6c6f-47f5-9fe1-b21c31b26625')
;

-- Aug 13, 2021 7:26:15 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203532,0,0,'Y',TO_TIMESTAMP('2021-08-13 19:26:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:26:14','YYYY-MM-DD HH24:MI:SS'),100,'P_String_Array','Process String Array','Process Parameter','P String Array','D','75a5a88b-39d5-4494-83a1-020182b573bd')
;

-- Aug 13, 2021 7:29:40 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200196,'Multi Select List Param','L',0,0,'Y',TO_TIMESTAMP('2021-08-13 19:29:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:29:39','YYYY-MM-DD HH24:MI:SS'),100,'D','N','cddb268f-5e0f-44ff-97d5-4e98d4949811')
;

-- Aug 13, 2021 7:30:07 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200197,'Multi Select Table Param ','T',0,0,'Y',TO_TIMESTAMP('2021-08-13 19:30:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:30:07','YYYY-MM-DD HH24:MI:SS'),100,'D','N','aa1bcfe2-3318-4341-ad09-b1c1f0f0b3df')
;

-- Aug 13, 2021 7:27:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214573,0,'Process Number Array','Process Parameter',283,'P_Number_Array',22,'N','N','N','N','N',0,'N',200138,200197,0,0,'Y',TO_TIMESTAMP('2021-08-13 19:27:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:27:37','YYYY-MM-DD HH24:MI:SS'),100,203531,'Y','N','D','N','N','N','Y','c48f9465-1e67-40c9-9455-466a954e7d25','Y',0,'N','N')
;

-- Aug 13, 2021 7:26:54 PM IST
ALTER TABLE AD_PInstance_Para ADD COLUMN P_Number_Array NUMERIC(10)[] DEFAULT NULL 
;

-- Aug 13, 2021 7:30:54 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214574,0,'Process String Array','Process Parameter',283,'P_String_Array',22,'N','N','N','N','N',0,'N',200139,200196,0,0,'Y',TO_TIMESTAMP('2021-08-13 19:30:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-13 19:30:54','YYYY-MM-DD HH24:MI:SS'),100,203532,'Y','N','D','N','N','N','Y','58dd90cf-8bc3-436e-b479-92153f13d85d','Y',0,'N','N')
;

-- Aug 13, 2021 7:30:58 PM IST
ALTER TABLE AD_PInstance_Para ADD COLUMN P_String_Array VARCHAR(22)[] DEFAULT NULL 
;

-- Aug 13, 2021 7:32:39 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@!200139 & @AD_Reference_ID@!200138', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-13 19:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2544
;

SELECT register_migration_script('202108131015_IDEMPIERE-3413_ProcessParams.sql') FROM dual
;
