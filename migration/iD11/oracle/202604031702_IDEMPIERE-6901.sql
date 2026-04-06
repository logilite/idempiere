--   IDEMPIERE-6901  Enhancing Workflow Activity Summary
SELECT register_migration_script('202604031702_IDEMPIERE-6901.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 03/04/2026 17:02:29 IST
INSERT INTO M_AttributeSet (AD_Org_ID,IsActive,Updated,IsGuaranteeDate,IsSerNo,Name,M_AttributeSet_ID,AD_Client_ID,IsLot,CreatedBy,UpdatedBy,Created,GuaranteeDays,IsInstanceAttribute,IsLotMandatory,IsSerNoMandatory,IsGuaranteeDateMandatory,MandatoryType,M_AttributeSet_UU,UseGuaranteeDateForMPolicy,M_AttributeSet_Type,IsAutoGenerateLot,EntityType) VALUES (0,'Y',TO_TIMESTAMP('2026-04-03 17:02:28','YYYY-MM-DD HH24:MI:SS'),'N','N','AD Table Attribute',200001,0,'N',100,100,TO_TIMESTAMP('2026-04-03 17:02:28','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','N','f24c37d1-e9cf-4507-be98-02b0140f1c2e','N','TA','N','D')
;

-- 03/04/2026 17:02:29 IST
UPDATE M_AttributeSet mas SET IsInstanceAttribute='Y' WHERE M_AttributeSet_ID=200001 AND IsInstanceAttribute='N' AND (IsSerNo='Y' OR IsLot='Y' OR IsGuaranteeDate='Y' OR EXISTS (SELECT * FROM M_AttributeUse mau INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID AND mau.IsActive='Y' AND ma.IsActive='Y' AND ma.IsInstanceAttribute='Y'))
;

-- 03/04/2026 17:07:13 IST
INSERT INTO M_Attribute (AD_Org_ID,AD_Client_ID,IsInstanceAttribute,Updated,M_Attribute_ID,Name,UpdatedBy,CreatedBy,Created,IsActive,Description,IsMandatory,AttributeValueType,M_Attribute_UU,AD_Reference_ID,EntityType) VALUES (0,0,'N',TO_TIMESTAMP('2026-04-03 17:07:13','YYYY-MM-DD HH24:MI:SS'),200016,'AD_WF_Activity_Summary',100,100,TO_TIMESTAMP('2026-04-03 17:07:13','YYYY-MM-DD HH24:MI:SS'),'Y','Workflow Activity Summary','N','R','60ca6f6d-01f2-444f-a8c7-6ae6c88a9d25',14,'D')
;

-- 03/04/2026 17:07:23 IST
INSERT INTO M_AttributeUse (IsActive,M_Attribute_ID,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,Created,UpdatedBy,M_AttributeSet_ID,SeqNo,M_AttributeUse_UU,EntityType) VALUES ('Y',200016,100,TO_TIMESTAMP('2026-04-03 17:07:23','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2026-04-03 17:07:23','YYYY-MM-DD HH24:MI:SS'),100,200001,10,'661d842f-0f38-4a0b-b0c7-8525ce1a264a','D')
;

-- 03/04/2026 17:07:23 IST
UPDATE M_AttributeSet mas SET IsInstanceAttribute='Y' WHERE M_AttributeSet_ID=200001 AND IsInstanceAttribute='N' AND (IsSerNo='Y' OR IsLot='Y' OR IsGuaranteeDate='Y' OR EXISTS (SELECT * FROM M_AttributeUse mau INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID AND mau.IsActive='Y' AND ma.IsActive='Y' AND ma.IsInstanceAttribute='Y'))
;

-- 03/04/2026 17:07:23 IST
UPDATE M_AttributeSet mas SET IsInstanceAttribute='N' WHERE M_AttributeSet_ID=200001 AND IsInstanceAttribute='Y'	AND IsSerNo='N' AND IsLot='N' AND IsGuaranteeDate='N' AND NOT EXISTS (SELECT * FROM M_AttributeUse mau INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID AND mau.IsActive='Y' AND ma.IsActive='Y' AND ma.IsInstanceAttribute='Y')
;

-- 03/04/2026 18:48:50 IST
INSERT INTO AD_TableAttributeSet (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_TableAttributeSet_ID,AD_TableAttributeSet_UU,M_AttributeSet_ID,AD_Table_ID) VALUES (0,0,TO_TIMESTAMP('2026-04-03 18:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-03 18:48:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'10b2d1e7-d17c-4e65-9e7b-75cd5b53e752',200001,100)
;
