package org.adempiere.webui.dashboard;

import java.util.Properties;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.calendar.event.CalendarsEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;
import org.zkoss.zul.North;

/**
 * 
 * @author swiki
 *
 */
public class DecisionWindow extends Window implements EventListener<Event> 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1725213080027893200L;

	private Button requestBtn, activityBtn, resourceBtn;
	CalendarsEvent calendarsEvent;

	Window parent;

	/**
	 * Main Constructor
	 * @param ce
	 * @param parent
	 */
	public DecisionWindow(CalendarsEvent ce, Window parent) {

		super();

		this.parent = parent;

		Properties ctx = Env.getCtx();
		setTitle(Msg.getMsg(ctx, "CreateNew"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		setWidth("200px");
		this.setSclass("popup-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);
		this.calendarsEvent = ce;

		requestBtn = new Button(Msg.getMsg(ctx, "CreateNew2")); 
		requestBtn.addEventListener(Events.ON_CLICK, this);
		requestBtn.setWidth("170px");

		activityBtn = new Button(Msg.getMsg(ctx, "ActivityNew"));
		activityBtn.addEventListener(Events.ON_CLICK, this);
		activityBtn.setWidth("170px");

		resourceBtn = new Button(Msg.getMsg(ctx, "ResourceAssignemntNew"));
		resourceBtn.addEventListener(Events.ON_CLICK, this);
		resourceBtn.setWidth("170px");

		Grid grid = GridFactory.newGridLayout();

		Columns columns = new Columns();
		grid.appendChild(columns);

		Column column = new Column();
		columns.appendChild(column);

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(requestBtn);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(activityBtn);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(resourceBtn);

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("min");

		North northPane = new North();
		northPane.setSclass("dialog-content");
		northPane.setAutoscroll(true);
		borderlayout.appendChild(northPane);

		northPane.appendChild(grid);

	}

	@Override
	public void onEvent(Event event) throws Exception {

		String type = event.getName();

		if (type.equals(Events.ON_CLICK)) {
			if (event.getTarget() == requestBtn){
				RequestWindow requestWin = new RequestWindow(calendarsEvent, parent);
				SessionManager.getAppDesktop().showWindow(requestWin);
				setVisible(false);
				this.detach();
			}
			else if (event.getTarget() == activityBtn){
				ContactActivityWindow requestWin = new ContactActivityWindow(calendarsEvent, parent);
				SessionManager.getAppDesktop().showWindow(requestWin);
				setVisible(false);
				this.detach();
			}
			else if (event.getTarget() == resourceBtn){

				ResourceAssignmentWindow requestWin = new ResourceAssignmentWindow(calendarsEvent, parent);
				SessionManager.getAppDesktop().showWindow(requestWin);
				setVisible(false);
				this.detach();
			}
		}

	}

}
