-- IDEMPIERE-2456 Adding _ID coloumn on LineMA tables
-- Feb 6, 2015 3:00:50 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202815,0,0,'Y',TO_TIMESTAMP('2015-02-06 15:00:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-06 15:00:49','YYYY-MM-DD HH24:MI:SS'),100,'M_InOutLineMA_ID','M_InOutLineMA_ID','Attributes','Attributes','D','d437aabd-6b5d-4b4f-acf0-2b0bbf936392')
;

-- Feb 6, 2015 3:01:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211836,0,'M_InOutLineMA_ID','Attributes',762,'M_InOutLineMA_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2015-02-06 15:01:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-06 15:01:15','YYYY-MM-DD HH24:MI:SS'),100,202815,'N','N','D','N','N','N','Y','b858b490-30d3-4790-9077-aeff52476baa','N',0,'N','N')
;

-- Feb 6, 2015 3:01:20 PM IST
ALTER TABLE M_InOutLineMA ADD COLUMN M_InOutLineMA_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 6, 2015 3:01:20 PM IST
ALTER TABLE M_InOutLineMA DROP CONSTRAINT IF EXISTS M_InOutLineMA_PKey
;
DO $$ 
Declare 
value1 Integer;
rec  M_InoutLineMA%rowtype;
Begin
value1 := (SELECT Coalesce((SELECT MAX(M_InOutLineMA_ID)FROM M_InOutLineMA) ,1000000) FROM DUAL FETCH FIRST ROW ONLY);
for rec IN 
Select * From M_InoutLineMA WHERE M_InOutLineMA_ID IS NULL Order By Created ASC 
Loop 
	execute 'Update M_InoutLineMA Set M_InoutLineMA_ID = $1 where M_InoutLine_ID = $2.M_inoutLine_ID AND M_AttributeSetInstance_ID = $2.M_AttributeSetInstance_ID AND DateMaterialPolicy = $2.DateMaterialPolicy' using value1,rec;
	value1 := value1 + 1 ;
End Loop;
End $$;

ALTER TABLE M_InOutLineMA ADD CONSTRAINT M_InOutLineMA_PKey PRIMARY KEY (M_InOutLineMA_ID)
;
ALTER TABLE M_InOutLineMA DROP CONSTRAINT IF EXISTS M_InOutLine_ID_M_AttributeSetInstance_ID_Date_Key
;
ALTER TABLE M_InOutLineMA ADD CONSTRAINT M_InOutLine_ID_M_AttributeSetInstance_ID_Date_Key UNIQUE(M_InOutLine_ID , M_AttributeSetInstance_ID , DateMaterialPolicy)
;

-- Feb 6, 2015 3:03:33 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203497,'M_InOutLineMA_ID','Attributes',751,211836,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-02-06 15:03:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-06 15:03:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','33f6eae8-2b4a-4e55-a772-dcdffe183c3b','N',2)
;

-- Feb 6, 2015 3:04:09 PM IST
UPDATE AD_Column SET IsParent='N',Updated=TO_TIMESTAMP('2015-02-06 15:04:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13323
;

-- Feb 6, 2015 3:04:16 PM IST
UPDATE AD_Column SET IsParent='N',Updated=TO_TIMESTAMP('2015-02-06 15:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13322
;

-- Feb 6, 2015 3:04:21 PM IST
INSERT INTO t_alter_column values('m_inoutlinema','M_AttributeSetInstance_ID','NUMERIC(10)',null,null)
;

-- Feb 6, 2015 3:04:21 PM IST
ALTER TABLE M_InOutLineMA DROP CONSTRAINT masi_minoutlinema
;

-- Feb 6, 2015 3:04:21 PM IST
ALTER TABLE M_InOutLineMA ADD CONSTRAINT masi_minoutlinema FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Feb 6, 2015 3:04:28 PM IST
INSERT INTO t_alter_column values('m_inoutlinema','M_InOutLine_ID','NUMERIC(10)',null,null)
;

-- Feb 6, 2015 3:04:28 PM IST
ALTER TABLE M_InOutLineMA DROP CONSTRAINT minoutline_minoutlinema
;

-- Feb 6, 2015 3:04:28 PM IST
ALTER TABLE M_InOutLineMA ADD CONSTRAINT minoutline_minoutlinema FOREIGN KEY (M_InOutLine_ID) REFERENCES m_inoutline(m_inoutline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201502061535-IDEMPIERE-2456.sql') FROM dual
;
