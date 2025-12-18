/*
 * Decompiled with CFR 0.152.
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import javax.script.Bindings;
import javax.script.ScriptEngine;
import org.adempiere.base.Core;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Rule;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

public class MRule
extends X_AD_Rule
implements ImmutablePOSupport {
    private static final long serialVersionUID = -288947666359685155L;
    public static final String GLOBAL_CONTEXT_PREFIX = "G_";
    public static final String WINDOW_CONTEXT_PREFIX = "W_";
    public static final String ARGUMENTS_PREFIX = "A_";
    public static final String PARAMETERS_PREFIX = "P_";
    public static final String SCRIPT_PREFIX = "@script:";
    private static ImmutableIntPOCache<Integer, MRule> s_cache = new ImmutableIntPOCache("AD_Rule", 20);
    private static CLogger s_log = CLogger.getCLogger(MRule.class);
    protected ScriptEngine engine = null;

    public static MRule get(int AD_Rule_ID) {
        return MRule.get(Env.getCtx(), AD_Rule_ID);
    }

    public static MRule get(Properties ctx, int AD_Rule_ID) {
        Integer key = AD_Rule_ID;
        MRule retValue = s_cache.get(ctx, key, e -> new MRule(ctx, (MRule)e));
        if (retValue != null) {
            return retValue;
        }
        retValue = new MRule(ctx, AD_Rule_ID, null);
        if (retValue.get_ID() == AD_Rule_ID) {
            s_cache.put(key, retValue, e -> new MRule(Env.getCtx(), (MRule)e));
            return retValue;
        }
        return null;
    }

    public static MRule get(Properties ctx, String ruleValue) {
        MRule retValue;
        MRule[] it;
        if (ruleValue == null) {
            return null;
        }
        MRule[] mRuleArray = it = s_cache.values().toArray(new MRule[0]);
        int n = it.length;
        int n2 = 0;
        while (n2 < n) {
            retValue = mRuleArray[n2];
            if (ruleValue.equals(retValue.getValue())) {
                return retValue;
            }
            ++n2;
        }
        retValue = (MRule)new Query(ctx, "AD_Rule", "Value=?", null).setParameters(ruleValue).setOnlyActiveRecords(true).first();
        if (retValue != null) {
            Integer key = retValue.getAD_Rule_ID();
            s_cache.put(key, retValue);
        }
        return retValue;
    }

    public static List<MRule> getModelValidatorLoginRules(Properties ctx) {
        List<MRule> rules = new Query(ctx, "AD_Rule", "EventType=?", null).setParameters("L").setOnlyActiveRecords(true).list();
        if (rules != null && rules.size() > 0) {
            return rules;
        }
        return null;
    }

    public MRule(Properties ctx, String AD_Rule_UU, String trxName) {
        super(ctx, AD_Rule_UU, trxName);
    }

    public MRule(Properties ctx, int AD_Rule_ID, String trxName) {
        super(ctx, AD_Rule_ID, trxName);
    }

    public MRule(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

    public MRule(MRule copy) {
        this(Env.getCtx(), copy);
    }

    public MRule(Properties ctx, MRule copy) {
        this(ctx, copy, null);
    }

    public MRule(Properties ctx, MRule copy, String trxName) {
        this(ctx, 0, trxName);
        this.copyPO(copy);
        this.engine = copy.engine;
    }

    @Override
    protected boolean beforeSave(boolean newRecord) {
        String engineName;
        if (this.getRuleType().equals("S") && ((engineName = this.getEngineName()) == null || !engineName.equalsIgnoreCase("groovy") && !engineName.equalsIgnoreCase("jython") && !engineName.equalsIgnoreCase("beanshell"))) {
            this.log.saveError("Error", Msg.getMsg(this.getCtx(), "WrongScriptValue"));
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("MRule[");
        sb.append(this.get_ID()).append("-").append(this.getValue()).append("]");
        return sb.toString();
    }

    public ScriptEngine getScriptEngine() {
        String engineName = this.getEngineName();
        if (engineName != null) {
            this.engine = Core.getScriptEngine(engineName);
        }
        return this.engine;
    }

    public String getEngineName() {
        int colonPosition = this.getValue().indexOf(":");
        if (colonPosition < 0) {
            return null;
        }
        return this.getValue().substring(0, colonPosition);
    }

    /**
     * Add context entries as variable binding to the script engine based on windowNo
     * @param engine Script Engine
     * @param ctx context
     * @param windowNo window number
     */
    public static void setContext(ScriptEngine engine, Properties ctx, int windowNo) {
        Bindings bindings = engine.createBindings();
        setContext(bindings, ctx, windowNo);
        for (String key : bindings.keySet()) {
            engine.put(key, bindings.get(key));
        }
    }

    /**
     * Add context entries as variable binding to a Bindings object based on windowNo.
     * This overload is used with CompiledScript for better performance.
     * @param bindings Script Bindings
     * @param ctx context
     * @param windowNo window number
     */
    public static void setContext(Bindings bindings, Properties ctx, int windowNo) {
        Enumeration<Object> en = ctx.keys();
        while (en.hasMoreElements()) {
            String key = en.nextElement().toString();
            // filter
            if (key == null || key.length() == 0
                    || key.startsWith("P")              // Preferences
                    || (key.indexOf('|') != -1 && !key.startsWith(String.valueOf(windowNo)))    // other Window Settings
                    || (key.indexOf('|') != -1 && key.indexOf('|') != key.lastIndexOf('|'))) // other tab
                continue;
            Object value = ctx.get(key);
            if (value != null) {
                if (value instanceof Boolean)
                    bindings.put(convertKey(key, windowNo), ((Boolean)value).booleanValue());
                else if (value instanceof Integer)
                    bindings.put(convertKey(key, windowNo), ((Integer)value).intValue());
                else if (value instanceof Double)
                    bindings.put(convertKey(key, windowNo), ((Double)value).doubleValue());
                else
                    bindings.put(convertKey(key, windowNo), value);
            }
        }
    }

    public static String convertKey(String key, int m_windowNo) {
        String k = m_windowNo + "|";
        if (key.startsWith(k)) {
            String retValue = WINDOW_CONTEXT_PREFIX + key.substring(k.length());
            retValue = Util.replace(retValue, "|", "_");
            return retValue;
        }
        String retValue = null;
        retValue = key.startsWith("#") ? GLOBAL_CONTEXT_PREFIX + key.substring(1) : key;
        retValue = Util.replace(retValue, "#", "_");
        return retValue;
    }

    @Override
    public MRule markImmutable() {
        if (this.is_Immutable()) {
            return this;
        }
        this.makeImmutable();
        return this;
    }
}
