-- Update reversal document reference in the original document
UPDATE C_AllocationHdr
SET Reversal_ID = sub.C_AllocationHdr_ID
FROM C_AllocationHdr AS sub
WHERE C_AllocationHdr.Reversal_ID IS NULL AND C_AllocationHdr.C_AllocationHdr_ID = sub.Reversal_ID;

SELECT register_migration_script('202405161330_Update_AllocationHdr_Reversal.sql') FROM dual
;
