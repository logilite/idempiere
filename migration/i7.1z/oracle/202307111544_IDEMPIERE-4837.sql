SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 11, 2023, 3:44:03 PM IST
--All window having following table should hae warehouse defaulted
--C_Order = 259
--I_Order = 591
--I_Invoice = 598
--C_Project = 203
--C_Invoice = 318
--M_Requisition = 702
--M_Movement = 323
--M_Inventroy = 321
UPDATE AD_Window SET PredefinedContextVariables=(PredefinedContextVariables || chr(10) || 'UseWarehouseInProductInfo=Y'),Updated=TO_DATE('2023-07-11 15:44:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 
WHERE AD_Window_ID in  (Select w.ad_window_ID from AD_Window w inner join AD_Tab tb on (w.AD_Window_ID=tb.AD_Window_ID) 
WHERE tb.AD_Table_ID in (259,591,598,203,318,702,323,321))
;


SELECT register_migration_script('202307111544_IDEMPIERE-4837.sql') FROM dual
;