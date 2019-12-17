package org.adempiere.webui.panel;

import org.adempiere.webui.apps.form.WPrintFormatEditor;

public class WPrintFormatEditorForm extends ADForm {

	/**
	 *@author Jonatas Silvestrini (jonatas.silvestrini@devcoffee.com.br, https://www.devcoffee.com.br)
	 */

	private static final long serialVersionUID = 4301816359636036151L;

	private WPrintFormatEditor pfe;

	public WPrintFormatEditorForm(WPrintFormatEditor printFormatE) {
		this.pfe = printFormatE;
	}

	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

	@Override
	public boolean setVisible(boolean visible) {
		boolean ok = super.setVisible(visible);
		if (visible && getProcessInfo() != null)
			try {
				pfe.initForm();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return ok;
	}

	@Override
	protected void initForm() {

	}



}
