/*
 * Decompiled with CFR 0.152.
 */
package org.adempiere.util;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.util.Properties;
import java.util.logging.Level;
import javax.script.Bindings;
import javax.script.CompiledScript;
import javax.script.ScriptEngine;
import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IProcessUI;
import org.compiere.model.MProcess;
import org.compiere.model.MRule;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;

public final class ProcessUtil {
    public static final String JASPER_STARTER_CLASS = "org.adempiere.report.jasper.ReportStarter";
    private static final CLogger log = CLogger.getCLogger(ProcessUtil.class);

    private ProcessUtil() {
    }

    public static boolean startDatabaseProcedure(ProcessInfo processInfo, String ProcedureName, Trx trx) {
        return ProcessUtil.startDatabaseProcedure(processInfo, ProcedureName, trx, true);
    }

    public static boolean startDatabaseProcedure(ProcessInfo processInfo, String ProcedureName, Trx trx, boolean managedTrx) {
        String sql = "{call " + ProcedureName + "(?)}";
        String trxName = trx != null ? trx.getTrxName() : null;
        CallableStatement cstmt = null;
        try {
            try {
                cstmt = DB.prepareCall(sql, 1008, trxName);
                cstmt.setInt(1, processInfo.getAD_PInstance_ID());
                cstmt.executeUpdate();
                if (trx != null && trx.isActive() && managedTrx) {
                    trx.commit(true);
                }
            }
            catch (Exception e) {
                log.log(Level.SEVERE, sql, e);
                if (trx != null && trx.isActive() && managedTrx) {
                    trx.rollback();
                }
                processInfo.setSummary(Msg.getMsg(Env.getCtx(), "ProcessRunError") + " " + e.getLocalizedMessage());
                processInfo.setError(true);
                DB.close(cstmt);
                cstmt = null;
                if (trx != null && managedTrx) {
                    trx.close();
                }
                return false;
            }
        }
        catch (Throwable throwable) {
            DB.close(cstmt);
            cstmt = null;
            if (trx != null && managedTrx) {
                trx.close();
            }
            throw throwable;
        }
        DB.close(cstmt);
        cstmt = null;
        if (trx != null && managedTrx) {
            trx.close();
        }
        return true;
    }

    @Deprecated
    public static boolean startJavaProcess(ProcessInfo pi, Trx trx) {
        return ProcessUtil.startJavaProcess(Env.getCtx(), pi, trx);
    }

    public static boolean startJavaProcess(Properties ctx, ProcessInfo pi, Trx trx) {
        return ProcessUtil.startJavaProcess(ctx, pi, trx, true);
    }

    public static boolean startJavaProcess(Properties ctx, ProcessInfo pi, Trx trx, boolean managedTrx) {
        return ProcessUtil.startJavaProcess(ctx, pi, trx, managedTrx, null);
    }

    public static boolean startJavaProcess(Properties ctx, ProcessInfo pi, Trx trx, boolean managedTrx, IProcessUI processMonitor) {
        MProcess proc;
        String className = pi.getClassName();
        if (className == null && (proc = new MProcess(ctx, pi.getAD_Process_ID(), trx.getTrxName())).getJasperReport() != null) {
            className = JASPER_STARTER_CLASS;
        }
        ProcessCall process = null;
        process = Core.getProcess(className);
        if (process == null) {
            pi.setSummary("Failed to create new process instance for " + className, true);
            return false;
        }
        boolean success = false;
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        try {
            try {
                Thread.currentThread().setContextClassLoader(process.getClass().getClassLoader());
                process.setProcessUI(processMonitor);
                success = process.startProcess(ctx, pi, trx);
                if (success && trx != null && managedTrx) {
                    trx.commit(true);
                }
            }
            catch (Throwable e) {
                pi.setSummary(Msg.getMsg(Env.getCtx(), "ProcessError") + " " + e.getLocalizedMessage(), true);
                log.log(Level.SEVERE, pi.getClassName(), e);
                success = false;
                if (trx != null && managedTrx) {
                    if (!success) {
                        trx.rollback();
                    }
                    trx.close();
                    trx = null;
                }
                Thread.currentThread().setContextClassLoader(cl);
                return false;
            }
        }
        finally {
            if (trx != null && managedTrx) {
                if (!success) {
                    trx.rollback();
                }
                trx.close();
                trx = null;
            }
            Thread.currentThread().setContextClassLoader(cl);
        }
        return success;
    }

