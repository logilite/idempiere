SET SQLBLANKLINES ON
SET DEFINE OFF

-- Quick Form Customize Grid
-- Nov 8, 2017 10:56:03 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213259,0,'Quick Form','Display in Quick Form','The field will be displayed in Quick Form for easy encoding.',200008,'IsQuickForm','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-11-08 10:56:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-08 10:56:02','YYYY-MM-DD HH24:MI:SS'),100,203142,'Y','N','D','N','N','N','Y','c52262c8-322a-4607-a50d-745a7f063706','Y',0,'N','N','N')
;

-- Nov 8, 2017 10:56:08 AM IST
ALTER TABLE AD_Tab_Customization ADD IsQuickForm CHAR(1) DEFAULT 'N' CHECK (IsQuickForm IN ('Y','N'))
;

-- Nov 9, 2017 10:55:12 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Quick Form',0,0,'Y',TO_DATE('2017-11-09 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-09 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,200440,'QuickForm','D','0fadb3eb-413b-41c2-b41c-d0ae3a1d5c27')
;

SELECT register_migration_script('201711081056_QUICK_FORM_CUSTOMIZE_GRID.sql') FROM dual
;
