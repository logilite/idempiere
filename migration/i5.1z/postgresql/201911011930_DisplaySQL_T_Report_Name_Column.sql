-- Indenting financial report detail rows, DisplaySQL for T_Report.Name Column
-- Nov 1, 2019 7:30:56 PM IST
UPDATE AD_Column SET Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.length.(repeat(''....''::text, abs(levelno)::int) || name)', ColumnSQL='(repeat(''....''::text, abs(levelno)::int) || name)', IsAllowCopy='N',Updated=TO_TIMESTAMP('2019-11-01 19:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8179
;

SELECT register_migration_script('201911011930_DisplaySQL_T_Report_Name_Column.sql') FROM dual
;
