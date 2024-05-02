package org.adempiere.webui.apps.wf;

import java.util.Date;

import org.adempiere.base.IWFActivityForwardDlg;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

public class WFApproverWindow extends Window implements EventListener<Event>,IWFActivityForwardDlg
{

	/**
	 * 
	 */
	private static final long	serialVersionUID	= -2983051917422902361L;

	/** Window No */
	private int					m_WindowNo			= 0;

	private static final String MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; overflow: auto; min-width: 230pt; max-width: 450pt;";	
	private static final String SMALLER_MESSAGE_PANEL_STYLE = "text-align:left; word-break: break-all; max-height: 350pt; min-width: 180pt; ";
	
	private WSearchEditor		fApprover			= null;
	private Label				lblAssignTo;
	private Label lTextMsg = new Label(Msg.getMsg(Env.getCtx(), "Messages:"));
	private Textbox fTextMsg = new Textbox();
	
	private ConfirmPanel		confirmPanel;

	private int					m_AD_User_ID		= 0;
	private boolean isCancelled = false;

	public WFApproverWindow()
	{
		
	}

	public void init()
	{

		// Set window properties
		this.setWidth("40%");
		this.setHeight("30%");
		this.setTitle("Approver WIndow");
		this.setBorder("normal");
		this.setClosable(true);
		this.setStyle("position: absolute;");
		this.setSclass("popup-dialog");
		this.setClosable(false);

		// Set widget attribute
		setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "Approver Dialog");

				
		Panel pnlApprover = new Panel();
		if (ClientInfo.maxWidth(399))
		{
			pnlApprover.setStyle(SMALLER_MESSAGE_PANEL_STYLE);
			this.setWidth("100%");
		}
		else
			pnlApprover.setStyle(MESSAGE_PANEL_STYLE);
		
		// Create Borderlayout for the main layout
		Borderlayout borderlayout = new Borderlayout();
		borderlayout.setParent(this);
		

		
		Panel pnlMessage = new Panel();
		if (ClientInfo.maxWidth(399))
		{
			pnlMessage.setStyle(SMALLER_MESSAGE_PANEL_STYLE);
			this.setWidth("100%");
		}
		else
			pnlMessage.setStyle(MESSAGE_PANEL_STYLE);
		
		
		// Create label for the approver field
		lblAssignTo = new Label("Assign To: ");
		ZKUpdateUtil.setWidth(lblAssignTo, "30%");

		// Create search editor for selecting the approver. Use User columns of workflow responsible
		MLookup lookup = MLookupFactory.get(Env.getCtx(), m_WindowNo, 0, 10443, DisplayType.Search);
		fApprover = new WSearchEditor(lookup, Msg.translate(Env.getCtx(), "AD_User_ID"), "", true, false, true);
		fApprover.setVisible(true);
		ZKUpdateUtil.setWidth(fApprover.getComponent(), "70%");
		
		// Create a div to hold the label and search editor
		pnlApprover.appendChild(lblAssignTo);
		pnlApprover.appendChild(fApprover.getComponent());
		ZKUpdateUtil.setWidth(lTextMsg, "30%");
		ZKUpdateUtil.setWidth(fTextMsg, "80%");
		pnlMessage.appendChild(lTextMsg);
		pnlMessage.appendChild(fTextMsg);
		
		Vlayout  vbox = new Vlayout();
		vbox.setStyle("overflow:auto");
		borderlayout.appendNorth(vbox);
		vbox.appendChild(new Space());
		vbox.appendChild(pnlApprover);
		vbox.appendChild(pnlMessage);
		
		
		// Create confirm panel for actions
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		ZKUpdateUtil.setVflex(confirmPanel, "true");

		// Create a div for the footer
		Div footer = new Div();
		footer.setSclass("dialog-footer");
		footer.appendChild(confirmPanel);

		// Append the footer to the south region of the layout
		borderlayout.appendSouth(footer);
		ZKUpdateUtil.setVflex(confirmPanel, "min");

		// Show the window centered on the screen
		final WFApproverWindow win = this;
		win.setAttribute(Window.MODE_KEY, Window.MODE_MODAL);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (Events.ON_CLICK.equals(event.getName()))
		{
			if (confirmPanel.getButton("Ok").equals(event.getTarget()))
			{
				int userId = (int) fApprover.getValue();
				setAD_User_ID(userId);
				this.detach();
			}
			else if (confirmPanel.getButton("Cancel").equals(event.getTarget()))
			{
				isCancelled = true;
				this.detach();
			}
		}
	}

	public int getAD_User_ID()
	{
		return m_AD_User_ID;
	}

	public void setAD_User_ID(int AD_User_ID)
	{
		m_AD_User_ID = AD_User_ID;
	}
	
	public boolean isCancelled() {
		return isCancelled;
	}
	
	@Override
	public void AskApprover()
	{
		WFApproverWindow win = this;
		
		AEnv.executeAsyncDesktopTask((new Runnable() {
			@Override
			public void run()
			{
				init();
				setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				AEnv.showCenterScreen(win);
			}
		}));
	}
	
	@Override
	public int getActivityApprover()
	{	
		try
		{
			long time = new Date().getTime();
			while (m_AD_User_ID <= 0 && !isCancelled)
			{
				Thread.sleep(500);
				if((new Date().getTime()-time)>300000) {
					this.detach();
					break;
				}
			}
			if(isCancelled) {
				m_AD_User_ID=-1;
			}
		}catch (InterruptedException e) {
		}
		
		return m_AD_User_ID;
	}
	
	@Override
	public String getMsg()
	{
		
		return fTextMsg.getValue();
	}

}
