-- Oracle Data Migration from AD_TreeBar to AD_Tree_Favorite and AD_Tree_Favorite_Node table
-- Insert TreeBar data to Tree Favorite
INSERT INTO AD_Tree_Favorite (AD_Tree_Favorite_ID, AD_Client_ID, AD_Org_ID, AD_User_ID, AD_Role_ID, Created, CreatedBy, Updated, UpdatedBy, AD_Tree_Favorite_UU)
SELECT 	(row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID))	+ 999999 AS AD_Tree_Favorite_ID, AD_Client_ID, 0, AD_User_ID, 0, SYSDATE, 100, SYSDATE, 100, Generate_UUID()
FROM AD_TreeBar
WHERE AD_User_ID NOT IN (SELECT DISTINCT AD_User_ID FROM AD_Tree_Favorite)
GROUP BY AD_Client_ID, AD_User_ID
;

-- Insert TreeBar data to Tree Favorite Node
INSERT INTO AD_Tree_Favorite_Node (AD_Client_ID, AD_Menu_ID, AD_Org_ID, AD_Tree_Favorite_ID, AD_Tree_Favorite_Node_ID, 
	 	AD_Tree_Favorite_Node_UU, Created, CreatedBy, IsSummary, SeqNo, Updated, UpdatedBy, IsFavourite, LoginOpenSeqNo)
SELECT 	AD_Client_ID, Node_ID, AD_Org_ID, (SELECT MIN(AD_Tree_Favorite_ID) FROM AD_Tree_Favorite WHERE AD_Client_ID = tb.AD_Client_ID AND AD_User_ID=tb.AD_User_ID) AS AD_Tree_Favorite_ID,
		CASE WHEN (SELECT MAX(AD_Tree_Favorite_Node_ID) FROM AD_Tree_Favorite_Node) > 999999	THEN
			(SELECT MAX(AD_Tree_Favorite_Node_ID) FROM AD_Tree_Favorite_Node)
		ELSE
			 999999
		END	+ (row_number() OVER (ORDER BY AD_Client_ID, AD_User_ID)) AS AD_Tree_Favorite_Node_ID,
		Generate_UUID(), SYSDATE, 100, 'N', 0, SYSDATE, 100, 'Y', LoginOpenSeqNo
FROM AD_TreeBar tb
WHERE (AD_Client_ID, AD_User_ID, Node_ID) NOT IN (SELECT DISTINCT tf.AD_Client_ID, tf.AD_User_ID, tfn.AD_Menu_ID FROM  AD_Tree_Favorite tf INNER JOIN AD_Tree_Favorite_Node tfn ON (tfn.AD_Tree_Favorite_ID = tf.AD_Tree_Favorite_ID) AND tfn.AD_Menu_ID>0)
ORDER BY AD_Client_ID, AD_User_ID
;


-- Set the sequence value based on latest ID created/inserted through above SQL for AD_Tree_Favorite_Node TABLE
DO
$$
DECLARE
	isNativeSeq boolean;
	isSeqExists boolean;
	newSeqNo int;
BEGIN
	SELECT Value='Y' FROM AD_SysConfig WHERE Name = 'SYSTEM_NATIVE_SEQUENCE'
	INTO isNativeSeq;

	SELECT COUNT(1) > 0 FROM pg_class WHERE relname ILIKE 'AD_Tree_Favorite_Node_SQ'
	INTO isSeqExists;

	IF isNativeSeq IS TRUE THEN
		SELECT MAX(AD_Tree_Favorite_Node_ID)+1 FROM AD_Tree_Favorite_Node 
		INTO newSeqNo;

		IF isSeqExists IS NOT TRUE THEN
			CREATE SEQUENCE AD_Tree_Favorite_Node_SQ
			INCREMENT BY 1 
			MINVALUE 1000000 
			MAXVALUE 2147483647 
			START WITH 1000000;

			DBMS_OUTPUT.PUT_LINE('Creating new sequence in DB... ' || (SELECT setval('AD_Tree_Favorite_Node_SQ', newSeqNo)));
		ELSE
			DBMS_OUTPUT.PUT_LINE('Altering sequence in DB... ' || (SELECT setval('AD_Tree_Favorite_Node_SQ', newSeqNo)));
		END IF;
	ELSE
		UPDATE AD_Sequence SET CurrentNext=(SELECT MAX(AD_Tree_Favorite_Node_ID)+1 FROM AD_Tree_Favorite_Node) 
		WHERE AD_Sequence_ID=(SELECT AD_Sequence_ID FROM AD_Sequence WHERE Name='AD_Tree_Favorite_Node' AND IsActive='Y' AND IsTableID='Y' AND IsAutoSequence='Y');

		DBMS_OUTPUT.PUT_LINE('Altering AD_Sequence in DB... ' || (SELECT MAX(AD_Tree_Favorite_Node_ID)+1 FROM AD_Tree_Favorite_Node));
	END IF;
END
$$
;

SELECT register_migration_script('202011101100_IDEMPIERE-3340_MigrateData.sql') FROM dual
;
