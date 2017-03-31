-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- 09/03/2017 8:17:10 PM
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200091,0,0,TO_TIMESTAMP('2017-03-09 20:17:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-03-09 20:17:09','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CALENDAR_TIME_FORMAT','HH:mm','Configure time format for request, activity, resource assignment from the calendar.','D','C','1574f6d8-25bf-437c-9332-f39252a92e92')
;

-- 09/03/2017 8:19:40 PM
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200092,0,0,TO_TIMESTAMP('2017-03-09 20:19:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-03-09 20:19:38','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CALENDAR_START_TIME_HOUR','9','Set default start time hour while creating request, activity or resource assignment.','D','C','117a9d56-5283-491b-94a3-3501bb833491')
;

-- 09/03/2017 8:20:29 PM
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200093,0,0,TO_TIMESTAMP('2017-03-09 20:20:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-03-09 20:20:27','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CALENDAR_END_TIME_HOUR','17','Set default end time hour while creating request, activity or resource assignment.','D','C','b76b6816-7024-4bb6-9787-f112eeafd53c')
;

SELECT register_migration_script('201703092020_IDEMPIERE-2870.sql') FROM dual
;
