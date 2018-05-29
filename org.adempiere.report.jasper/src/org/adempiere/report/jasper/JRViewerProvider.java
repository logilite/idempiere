package org.adempiere.report.jasper;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

import org.compiere.process.ProcessInfo;

public interface JRViewerProvider {

	public void openViewer(JasperPrint jasperPrint, String title, ProcessInfo processInfo) throws JRException;
}
