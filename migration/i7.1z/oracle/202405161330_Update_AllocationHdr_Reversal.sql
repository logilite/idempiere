SET SQLBLANKLINES ON
SET DEFINE OFF

-- Update reversal document reference in the original document
UPDATE C_AllocationHdr
SET Reversal_ID = (
    SELECT sub.C_AllocationHdr_ID
    FROM C_AllocationHdr sub
    WHERE sub.Reversal_ID = C_AllocationHdr.C_AllocationHdr_ID
)
WHERE Reversal_ID IS NULL
AND EXISTS (
    SELECT 1
    FROM C_AllocationHdr sub
    WHERE sub.Reversal_ID = C_AllocationHdr.C_AllocationHdr_ID
);

SELECT register_migration_script('202405161330_Update_AllocationHdr_Reversal.sql') FROM dual
;
