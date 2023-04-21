SET SQLBLANKLINES ON
SET DEFINE OFF

-- Location map using Latitude and Longitude
-- Apr 20, 2023, 10:47:24 AM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200225,0,0,TO_DATE('2023-04-20 10:47:23','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-04-20 10:47:23','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','LOCATION_MAPS_URL_LAT_LONG','https://maps.google.com/?q=<LAT>,<LNG>&z=20','URL to indicate the preferred maps service for latitude and longitude location point. Add <LAT>,<LNG> tag in the URL to replace value for parsing. URL Ex: https://maps.google.com/?q=<LAT>,<LNG>&z=16','D','S','203294f6-8fce-4e6a-a9d3-09b1be750950')
;

SELECT register_migration_script('202304201240_Report_Lat_Long_Zoom.sql') FROM dual;
