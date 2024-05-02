SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Element SET Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.',Updated=TO_DATE('2021-11-16 15:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2466
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Column SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Process_Para SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', AD_Element_ID=2466 WHERE UPPER(ColumnName)='ISDROPSHIP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Process_Para SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466 AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_InfoColumn SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466 AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Field SET Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2466) AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:51:54 PM CET
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-16 15:51:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10124
;

SELECT register_migration_script('202111161449_IDEMPIERE-2620.sql') FROM dual
;

