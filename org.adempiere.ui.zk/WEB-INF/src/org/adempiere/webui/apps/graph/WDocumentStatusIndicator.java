/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Adaxa                                                             *
* - Ashley Ramdass                                                    *
* - Deepak Pansheriya                                                 *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.apps.graph;

import java.sql.Timestamp;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MDocumentStatus;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.print.MPrintColor;
import org.compiere.print.MPrintFont;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Image;
import org.zkoss.zul.Space;

/**
 * 	Document Status Indicator
 */
public class WDocumentStatusIndicator extends Panel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 794746556509546913L;

	/**
	 * 	Constructor
	 *	@param documentStatus
	 */
	public WDocumentStatusIndicator(MDocumentStatus documentStatus)
	{
		super();

		m_documentStatus = documentStatus;

		init();
		this.setSclass("activities-box");
		
		refresh();
		updateUI();
	}	//	WDocumentStatusIndicator

	private MDocumentStatus		m_documentStatus = null;
	private int statusCount;
	private Label statusLabel;
	private ToolBarButton btnHelp;
	private Image imgrHelp;
	private String helpTitle;
	private Label helpLabel;
	private Timestamp lastRunTime;
	private long queryTime;

	/**
	 * 	Get Document Status
	 *	@return Document Status
	 */
	public MDocumentStatus getDocumentStatus()
	{
		return m_documentStatus;
	}	//	getGoal

     /**
	 * 	Init Graph Display
	 */
	private void init()
	{
		Div div = new Div();
		appendChild(div);
		Label nameLabel = new Label();
		String label = m_documentStatus.get_Translation(MDocumentStatus.COLUMNNAME_Name);
		helpTitle = label + " Information";
		nameLabel.setText(label + ": ");
		String nameColorStyle = "";
		int Name_PrintColor_ID = m_documentStatus.getName_PrintColor_ID();
		if (Name_PrintColor_ID > 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), Name_PrintColor_ID);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			nameColorStyle = "color:#"+color+";";
		}
		int AD_PrintFont_ID = m_documentStatus.getName_PrintFont_ID();
		String nameFontStyle = "";
		if (AD_PrintFont_ID > 0) {
			MPrintFont printFont = MPrintFont.get(AD_PrintFont_ID);
			String family = printFont.getFont().getFamily();
			boolean bold = printFont.getFont().isBold();
			boolean italic = printFont.getFont().isItalic();
			int pointSize = printFont.getFont().getSize();
			nameFontStyle = "font-family:'"+family+"';font-weight:"+(bold ? "bold" : "normal")+";font-style:"+(italic ? "italic" : "normal")+";font-size:"+pointSize+"pt";
		}
		nameLabel.setStyle(nameColorStyle+nameFontStyle);
		div.appendChild(nameLabel);

		statusLabel = new Label();
		helpLabel = new Label();
		String numberColorStyle = "";
		int Number_PrintColor_ID = m_documentStatus.getNumber_PrintColor_ID();
		if (Number_PrintColor_ID > 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), Number_PrintColor_ID);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			numberColorStyle = "color:#"+color+";";
		}
		String numberFontStyle = "";
		int Number_PrintFont_ID = m_documentStatus.getNumber_PrintFont_ID();
		if (Number_PrintFont_ID > 0) {
			MPrintFont printFont = MPrintFont.get(Number_PrintFont_ID);
			String family = printFont.getFont().getFamily();
			boolean bold = printFont.getFont().isBold();
			boolean italic = printFont.getFont().isItalic();
			int pointSize = printFont.getFont().getSize();
			numberFontStyle = "font-family:'"+family+"';font-weight:"+(bold ? "bold" : "normal")+";font-style:"+(italic ? "italic" : "normal")+";font-size:"+pointSize+"pt;";
			int margin = pointSize;
			numberFontStyle += "margin-top:"+margin+"pt;"+"margin-bottom:"+margin+"pt;";
		}
		statusLabel.setStyle(numberColorStyle+numberFontStyle);
		div.appendChild(statusLabel);
		
		if (ThemeManager.isUseFontIconForImage()) {
			btnHelp = new ToolBarButton();
			btnHelp.setIconSclass("z-icon-Help");
			div.appendChild(btnHelp);
			btnHelp.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Help")));
			btnHelp.addEventListener(Events.ON_CLICK, this);
		} else {
			imgrHelp = new Image(ThemeManager.getThemeResource("images/Help16.png"));
			imgrHelp.setStyle("text-align: right; cursor: pointer; width:12px; height:12px;");
			div.appendChild(new Space());
			div.appendChild(imgrHelp);
			imgrHelp.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Help")));
			imgrHelp.addEventListener(Events.ON_CLICK, this);
		}

		this.addEventListener(Events.ON_CLICK, this);
	}


	public void onEvent(Event event) throws Exception {
		String eventName = event.getName();

		if (eventName.equals(Events.ON_CLICK)) {
			if (event.getTarget() == this) {
				int AD_Window_ID = m_documentStatus.getAD_Window_ID();
				int AD_Form_ID = m_documentStatus.getAD_Form_ID();
				if (AD_Window_ID > 0) {
					MQuery query = new MQuery(m_documentStatus.getAD_Table_ID());
					query.addRestriction(MDocumentStatus.getWhereClause(m_documentStatus));
					AEnv.zoom(AD_Window_ID, query);
				} else if (AD_Form_ID > 0) {
					ADForm form = ADForm.openForm(AD_Form_ID);

					form.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
					SessionManager.getAppDesktop().showWindow(form);
				}
			} else if (event.getTarget() == btnHelp || event.getTarget() == imgrHelp) {
				FDialog.info(0, this, helpLabel.getValue());
			}
		}
	}
		
	public void refresh() {
		lastRunTime = new Timestamp(System.currentTimeMillis());
		statusCount = MDocumentStatus.evaluate(m_documentStatus);
		long currenutTime = new Timestamp(System.currentTimeMillis()).getTime();
		queryTime = currenutTime - lastRunTime.getTime();
	}

	public void updateUI() {
		statusLabel.setText(Integer.toString(statusCount));

		// default 500 milliseconds
		int interval = MSysConfig.getIntValue(MSysConfig.ZK_DASHBOARD_SLOW_QUERY_TIME_INTERVAL, 500,
				Env.getAD_Client_ID(Env.getCtx()));

		if (queryTime > interval) {
			if (ThemeManager.isUseFontIconForImage())
				btnHelp.setVisible(true);
			else
				imgrHelp.setVisible(true);
			
			String runTime = DisplayType.getDateFormat(DisplayType.DateTime, Env.getLanguage(Env.getCtx()))
					.format(lastRunTime);
			helpLabel.setText("<b>" + helpTitle + "</b> \n\n Records Count : " + statusCount + "\n Last Run Time : "
					+ runTime + "\n Last Query Run Time : " + queryTime + " ms");

		} else {
			if (ThemeManager.isUseFontIconForImage())
				btnHelp.setVisible(false);
			else
				imgrHelp.setVisible(false);
		}
	}

}
