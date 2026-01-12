package org.compiere.wf;

import java.sql.ResultSet;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.model.MColumn;
import org.compiere.model.Query;
import org.compiere.model.X_AD_WF_Node_Var;

public class MWFNodeVar extends X_AD_WF_Node_Var
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 82706241630223131L;

	/**
	 * 
	 * @param ctx
	 * @param id
	 * @param trxName
	 */
	public MWFNodeVar (Properties ctx, int id, String trxName)
	{
		super (ctx, id, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MWFNodeVar (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param AD_WF_Node_ID
	 * @return
	 */
	public static MWFNodeVar[] getNodeVars (Properties ctx, int AD_WF_Node_ID) {
		List<MWFNodeVar> list = new Query(ctx, Table_Name, "AD_WF_Node_ID=? AND AttributeValue IS NOT NULL", null)
				.setOnlyActiveRecords(true)
				.setParameters(new Object[]{AD_WF_Node_ID})
				.list();
		MWFNodeVar[] retValue = new MWFNodeVar[list.size ()];
			list.toArray (retValue);
			return retValue;
	}
	
	/**
	 * Returns the workflow node variable columns for the given node.
	 * Only active node variables without AttributeValue are considered.
	 *
	 * @param ctx           context
	 * @param AD_WF_Node_ID workflow node ID
	 * @return List of MColumn, or null if none found
	 */
	public static List <MColumn> getNodeVarsColumns(Properties ctx, int AD_WF_Node_ID)
	{
		List <MWFNodeVar> list = new Query(ctx, Table_Name, "AD_WF_Node_ID=? AND AttributeValue IS NULL", null).setOnlyActiveRecords(true).setParameters(AD_WF_Node_ID).list();

		if (list == null || list.isEmpty())
			return null;

		List <MColumn> colList = list.stream().map(v -> MColumn.get(ctx, v.getAD_Column_ID())).filter(Objects::nonNull).collect(Collectors.toList());
		return colList;
	}
	
	/**
	 * Retrieves a workflow node variable record for the given node and column.
	 * Looks up the active MWFNodeVar entry matching both WF_Node_ID and AD_Column_ID.
	 *
	 * @param ctx application context
	 * @param WF_Node_ID workflow node
	 * @param AD_Column_ID column linked to the node variable
	 * @return the matching MWFNodeVar record, or null if none exists
	 */
	public static MWFNodeVar getNodeVarsField(Properties ctx, int WF_Node_ID, int AD_Column_ID)
	{
		return new Query(ctx, Table_Name, "AD_WF_Node_ID = ? AND AD_Column_ID = ? ", null).setOnlyActiveRecords(true).setParameters(WF_Node_ID, AD_Column_ID).first();
	}
}
