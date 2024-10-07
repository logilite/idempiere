-- IDEMPIERE-5653  Print format access and restriction
-- Oct 3, 2024, 6:48:30 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,ColumnSQL,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross) VALUES (216887,0,'Accessible',493,'IsAccessible','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-10-03 18:48:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-03 18:48:29','YYYY-MM-DD HH24:MI:SS'),100,200278,'N','N','D','N','N','@SQL=SELECT CASE 
	 WHEN (SELECT COUNT(1) 
		   FROM AD_PrintFormat_Access 
		   WHERE ((AD_User_ID IS NULL AND AD_Role_ID = @#AD_Role_ID@) 
				  OR (AD_Role_ID IS NULL AND AD_User_ID = @#AD_User_ID@) 
				  OR (AD_Role_ID = @#AD_Role_ID@ AND AD_User_ID = @#AD_User_ID@)) 
			 AND AD_PrintFormat_ID = @AD_PrintFormat_ID@) > 0 
	 THEN ''Y'' 
	 ELSE ''N'' 
   END','N','Y','6b17f7a6-1cb9-420f-95e1-80347277fdd1','N',0,'N','N','N','N')
;

-- Oct 3, 2024, 6:48:43 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208516,'Accessible',425,216887,'Y',1,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-10-03 18:48:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-03 18:48:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','36e6a25d-e218-4beb-a4b0-fdb853f9ba67','Y',280,2,2)
;

-- Oct 3, 2024, 6:48:52 PM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-10-03 18:48:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208516
;

-- Oct 3, 2024, 6:49:11 PM IST
UPDATE AD_ToolBarButton SET DisplayLogic='@IsForm@=Y & @IsAccessible@=Y',Updated=TO_TIMESTAMP('2024-10-03 18:49:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200100
;

-- Oct 3, 2024, 7:00:03 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Share Print Format',0,0,'Y',TO_TIMESTAMP('2024-10-03 19:00:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-03 19:00:02','YYYY-MM-DD HH24:MI:SS'),100,200907,'SharePrintFormat','D','62a67722-d33d-427f-afba-5032da365c97')
;

-- Oct 3, 2024, 1:54:04 PM IST
UPDATE AD_Tab SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2024-10-03 13:54:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200357
;

-- Oct 3, 2024, 2:04:24 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200203,'AD_Role - No Print Format Access','S','AD_Role_ID NOT IN (SELECT COALESCE(AD_Role_ID,0) FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = @AD_PrintFormat_ID@ AND AD_User_ID IS NULL)',0,0,'Y',TO_TIMESTAMP('2024-10-03 14:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-03 14:04:23','YYYY-MM-DD HH24:MI:SS'),100,'D','db363a28-e012-4a72-9984-81357459dcf1')
;

-- Oct 3, 2024, 2:04:51 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200204,'AD_User - No Print Format Access','S','AD_User_ID NOT IN (SELECT COALESCE(AD_User_ID,0) FROM AD_PrintFormat_Access WHERE AD_PrintFormat_ID = @AD_PrintFormat_ID@ AND AD_Role_ID IS NULL)',0,0,'Y',TO_TIMESTAMP('2024-10-03 14:04:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-03 14:04:50','YYYY-MM-DD HH24:MI:SS'),100,'D','5f993970-a21c-442c-b6bf-e140882d3f81')
;

-- Oct 3, 2024, 2:05:14 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200203,Updated=TO_TIMESTAMP('2024-10-03 14:05:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215954
;

-- Oct 3, 2024, 2:05:32 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200204,Updated=TO_TIMESTAMP('2024-10-03 14:05:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215955
;

-- Oct 3, 2024, 7:31:45 PM IST
DELETE FROM AD_SysConfig WHERE AD_SysConfig_ID=200238
;

-- Oct 4, 2024, 6:12:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208517,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200357,216592,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-10-04 18:12:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-04 18:12:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec6f3cc3-c4d7-4a87-80b9-9c365ae14b99','Y',60,2,2)
;

SELECT register_migration_script('202410031850_IDEMPIERE-5653.sql') FROM dual
;
