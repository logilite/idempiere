-- IDEMPIERE-5861  Tab specific readonly logic and display logic for toolbar button
SELECT register_migration_script('202606181638_IDEMPIERE-5861.sql') FROM dual;

-- 18/06/2026 17:16:16 IST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='IsExclude', IsMandatory='Y', AD_Reference_Value_ID=NULL, IsUpdateable='Y', AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2026-06-18 17:16:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200811
;

-- 18/06/2026 17:16:17 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217634,0,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200004,'ReadOnlyLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-06-18 17:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-18 17:16:16','YYYY-MM-DD HH24:MI:SS'),100,1663,'Y','N','D','Y','N','N','Y','d1698106-7892-4eda-88bc-3b88c7d61ed8','Y',0,'N','N','N','N')
;

-- 18/06/2026 17:16:17 IST
ALTER TABLE AD_ToolBarButtonRestrict ADD COLUMN ReadOnlyLogic VARCHAR(2000) DEFAULT NULL 
;

-- 18/06/2026 17:16:18 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217635,0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200004,'DisplayLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-06-18 17:16:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-18 17:16:17','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','Y','N','N','Y','2f0a4f7d-7da3-4ed3-abd8-8e97e92a5b4f','Y',0,'N','N','N','N')
;

-- 18/06/2026 17:16:18 IST
ALTER TABLE AD_ToolBarButtonRestrict ADD COLUMN DisplayLogic VARCHAR(2000) DEFAULT NULL 
;

-- 18/06/2026 17:16:18 IST
UPDATE AD_Field SET IsReadOnly='N', AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, ReadOnlyLogic='@AD_Client_ID@>0', AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2026-06-18 17:16:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200730
;

-- 18/06/2026 17:16:18 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (209224,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200003,217634,'Y','@AD_Client_ID@=0',2000,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-18 17:16:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-18 17:16:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a371d8d-7b9a-4df0-94d8-8aa93b53029c','Y',100,1,5,3,'N','N','N','N')
;

-- 18/06/2026 17:16:20 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (209225,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200003,217635,'Y','@AD_Client_ID@=0',2000,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-18 17:16:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-18 17:16:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af8bc53d-1454-4b4a-940f-729fa743f7ca','Y',110,1,5,3,'N','N','N','N')
;

