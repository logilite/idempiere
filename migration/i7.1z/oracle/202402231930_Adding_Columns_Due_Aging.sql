SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding PastDue121_Plus & Due121_Plus Columns

-- 23-Feb-2024, 7:20:23 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203921,0,0,'Y',TO_DATE('2024-02-23 19:20:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-23 19:20:22','YYYY-MM-DD HH24:MI:SS'),100,'PastDue121_Plus','Past Due > 121','Past Due > 121','D','2a193ad9-9c1b-4aba-a4ce-31656324cf14')
;

-- 23-Feb-2024, 7:20:46 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203922,0,0,'Y',TO_DATE('2024-02-23 19:20:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-23 19:20:45','YYYY-MM-DD HH24:MI:SS'),100,'Due121_Plus','Due > 121','Due > 121','D','9b7a4d56-6658-4d2e-9efa-d31ce9930aab')
;

-- 23-Feb-2024, 7:21:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216567,0,'Past Due > 121',631,'PastDue121_Plus','0',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_DATE('2024-02-23 19:21:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-23 19:21:16','YYYY-MM-DD HH24:MI:SS'),100,203921,'Y','N','D','N','N','N','Y','2d89ceef-3c80-45ce-9b3c-60d3b95f3b4b','Y',0,'N','N','N','N','N')
;

-- 23-Feb-2024, 7:21:20 PM IST
ALTER TABLE T_Aging MODIFY PastDue121_Plus NUMBER DEFAULT 0
;

-- 23-Feb-2024, 7:21:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216568,0,'Due > 121',631,'Due121_Plus','0',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_DATE('2024-02-23 19:21:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-02-23 19:21:42','YYYY-MM-DD HH24:MI:SS'),100,203922,'Y','N','D','N','N','N','Y','7254656e-50cf-4908-b2db-7639da5610f3','Y',0,'N','N','N','N','N')
;

-- 23-Feb-2024, 7:21:46 PM IST
ALTER TABLE T_Aging ADD Due121_Plus NUMBER DEFAULT 0 NOT NULL
;

