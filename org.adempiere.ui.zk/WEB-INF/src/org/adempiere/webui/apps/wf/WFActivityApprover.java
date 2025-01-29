package org.adempiere.webui.apps.wf;

import org.adempiere.base.IWFActivityForwardDlg;
import org.adempiere.base.IWFActivityForwardFactory;

public class WFActivityApprover implements IWFActivityForwardFactory
{
	
	@Override
	public IWFActivityForwardDlg getWFActivityForwardDlg()
	{
		return new WFApproverWindow();
	}
	
}
