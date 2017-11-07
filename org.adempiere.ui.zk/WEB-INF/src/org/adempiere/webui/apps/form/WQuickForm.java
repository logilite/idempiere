/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.adempiere.webui.apps.form;

import java.util.ArrayList;
import java.util.Arrays;

import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.adwindow.QuickGridView;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

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
	private static final long		serialVersionUID		= -5095168843989540551L;

	public Trx						trx						= null;

	private Borderlayout			mainLayout				= new Borderlayout();
	private AbstractADWindowContent	abstractADWindowContent	= null;
	private QuickGridView			quickGridView			= null;
	private GridTab					gridTab;

	private ConfirmPanel			confirmPanel			= new ConfirmPanel(true, true, false, false, false, false);

	private Button					bDelete					= confirmPanel.createButton(ConfirmPanel.A_DELETE);
	private Button					bSave					= confirmPanel.createButton("Save");
	private Button					bIgnore					= confirmPanel.createButton("Ignore");

	private boolean					onlyCurrentRows			= false;

	private int						onlyCurrentDays			= 0;

	public WQuickForm(AbstractADWindowContent winContent, boolean m_onlyCurrentRows, int m_onlyCurrentDays)
	{
		super();

		abstractADWindowContent = winContent;
		onlyCurrentRows = m_onlyCurrentRows;
		onlyCurrentDays = m_onlyCurrentDays;

		this.gridTab = abstractADWindowContent.getADTab().getSelectedGridTab();
		this.quickGridView = new QuickGridView(abstractADWindowContent, gridTab);
		this.quickGridView.setVisible(true);

		initForm();
		gridTab.isQuickForm = true;
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
		south.appendChild(confirmPanel);
		ZkCssHelper.appendStyle(south, "height: 50px; padding-top: 9px; background: #9c9c9c;");

		bSave.setEnabled(!gridTab.isReadOnly());
		bDelete.setEnabled(!gridTab.isReadOnly());
		bIgnore.setEnabled(!gridTab.isReadOnly());

		bSave.addEventListener(Events.ON_CLICK, this);
		bDelete.addEventListener(Events.ON_CLICK, this);
		bIgnore.addEventListener(Events.ON_CLICK, this);

		confirmPanel.addComponentsLeft(bSave);
		confirmPanel.addComponentsLeft(bDelete);
		confirmPanel.addComponentsLeft(bIgnore);
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
		event.stopPropagation();
	}

	private void onIgnore()
	{
		quickGridView.setStatusLine("Changes rolled back", false, true);
		gridTab.dataIgnore();
		gridTab.dataRefreshAll();
		quickGridView.isNewLineSaved = true;
		if (gridTab.getRowCount() <= 0)
			quickGridView.createNewLine();
		quickGridView.updateListIndex();
	}

	private void onDelete()
	{
		if (gridTab == null)
			return;

		if (!quickGridView.isNewLineSaved)
		{
			quickGridView.setStatusLine("First, Save new record!", true, true);
			return;
		}

		final int[] indices = gridTab.getSelection();
		if (indices.length > 0)
		{
			StringBuilder sb = new StringBuilder();
			sb.append(Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "_WinInfo_WindowName", false)).append(" - ")
					.append(indices.length).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected"));

			gridTab.clearSelection();
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
			}
			gridTab.dataRefresh(true);
			quickGridView.setStatusLine(count + " Record(s) deleted.", false, true);

			// if all records is deleted then it will show default with new
			// record.
			if (gridTab.getRowCount() <= 0)
			{
				quickGridView.createNewLine();
			}
			quickGridView.updateListIndex();
		}
	}

	private void onSave(boolean isShowError)
	{
		ArrayList<Integer> rows = gridTab.getTableModel().getRowChangedQuickForm();
		if (rows.size() > 0)
		{
			quickGridView.dataSave(0);
		}

		quickGridView.setStatusLine("Saved", false, true);
		gridTab.dataRefreshAll();
	}

	private void onRefresh()
	{
		gridTab.dataRefreshAll();
		quickGridView.isNewLineSaved = true;
		quickGridView.updateListIndex();
	}

	@Override
	public void dispose()
	{
		super.dispose();

		gridTab.setQuickForm(false);
		onIgnore();
		quickGridView.dispose();
		abstractADWindowContent.getADTab().getSelectedTabpanel().query(onlyCurrentRows, onlyCurrentDays,
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
				quickGridView.setStatusLine("Cannot insert records on the tab.", true, true);
			}
		}
	}
}