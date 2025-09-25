-- IDEMPIERE-5598  Add new Accounting Dimensions - Merge correction based on iD13
SELECT register_migration_script('202504211145_IDEMPIERE-5598_MergeCorrection.sql') FROM dual;


UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_CAcctSchemaElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216596
;

ALTER TABLE C_AcctSchema_Element RENAME CONSTRAINT MASI_CAcctSchemaElement TO MAttributeSetInstance_CAcctSchemaElement
;

UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_FactAcctSummary', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216925
;

ALTER TABLE Fact_Acct_Summary RENAME CONSTRAINT MASI_FactAcctSummary TO MAttributeSetInstance_FactAcctSummary
;

UPDATE AD_Column SET FKConstraintName='CDepartment_CPaymentTransaction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216939
;

ALTER TABLE C_PaymentTransaction RENAME CONSTRAINT CDept_CPaymentTransaction TO CDepartment_CPaymentTransaction
;

UPDATE AD_Column SET FKConstraintName='CCostCenter_CPaymentTransaction', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216940
;

ALTER TABLE C_PaymentTransaction RENAME CONSTRAINT CCostCenter_CPaymentTrx TO CCostCenter_CPaymentTransaction
;

UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistribution', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216993
;

ALTER TABLE GL_Distribution RENAME CONSTRAINT MASI_GLDistribution TO MAttributeSetInstance_GLDistribution
;

UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLDistributionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216997
;

ALTER TABLE GL_DistributionLine RENAME CONSTRAINT MASI_GLDistributionLine TO MAttributeSetInstance_GLDistributionLine
;

UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_GLJournalLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-01-23 15:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217010
;

ALTER TABLE GL_JournalLine RENAME CONSTRAINT MASI_GLJournalLine TO MAttributeSetInstance_GLJournalLine
;

-- Reference required to alter [ from 7.1 as 10 and 11+ as 200231 ]
UPDATE AD_Column SET AD_Reference_ID = 200231 WHERE AD_Column_ID IN (216361, 216353)
;

