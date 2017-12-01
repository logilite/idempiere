/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP * This program is free software;
 * you can redistribute it and/or modify it * under the terms version 2 of the
 * GNU General Public License as published * by the Free Software Foundation.
 * This program is distributed in the hope * that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied * warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. * See the GNU General Public License for
 * more details. * You should have received a copy of the GNU General Public
 * License along * with this program; if not, write to the Free Software
 * Foundation, Inc., * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA. *
 *****************************************************************************/

package org.adempiere.webui.apps.form;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.adwindow.QuickGridView;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.CustomizeGridViewDialog;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkforge.keylistener.Keylistener;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Column;
import org.zkoss.zul.Columns;

/**
 * Quick entry form
 * 
 * @author Logilite Technologies
 * @since Nov 03, 2017
 */
public class WQuickForm extends Window implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long		serialVersionUID	= -5095168843989540551L;

	public Trx						trx					= null;

	private Borderlayout			mainLayout			= new Borderlayout();
	private AbstractADWindowContent	adWinContent		= null;
	private QuickGridView			quickGridView		= null;
	private GridTab					gridTab;

	private ConfirmPanel			confirmPanel		= new ConfirmPanel(true, true, false, false, false, false);

	private Button					bDelete				= confirmPanel.createButton(ConfirmPanel.A_DELETE);
	private Button					bSave				= confirmPanel.createButton("Save");
	private Button					bIgnore				= confirmPanel.createButton("Ignore");
	private Button					bCustomize			= confirmPanel.createButton("Customize");

	private boolean					onlyCurrentRows		= false;

	private int						onlyCurrentDays		= 0;

	QuickGridView					prevQGV				= null;

	public WQuickForm(AbstractADWindowContent winContent, boolean m_onlyCurrentRows, int m_onlyCurrentDays)
	{
		super();

		adWinContent = winContent;
		onlyCurrentRows = m_onlyCurrentRows;
		onlyCurrentDays = m_onlyCurrentDays;
		this.gridTab = adWinContent.getADTab().getSelectedGridTab();
		this.quickGridView = new QuickGridView(adWinContent, gridTab, this);
		this.quickGridView.setVisible(true);
		initForm();
		gridTab.isQuickForm = true;

		// To maintain parent-child Quick Form
		prevQGV = adWinContent.getCurrQGV();
		adWinContent.setCurrQGV(quickGridView);
	}

	protected void initForm()
	{
		initZk();
		createNewRow();
		quickGridView.refresh(gridTab);
	}

	private void initZk()
	{
		// Center
		Panel Center = new Panel();
		Center.appendChild(quickGridView);
		ZkCssHelper.appendStyle(Center, "border: none; width: 100%; height:99%; background: gainsboro;");

		// South
		Panel south = new Panel();

		// Adding statusBar for Quick Form
		south.appendChild(adWinContent.getStatusBarQF());
		ZkCssHelper.appendStyle(adWinContent.getStatusBarQF(), "height: 20px; padding-bottom: 3px background: white");
		south.appendChild(confirmPanel);
		ZkCssHelper.appendStyle(confirmPanel, "height: 50px; padding-top: 9px; background: #9c9c9c;");

		bSave.setEnabled(!gridTab.isReadOnly());
		bDelete.setEnabled(!gridTab.isReadOnly());
		bIgnore.setEnabled(!gridTab.isReadOnly());

		bSave.addEventListener(Events.ON_CLICK, this);
		bDelete.addEventListener(Events.ON_CLICK, this);
		bIgnore.addEventListener(Events.ON_CLICK, this);
		bCustomize.addEventListener(Events.ON_CLICK, this);

		confirmPanel.addComponentsLeft(bSave);
		confirmPanel.addComponentsLeft(bDelete);
		confirmPanel.addComponentsLeft(bIgnore);
		confirmPanel.addComponentsLeft(bCustomize);
		confirmPanel.addActionListener(this);

		mainLayout.appendCenter(Center);
		mainLayout.appendSouth(south);

		this.appendChild(mainLayout);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
		{
			dispose();
		}
		else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_REFRESH))
		{
			quickGridView.getRenderer().setCurrentCell(null);
			onRefresh();
		}
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
		{
			onSave(true);
			dispose();
		}
		else if (event.getTarget() == confirmPanel.getButton("Save"))
		{
			quickGridView.getRenderer().setCurrentCell(null);
			onSave(true);
		}
		else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_DELETE))
		{
			quickGridView.getRenderer().setCurrentCell(null);
			onDelete();
		}
		else if (event.getTarget() == confirmPanel.getButton("Ignore"))
		{
			quickGridView.getRenderer().setCurrentCell(null);
			onIgnore();
		}
		else if (event.getTarget() == confirmPanel.getButton("Customize"))
		{
			onCustomize();
		}
		event.stopPropagation();
	}

	public void onCustomize()
	{
		Columns columns = quickGridView.getListbox().getColumns();
		List<Component> columnList = columns.getChildren();
		GridField[] fields = quickGridView.getGridField();
		Map<Integer, String> columnsWidth = new HashMap<Integer, String>();
		ArrayList<Integer> gridFieldIds = new ArrayList<Integer>();

		for (int i = 0; i < fields.length; i++)
		{
			Column column = (Column) columnList.get(i + 1);
			String width = column.getWidth();
			columnsWidth.put(fields[i].getAD_Field_ID(), width);
			gridFieldIds.add(fields[i].getAD_Field_ID());
		}

		quickGridView.setWidth(getWidth());
		quickGridView.setHeight(getHeight());

		CustomizeGridViewDialog.showCustomize(0, gridTab.getAD_Tab_ID(), columnsWidth, gridFieldIds, null,
				quickGridView, true);
	}

	public void onIgnore()
	{
		gridTab.dataIgnore();
		gridTab.dataRefreshAll();
		adWinContent.getStatusBarQF().setStatusLine(Msg.getMsg(Env.getCtx(), "Ignored"), false);
		quickGridView.isNewLineSaved = true;
		if (gridTab.getRowCount() <= 0)
			quickGridView.createNewLine();
		quickGridView.updateListIndex();
		Events.echoEvent("onSetFocusToFirstCell", quickGridView, null);
	}

	public void onDelete()
	{
		if (gridTab == null)
			return;
		final int[] indices = gridTab.getSelection();
		if (indices.length > 0)
		{
			quickGridView.isNewLineSaved = true;
			StringBuilder sb = new StringBuilder();
			sb.append(Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "_WinInfo_WindowName", false)).append(" - ")
					.append(indices.length).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected"));

			gridTab.clearSelection();
			quickGridView.toggleSelectionForAll(false);
			Arrays.sort(indices);
			int offset = 0;
			int count = 0;
			for (int i = 0; i < indices.length; i++)
			{
				gridTab.navigate(indices[i] - offset);
				if (gridTab.dataDelete())
				{
					offset++;
					count++;
				}
				else
				{
					break;
				}
			}
			if (count == indices.length)
				adWinContent.getStatusBarQF().setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted") + ": " + count, false);

			// if all records is deleted then it will show default with new
			// record.
			if (gridTab.getRowCount() <= 0)
			{
				quickGridView.createNewLine();
			}
			quickGridView.updateListIndex();
		}
		Events.echoEvent("onSetFocusToFirstCell", quickGridView, null);
	}

	public void onSave(boolean isShowError)
	{
		if (quickGridView.dataSave(0))
		{
			gridTab.dataRefreshAll();
			adWinContent.getStatusBarQF().setStatusLine(Msg.getMsg(Env.getCtx(), "Saved"), false);
		}
		Events.echoEvent("onSetFocusToFirstCell", quickGridView, null);
	}

	public void onRefresh()
	{
		gridTab.dataRefreshAll();
		adWinContent.getStatusBarQF().setStatusLine(Msg.getMsg(Env.getCtx(), "Refresh"), false);
		quickGridView.isNewLineSaved = true;
		quickGridView.updateListIndex();
		Events.echoEvent("onSetFocusToFirstCell", quickGridView, null);
	}

	@Override
	public void dispose()
	{
		super.dispose();

		gridTab.setQuickForm(false);
		onIgnore();
		SessionManager.closeQuickFormTab(gridTab.getAD_Tab_ID());
		int tabLevel = adWinContent.getToolbar().getQuickFormTabHrchyLevel();
		if (tabLevel > 0)
		{
			adWinContent.getToolbar().setQuickFormTabHrchyLevel(tabLevel - 1);
			Keylistener keyListener = SessionManager.getSessionApplication().getKeylistener();
			keyListener.setCtrlKeys(keyListener.getCtrlKeys() + QuickGridView.CNTRL_KEYS);

			// Add Key-listener of parent Quick Form
			if (prevQGV != null)
			{
				adWinContent.onParentRecord();
				SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, prevQGV);
				// TODO need to set focus on last focused row of parent Form.
				Events.echoEvent("onPageNavigate", prevQGV, null);
			}
			adWinContent.setCurrQGV(prevQGV);
		}
		else
		{
			adWinContent.setCurrQGV(null);
		}
		adWinContent.getADTab().getSelectedTabpanel().query(onlyCurrentRows, onlyCurrentDays,
				MRole.getDefault().getMaxQueryRecords()); // autoSize
	}

	private void createNewRow()
	{
		int row = gridTab.getRowCount();
		if (row <= 0)
		{
			gridTab.dataIgnore();
			if (gridTab.isInsertRecord())
			{
				quickGridView.createNewLine();
			}
			else
			{
				adWinContent.getStatusBarQF().setStatusLine(Msg.getMsg(Env.getCtx(), "NewError"), true);
			}
		}
	}
}