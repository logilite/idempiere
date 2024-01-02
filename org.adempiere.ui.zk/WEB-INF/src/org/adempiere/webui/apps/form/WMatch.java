/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.apps.form;

import static org.adempiere.webui.ClientInfo.MEDIUM_WIDTH;
import static org.adempiere.webui.ClientInfo.SMALL_WIDTH;
import static org.adempiere.webui.ClientInfo.maxWidth;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.form.Match;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 *  Form to perform Matching between Purchase Order, Vendor Invoice and Material Receipt.
 *
 *  @author     Jorg Janke
 *  @version    $Id: VMatch.java,v 1.2 2006/07/30 00:51:28 jjanke Exp $
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VMatch")
public class WMatch extends Match
	implements IFormController, EventListener<Event>, WTableModelListener
{
	/** UI form instance */
	private CustomForm form = new CustomForm();

	/**
	 *	Default constructor
	 */
	public WMatch()
	{
		m_WindowNo = form.getWindowNo();
		if (log.isLoggable(Level.INFO))
			log.info("WinNo=" + m_WindowNo
				+ " - AD_Client_ID=" + m_AD_Client_ID + ", AD_Org_ID=" + m_AD_Org_ID + ", By=" + m_by);
		Env.setContext(Env.getCtx(), m_WindowNo, "IsSOTrx", "N");

		try
		{
			//	UI
			onlyVendor = WSearchEditor.createBPartner(m_WindowNo); 
			onlyProduct = WSearchEditor.createProduct(m_WindowNo);
			zkInit();
			dynInit();

			southPanel.appendChild(new Separator());
			southPanel.appendChild(statusBar);
			LayoutUtils.addSclass("status-border", statusBar);
			//
			cmd_matchTo();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		
		if (ClientInfo.isMobile()) 
		{
			ClientInfo.onClientInfo(form, this::onClientInfo);
		}
	}

	/**	Window No */
	private int         	m_WindowNo = 0;
	/**	Logger */
	private static final CLogger log = CLogger.getCLogger(WMatch.class);

	private int     m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
	private int     m_AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
	private int     m_by = Env.getAD_User_ID(Env.getCtx());

	/** Matching To Options */
	private String[] m_matchOptions = new String[] {
		Msg.getElement(Env.getCtx(), "C_Invoice_ID", false),
		Msg.getElement(Env.getCtx(), "M_InOut_ID", false),
		Msg.getElement(Env.getCtx(), "C_Order_ID", false) };

	/** Matching Mode */
	private String[] m_matchMode = new String[] {
		Msg.translate(Env.getCtx(), "NotMatched"),
		Msg.translate(Env.getCtx(), "Matched")};
	private static final int		MODE_NOTMATCHED = 0;
	private static final int		MODE_MATCHED = 1;

	private BigDecimal      m_xMatched = Env.ZERO;
	private BigDecimal      m_xMatchedTo = Env.ZERO;

	private int					selectedID			= 0;
	/** Main panel of {@link #form} */
	private Panel mainPanel = new Panel();
	private StatusBarPanel statusBar = new StatusBarPanel();
	/** Layout of {@link #mainPanel} */
	private Borderlayout mainLayout = new Borderlayout();
	
	/** North of {@link #mainLayout}. Form parameters. */
	private Panel northPanel = new Panel();
	/** Grid layout of {@link #northPanel} */	
	private Grid northLayout = GridFactory.newGridLayout();
	private Label matchFromLabel = new Label();
	/** Select matching source (order, invoice or material receipt) */
	private Listbox matchFrom = ListboxFactory.newDropdownListbox(m_matchOptions);
	private Label matchToLabel = new Label();
	/** Select matching target (order, invoice or material receipt) */
	private Listbox matchTo = ListboxFactory.newDropdownListbox();
	private Label matchModeLabel = new Label();
	private Listbox matchMode = ListboxFactory.newDropdownListbox(m_matchMode);
	private WSearchEditor onlyVendor = null; 
	private WSearchEditor onlyProduct = null;
	private Label onlyVendorLabel = new Label();
	private Label onlyProductLabel = new Label();
	private Label dateFromLabel = new Label();
	private Label dateToLabel = new Label();
	private WDateEditor dateFrom = new WDateEditor("DateFrom", false, false, true, "DateFrom");
	private WDateEditor dateTo = new WDateEditor("DateTo", false, false, true, "DateTo");
	/** Button to start searching of source document */
	private Button bSearch = new Button();
	
	/** South of {@link #mainLayout}. Matching summary info text. */
	private Panel southPanel = new Panel();
	/** Grid layout of {@link #southPanel} */
	private Grid southLayout = GridFactory.newGridLayout();
	private Label xMatchedLabel = new Label();
	private Label xMatchedToLabel = new Label();
	private Label differenceLabel = new Label();
	/** Quantity from source documents */
	private WNumberEditor xMatched = new WNumberEditor("xMatched", false, true, false, DisplayType.Quantity, "xMatched");
	/** Quantity from target documents */
	private WNumberEditor xMatchedTo = new WNumberEditor("xMatchedTo", false, true, false, DisplayType.Quantity, "xMatchedTo");
	/** Difference between {@link #xMatched} and {@link #xMatchedTo} */
	private WNumberEditor difference = new WNumberEditor("Difference", false, true, false, DisplayType.Quantity, "Difference");
	/** Button to start the matching process */
	private Button bProcess = new Button();
	
	/** Center of {@link #mainLayout} */
	private Panel centerPanel = new Panel();
	/** Layout of {@link #centerPanel} */
	private Borderlayout centerLayout = new Borderlayout();
	private Label xMatchedBorder = new Label("xMatched");
	/** North of {@link #centerLayout}. Source documents. */
	private WListbox xMatchedTable = ListboxFactory.newDataTable();
	private Label xMatchedToBorder = new Label("xMatchedTo");
	/** Center of {@link #centerLayout}. Target documents. */
	private WListbox xMatchedToTable = ListboxFactory.newDataTable();
	/**
	 * Center of {@link #centerLayout} (Above {@link #xMatchedToTable}). <br/>
	 * Container of {@link #sameProduct}, {@link #sameProduct} and {@link #sameQty}.
	 */
	private Panel xPanel = new Panel();
	/** Same product flag between source and target document */
	private Checkbox sameProduct = new Checkbox();
	/** Same business partner flag between source and target document */
	private Checkbox sameBPartner = new Checkbox();
	/** Same quantity flag between source and target document */
	private Checkbox sameQty = new Checkbox();
	
	/** Number of column for {@link #northLayout} */
	private int noOfColumn;
	private boolean				isCreateMatchInvHDR	= false;
	
	/**
	 *  Layout form.
	 *  <pre>
	 *  mainPanel
	 *      northPanel
	 *      centerPanel
	 *          xMatched
	 *          xPanel
	 *          xMathedTo
	 *      southPanel
	 *  </pre>
	 *  @throws Exception
	 */
	private void zkInit() throws Exception
	{
		form.appendChild(mainPanel);
		mainPanel.setStyle("width: 100%; height: 100%; padding: 0; margin: 0; overflow: auto;");
		mainPanel.appendChild(mainLayout);
		ZKUpdateUtil.setWidth(mainLayout, "100%");
		ZKUpdateUtil.setHeight(mainLayout, "100%");
		mainLayout.setStyle("min-height: 750px");
		northPanel.appendChild(northLayout);
		matchFromLabel.setText(Msg.translate(Env.getCtx(), "MatchFrom"));
		matchToLabel.setText(Msg.translate(Env.getCtx(), "MatchTo"));
		matchModeLabel.setText(Msg.translate(Env.getCtx(), "MatchMode"));
		onlyVendorLabel.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		onlyProductLabel.setText(Msg.translate(Env.getCtx(), "M_Product_ID"));
		dateFromLabel.setText(Msg.translate(Env.getCtx(), "DateFrom"));
		dateToLabel.setText(Msg.translate(Env.getCtx(), "DateTo"));
		bSearch.setLabel(Msg.translate(Env.getCtx(), "Search"));
		southPanel.appendChild(southLayout);
		xMatchedLabel.setText(Msg.translate(Env.getCtx(), "ToBeMatched"));
		xMatchedToLabel.setText(Msg.translate(Env.getCtx(), "Matching"));
		differenceLabel.setText(Msg.translate(Env.getCtx(), "Difference"));
		bProcess.setLabel(Msg.translate(Env.getCtx(), "Process"));
		centerPanel.appendChild(centerLayout);
		sameProduct.setSelected(true);
		sameProduct.setText(Msg.translate(Env.getCtx(), "SameProduct"));
		sameBPartner.setSelected(true);
		sameBPartner.setText(Msg.translate(Env.getCtx(), "SameBPartner"));
		sameQty.setSelected(false);
		sameQty.setText(Msg.translate(Env.getCtx(), "SameQty"));
		
		// north - parameters
		North north = new North();
		mainLayout.appendChild(north);
		north.appendChild(northPanel);
		north.setCollapsible(true);
		north.setSplittable(true);
		
		layoutParameterAndSummary();
		
		// center - match from and match to list
		Center center = new Center();
		center.setAutoscroll(true);
		mainLayout.appendChild(center);
		center.appendChild(centerPanel);
		ZKUpdateUtil.setHflex(centerPanel, "1");
		ZKUpdateUtil.setVflex(centerPanel, "1");
		ZKUpdateUtil.setWidth(centerLayout, "100%");
		ZKUpdateUtil.setHeight(centerLayout, "100%");
		north = new North();
		centerLayout.appendChild(north);
		north.setStyle("border: none");
		Panel p = new Panel();
		p.appendChild(xMatchedBorder);
		p.appendChild(xMatchedTable);
		ZKUpdateUtil.setWidth(xMatchedTable, "100%");
		p.setStyle("width: 100%; height: 100%; padding: 0; margin: 0");
		north.appendChild(p);
		ZKUpdateUtil.setHeight(north, "45%");
		north.setSplittable(true);
		north.setCollapsible(true);
						
		center = new Center();
		centerLayout.appendChild(center);
		center.setBorder("none");
		Vlayout vlayout = new Vlayout();
		vlayout.setVflex("1");
		vlayout.setHflex("1");
		center.appendChild(vlayout);
		ZKUpdateUtil.setVflex(xPanel, "1");
		ZKUpdateUtil.setHflex(xPanel, "1");
		xPanel.appendChild(sameBPartner);
		xPanel.appendChild(new Space());
		xPanel.appendChild(sameProduct);
		xPanel.appendChild(new Space());
		xPanel.appendChild(sameQty);
		ZKUpdateUtil.setVflex(xPanel, "min");
		xPanel.appendChild(new Separator());
		vlayout.appendChild(xPanel);
		vlayout.appendChild(xMatchedToBorder);
		ZKUpdateUtil.setWidth(xMatchedToTable, "100%");
		vlayout.appendChild(xMatchedToTable);
		ZKUpdateUtil.setVflex(xMatchedTable, true);
				
		centerPanel.setStyle("min-height: 300px;");
	}

	/**
	 * Layout {@link #northPanel} and {@link #southPanel}
	 */
	protected void layoutParameterAndSummary() {
		setupParameterColumns();
		
		Rows rows = northLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(matchFromLabel.rightAlign());
		row.appendChild(matchFrom);
		row.appendChild(matchToLabel.rightAlign());
		row.appendChild(matchTo);
		
		row = rows.newRow();
		row.appendCellChild(matchModeLabel.rightAlign(), 1);
		row.appendCellChild(matchMode, 1);
		row.appendCellChild(new Space(), 1);
		
		row = rows.newRow();
		row.appendChild(onlyVendorLabel.rightAlign());
		row.appendChild(onlyVendor.getComponent());
		row.appendChild(onlyProductLabel.rightAlign());
		row.appendChild(onlyProduct.getComponent());	
		
		row = rows.newRow();
		row.appendChild(dateFromLabel.rightAlign());		
		row.appendChild(dateFrom.getComponent());
		row.appendChild(dateToLabel.rightAlign());
		row.appendChild(dateTo.getComponent());
		bSearch.setStyle("float: right");
		int r = row.getChildren().size() % noOfColumn;
		row.appendCellChild(bSearch, noOfColumn-r);
		if (noOfColumn < 6)
			LayoutUtils.compactTo(northLayout, noOfColumn);
		else
			LayoutUtils.expandTo(northLayout, noOfColumn, true);
		
		// south - summary	
		South south = new South();
		mainLayout.appendChild(south);
		south.appendChild(southPanel);
		
		rows = southLayout.newRows();
		
		row = rows.newRow();
		row.appendChild(xMatchedLabel.rightAlign());
		row.appendChild(xMatched.getComponent());
		row.appendChild(xMatchedToLabel.rightAlign());
		row.appendChild(xMatchedTo.getComponent());
		row.appendChild(differenceLabel.rightAlign());
		row.appendChild(difference.getComponent());
		
		row = rows.newRow();
		row.appendCellChild(bProcess, noOfColumn);
		bProcess.setStyle("float: right");
		if (noOfColumn < 6)
			LayoutUtils.compactTo(southLayout, noOfColumn);
	}

	/**
	 * Setup columns of {@link #northLayout}
	 */
	protected void setupParameterColumns() {
		noOfColumn = 6;
		if (maxWidth(MEDIUM_WIDTH-1))
		{
			if (maxWidth(SMALL_WIDTH-1))
				noOfColumn = 2;
			else
				noOfColumn = 4;
		}
		Columns columns = new Columns();
		Column column = new Column();
		column.setWidth(noOfColumn == 2 ? "35%" : (noOfColumn == 4 ? "15%" : "10%"));
		columns.appendChild(column);
		column = new Column();
		column.setWidth(noOfColumn == 2 ? "65%" : "35%");
		columns.appendChild(column);
		if (noOfColumn > 2) {
			column = new Column();
			column.setWidth(noOfColumn == 4 ? "15%" : "10%");
			columns.appendChild(column);
			column = new Column();
			column.setWidth("35%");
			columns.appendChild(column);
		}
		if (noOfColumn == 6) {
			column = new Column();
			column.setWidth("5%");
			columns.appendChild(column);
			column = new Column();
			column.setWidth("5%");
			columns.appendChild(column);
		}
		northLayout.appendChild(columns);
	}

	/**
	 *  Dynamic Init.
	 *  Configure {@link #xMatchedTable} and {@link #xMatchedToTable}. Setup Listeners.
	 */
	private void dynInit()
	{
		ColumnInfo[] layout = getColumnLayout();

		xMatchedTable.prepareTable(layout, "", "", false, "");
		xMatchedToTable.prepareTable(layout, "", "", true, "");

		matchFrom.setSelectedIndex(0);
		//  Listener
		matchFrom.addActionListener(this);
		matchTo.addActionListener(this);
		bSearch.addActionListener(this);
		xMatchedTable.addEventListener(Events.ON_SELECT, this);
		xMatchedToTable.getModel().addTableModelListener(this);
		xMatchedTable.getModel().addTableModelListener(this);
		bProcess.addActionListener(this);
		sameBPartner.addActionListener(this);
		sameProduct.addActionListener(this);
		sameQty.addActionListener(this);
		
		String selection = (String)matchFrom.getSelectedItem().getValue();
		SimpleListModel model = new SimpleListModel(cmd_matchFrom((String)matchFrom.getSelectedItem().getLabel()));
		matchTo.setItemRenderer(model);
		matchTo.setModel(model);		
		//  Set Title
		xMatchedBorder.setValue(selection);
		//  Reset Table
		xMatchedTable.setRowCount(0);
		//  sync To
		matchTo.setSelectedIndex(0);
		cmd_matchTo();

		statusBar.setStatusLine("");
		statusBar.setStatusDB("0");
	}   //  dynInit

	/**
	 * 	Close form.
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	/**
	 * Handle onClientInfo event from browser.
	 */
	protected void onClientInfo()
	{
		if (ClientInfo.isMobile() && form.getPage() != null) 
		{
			if (noOfColumn > 0 && northLayout.getRows() != null)
			{
				int t = 6;
				if (maxWidth(MEDIUM_WIDTH-1))
				{
					if (maxWidth(SMALL_WIDTH-1))
						t = 2;
					else
						t = 4;
				}
				if (t != noOfColumn)
				{
					northLayout.getRows().detach();
					if (northLayout.getColumns() != null)
						northLayout.getColumns().detach();
					if (mainLayout.getSouth() != null)
						mainLayout.getSouth().detach();
					if (southLayout.getRows() != null)
						southLayout.getRows().detach();
					layoutParameterAndSummary();
					form.invalidate();
				}
			}
		}
	}
	
	/**
	 * Event Listener
	 * @param e event
	 */
	@Override
	public void onEvent (Event e)
	{
		Integer product = onlyProduct.getValue()!=null?(Integer)onlyProduct.getValue():null;
		Integer vendor = onlyVendor.getValue()!=null?(Integer)onlyVendor.getValue():null;
		Timestamp from = dateFrom.getValue()!=null?(Timestamp)dateFrom.getValue():null;
		Timestamp to = dateTo.getValue()!=null?(Timestamp)dateTo.getValue():null;
		
		if (e.getTarget() == matchFrom) {
			String selection = (String)matchFrom.getSelectedItem().getValue();
			SimpleListModel model = new SimpleListModel(cmd_matchFrom((String)matchFrom.getSelectedItem().getLabel()));
			matchTo.setItemRenderer(model);
			matchTo.setModel(model);		
			//  Set Title
			xMatchedBorder.setValue(selection);
			//  Reset Table
			xMatchedTable.setRowCount(0);
			//  sync To
			matchTo.setSelectedIndex(0);
			cmd_matchTo();
		}
		else if (e.getTarget() == matchTo)
			cmd_matchTo();
		else if (e.getTarget() == bSearch)
		{
			// Reset all things done for match invoice header
			selectedID = 0;
			isCreateMatchInvHDR = false;
			
			sameProduct.setSelected(true);
			sameProduct.setEnabled(true);
			
			sameBPartner.setSelected(true);
			sameBPartner.setEnabled(true);
			
			xMatchedTable.setMultiSelection(false);
			
			onSearch(product, vendor, from, to);
			xMatchedTable.repaint();
		}
		else if (e.getTarget() == bProcess)
		{
			if(isCreateMatchInvHDR())
			{
				ArrayList<Integer> matchedRows = new ArrayList<Integer>();
				for (int row = 0; row < xMatchedTable.getRowCount(); row++)
				{
					IDColumn id = (IDColumn) xMatchedTable.getValueAt(row, 0);
					if (id != null && id.isSelected())
					{
						matchedRows.add(id.getRecord_ID());
					}
				}

				ArrayList<Integer> matchedToRows = new ArrayList<Integer>();
				for (int row = 0; row < xMatchedToTable.getRowCount(); row++)
				{
					IDColumn id = (IDColumn) xMatchedToTable.getValueAt(row, 0);
					if (id != null && id.isSelected())
					{
						matchedToRows.add(id.getRecord_ID());
					}
				}

				Comparator<Object> comparator = new Comparator<Object>() {
					@SuppressWarnings("unchecked")
					@Override
					public int compare(Object o1, Object o2)
					{
						ArrayList<Object> list1 = (ArrayList<Object>) o1;
						ArrayList<Object> list2 = (ArrayList<Object>) o2;

						Double qty1 = ((Double) (list1.get(I_QTY) == null ? 0 : list1.get(I_QTY)))
								- ((Double) (list1.get(I_MATCHED) == null ? 0 : list1.get(I_MATCHED)));
						Double qty2 = ((Double) (list2.get(I_QTY) == null ? 0 : list2.get(I_QTY)))
								- ((Double) (list2.get(I_MATCHED) == null ? 0 : list2.get(I_MATCHED)));

						return qty1.compareTo(qty2);
					}
				};

				xMatchedToTable.getModel().sort(comparator, false);
				xMatchedTable.getModel().sort(comparator, false);

				ArrayList<Integer> selectedIndices = new ArrayList<Integer>();
				for (int row = 0; row < xMatchedTable.getRowCount(); row++)
				{
					IDColumn id = (IDColumn) xMatchedTable.getValueAt(row, 0);
					if (id != null && matchedRows.contains(id.getRecord_ID()))
					{
						id.setSelected(true);
						selectedIndices.add(row);
					}
				}
				xMatchedTable
						.setSelectedIndices(toIntArray(selectedIndices.toArray(new Integer[selectedIndices.size()])));
				selectedIndices.clear();

				for (int row = 0; row < xMatchedToTable.getRowCount(); row++)
				{
					IDColumn id = (IDColumn) xMatchedToTable.getValueAt(row, 0);
					if (id != null && matchedToRows.contains(id.getRecord_ID()))
					{
						id.setSelected(true);
						selectedIndices.add(row);
					}
				}
				xMatchedToTable.setSelectedIndices(toIntArray(selectedIndices.toArray(new Integer[selectedIndices
						.size()])));
			}
			
			cmd_process(xMatchedTable, xMatchedToTable, matchMode.getSelectedIndex(), matchFrom.getSelectedIndex(), matchTo.getSelectedItem().getLabel(), m_xMatched, isCreateMatchInvHDR());

			// Reset all things done for match invoice header
			selectedID = 0;
			isCreateMatchInvHDR = false;
			sameProduct.setSelected(true);
			sameProduct.setEnabled(true);
			sameBPartner.setSelected(true);
			sameBPartner.setEnabled(true);
			xMatchedTable.setMultiSelection(false);

			xMatchedTable = (WListbox) cmd_search(xMatchedTable, matchFrom.getSelectedIndex(), (String)matchTo.getSelectedItem().getLabel(), product, vendor, from, to, matchMode.getSelectedIndex() == MODE_MATCHED, selectedID);
			xMatched.setValue(Env.ZERO);
			//  Status Info
			statusBar.setStatusLine(matchFrom.getSelectedItem().getLabel()
				+ "# = " + xMatchedTable.getRowCount(),
				xMatchedTable.getRowCount() == 0);
			statusBar.setStatusDB("0");
			cmd_searchTo();
		}
		else if ((e.getTarget() == sameBPartner
			|| e.getTarget() == sameProduct
			|| e.getTarget() == sameQty)
			 && !isCreateMatchInvHDR())
			cmd_searchTo();
		else if (AEnv.contains(xMatchedTable, e.getTarget()))
		{
			if(!isCreateMatchInvHDR && matchFrom.getSelectedIndex() == MATCH_INVOICE && matchTo.getSelectedIndex() == 0 && isMatchInvHdrEnabled)
			{
				isCreateMatchInvHDR = true;
				
				int row = xMatchedTable.getSelectedIndex();

				//Set Only Product
				KeyNamePair productKNP = (KeyNamePair) xMatchedTable.getValueAt(row, I_Product);
				product = new Integer(productKNP.getKey());
				
				//Set Only Vendor
				KeyNamePair bpartnerKNP = (KeyNamePair) xMatchedTable.getValueAt(row, I_BPartner);
				vendor = new Integer(bpartnerKNP.getKey());
				
				// Set selected invoiceLine
				KeyNamePair C_InvoiceLine_ID = (KeyNamePair) xMatchedTable.getValueAt(row, I_Line);
				selectedID = C_InvoiceLine_ID.getKey();

				//Set Multiselection True
				xMatchedTable.setMultiple(true);
				
				//Search for AP Credit Memo
				onSearch(product, vendor, from, to);
				
				//Mark AP Invoice as selected and Load MR for same product and BP
				for (row = 0; row < xMatchedTable.getRowCount(); row++)
				{
					KeyNamePair C_InvoiceLineID = (KeyNamePair) xMatchedTable.getValueAt(row, I_Line);
					if (C_InvoiceLineID != null && C_InvoiceLineID.getKey() == selectedID)
					{
						xMatchedTable.setSelectedIndex(row);
						((IDColumn) xMatchedTable.getValueAt(row, 0)).setSelected(true);
						xMatchedTable.getItemAtIndex(row).focus();

						WTableModelEvent event = new WTableModelEvent(xMatchedTable.getListModel(), row, 0);
						tableChanged(event);
						break;
					}
				}
				
				cmd_searchTo();
			}
			else
			{
				cmd_searchTo();
			}
		}
	}   //  actionPerformed

	private int[] toIntArray(Integer[] array)
	{
		int[] returnVal = new int[array.length];
		for(int i = 0; i< array.length; i++)
		{
			returnVal[i] = array[i].intValue();
		}
		return returnVal;
	}

	private void onSearch(Integer product, Integer vendor, Timestamp from, Timestamp to)
	{
		xMatchedTable = (WListbox) cmd_search(xMatchedTable, matchFrom.getSelectedIndex(), (String) matchTo
				.getSelectedItem().getLabel(), product, vendor, from, to, matchMode.getSelectedIndex() == MODE_MATCHED,
				selectedID);
		xMatched.setValue(Env.ZERO);
		//  Status Info
		statusBar.setStatusLine(matchFrom.getSelectedItem().getLabel()
				+ "# = " + xMatchedTable.getRowCount(),
				xMatchedTable.getRowCount() == 0);
		statusBar.setStatusDB("0");
		cmd_searchTo();
//		xMatchedTable.repaint();
	}

	
	/**
	 *  Handle selection change of {@link #matchTo}.
	 */
	private void cmd_matchTo()
	{
		int index = matchTo.getSelectedIndex();
		String selection = (String)matchTo.getModel().getElementAt(index);
		xMatchedToBorder.setValue(selection);
		//  Reset Table
		xMatchedToTable.setRowCount(0);
		//TODO
		/*if(isCreateMatchInvHDR())
		{
			xMatchedTable.setMultiple(true);
			sameBPartner.setEnabled(false);
			sameProduct.setEnabled(false);
		}
		else
		{
			xMatchedTable.setMultiple(false);
			sameBPartner.setEnabled(true);
			sameProduct.setEnabled(true);
		}*/
	}   //  cmd_matchTo
	

	/**
	 *  Fill {@link #xMatchedToTable} from selected row of {@link #xMatchedTable}.
	 */
	private void cmd_searchTo()
	{
		int row = xMatchedTable.getSelectedRow();
		if (log.isLoggable(Level.CONFIG)) log.config("Row=" + row);

		if (row < 0)
		{
			xMatchedToTable.setRowCount(0);
		}
		else
		{
			//  ** Create SQL **
 			String displayString = (String)matchTo.getSelectedItem().getLabel();
			int matchToType = matchFrom.getSelectedIndex();
			xMatchedToTable = (WListbox) cmd_searchTo(xMatchedTable, xMatchedToTable, displayString, matchToType,
					sameBPartner.isSelected(), sameProduct.isSelected(), sameQty.isSelected(),
					matchMode.getSelectedIndex() == MODE_MATCHED);
		}
		
		//  Status Info
		statusBar.setStatusLine(matchFrom.getSelectedItem().getLabel()
			+ "# = " + xMatchedTable.getRowCount() + " - "
			+ getMatchToLabel()
			+  "# = " + xMatchedToTable.getRowCount(),
			xMatchedToTable.getRowCount() == 0);
		statusBar.setStatusDB("0");
	}   //  cmd_seachTo
	
	/**
	 * @return selected text from {@link #matchTo}
	 */
	private String getMatchToLabel() {
		int index = matchTo.getSelectedIndex();
		return matchTo.getModel().getElementAt(index).toString();
	}

	/**
	 * Table Model Listener - calculate matched Qty
	 * @param e event
	 */
	@Override
	public void tableChanged (WTableModelEvent e)
	{
		
		if (e.getColumn() != 0)
			return;
		if (log.isLoggable(Level.CONFIG)) log.config("Row=" + e.getFirstRow() + "-" + e.getLastRow() + ", Col=" + e.getColumn()
			+ ", Type=" + e.getType());

		KeyNamePair Product = null;
		if(!isCreateMatchInvHDR())
		{
			int matchedRow = xMatchedTable.getSelectedRow();
			if(matchedRow < 0)
				return;
			Product = (KeyNamePair)xMatchedTable.getValueAt(matchedRow, 5);
			
			// make same Product and same BP as Read Only
			sameProduct.setEnabled(true);
			sameBPartner.setEnabled(true);
		}
		else
		{
			// Set same Product and same BP checked
			sameProduct.setSelected(true);
			sameBPartner.setSelected(true);

			// make same Product and same BP as Read Only
			sameProduct.setEnabled(false);
			sameBPartner.setEnabled(false);
		}

		//  Matched From
		double matchedQty = 0.0;
		int noRows = 0;
		for (int row = 0; row < xMatchedTable.getRowCount(); row++)
		{
			IDColumn id = (IDColumn) xMatchedTable.getValueAt(row, 0);
			if (id != null && id.isSelected())
			{
				if (matchMode.getSelectedIndex() == MODE_NOTMATCHED)
					matchedQty += ((Double) xMatchedTable.getValueAt(row, I_QTY)).doubleValue(); // doc
				matchedQty -= ((Double) xMatchedTable.getValueAt(row, I_MATCHED)).doubleValue(); // matched
				noRows++;
			}
		}
		
		//  Matched To
		double matchedToQty = 0.0;
		for (int row = 0; row < xMatchedToTable.getRowCount(); row++)
		{
			IDColumn id = (IDColumn)xMatchedToTable.getValueAt(row, 0);
			if (id != null && id.isSelected())
			{
				KeyNamePair ProductCompare = (KeyNamePair)xMatchedToTable.getValueAt(row, 5);
				if (!isCreateMatchInvHDR() && Product.getKey() != ProductCompare.getKey() )
				{
					id.setSelected(false);
				}
				else
				{
					if (matchMode.getSelectedIndex() == MODE_NOTMATCHED)
						matchedToQty += ((Double)xMatchedToTable.getValueAt(row, I_QTY)).doubleValue();  //  doc
					matchedToQty -= ((Double)xMatchedToTable.getValueAt(row, I_MATCHED)).doubleValue();  //  matched
					noRows++;
				}
			}
		}
		
		//  update qualtities
		m_xMatchedTo = BigDecimal.valueOf(matchedToQty);
		m_xMatched = BigDecimal.valueOf(matchedQty);
		xMatched.setValue(m_xMatched);
		xMatchedTo.setValue(m_xMatchedTo);
		difference.setValue(m_xMatched.subtract(m_xMatchedTo));
		if(!isCreateMatchInvHDR())
		{
			bProcess.setEnabled(xMatchedToTable.getSelectedCount() > 0);
		}
		else
		{
			bProcess.setEnabled(((BigDecimal)difference.getValue()).signum() == 0);
		}
		//  Status
		statusBar.setStatusDB(noRows + "");
	}   //  tableChanged

	@Override
	private boolean isCreateMatchInvHDR()
	{
		if(!isCreateMatchInvHDR || !isMatchInvHdrEnabled)
		{
			return false;
		}
		
		if(matchFrom.getSelectedIndex() == MATCH_INVOICE && matchTo.getSelectedIndex() == 0)
		{
			return xMatchedTable.getSelectedIndices().length > 1;
		}
		else
		{
			return false;
		}
	}
	
	public ADForm getForm() {
		return form;
	}
}