-- Mar 19, 2014 5:45:58 PM IST
-- Adding SQL Operation on Conditional transition between nodes of workflow.
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','SQL must not update or insert record.',200259,'U','49c3be7e-16de-46ff-a2a9-f9411a6a4982','SQLReadOnly','Y',TO_TIMESTAMP('2014-03-19 17:45:57','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-03-19 17:45:57','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 19, 2014 5:47:52 PM IST
UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@Operation@!''SQ''',Updated=TO_TIMESTAMP('2014-03-19 17:47:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11579
;

-- Mar 19, 2014 5:47:54 PM IST
INSERT INTO t_alter_column values('ad_wf_nextcondition','AD_Column_ID','NUMERIC(10)',null,'NULL',null)
;

-- Mar 19, 2014 5:47:54 PM IST
INSERT INTO t_alter_column values('ad_wf_nextcondition','AD_Column_ID',null,'NULL',null,null)
;

-- Mar 19, 2014 5:47:54 PM IST
ALTER TABLE AD_WF_NextCondition DROP CONSTRAINT adcolumn_adwfnextcondition
;

-- Mar 19, 2014 5:47:54 PM IST
ALTER TABLE AD_WF_NextCondition ADD CONSTRAINT adcolumn_adwfnextcondition FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 19, 2014 5:47:59 PM IST
UPDATE AD_Field SET DisplayLogic='@Operation@!''SQ''',Updated=TO_TIMESTAMP('2014-03-19 17:47:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10101
;

