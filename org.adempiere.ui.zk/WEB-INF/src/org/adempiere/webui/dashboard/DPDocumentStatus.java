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

package org.adempiere.webui.dashboard;

import java.sql.Timestamp;
import org.adempiere.webui.apps.BusyDialog;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.graph.WDocumentStatusPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ServerPushTemplate;
import org.adempiere.webui.util.ZkContextRunnable;
import org.compiere.util.DisplayType;
import org.compiere.Adempiere;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Image;
import org.zkoss.zul.Toolbar;

/**
 * Dashboard gadget for {@link WDocumentStatusPanel} 
 */
public class DPDocumentStatus extends DashboardPanel implements EventListener<Event> {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7904122964566112177L;
	private WDocumentStatusPanel statusPanel;
	private Label statusLabel;

	@Override
	public void refresh(ServerPushTemplate template) {
		
		final DPDocumentStatus documentStatus = this;
		// An Async task
		AEnv.executeAsyncDesktopTask(new Runnable() {
			@Override
			public void run() {
				statusPanel.refresh();
				template.executeAsync(documentStatus);
			}
		});
	}

	@Override
	public void updateUI() {
		statusPanel.updateUI();
		// show last run time
		String lastRunTime = DisplayType.getDateFormat(DisplayType.DateTime, Env.getLanguage(Env.getCtx()))
				.format(new Timestamp(System.currentTimeMillis()));
		statusLabel.setText(lastRunTime);
	}

	/**
	 * Default constructor
	 */
	public DPDocumentStatus()
	{
		super();

		statusPanel = WDocumentStatusPanel.get();
		if (statusPanel == null)
			return;
		this.appendChild(statusPanel);

		Toolbar documentStatusToolbar = new Toolbar();
		this.appendChild(documentStatusToolbar);
		
		if (ThemeManager.isUseFontIconForImage())
		{
			ToolBarButton btn = new ToolBarButton();
			btn.setIconSclass("z-icon-Refresh");
			btn.setSclass("trash-toolbarbutton");
			documentStatusToolbar.appendChild(btn);
			btn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			btn.addEventListener(Events.ON_CLICK, this);
		}
		else
		{
			Image imgr = new Image(ThemeManager.getThemeResource("images/Refresh24.png"));
			documentStatusToolbar.appendChild(imgr);
			imgr.setStyle("text-align: right; cursor: pointer; width:24px; height:24px;");
			imgr.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
			imgr.addEventListener(Events.ON_CLICK, this);
		}
		
		statusLabel = new Label();
		documentStatusToolbar.appendChild(statusLabel);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		String eventName = event.getName();

		if (eventName.equals(Events.ON_CLICK)) {
    		BusyDialog busyDialog = new BusyDialog();
            busyDialog.setShadow(false);
            getParent().insertBefore(busyDialog, getParent().getFirstChild());
			ServerPushTemplate template = new ServerPushTemplate(getDesktop());
    		ZkContextRunnable cr = new ZkContextRunnable() {
    			@Override
				protected void doRun() {
    				refresh(template);
    				template.executeAsync(() -> {
    					busyDialog.detach();
    				});
    			}
    		};
    		Adempiere.getThreadPoolExecutor().submit(cr);
		}
	}	
	
	@Override
	public boolean isPooling() {
		return true;
	}

	@Override
	public boolean isLazy() {
		return true;
	}
}