    public static boolean startScriptProcess(Properties ctx, ProcessInfo pi, Trx trx) {
        MRule rule;
        boolean success;
        String msg;
        block25: {
            String cmd;
            block24: {
                msg = null;
                success = true;
                cmd = pi.getClassName();
                rule = MRule.get(ctx, cmd.substring("@script:".length()));
                if (rule != null) break block24;
                log.log(Level.WARNING, cmd + " not found");
                pi.setSummary("ScriptNotFound", true);
                return false;
            }
            if (rule.getEventType().equals("P") && rule.getRuleType().equals("S")) break block25;
            log.log(Level.WARNING, cmd + " must be of type JSR 223 and event Process");
            pi.setSummary("ScriptNotFound", true);
            return false;
        }
        try {
            // Try to use cached compiled script for better performance
            CompiledScript compiled = Core.getCompiledScript(rule);

            // Prepare transaction
            if (trx == null) {
                trx = Trx.get(Trx.createTrxName(pi.getTitle() + "_" + pi.getAD_PInstance_ID()), true);
                trx.setDisplayName(ProcessUtil.class.getName() + "_startScriptProcess");
            }

            // Add process parameters
            ProcessInfoParameter[] para = pi.getParameter();
            if (para == null) {
                ProcessInfoUtil.setParameterFromDB(pi);
                para = pi.getParameter();
            }

            if (compiled != null) {
                // Use compiled script with bindings
                Bindings bindings = compiled.getEngine().createBindings();
                MRule.setContext(bindings, ctx, 0);
                bindings.put(MRule.ARGUMENTS_PREFIX + "Ctx", ctx);
                bindings.put(MRule.ARGUMENTS_PREFIX + "Trx", trx);
                bindings.put(MRule.ARGUMENTS_PREFIX + "TrxName", trx.getTrxName());
                bindings.put(MRule.ARGUMENTS_PREFIX + "Record_ID", pi.getRecord_ID());
                bindings.put(MRule.ARGUMENTS_PREFIX + "AD_Client_ID", pi.getAD_Client_ID());
                bindings.put(MRule.ARGUMENTS_PREFIX + "AD_User_ID", pi.getAD_User_ID());
                bindings.put(MRule.ARGUMENTS_PREFIX + "AD_PInstance_ID", pi.getAD_PInstance_ID());
                bindings.put(MRule.ARGUMENTS_PREFIX + "Table_ID", pi.getTable_ID());
                if (para != null) {
                    bindings.put(MRule.ARGUMENTS_PREFIX + "Parameter", pi.getParameter());
                    for (int i = 0; i < para.length; i++) {
                        String name = para[i].getParameterName();
                        if (para[i].getParameter_To() == null) {
                            Object value = para[i].getParameter();
                            if (name.endsWith("_ID") && (value instanceof BigDecimal))
                                bindings.put(MRule.PARAMETERS_PREFIX + name, ((BigDecimal)value).intValue());
                            else
                                bindings.put(MRule.PARAMETERS_PREFIX + name, value);
                        } else {
                            Object value1 = para[i].getParameter();
                            Object value2 = para[i].getParameter_To();
                            if (name.endsWith("_ID") && (value1 instanceof BigDecimal))
                                bindings.put(MRule.PARAMETERS_PREFIX + name + "1", ((BigDecimal)value1).intValue());
                            else
                                bindings.put(MRule.PARAMETERS_PREFIX + name + "1", value1);
                            if (name.endsWith("_ID") && (value2 instanceof BigDecimal))
                                bindings.put(MRule.PARAMETERS_PREFIX + name + "2", ((BigDecimal)value2).intValue());
                            else
                                bindings.put(MRule.PARAMETERS_PREFIX + name + "2", value2);
                        }
                    }
                }
                bindings.put(MRule.ARGUMENTS_PREFIX + "ProcessInfo", pi);
                msg = compiled.eval(bindings).toString();
            } else {
                // Fallback to non-compiled execution
                ScriptEngine engine = rule.getScriptEngine();
                if (engine == null) {
                    throw new AdempiereException("Engine not found: " + rule.getEngineName());
                }
                MRule.setContext(engine, ctx, 0);
                engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", ctx);
                engine.put(MRule.ARGUMENTS_PREFIX + "Trx", trx);
                engine.put(MRule.ARGUMENTS_PREFIX + "TrxName", trx.getTrxName());
                engine.put(MRule.ARGUMENTS_PREFIX + "Record_ID", pi.getRecord_ID());
                engine.put(MRule.ARGUMENTS_PREFIX + "AD_Client_ID", pi.getAD_Client_ID());
                engine.put(MRule.ARGUMENTS_PREFIX + "AD_User_ID", pi.getAD_User_ID());
                engine.put(MRule.ARGUMENTS_PREFIX + "AD_PInstance_ID", pi.getAD_PInstance_ID());
                engine.put(MRule.ARGUMENTS_PREFIX + "Table_ID", pi.getTable_ID());
                if (para != null) {
                    engine.put(MRule.ARGUMENTS_PREFIX + "Parameter", pi.getParameter());
                    for (int i = 0; i < para.length; i++) {
                        String name = para[i].getParameterName();
                        if (para[i].getParameter_To() == null) {
                            Object value = para[i].getParameter();
                            if (name.endsWith("_ID") && (value instanceof BigDecimal))
                                engine.put(MRule.PARAMETERS_PREFIX + name, ((BigDecimal)value).intValue());
                            else
                                engine.put(MRule.PARAMETERS_PREFIX + name, value);
                        } else {
                            Object value1 = para[i].getParameter();
                            Object value2 = para[i].getParameter_To();
                            if (name.endsWith("_ID") && (value1 instanceof BigDecimal))
                                engine.put(MRule.PARAMETERS_PREFIX + name + "1", ((BigDecimal)value1).intValue());
                            else
                                engine.put(MRule.PARAMETERS_PREFIX + name + "1", value1);
                            if (name.endsWith("_ID") && (value2 instanceof BigDecimal))
                                engine.put(MRule.PARAMETERS_PREFIX + name + "2", ((BigDecimal)value2).intValue());
                            else
                                engine.put(MRule.PARAMETERS_PREFIX + name + "2", value2);
                        }
                    }
                }
                engine.put(MRule.ARGUMENTS_PREFIX + "ProcessInfo", pi);
                msg = engine.eval(rule.getScript()).toString();
            }
            // transaction should rollback if there are error in process
            if (msg != null && msg.startsWith("@Error@")) {
                success = false;
            }
            // Parse Variables
            msg = Msg.parseTranslation(ctx, msg);
            pi.setSummary(msg, !success);
        }
        catch (Exception e) {
            pi.setSummary("ScriptError", true);
            log.log(Level.SEVERE, pi.getClassName(), e);
            success = false;
        }
        if (success) {
            if (trx != null) {
                try {
                    trx.commit(true);
                }
                catch (Exception e) {
                    log.log(Level.SEVERE, "Commit failed.", e);
                    pi.addSummary("Commit Failed.");
                    pi.setError(true);
                    success = false;
                }
                trx.close();
            }
        } else if (trx != null) {
            trx.rollback();
            trx.close();
        }
        return success;
    }

    public static MWFProcess startWorkFlow(Properties ctx, ProcessInfo pi, int AD_Workflow_ID) {
        MWorkflow wf = MWorkflow.get(ctx, AD_Workflow_ID);
        MWFProcess wfProcess = wf.start(pi, pi.getTransactionName());
        if (log.isLoggable(Level.FINE)) {
            log.fine(pi.toString());
        }
        return wfProcess;
    }

    public static boolean startJavaProcessWithoutTrxClose(Properties ctx, ProcessInfo pi, Trx trx) {
        return ProcessUtil.startJavaProcess(ctx, pi, trx, false);
    }
}
