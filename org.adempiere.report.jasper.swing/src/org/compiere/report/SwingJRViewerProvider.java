package org.compiere.report;

import org.adempiere.report.jasper.JRViewerProvider;
import org.compiere.process.ProcessInfo;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

public class SwingJRViewerProvider implements JRViewerProvider {

	public void openViewer(JasperPrint jasperPrint, String title, ProcessInfo processInfo) throws JRException {
		JasperViewer jasperViewer = new JasperViewer( jasperPrint, title, processInfo);
		jasperViewer.setExtendedState(jasperViewer.getExtendedState() | javax.swing.JFrame.MAXIMIZED_BOTH);
        jasperViewer.setVisible(true);
	}

}
