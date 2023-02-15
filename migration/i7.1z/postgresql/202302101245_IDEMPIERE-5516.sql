-- Remove mandatory column value from Bank account accounting tab
SELECT register_migration_script('202302101245_IDEMPIERE-5516.sql') FROM dual;


ALTER TABLE C_BankAccount_Acct
ALTER COLUMN B_UnAllocatedCash_Acct 
DROP NOT NULL
;


ALTER TABLE C_BankAccount_Acct
ALTER COLUMN B_PaymentSelect_Acct
DROP NOT NULL
;
