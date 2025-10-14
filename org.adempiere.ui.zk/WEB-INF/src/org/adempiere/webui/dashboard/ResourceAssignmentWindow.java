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

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

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
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MResourceAssignment;
import org.compiere.model.MRole;
import org.compiere.model.X_S_Resource;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * 
 * @author swiki - based on Elaine
 * Create new Resource Assignment from calendar
 *
 */
public class ResourceAssignmentWindow extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7757368164776005797L;

	private static CLogger log = CLogger.getCLogger(RequestWindow.class);

	/** Read Only				*/
	private boolean m_readOnly = false;

	private WTableDirEditor resourceField;
	private ConfirmPanel confirmPanel;

	private Textbox txtName, txtDescription;

	private Window parent;
	private Calendar calBegin,calEnd;
	private DatetimeBox dbxStartDate, dbxEndDate;

	public ResourceAssignmentWindow(CalendarsEvent ce, Window parent) {

		super();

		this.parent = parent;

		Properties ctx = Env.getCtx();
		setTitle(Msg.getElement(ctx, "S_ResourceAssignment_ID"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		ZKUpdateUtil.setWidth(this, "550px");
		ZKUpdateUtil.setHeight(this, "300px");
		this.setSclass("popup-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);

		m_readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), 
				MResourceAssignment.Table_ID, 0, false);

		Label lblResource      		= new Label(Msg.getElement(ctx, X_S_Resource.COLUMNNAME_S_Resource_ID));
		Label lblName       		= new Label(Msg.getElement(ctx, MResourceAssignment.COLUMNNAME_Name));
		Label lblDescription        = new Label(Msg.getElement(ctx, MResourceAssignment.COLUMNNAME_Description));
		Label lblStartDate          = new Label(Msg.getElement(ctx, MResourceAssignment.COLUMNNAME_AssignDateFrom));
		Label lblEndDate            = new Label(Msg.getElement(ctx, MResourceAssignment.COLUMNNAME_AssignDateTo));

		int columnID = MColumn.getColumn_ID(X_S_Resource.Table_Name, X_S_Resource.COLUMNNAME_S_Resource_ID);
		MLookup lookup = MLookupFactory.get(ctx, 0, 0, columnID, DisplayType.TableDir);
		resourceField = new WTableDirEditor(X_S_Resource.COLUMNNAME_S_Resource_ID, true, false, true, lookup);
		if(resourceField.getValue() == null || resourceField.getValue().equals(""))
			if(resourceField.getComponent().getItemCount() > 1)
				resourceField.setValue(resourceField.getComponent().getItemAtIndex(0).getValue());

		txtName = new Textbox();
		ZKUpdateUtil.setWidth(txtName, "95%");
		ZKUpdateUtil.setHeight(txtName, "100%");

		txtDescription = new Textbox();
		txtDescription.setMultiline(true);
		ZKUpdateUtil.setWidth(txtDescription, "95%");
		ZKUpdateUtil.setHeight(txtDescription, "100%");

		dbxStartDate = new DatetimeBox();
		dbxEndDate = new DatetimeBox();

		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);


		Grid grid = GridFactory.newGridLayout();

		Columns columns = new Columns();
		grid.appendChild(columns);

		Column column = new Column();
		columns.appendChild(column);

		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "450px");

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblResource.rightAlign());
		row.appendChild(resourceField.getComponent());

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblStartDate.rightAlign());
		row.appendChild(dbxStartDate);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblEndDate.rightAlign());
		row.appendChild(dbxEndDate);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblName.rightAlign());
		row.appendChild(txtName);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDescription.rightAlign());
		row.appendChild(txtDescription);

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "min");

		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);

		northPane.appendChild(grid);
		ZKUpdateUtil.setHflex(grid, "1");
		ZKUpdateUtil.setHeight(grid, "200px");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);

		dbxStartDate.getTimebox().setFormat(DPCalendar.getTimeFormat());
		dbxEndDate.getTimebox().setFormat(DPCalendar.getTimeFormat());

		dbxStartDate.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getStartTimeHour()));
		dbxEndDate.setValue(new Date(ce.getBeginDate().getTime() + DPCalendar.getEndTimeHour()));

	}

	public void onEvent(Event e) throws Exception {

		if (m_readOnly)
			this.detach();
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			// Check Mandatory fields
			int AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
			if (AD_Org_ID == 0){ 
				Dialog.error(0, Msg.parseTranslation(Env.getCtx(), "@Org0NotAllowed@"));
				return;
			}

			if (resourceField.getValue() == null || resourceField.getValue().equals(""))
				throw new WrongValueException(resourceField.getComponent(), 
						Msg.parseTranslation(Env.getCtx(), "@FillMandatory@ @"+X_S_Resource.COLUMNNAME_S_Resource_ID+"@"));

			else if (txtName.getText() == null || txtName.getText().equals(""))
				throw new WrongValueException(txtName, 
						Msg.parseTranslation(Env.getCtx(), "@FillMandatory@ @"+MResourceAssignment.COLUMNNAME_Name+"@"));

			else if (dbxStartDate.getValue() == null) 
				throw new WrongValueException(dbxEndDate, 
						Msg.parseTranslation(Env.getCtx(), "@FillMandatory@ @"+MResourceAssignment.COLUMNNAME_AssignDateFrom+"@"));

			else if (dbxEndDate.getValue() == null) 
				throw new WrongValueException(dbxEndDate, 
						Msg.parseTranslation(Env.getCtx(), "@FillMandatory@ @"+MResourceAssignment.COLUMNNAME_AssignDateTo+"@"));

			else if (checkTime()) 
				throw new WrongValueException(dbxStartDate, Msg.translate(Env.getCtx(), "CheckTime"));

			MResourceAssignment assignment =  new MResourceAssignment(Env.getCtx(), 0, null);
			assignment.setAD_Org_ID(AD_Org_ID);
			assignment.setS_Resource_ID((Integer) resourceField.getValue());
			assignment.setName(txtName.getText());
			assignment.setDescription(txtDescription.getText());
			assignment.setAssignDateFrom(new Timestamp(calBegin.getTimeInMillis()));
			assignment.setAssignDateTo(new Timestamp(calEnd.getTimeInMillis()));

			if (assignment.save())
			{
				if (log.isLoggable(Level.FINE)) log.fine("S_ResourceAssignment_ID=" + assignment.getS_ResourceAssignment_ID());
				Events.postEvent("onRefresh", parent, null);
			}
			else
			{
				Dialog.error(0, "RequestRecordNotSaved");
				return;
			}

			this.detach();
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
			this.detach();

	}

	//Check, Start time is not  >=  End time
	private boolean checkTime()
	{

		if(dbxEndDate.getValue() == null)
			return false;

		calBegin = Calendar.getInstance();
		calBegin.setTime(dbxStartDate.getValue());
		Calendar cal1 = Calendar.getInstance();
		cal1.setTimeInMillis(dbxStartDate.getValue().getTime());
		calBegin.set(Calendar.HOUR_OF_DAY, cal1.get(Calendar.HOUR_OF_DAY));
		calBegin.set(Calendar.MINUTE, cal1.get(Calendar.MINUTE));
		calBegin.set(Calendar.SECOND, 0);
		calBegin.set(Calendar.MILLISECOND, 0);

		calEnd = Calendar.getInstance();
		calEnd.setTime(dbxEndDate.getValue());
		Calendar cal2 = Calendar.getInstance();
		cal2.setTimeInMillis(dbxEndDate.getValue().getTime());
		calEnd.set(Calendar.HOUR_OF_DAY, cal2.get(Calendar.HOUR_OF_DAY));
		calEnd.set(Calendar.MINUTE, cal2.get(Calendar.MINUTE));
		calEnd.set(Calendar.SECOND, 0);
		calEnd.set(Calendar.MILLISECOND, 0);

		if (calBegin.compareTo(calEnd) >= 0) {
			return true;
		} else {
			return false;
		}

	}
}
