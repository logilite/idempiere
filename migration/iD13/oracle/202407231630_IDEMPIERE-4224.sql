SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4224  Decluttering configuration
SELECT register_migration_script('202407231630_IDEMPIERE-4224.sql') FROM dual;


-- Oct 5, 2023, 6:58:10 PM IST
UPDATE AD_Column 
SET AD_Reference_ID = 200202,
	Updated = TO_DATE('2023-10-05 18:58:09','YYYY-MM-DD HH24:MI:SS')
WHERE AD_Column_ID = 215945
;

-- Oct 5, 2023, 7:00:24 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_DATE('2023-10-05 19:00:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=562
;

-- Oct 5, 2023, 7:04:17 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_DATE('2023-10-05 19:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=558
;

-- Oct 5, 2023, 7:04:30 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_DATE('2023-10-05 19:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=560
;

-- Oct 5, 2023, 7:04:53 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_DATE('2023-10-05 19:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=563
;


-- Update existing record Entity Type
UPDATE M_AttributeSet SET EntityType = 'D' WHERE M_AttributeSet_ID < 1000000;

UPDATE M_AttributeUse SET EntityType = 'D' WHERE  M_AttributeSet_ID  < 1000000 AND M_Attribute_ID < 1000000;

UPDATE M_Attribute SET EntityType = 'D' WHERE M_Attribute_ID < 1000000;

UPDATE M_AttributeValue SET EntityType = 'D' WHERE M_AttributeValue_ID < 1000000;

UPDATE M_AttributeSet SET EntityType = 'U' WHERE M_AttributeSet_ID >= 1000000;

UPDATE M_AttributeUse SET EntityType = 'U' WHERE  M_AttributeSet_ID  >= 1000000 OR M_Attribute_ID >= 1000000;

UPDATE M_Attribute SET EntityType = 'U' WHERE M_Attribute_ID >= 1000000;

UPDATE M_AttributeValue SET EntityType = 'U' WHERE M_AttributeValue_ID >= 1000000;


-- Dec 30, 2024, 6:35:16 PM IST
UPDATE AD_Column
SET AD_Reference_ID = 200231
WHERE AD_Column_ID = 217022
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSet_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217023
;

