-- Delete Reverse Correct Posting
-- Jan 5, 2024, 3:44:17 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203898,0,0,'Y',TO_TIMESTAMP('2024-01-05 15:44:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-05 15:44:16','YYYY-MM-DD HH24:MI:SS'),100,'IsDeleteReverseCorrectPosting','Delete Reverse Correct Posting','This flag controls if Adempiere must delete the posting line when reverse correct document.','Delete Reverse Correct Posting','D','6167003d-e9bd-4bf5-9ccf-29673ae51396')
;

-- Jan 5, 2024, 3:44:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (216345,0,'Delete Reverse Correct Posting','This flag controls if Adempiere must delete the posting line when reverse correct document.',265,'IsDeleteReverseCorrectPosting','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-01-05 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-05 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,203898,'Y','N','D','N','N','N','Y','44047722-6d77-457b-9341-880654a7b3c5','Y',0,'N','N','N','N','N')
;

-- Jan 5, 2024, 3:44:38 PM IST
ALTER TABLE C_AcctSchema ADD COLUMN IsDeleteReverseCorrectPosting CHAR(1) DEFAULT 'N' CHECK (IsDeleteReverseCorrectPosting IN ('Y','N'))
;

-- Jan 5, 2024, 3:47:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsDisableZoomAcross) VALUES (208123,'Delete Reverse Correct Posting','This flag controls if Adempiere must delete the posting line when reverse correct document.',199,216345,'Y',0,270,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-05 15:47:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-05 15:47:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ef71f873-9b0d-42d7-a83b-f545ae6d9bc7','Y',280,5,2,1,'N','N','N','N','N')
;

SELECT register_migration_script('202401051550_IDEMPIERE-5983.sql') FROM dual
;
