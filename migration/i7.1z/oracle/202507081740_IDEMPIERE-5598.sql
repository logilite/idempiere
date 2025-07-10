SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5598: Add new Accounting Dimensions
-- Jul 8, 2025, 5:36:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217140,0,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',270,'C_BankAccount_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2025-07-08 17:36:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-08 17:36:54','YYYY-MM-DD HH24:MI:SS'),100,836,'Y','N','D','N','N','N','Y','25cdf47a-c1bf-4c7a-a089-2086ad24198d','Y',0,'N','N','N','N','N')
;

-- Jul 8, 2025, 5:37:03 PM IST
UPDATE AD_Column SET FKConstraintName='CBankAccount_FactAcct', FKConstraintType='N',Updated=TO_DATE('2025-07-08 17:37:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217140
;

-- Jul 8, 2025, 5:37:03 PM IST
ALTER TABLE Fact_Acct ADD C_BankAccount_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2025, 5:37:03 PM IST
ALTER TABLE Fact_Acct ADD CONSTRAINT CBankAccount_FactAcct FOREIGN KEY (C_BankAccount_ID) REFERENCES c_bankaccount(c_bankaccount_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2025, 6:40:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross) VALUES (217141,0,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',226,'C_BankAccount_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2025-07-08 18:40:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-08 18:40:01','YYYY-MM-DD HH24:MI:SS'),100,836,'Y','N','D','N','N','N','Y','ca27d73b-82cf-498f-9877-6d873e6bf3e1','Y',0,'N','N','N','N','N')
;

-- Jul 8, 2025, 6:40:03 PM IST
UPDATE AD_Column SET FKConstraintName='CBankAccount_GLJournalLine', FKConstraintType='N',Updated=TO_DATE('2025-07-08 18:40:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217141
;

-- Jul 8, 2025, 6:40:03 PM IST
ALTER TABLE GL_JournalLine ADD C_BankAccount_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2025, 6:40:03 PM IST
ALTER TABLE GL_JournalLine ADD CONSTRAINT CBankAccount_GLJournalLine FOREIGN KEY (C_BankAccount_ID) REFERENCES c_bankaccount(c_bankaccount_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2025, 6:41:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208829,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',161,217141,'Y',22,430,'N','N','N','N',0,0,'Y',TO_DATE('2025-07-08 18:41:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-08 18:41:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a37153aa-32e6-442c-9df3-b301b0c2c211','Y',450,2)
;

-- Jul 8, 2025, 6:42:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208830,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200008,217141,'Y',22,430,'N','N','N','N',0,0,'Y',TO_DATE('2025-07-08 18:42:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-08 18:42:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb7d8a5b-a691-4538-8b87-e23a3a7e8a5d','Y',450,2)
;

-- Jul 9, 2025, 11:40:48 AM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200496,0,0,'Y',TO_DATE('2025-07-09 11:40:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-09 11:40:47','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',204,240,19,'N',0,'N','C_BankAccount_ID','Y','D',836,'32ca322e-c068-4eeb-8181-631dda71bf7e','N')
;

-- Jul 9, 2025, 11:41:28 AM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200497,0,0,'Y',TO_DATE('2025-07-09 11:41:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-09 11:41:27','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',202,230,19,'N',0,'N','C_BankAccount_ID','Y','D',836,'87fb7f0b-964d-49a0-baf4-257f352155b6','N')
;

-- Jul 10, 2025, 1:23:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208831,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',242,217140,'Y',22,490,'N','N','N','N',0,0,'Y',TO_DATE('2025-07-10 13:23:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2025-07-10 13:23:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','91fb6ade-fd87-4990-a8b9-81cf061e24da','Y',550,2)
;

SELECT register_migration_script('202507081740_IDEMPIERE-5598.sql') FROM dual;
;