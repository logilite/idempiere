-- Merging correction for V11 script

SELECT register_migration_script('202401122000_Merging_Correction_V11.sql') FROM dual
;


DROP VIEW IF EXISTS ad_field_v;
DROP VIEW IF EXISTS adempiere.ad_field_vt;


CREATE OR REPLACE VIEW ad_field_v
 AS
 SELECT t.ad_window_id,
    f.ad_tab_id,
    f.ad_field_id,
    tbl.ad_table_id,
    f.ad_column_id,
    f.name,
    f.description,
    f.help,
    f.isdisplayed,
    f.displaylogic,
    f.displaylength,
    f.seqno,
    f.sortno,
    f.issameline,
    f.isheading,
    f.isfieldonly,
    f.isreadonly,
    f.isencrypted AS isencryptedfield,
    f.obscuretype,
    c.columnname,
    NVL(f.columnsql, c.columnsql) AS columnsql,
    c.fieldlength,
    NVL(f.vformat, c.vformat) AS vformat,
    NVL(f.defaultvalue, c.defaultvalue) AS defaultvalue,
    c.iskey,
    c.isparent,
    NVL(f.ismandatory, c.ismandatory) AS ismandatory,
    c.isidentifier,
    c.istranslated,
    NVL(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
    c.callout,
    NVL(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id,
    NVL(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id,
    c.ad_process_id,
    NVL(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable,
    NVL(f.readonlylogic, c.readonlylogic) AS readonlylogic,
    NVL(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic,
    NVL(f.isupdateable, c.isupdateable) AS isupdateable,
    c.isencrypted AS isencryptedcolumn,
    NVL(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn,
    tbl.tablename,
    c.valuemin,
    c.valuemax,
    fg.name AS fieldgroup,
    vr.code AS validationcode,
    f.included_tab_id,
    fg.fieldgrouptype,
    fg.iscollapsedbydefault,
    NVL(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass,
    c.isautocomplete,
    NVL(f.isallowcopy, c.isallowcopy) AS isallowcopy,
    f.isdisplayedgrid,
    f.seqnogrid,
    c.seqnoselection,
    f.xposition,
    f.columnspan,
    f.numlines,
    NVL(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton,
    c.formatpattern,
    f.isadvancedfield,
    f.isdefaultfocus,
    NVL(f.ad_chart_id, c.ad_chart_id) AS ad_chart_id,
    f.ad_labelstyle_id,
    f.ad_fieldstyle_id,
    c.pa_dashboardcontent_id,
    NVL(f.placeholder, c.placeholder) AS placeholder,
    c.ishtml,
    f.isquickform,
    NVL(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS ad_val_rule_lookup_id,
    vrf.code AS validationcodelookup,
    f.entitytype,
    NVL(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic,
    c.ad_infowindow_id
   FROM ad_field f
     JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
     LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
     LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
     JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
     LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = NVL(f.ad_val_rule_id, c.ad_val_rule_id)
     LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = NVL(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;


CREATE OR REPLACE VIEW adempiere.ad_field_vt
 AS
 SELECT trl.ad_language,
    t.ad_window_id,
    f.ad_tab_id,
    f.ad_field_id,
    tbl.ad_table_id,
    f.ad_column_id,
    trl.name,
    trl.description,
    trl.help,
    f.isdisplayed,
    f.displaylogic,
    f.displaylength,
    f.seqno,
    f.sortno,
    f.issameline,
    f.isheading,
    f.isfieldonly,
    f.isreadonly,
    f.isencrypted AS isencryptedfield,
    f.obscuretype,
    c.columnname,
    NVL(f.columnsql, c.columnsql) AS columnsql,
    c.fieldlength,
    NVL(f.vformat, c.vformat) AS vformat,
    NVL(f.defaultvalue, c.defaultvalue) AS defaultvalue,
    c.iskey,
    c.isparent,
    NVL(f.ismandatory, c.ismandatory) AS ismandatory,
    c.isidentifier,
    c.istranslated,
    NVL(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id,
    c.callout,
    NVL(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id,
    NVL(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id,
    c.ad_process_id,
    NVL(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable,
    NVL(f.readonlylogic, c.readonlylogic) AS readonlylogic,
    NVL(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic,
    NVL(f.isupdateable, c.isupdateable) AS isupdateable,
    c.isencrypted AS isencryptedcolumn,
    NVL(f.isselectioncolumn, c.isselectioncolumn) AS isselectioncolumn,
    tbl.tablename,
    c.valuemin,
    c.valuemax,
    fgt.name AS fieldgroup,
    vr.code AS validationcode,
    f.included_tab_id,
    fg.fieldgrouptype,
    fg.iscollapsedbydefault,
    NVL(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass,
    c.isautocomplete,
    NVL(f.isallowcopy, c.isallowcopy) AS isallowcopy,
    f.isdisplayedgrid,
    f.seqnogrid,
    c.seqnoselection,
    f.xposition,
    f.columnspan,
    f.numlines,
    NVL(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton,
    c.formatpattern,
    f.isadvancedfield,
    f.isdefaultfocus,
    NVL(f.ad_chart_id, c.ad_chart_id) AS ad_chart_id,
    f.ad_labelstyle_id,
    f.ad_fieldstyle_id,
    c.pa_dashboardcontent_id,
    NVL(trl.placeholder, ct.placeholder) AS placeholder,
    c.ishtml,
    f.isquickform,
    NVL(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id) AS ad_val_rule_lookup_id,
    vrf.code AS validationcodelookup,
    f.entitytype,
    NVL(f.alwaysupdatablelogic, c.alwaysupdatablelogic) AS alwaysupdatablelogic,
    c.ad_infowindow_id
   FROM ad_field f
     JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
     JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
     LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
     LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
     LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
     LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id AND trl.ad_language = ct.ad_language
     JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
     LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = NVL(f.ad_val_rule_id, c.ad_val_rule_id)
     LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = NVL(f.ad_val_rule_lookup_id, c.ad_val_rule_lookup_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;
