-- IDEMPIERE-6460  On workflow, Allowing to set multiple variables on User choice, set variable and user task type node
SELECT register_migration_script('202511241656_IDEMPIERE-6460.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 24/11/2025 16:56:42 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217170,0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)',200430,'DisplayLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-11-24 16:56:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-24 16:56:41','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','N','N','Y','24c7c46a-4974-4aba-80fa-7ecaae9af118','Y',0,'N','N','N','N','N','N')
;

-- 24/11/2025 16:56:45 IST
ALTER TABLE AD_WF_Node_Var ADD DisplayLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- 24/11/2025 16:57:03 IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsDisableZoomAcross,IsPartitionKey) VALUES (217171,0,'Mandatory Logic',200430,'MandatoryLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2025-11-24 16:57:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-24 16:57:02','YYYY-MM-DD HH24:MI:SS'),100,50074,'Y','N','D','N','N','N','Y','13ac215f-1e90-412a-a869-77bd9e5966d9','Y',0,'N','N','N','N','N')
;

-- 24/11/2025 16:57:04 IST
ALTER TABLE AD_WF_Node_Var ADD MandatoryLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- 24/11/2025 17:02:31 IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208977,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
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
Strings may be in single quotes (optional)',200393,217170,'Y',2000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-11-24 17:02:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-24 17:02:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4478117c-56f5-4414-95cb-ba151e041f25','Y',80,5,3)
;

-- 24/11/2025 17:02:31 IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208978,'Mandatory Logic',200393,217171,'Y',2000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-11-24 17:02:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-24 17:02:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bdc10281-e85a-41a6-a34e-14b611d08fb9','Y',90,5,3)
;

-- 24/11/2025 17:03:22 IST
UPDATE AD_Field SET DisplayLogic='@AttributeValue@=''''',Updated=TO_TIMESTAMP('2025-11-24 17:03:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208977
;

-- 24/11/2025 17:03:30 IST
UPDATE AD_Field SET DisplayLogic='@AttributeValue@=''''',Updated=TO_TIMESTAMP('2025-11-24 17:03:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208978
;

-- 27-Nov-2025, 7:18:21 pm IST
UPDATE AD_Tab SET DisplayLogic='@Action@=C|@Action@=V|@Action@=U|@Action@=Z',Updated=TO_TIMESTAMP('2025-11-27 19:18:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200393
;

-- 28-Nov-2025, 12:34:48 pm IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Workflow Node Variable',0,0,'Y',TO_TIMESTAMP('2025-11-28 12:34:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-28 12:34:47','YYYY-MM-DD HH24:MI:SS'),100,200986,'WFNodeVariable','D','e632e285-26c5-4c3b-9c2d-73fd9bb3169e')
;
