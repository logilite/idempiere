SET SQLBLANKLINES ON
SET DEFINE OFF

-- Remove mandatory column value from Bank account accounting tab
SELECT register_migration_script('202302101245_IDEMPIERE-5516.sql') FROM dual;


ALTER TABLE C_BankAccount_Acct
MODIFY ( B_UnAllocatedCash_Acct null)
;

ALTER TABLE C_BankAccount_Acct
MODIFY ( B_PaymentSelect_Acct null)
;
