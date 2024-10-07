package org.adempiere.webui.apps;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WYesNoEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MPrintFormatAccess;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

public class WSharePrintFormatForm extends Window implements EventListener<Event>, ValueChangeListener
{
	/**
	 * 
	 */
	private static final long	serialVersionUID	= 2097308568652511400L;

	private Label				lblUser;
	private Label				lblRole;
	private Label				lblReadWrite;

	private WEditor				eUser;
	private WEditor				eRole;
	private WEditor				eIsReadWrite;

	private int					printFormat_ID		= 0;
	int							windowNo			= 0;

	private ConfirmPanel		confirmPanel		= new ConfirmPanel(true);

	public WSharePrintFormatForm(int printFormat_ID)
	{
		this.windowNo = SessionManager.getAppDesktop().registerWindow(this);
		this.printFormat_ID = printFormat_ID;
		this.setBorder(true);
		this.setTitle(Msg.translate(Env.getCtx(), "SharePrintFormat"));
		this.setClosable(true);
		this.setWidth("500px");
		this.setHeight("160px");
		Grid centerPanel = GridFactory.newGridLayout();
		this.appendChild(centerPanel);

		Env.setContext(Env.getCtx(), windowNo, MPrintFormatAccess.COLUMNNAME_AD_PrintFormat_ID, printFormat_ID);
		Rows rows = centerPanel.newRows();
		Row row = rows.newRow();
		int columnID = MColumn.getColumn_ID(MPrintFormatAccess.Table_Name, MPrintFormatAccess.COLUMNNAME_AD_User_ID);
		MLookup lookup = MLookupFactory.get(Env.getCtx(), windowNo, 0, columnID, DisplayType.Search);
		eUser = new WSearchEditor(lookup, MPrintFormatAccess.COLUMNNAME_AD_User_ID, "", true, false, true);
		eUser.addValueChangeListener(this);
		lblUser = new Label(Msg.translate(Env.getCtx(), eUser.getColumnName()));
		row.appendCellChild(lblUser);
		row.appendCellChild(eUser.getComponent());

		row = rows.newRow();
		columnID = MColumn.getColumn_ID(MPrintFormatAccess.Table_Name, MPrintFormatAccess.COLUMNNAME_AD_Role_ID);
		lookup = MLookupFactory.get(Env.getCtx(), windowNo, 0, columnID, DisplayType.Table);
		eRole = new WTableDirEditor(lookup, MPrintFormatAccess.COLUMNNAME_AD_Role_ID, "", true, false, true);
		eRole.addValueChangeListener(this);
		lblRole = new Label(Msg.translate(Env.getCtx(), eRole.getColumnName()));
		row.appendCellChild(lblRole);
		row.appendCellChild(eRole.getComponent());

		row = rows.newRow();
		eIsReadWrite = new WYesNoEditor(MPrintFormatAccess.COLUMNNAME_IsReadWrite, "", "", true, false, true);
		eIsReadWrite.setValue(true);
		lblReadWrite = new Label(Msg.translate(Env.getCtx(), eIsReadWrite.getColumnName()));
		row.appendCellChild(lblReadWrite);
		row.appendCellChild(eIsReadWrite.getComponent());

		this.appendChild(confirmPanel);
		confirmPanel.addActionListener(Events.ON_CLICK, this);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		if (event.getTarget().equals(confirmPanel.getOKButton()))
		{
			Integer userID = eUser.getValue() == null ? 0 : (Integer) eUser.getValue();
			Integer roleID = eRole.getValue() == null ? 0 : (Integer) eRole.getValue();
			MPrintFormatAccess access = MPrintFormatAccess.get(printFormat_ID, userID, roleID, null);
			if (access != null && access.getAD_PrintFormat_Access_ID() > 0 && (access.isReadWrite() == (Boolean) eIsReadWrite.getValue()))
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), MPrintFormatAccess.Msg_PF_Access_Already_Exists, true));
			access = MPrintFormatAccess.sharePrintFormatAccess(Env.getCtx(), printFormat_ID, userID, roleID, (Boolean) eIsReadWrite.getValue(), null);
			Object[] infoPara = new Object[2];
			infoPara[0] = access.getAD_User_ID() > 0 ? access.getAD_User().getName() : "N/A";
			infoPara[1] = access.getAD_Role_ID() > 0 ? access.getAD_Role().getName() : "N/A";
			FDialog.info(0, this, Msg.getMsg(Env.getCtx(), MPrintFormatAccess.Mag_PF_Access_Share_Successfully, infoPara));
			dispose();
		}
		else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL)))
		{
			dispose();
		}

	}

	@Override
	public void valueChange(ValueChangeEvent evt)
	{
		if (evt.getSource().equals(eRole) && eRole.getValue() != null)
			Env.setContext(Env.getCtx(), windowNo, MPrintFormatAccess.COLUMNNAME_AD_Role_ID, String.valueOf(eRole.getValue()));
		if (evt.getSource().equals(eUser) && eUser.getValue() != null)
			Env.setContext(Env.getCtx(), windowNo, MPrintFormatAccess.COLUMNNAME_AD_User_ID, String.valueOf(eUser.getValue()));
	}

}
