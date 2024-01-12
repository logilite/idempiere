SET SQLBLANKLINES ON
SET DEFINE OFF

-- Disable Zoom Across

-- Sep 11, 2023, 4:33:58 PM IST
ALTER TABLE AD_Column ADD IsDisableZoomAcross CHAR(1) DEFAULT 'N' CHECK (IsDisableZoomAcross IN ('Y','N'))
;

SELECT register_migration_script('202309111840_DisableZoomAcross_2.sql') FROM dual
;