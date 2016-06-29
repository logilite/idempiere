package org.adempiere.webui.dashboard;

import org.zkoss.calendar.impl.SimpleCalendarEvent;

/**
 * 
 * @author swiki
 *
 */
public class ADCalendarContactActivity extends SimpleCalendarEvent  {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7211639483260795267L;

	private int C_ContactActivity_ID;
	private String ContactActivityType;
	private String description;
	private String comments;
	private String ContactActivityTypeName;
	private String SalesRepName;
	private int SalesRep_ID;
	private int AD_User_ID;
	private int C_Opportunity_ID;

	public int getC_ContactActivity_ID() {
		return C_ContactActivity_ID;
	}

	public void setC_ContactActivity_ID(int contactActivity_ID) {
		C_ContactActivity_ID = contactActivity_ID;
	}

	public String getContactActivityType() {
		return ContactActivityType;
	}

	public void setContactActivityType(String contactActivityType) {
		ContactActivityType = contactActivityType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String Description) {
		description = Description;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String Comments) {
		comments = Comments;
	}

	public String getContactActivityTypeName() {
		return ContactActivityTypeName;
	}

	public void setContactActivityTypeName(String contactActivityType) {
		ContactActivityTypeName = contactActivityType;
	}

	public String getSalesRepName() {
		return SalesRepName;
	}

	public void setSalesRepName(String salesRepName) {
		SalesRepName = salesRepName;
	}

	public int getSalesRep_ID() {
		return SalesRep_ID;
	}

	public void setSalesRep_ID(int salesRep_ID) {
		SalesRep_ID = salesRep_ID;
	}

	public int getAD_User_ID() {
		return AD_User_ID;
	}

	public void setAD_User_ID(int AD_User_ID) {
		this.AD_User_ID = AD_User_ID;
	}

	public int getC_Opportunity_ID() {
		return C_Opportunity_ID;
	}

	public void setC_Opportunity_ID(int C_Opportunity_ID) {
		this.C_Opportunity_ID = C_Opportunity_ID;
	}
}
