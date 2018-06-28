package org.adempiere.webui.component;

import java.util.ArrayList;

import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Vbox;

public class MultiSelectionBox extends Vbox implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long				serialVersionUID	= 2167442925025063802L;

	private static String					PleaseSelect		= "(Please Select)";

	private Textbox							textbox;
	private Popup							popup;
	private Vbox							vbox;
	private boolean							editable;

	private ArrayList<Checkbox>				cbxList				= new ArrayList<Checkbox>();
	private ArrayList<ValueChangeListener>	listeners			= new ArrayList<ValueChangeListener>();

	public MultiSelectionBox(ArrayList<ValueNamePair> list, boolean editable)
	{
		super();
		ZKUpdateUtil.setWidth(this, "100%");

		init();
		loadData(list);
		setEditable(editable);
	}

	private void init()
	{
		setSclass(".z-popup");
		popup = new Popup();
		popup.setStyle("max-height:500px; min-width:300px; overflow: auto;");
		// popup.setWidth("300px");
		appendChild(popup);
		popup.addEventListener(Events.ON_OPEN, this);

		vbox = new Vbox();
		vbox.setStyle("background-color: #ffffff; border-color:#ffffff; border:none; background:#ffffff;");
		ZKUpdateUtil.setHflex(vbox, "1");
		popup.appendChild(vbox);

		textbox = new Textbox(PleaseSelect) {
			private static final long	serialVersionUID	= 1L;

			public void setValue(String value) throws WrongValueException
			{
				super.setValue(value);
				setTooltiptext(value);
			}
		};

		textbox.setReadonly(true);
		textbox.setStyle("background-color: white");
		ZKUpdateUtil.setHflex(textbox, "1");
		textbox.addEventListener(Events.ON_CLICK, this);
		if (isEditable())
			textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");
		appendChild(textbox);
	}

	public void onEvent(Event e) throws Exception
	{
		if (e.getName().equals(Events.ON_CLICK))
		{
			if (e.getTarget() == textbox && editable)
				popup.open(textbox, "after_start");
		}
		else if (e.getName().equals(Events.ON_OPEN) && e.getTarget() == popup)
		{
			OpenEvent oe = (OpenEvent) e;
			if (!oe.isOpen())
			{
				String value = "";
				for (Checkbox cbx : cbxList)
				{
					if (cbx.isChecked())
						value += cbx.getLabel() + "; ";
				}

				value = value.trim();
				if (value.length() == 0)
					value = PleaseSelect;
				textbox.setValue(value);
				fireValueChange(new ValueChangeEvent(this, null, null, getValues()));
			}
		}
	}

	public void loadData(ArrayList<ValueNamePair> list)
	{
		textbox.setValue(PleaseSelect);

		for (Checkbox cbx : cbxList)
			cbx.detach();
		cbxList.clear();

		if (list != null)
		{
			for (ValueNamePair vnp : list)
			{
				Checkbox cbx = new Checkbox(vnp.getName());
				cbx.setAttribute("msbValue", vnp.getValue());
				cbxList.add(cbx);
				vbox.appendChild(cbx);
			}
		}
	}

	public ArrayList<ValueNamePair> getValues()
	{
		ArrayList<ValueNamePair> values = new ArrayList<ValueNamePair>();
		for (Checkbox cbx : cbxList)
		{
			if (cbx.isChecked())
				values.add(new ValueNamePair((String) cbx.getAttribute("msbValue"), cbx.getLabel()));
		}
		return values;
	}

	public void setValues(ArrayList<ValueNamePair> values)
	{
		for (Checkbox cbx : cbxList)
			cbx.setChecked(false);

		if (values != null)
		{
			String value = "";
			for (Checkbox cbx : cbxList)
			{
				ValueNamePair vnp = new ValueNamePair((String) cbx.getAttribute("msbValue"), cbx.getLabel());
				if (values.contains(vnp))
				{
					cbx.setChecked(true);
					value += cbx.getLabel() + "; ";
				}
			}

			value = value.trim();
			if (value.length() == 0)
				value = PleaseSelect;
			textbox.setValue(value);
		}
	}

	public boolean isEditable()
	{
		return editable;
	}

	public void setEditable(boolean editable)
	{
		this.editable = editable;

		if (textbox != null)
		{
			if (!isEditable())
				textbox.setPopup((Popup) null);
			else
				textbox.setPopup("uuid(" + popup.getUuid() + "), after_start");
		}
	}

	public void addValueChangeListener(ValueChangeListener listener)
	{
		if (listener == null)
			return;

		if (!listeners.contains(listener))
			listeners.add(listener);
	}

	public boolean removeValueChangeListener(ValueChangeListener listener)
	{
		return listeners.remove(listener);
	}

	private void fireValueChange(ValueChangeEvent event)
	{
		// copy to array to avoid concurrent modification exception
		ValueChangeListener[] vcl = new ValueChangeListener[listeners.size()];
		listeners.toArray(vcl);
		for (ValueChangeListener listener : vcl)
		{
			listener.valueChange(event);
		}
	}
}
