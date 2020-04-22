-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Apr 22, 2020, 10:17:11 AM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstanceTo_MAMove',Updated=TO_TIMESTAMP('2020-04-22 10:17:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212226
;

-- Apr 22, 2020, 10:17:15 AM IST
INSERT INTO t_alter_column values('m_movementlinema','M_AttributeSetInstanceTo_ID','NUMERIC(10)',null,'NULL',null)
;

-- Apr 22, 2020, 10:17:15 AM IST
ALTER TABLE M_MovementLineMA DROP CONSTRAINT mattributesetinstanceto_mmovem
;

-- Apr 22, 2020, 10:17:15 AM IST
ALTER TABLE M_MovementLineMA ADD CONSTRAINT MAttributeSetInstanceTo_MAMove FOREIGN KEY (M_AttributeSetInstanceTo_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201908011126_IDEMPIERE-4017.sql') FROM dual
;
