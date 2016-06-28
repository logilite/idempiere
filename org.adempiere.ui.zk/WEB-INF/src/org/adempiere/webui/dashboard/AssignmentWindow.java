/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.dashboard;

import java.util.Properties;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.compiere.model.MResource;
import org.compiere.model.X_S_Resource;
import org.compiere.model.X_S_ResourceAssignment;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * 
 * @author Tomas Svikruha - based on Elaine
 * Show Resource Assignment
 *
 */
public class AssignmentWindow extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8188593824689379210L;
	private DatetimeBox dtBeginDate, dtEndDate;
	private Textbox txtDescription, txtName, resourceName;
	private ConfirmPanel confirmPanel;

	private int S_ResourceAssignment_ID = 0;

	public AssignmentWindow() {

		super();

		Properties ctx = Env.getCtx();
		setTitle(Msg.getElement(ctx, "S_ResourceAssignment_ID"));
		setAttribute(Window.MODE_KEY, Window.MODE_POPUP);
		setWidth("400px");
		setHeight("310px");
		this.setBorder("normal");
		this.setClosable(true);

		Label lblResource      	= new Label(Msg.getElement(ctx, X_S_Resource.COLUMNNAME_S_Resource_ID));
		Label lblName      		= new Label(Msg.getElement(ctx,X_S_ResourceAssignment.COLUMNNAME_Name));
		Label lblDescription    = new Label(Msg.getElement(ctx,X_S_ResourceAssignment.COLUMNNAME_Description));
		Label lblBeginDate   	= new Label(Msg.getElement(ctx,X_S_ResourceAssignment.COLUMNNAME_AssignDateFrom));
		Label lblEndDate      	= new Label(Msg.getElement(ctx,X_S_ResourceAssignment.COLUMNNAME_AssignDateTo));

		dtBeginDate = new DatetimeBox();
		dtBeginDate.setEnabled(false);

		dtEndDate = new DatetimeBox();
		dtEndDate.setEnabled(false);

		resourceName = new Textbox();
		resourceName.setWidth("95%");
		resourceName.setReadonly(true);

		txtName = new Textbox();
		txtName.setWidth("95%");
		txtName.setReadonly(true);

		txtDescription = new Textbox();
		txtDescription.setWidth("95%");
		txtDescription.setReadonly(true);

		confirmPanel = new ConfirmPanel(false, false, false, false, false, true);
		confirmPanel.addActionListener(this);


		Grid grid = GridFactory.newGridLayout();

		Columns columns = new Columns();
		grid.appendChild(columns);

		Column column = new Column();
		columns.appendChild(column);

		column = new Column();
		columns.appendChild(column);
		column.setWidth("250px");

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblResource.rightAlign());
		row.appendChild(resourceName);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblName.rightAlign());
		row.appendChild(txtName);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDescription.rightAlign());
		row.appendChild(txtDescription);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblBeginDate.rightAlign());
		row.appendChild(dtBeginDate);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEndDate.rightAlign());
		row.appendChild(dtEndDate);

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("min");

		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);

		northPane.appendChild(grid);
		grid.setVflex("1");
		grid.setHflex("1");

		South south = new South();
		borderlayout.appendChild(south);
		south.appendChild(confirmPanel);
	}

	public void setData(ADCalendarResourceAssignment event) {

		dtBeginDate.setValue(event.getBeginDate());
		dtEndDate.setValue(event.getEndDate());
		txtDescription.setText(event.getDescription());
		txtName.setText(event.getContent());

		S_ResourceAssignment_ID = event.getS_ResourceAssignment_ID();

		MResource resource = new MResource(Env.getCtx(), event.getS_Resource_ID(), null);
		resourceName.setText(resource.getName());

		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setEnabled(S_ResourceAssignment_ID > 0);
	}

	public void onEvent(Event e) throws Exception {
		if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
			setVisible(false);
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_ZOOM)) {
			if (S_ResourceAssignment_ID > 0){
				X_S_ResourceAssignment ra =  new X_S_ResourceAssignment(Env.getCtx(), S_ResourceAssignment_ID, null);
				AEnv.zoom(487, ra.getS_Resource_ID());
			}
		}
	}
}
