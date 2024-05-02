SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding aging 91 - 120 due bucket
-- 04-Apr-2024, 6:11:11 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203930,0,0,'Y',TO_DATE('2024-04-04 18:11:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:11:10','YYYY-MM-DD HH24:MI:SS'),100,'PastDue91_120','Past Due 91-120','Past Due 91-120','D','4801ba11-4bba-42d5-8097-f9ba7912ddb9')
;

-- 04-Apr-2024, 6:11:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216589,1,'Past Due 91-120',631,'PastDue91_120',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_DATE('2024-04-04 18:11:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:11:11','YYYY-MM-DD HH24:MI:SS'),100,203930,'Y','N','D','Y','N','N','Y','74a4b223-7cf0-4dc7-9c44-937973f3c1a4','Y','N','N','N','N','N')
;

-- 04-Apr-2024, 6:11:12 PM IST
ALTER TABLE T_Aging ADD PastDue91_120 NUMBER DEFAULT NULL 
;

-- 04-Apr-2024, 6:11:13 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203931,0,0,'Y',TO_DATE('2024-04-04 18:11:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:11:12','YYYY-MM-DD HH24:MI:SS'),100,'Due91_120','To Due 91-120','To Due 91-120','D','d417f95e-7e51-409d-aa6e-973d907252d5')
;

-- 04-Apr-2024, 6:11:13 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216590,1,'To Due 91-120',631,'Due91_120',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_DATE('2024-04-04 18:11:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:11:13','YYYY-MM-DD HH24:MI:SS'),100,203931,'Y','N','D','Y','N','N','Y','e2e7c256-4119-45a1-81c4-17fb0b183a13','Y','N','N','N','N','N')
;

-- 04-Apr-2024, 6:11:13 PM IST
ALTER TABLE T_Aging ADD Due91_120 NUMBER DEFAULT NULL 
;

SELECT register_migration_script('202404041815_Adding_Columns_Due_Aging.sql') FROM dual
;
