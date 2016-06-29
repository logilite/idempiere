package org.adempiere.webui.dashboard;

import org.zkoss.calendar.impl.SimpleCalendarEvent;

/**
 * 
 * @author swiki
 *
 */
public class ADCalendarResourceAssignment extends SimpleCalendarEvent  {


	/**
	 * 
	 */
	private static final long serialVersionUID = 2085937202905451473L;

	private int S_ResourceAssignment_ID;
	private String Description;
	private int S_Resource_ID;

	public int getS_ResourceAssignment_ID() {
		return S_ResourceAssignment_ID;
	}

	public void setS_ResourceAssignment_ID(int resourceAssignment_ID) {
		S_ResourceAssignment_ID = resourceAssignment_ID;
	}

	public int getS_Resource_ID() {
		return S_Resource_ID;
	}

	public void setS_Resource_ID(int resource_ID) {
		S_Resource_ID = resource_ID;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}
}
