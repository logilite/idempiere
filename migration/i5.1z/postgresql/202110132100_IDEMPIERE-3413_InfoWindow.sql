-- IDEMPIERE-3413 Implement multi-select field for filter criteria support in info window
-- Oct 13, 2021 5:17:45 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203545,0,0,'Y',TO_TIMESTAMP('2021-10-13 17:17:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-13 17:17:44','YYYY-MM-DD HH24:MI:SS'),100,'IsMultiSelectCriteria','Multi-Select Criteria','Multi-Select Criteria','D','d8004d9d-58f1-44c1-9a50-48366459ab0f')
;

-- Oct 13, 2021 5:18:07 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214596,0,'Multi-Select Criteria',897,'IsMultiSelectCriteria','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-10-13 17:18:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-13 17:18:05','YYYY-MM-DD HH24:MI:SS'),100,203545,'Y','N','D','N','N','N','Y','64d3e3a0-c5e4-4792-ae48-8d27b0fbb6dc','Y',0,'N','N')
;

-- Oct 13, 2021 5:18:10 PM IST
ALTER TABLE AD_InfoColumn ADD COLUMN IsMultiSelectCriteria CHAR(1) DEFAULT 'N' CHECK (IsMultiSelectCriteria IN ('Y','N'))
;

-- Oct 13, 2021 5:19:37 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206755,'Multi-Select Criteria',844,214596,'Y','@IsQueryCriteria@=Y',0,165,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-10-13 17:19:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-13 17:19:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b1fbef0-471b-43cb-8e23-007034045f49','Y',140,6,2,1,'N','N','N','N')
;

-- Oct 13, 2021 5:21:11 PM IST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 & @IsQueryCriteria@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-13 17:21:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206755
;

-- Oct 13, 2021 5:21:21 PM IST
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y & @AD_Reference_ID@!200138 & @AD_Reference_ID@!200139 & @AD_Reference_ID@!200161 & @AD_Reference_ID@!200162 & @AD_Reference_ID@!200163 & @IsMultiSelectCriteria:N@=N', Updated=TO_TIMESTAMP('2021-10-13 17:21:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Oct 13, 2021 5:21:53 PM IST
UPDATE AD_Val_Rule SET Code='(( AD_Ref_List.Value IN (''='', ''!='', ''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ IN (200138, 200139)) OR ( AD_Ref_List.Value NOT IN (''>>>'', ''<<<'', ''&&'', ''-&&'') AND @AD_Reference_ID@ NOT IN (200138, 200139)  AND ''@IsMultiSelectCriteria:N@''=''N'') OR( AD_Ref_List.Value IN ( ''<<<'') AND ''@IsMultiSelectCriteria:N@''=''Y''  ) ) AND  AD_Reference_ID=200061',Updated=TO_TIMESTAMP('2021-10-13 17:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200152
;

SELECT register_migration_script('202110132100_IDEMPIERE-3413_InfoWindow.sql') FROM dual
;
