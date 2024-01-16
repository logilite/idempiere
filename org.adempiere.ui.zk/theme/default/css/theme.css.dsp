<%@ page contentType="text/css;charset=UTF-8" %>
<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>

html,body {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
	background-color: #D4E3F4;
	color: #333;
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
	overflow: hidden;
}

.z-html p{
	margin:0px;
}

[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
    font-size: 14px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
}

<%-- Mobile/Tablet --%>
.tablet-scrolling {
	-webkit-overflow-scrolling: touch;
}
.mobile [class*="z-"] {
    font-size: 16px;
}

<%-- vbox fix for firefox and ie --%>
table.z-vbox > tbody > tr > td > table {
	width: 100%;	
}

<%-- workflow activity --%>
.workflow-activity-form {
}
.workflow-panel-table {
	border: 0px;
}

<%-- payment form --%>
.payment-form-content {
}

<c:include page="fragment/login.css.dsp" />

<c:include page="fragment/desktop.css.dsp" />

<c:include page="fragment/application-menu.css.dsp" />

<c:include page="fragment/gadget.css.dsp" />

<c:include page="fragment/toolbar.css.dsp" />

<c:include page="fragment/button.css.dsp" />

<c:include page="fragment/adwindow.css.dsp" />
			
<c:include page="fragment/grid.css.dsp" />

<c:include page="fragment/input-element.css.dsp" />

<c:include page="fragment/tree.css.dsp" /> 

<c:include page="fragment/field-editor.css.dsp" />

<c:include page="fragment/group.css.dsp" />

<c:include page="fragment/tab.css.dsp" />

<c:include page="fragment/menu-tree.css.dsp" />

<c:include page="fragment/info-window.css.dsp" />

<c:include page="fragment/window.css.dsp" />

<c:include page="fragment/form.css.dsp" />

<c:include page="fragment/toolbar-popup.css.dsp" />	

<c:include page="fragment/setup-wizard.css.dsp" />

<c:include page="fragment/about.css.dsp" />

<c:include page="fragment/tab-editor.css.dsp" />

<c:include page="fragment/find-window.css.dsp" />

<c:include page="fragment/help-window.css.dsp" />

<c:include page="fragment/borderlayout.css.dsp" />

<c:include page="fragment/parameter-process.css.dsp" />

<c:include page="fragment/window-size.css.dsp" />

<c:include page="fragment/font-icons.css.dsp" />

<c:include page="fragment/printformat.css.dsp" />

<c:include page="fragment/gadget-kpi.css.dsp" />

<c:if test="${u:isThemeHasCustomCSSFragment()}">
    <c:include page="fragment/custom.css.dsp" />
</c:if>

<%-- Multi Select List & Table Editor Start --%>

.multi-select-box {
}

.multi-select-popup {
  background: #f5f5f5;
  border: solid 1px #828282;
  border-radius: 5px;
  max-height: 350px;
  min-width: 250px;
  overflow: auto;
}

.multi-select-vbox {
  background: white;
  border-radius: 5px;
  padding: 5px;
}

.multi-select-all-btn {
 width: 100%;
 height: 30px;
}

.multi-select-textbox {
  background-color: white !important;
}

.multi-select-textbox-readonly {
  background-color: #F0F0F0 !important;
}

<%-- Multi Select List & Table Editor End --%>

<%-- Attachment by Drag & Drop Start --%>

.drop-btn-holder {
	background: #eee;
    border: 5px dashed #ccc;
    width: 99%;
    min-height: 100px;
    margin: 1px 1px !important;
}

.drop-btn-holder:hover {
    border: 5px dashed #2184ba;
}

.attachment-drag-entered {
    border: 5px dashed #3fb900;
}

.drop-progress-meter
{
	width:100% !important;
}

.z-progressmeter-image {
	background: linear-gradient(to bottom, #1eff00 0%, #1a6b18 100%);
}

<%-- Attachment by Drag & Drop End --%>

input[type="checkbox"]:focus
{
 	 outline: #0000ff auto 1px;
	-moz-outline-radius: 3px;
}

<%-- Quick Form Read-only Component --%>
.quickform-readonly .z-textbox-readonly, .quickform-readonly .z-intbox-readonly, .quickform-readonly .z-longbox-readonly, .quickform-readonly .z-doublebox-readonly,
.quickform-readonly .z-decimalbox-readonly, .quickform-readonly .z-datebox-readonly, .quickform-readonly .z-timebox-readonly, .quickform-readonly .editor-input-disd,
.quickform-readonly .z-textbox[readonly], .quickform-readonly .z-intbox[readonly], .quickform-readonly .z-longbox[readonly], .quickform-readonly .z-doublebox[readonly],
.quickform-readonly .z-decimalbox[readonly], .quickform-readonly .z-datebox[readonly], .quickform-readonly .z-timebox[readonly]
{
    color: #252525 !important;
    opacity: .8;
}

<%-- Included Tab --%>

.adtab-grid-panel {
	position: absolute;
	overflow: hidden;
	width: 100%;
	height: 100%;
}