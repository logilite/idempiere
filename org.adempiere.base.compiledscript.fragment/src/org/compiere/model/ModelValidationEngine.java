/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  org.osgi.service.event.Event
 */
package org.compiere.model;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.logging.Level;
import javax.script.Bindings;
import javax.script.CompiledScript;
import javax.script.ScriptEngine;
import org.adempiere.base.Core;
import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.EventProperty;
import org.adempiere.base.event.FactsEventData;
import org.adempiere.base.event.ImportEventData;
import org.adempiere.base.event.LoginEventData;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.ImportValidator;
import org.adempiere.process.ImportProcess;
import org.compiere.acct.Fact;
import org.compiere.model.FactsValidator;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MRule;
import org.compiere.model.MSystem;
import org.compiere.model.MTable;
import org.compiere.model.MTableScriptValidator;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_ModelValidator;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.compiere.wf.MWFActivity;
import org.osgi.service.event.Event;

public class ModelValidationEngine {
    private static ModelValidationEngine s_engine = null;
    private static String missingModelValidationMessage = "";
    private static CLogger log = CLogger.getCLogger(ModelValidationEngine.class);
    private ArrayList<ModelValidator> m_validators = new ArrayList();
    private Hashtable<String, ArrayList<ModelValidator>> m_modelChangeListeners = new Hashtable();
    private Hashtable<String, ArrayList<ModelValidator>> m_docValidateListeners = new Hashtable();
    private Hashtable<String, ArrayList<FactsValidator>> m_factsValidateListeners = new Hashtable();
    private Hashtable<String, ArrayList<ImportValidator>> m_impValidateListeners = new Hashtable();
    private ArrayList<ModelValidator> m_globalValidators = new ArrayList();

    public static synchronized ModelValidationEngine get() {
        if (s_engine == null) {
            s_engine = new ModelValidationEngine();
        }
        return s_engine;
    }

    private ModelValidationEngine() {
        MTable table = MTable.get(Env.getCtx(), 53014);
        Query query = table.createQuery("IsActive='Y'", null);
        query.setOrderBy("SeqNo");
        try {
            List<X_AD_ModelValidator> entityTypes = query.list();
            for (X_AD_ModelValidator entityType : entityTypes) {
                String className = entityType.getModelValidationClass();
                if (className == null || className.length() == 0) continue;
                this.loadValidatorClass(null, className);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            missingModelValidationMessage = missingModelValidationMessage + e.toString() + " global\n";
        }
        MClient[] clients = MClient.getAll(Env.getCtx());
        int i = 0;
        while (i < clients.length) {
            String classNames = clients[i].getModelValidationClasses();
            if (classNames != null && classNames.length() != 0) {
                this.loadValidatorClasses(clients[i], classNames);
            }
            ++i;
        }
    }

    private void loadValidatorClasses(MClient client, String classNames) {
        StringTokenizer st = new StringTokenizer(classNames, ";");
        while (st.hasMoreTokens()) {
            String className = null;
            try {
                className = st.nextToken();
                if (className == null || (className = className.trim()).length() == 0) continue;
                this.loadValidatorClass(client, className);
            }
            catch (Exception e) {
                e.printStackTrace();
                missingModelValidationMessage = missingModelValidationMessage + e.toString() + " on tenant " + client.getName() + "\n";
            }
        }
    }

    private void loadValidatorClass(MClient client, String className) {
        try {
            ModelValidator validator = null;
            validator = Core.getModelValidator(className);
            if (validator == null) {
                missingModelValidationMessage = missingModelValidationMessage + " Missing class " + className + (String)(client != null ? " on tenant " + client.getName() : " global") + "\n";
            } else {
                this.initialize(validator, client);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            missingModelValidationMessage = missingModelValidationMessage + e.toString() + (String)(client != null ? " on tenant " + client.getName() : " global") + "\n";
        }
    }

    private void initialize(ModelValidator validator, MClient client) {
        if (client == null) {
            this.m_globalValidators.add(validator);
        }
        this.m_validators.add(validator);
        validator.initialize(this, client);
    }

    public String loginComplete(int AD_Client_ID, int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
        MSystem system;
        int i = 0;
        while (i < this.m_validators.size()) {
            String error;
            ModelValidator validator = this.m_validators.get(i);
            if ((AD_Client_ID == validator.getAD_Client_ID() || this.m_globalValidators.contains(validator)) && (error = validator.login(AD_Org_ID, AD_Role_ID, AD_User_ID)) != null && error.length() > 0) {
                return error;
            }
            ++i;
        }
        List<MRule> loginRules = MRule.getModelValidatorLoginRules(Env.getCtx());
        if (loginRules != null) {
            for (MRule loginRule : loginRules) {
                String error;
                if (!loginRule.getRuleType().equals("S") || !loginRule.getEventType().equals("L")) continue;
                try {
                    // Try to use cached compiled script for better performance
                    CompiledScript compiled = Core.getCompiledScript(loginRule);
                    Object retval;
                    if (compiled != null) {
                        Bindings bindings = compiled.getEngine().createBindings();
                        MRule.setContext(bindings, Env.getCtx(), 0);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Ctx", Env.getCtx());
                        bindings.put(MRule.ARGUMENTS_PREFIX + "AD_Client_ID", AD_Client_ID);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "AD_Org_ID", AD_Org_ID);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "AD_Role_ID", AD_Role_ID);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "AD_User_ID", AD_User_ID);
                        retval = compiled.eval(bindings);
                    } else {
                        // Fallback to non-compiled execution
                        ScriptEngine engine = loginRule.getScriptEngine();
                        if (engine == null) {
                            throw new AdempiereException("Engine not found: " + loginRule.getEngineName());
                        }
                        MRule.setContext(engine, Env.getCtx(), 0);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", Env.getCtx());
                        engine.put(MRule.ARGUMENTS_PREFIX + "AD_Client_ID", AD_Client_ID);
                        engine.put(MRule.ARGUMENTS_PREFIX + "AD_Org_ID", AD_Org_ID);
                        engine.put(MRule.ARGUMENTS_PREFIX + "AD_Role_ID", AD_Role_ID);
                        engine.put(MRule.ARGUMENTS_PREFIX + "AD_User_ID", AD_User_ID);
                        retval = engine.eval(loginRule.getScript());
                    }
                    error = retval == null ? "" : retval.toString();
                }
                catch (Exception e) {
                    e.printStackTrace();
                    error = e.toString();
                }
                if (error == null || error.length() <= 0) continue;
                return error;
            }
        }
        LoginEventData eventData = new LoginEventData(AD_Client_ID, AD_Org_ID, AD_Role_ID, AD_User_ID);
        Event event = EventManager.newEvent("adempiere/afterLogin", eventData);
        EventManager.getInstance().sendEvent(event);
        @SuppressWarnings("unchecked")
        List<String> errors = (List<String>)event.getProperty("event.errorMessages");
        if (errors != null && !errors.isEmpty()) {
            Collections.reverse(errors);
            StringBuilder eventErrors = new StringBuilder("");
            for (String error : errors) {
                eventErrors.append(error).append("<br>");
            }
            return eventErrors.toString();
        }
        if ((AD_User_ID != 10 && AD_User_ID != 100 || AD_Role_ID != 0) && !Util.isEmpty(missingModelValidationMessage) && (system = MSystem.get(Env.getCtx())).isFailOnMissingModelValidator()) {
            return missingModelValidationMessage;
        }
        return null;
    }

    public void addModelChange(String tableName, ModelValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = this.m_globalValidators.contains(listener) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<ModelValidator> list = this.m_modelChangeListeners.get(propertyName);
        if (list == null) {
            list = new ArrayList();
            list.add(listener);
            this.m_modelChangeListeners.put(propertyName, list);
        } else {
            list.add(listener);
        }
    }

    public void removeModelChange(String tableName, ModelValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = this.m_globalValidators.contains(listener) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<ModelValidator> list = this.m_modelChangeListeners.get(propertyName);
        if (list == null) {
            return;
        }
        list.remove(listener);
        if (list.size() == 0) {
            this.m_modelChangeListeners.remove(propertyName);
        }
    }

    public String fireModelChange(PO po, int changeType) {
        String error;
        if (po == null) {
            return null;
        }
        String propertyName = po.get_TableName() + "*";
        ArrayList<ModelValidator> list = this.m_modelChangeListeners.get(propertyName);
        if (list != null && (error = this.fireModelChange(po, changeType, list)) != null && error.length() > 0) {
            return error;
        }
        propertyName = po.get_TableName() + po.getAD_Client_ID();
        list = this.m_modelChangeListeners.get(propertyName);
        if (list != null && (error = this.fireModelChange(po, changeType, list)) != null && error.length() > 0) {
            return error;
        }
        List<MTableScriptValidator> scriptValidators = MTableScriptValidator.getModelValidatorRules(po.getCtx(), po.get_Table_ID(), ModelValidator.tableEventValidators[changeType]);
        if (scriptValidators != null) {
            for (MTableScriptValidator scriptValidator : scriptValidators) {
                String error2;
                MRule rule = MRule.get(po.getCtx(), scriptValidator.getAD_Rule_ID());
                if (rule == null || !rule.isActive() || !rule.getRuleType().equals("S") || !rule.getEventType().equals("T")) continue;
                try {
                    // Try to use cached compiled script for better performance
                    CompiledScript compiled = Core.getCompiledScript(rule);
                    Object retval;
                    if (compiled != null) {
                        Bindings bindings = compiled.getEngine().createBindings();
                        MRule.setContext(bindings, po.getCtx(), 0);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Ctx", po.getCtx());
                        bindings.put(MRule.ARGUMENTS_PREFIX + "PO", po);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Type", changeType);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Event", ModelValidator.tableEventValidators[changeType]);
                        retval = compiled.eval(bindings);
                    } else {
                        // Fallback to non-compiled execution
                        ScriptEngine engine = rule.getScriptEngine();
                        if (engine == null) {
                            throw new AdempiereException("Engine not found: " + rule.getEngineName());
                        }
                        MRule.setContext(engine, po.getCtx(), 0);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", po.getCtx());
                        engine.put(MRule.ARGUMENTS_PREFIX + "PO", po);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Type", changeType);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Event", ModelValidator.tableEventValidators[changeType]);
                        retval = engine.eval(rule.getScript());
                    }
                    error2 = retval == null ? "" : retval.toString();
                }
                catch (Exception e) {
                    e.printStackTrace();
                    error2 = e.toString();
                }
                if (error2 == null || error2.length() <= 0) continue;
                return error2;
            }
        }
        Event event = EventManager.newEvent(ModelValidator.tableEventTopics[changeType], new EventProperty("event.data", po), new EventProperty("tableName", po.get_TableName()));
        EventManager.getInstance().sendEvent(event);
        @SuppressWarnings("unchecked")
        List<String> errors = (List<String>)event.getProperty("event.errorMessages");
        if (errors != null && !errors.isEmpty()) {
            Collections.reverse(errors);
            StringBuilder eventErrors = new StringBuilder("");
            for (String error2 : errors) {
                eventErrors.append(error2).append("<br>");
            }
            return eventErrors.toString();
        }
        return null;
    }

    private String fireModelChange(PO po, int changeType, ArrayList<ModelValidator> list) {
        int i = 0;
        while (i < list.size()) {
            String error;
            try {
                ModelValidator validator = list.get(i);
                if ((validator.getAD_Client_ID() == po.getAD_Client_ID() || this.m_globalValidators.contains(validator)) && (error = validator.modelChange(po, changeType)) != null && error.length() > 0) {
                    if (log.isLoggable(Level.FINE)) {
                        log.log(Level.FINE, "po=" + String.valueOf(po) + " validator=" + String.valueOf(validator) + " changeType=" + changeType);
                    }
                    return error;
                }
            }
            catch (Exception e) {
                log.log(Level.SEVERE, e.getLocalizedMessage(), e);
                error = e.getLocalizedMessage();
                if (error == null) {
                    error = e.toString();
                }
                return error;
            }
            ++i;
        }
        return null;
    }

    public void addDocValidate(String tableName, ModelValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = this.m_globalValidators.contains(listener) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<ModelValidator> list = this.m_docValidateListeners.get(propertyName);
        if (list == null) {
            list = new ArrayList();
            list.add(listener);
            this.m_docValidateListeners.put(propertyName, list);
        } else if (!list.contains(listener)) {
            list.add(listener);
        }
    }

    public void removeDocValidate(String tableName, ModelValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = this.m_globalValidators.contains(listener) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<ModelValidator> list = this.m_docValidateListeners.get(propertyName);
        if (list == null) {
            return;
        }
        list.remove(listener);
        if (list.size() == 0) {
            this.m_docValidateListeners.remove(propertyName);
        }
    }

    public String fireDocValidate(PO po, int docTiming) {
        List<MTableScriptValidator> scriptValidators;
        String error;
        ArrayList<ModelValidator> list;
        if (po == null) {
            return null;
        }
        String propertyName = po.get_TableName() + "*";
        if (docTiming == 17) {
            propertyName = ((MWFActivity)po).getPO().get_TableName() + "*";
        }
        if ((list = this.m_docValidateListeners.get(propertyName)) != null && (error = this.fireDocValidate(po, docTiming, list)) != null && error.length() > 0) {
            return error;
        }
        propertyName = po.get_TableName() + po.getAD_Client_ID();
        if (docTiming == 17) {
            propertyName = ((MWFActivity)po).getPO().get_TableName() + po.getAD_Client_ID();
        }
        if ((list = this.m_docValidateListeners.get(propertyName)) != null && (error = this.fireDocValidate(po, docTiming, list)) != null && error.length() > 0) {
            return error;
        }
        if (docTiming != 17 && (scriptValidators = MTableScriptValidator.getModelValidatorRules(po.getCtx(), po.get_Table_ID(), ModelValidator.documentEventValidators[docTiming])) != null) {
            for (MTableScriptValidator scriptValidator : scriptValidators) {
                String error2;
                MRule rule = MRule.get(po.getCtx(), scriptValidator.getAD_Rule_ID());
                if (rule == null || !rule.isActive() || !rule.getRuleType().equals("S") || !rule.getEventType().equals("D")) continue;
                try {
                    // Try to use cached compiled script for better performance
                    CompiledScript compiled = Core.getCompiledScript(rule);
                    Object retval;
                    if (compiled != null) {
                        Bindings bindings = compiled.getEngine().createBindings();
                        MRule.setContext(bindings, po.getCtx(), 0);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Ctx", po.getCtx());
                        bindings.put(MRule.ARGUMENTS_PREFIX + "PO", po);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Type", docTiming);
                        bindings.put(MRule.ARGUMENTS_PREFIX + "Event", ModelValidator.documentEventValidators[docTiming]);
                        retval = compiled.eval(bindings);
                    } else {
                        // Fallback to non-compiled execution
                        ScriptEngine engine = rule.getScriptEngine();
                        if (engine == null) {
                            throw new AdempiereException("Engine not found: " + rule.getEngineName());
                        }
                        MRule.setContext(engine, po.getCtx(), 0);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Ctx", po.getCtx());
                        engine.put(MRule.ARGUMENTS_PREFIX + "PO", po);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Type", docTiming);
                        engine.put(MRule.ARGUMENTS_PREFIX + "Event", ModelValidator.documentEventValidators[docTiming]);
                        retval = engine.eval(rule.getScript());
                    }
                    error2 = retval == null ? "" : retval.toString();
                }
                catch (Exception e) {
                    e.printStackTrace();
                    error2 = e.toString();
                }
                if (error2 == null || error2.length() <= 0) continue;
                return error2;
            }
        }
        Event event = EventManager.newEvent(ModelValidator.documentEventTopics[docTiming], new EventProperty("event.data", po), new EventProperty("tableName", po.get_TableName()));
        EventManager.getInstance().sendEvent(event);
        @SuppressWarnings("unchecked")
        List<String> errors = (List<String>)event.getProperty("event.errorMessages");
        if (errors != null && !errors.isEmpty()) {
            Collections.reverse(errors);
            StringBuilder eventErrors = new StringBuilder("");
            for (String error3 : errors) {
                eventErrors.append(error3).append("<br>");
            }
            return eventErrors.toString();
        }
        return null;
    }

    private String fireDocValidate(PO po, int docTiming, ArrayList<ModelValidator> list) {
        int i = 0;
        while (i < list.size()) {
            ModelValidator validator = null;
            try {
                String error;
                validator = list.get(i);
                if ((validator.getAD_Client_ID() == po.getAD_Client_ID() || this.m_globalValidators.contains(validator)) && (error = validator.docValidate(po, docTiming)) != null && error.length() > 0) {
                    if (log.isLoggable(Level.FINE)) {
                        log.log(Level.FINE, "po=" + String.valueOf(po) + " validator=" + String.valueOf(validator) + " timing=" + docTiming);
                    }
                    return error;
                }
            }
            catch (Exception e) {
                log.log(Level.SEVERE, e.getLocalizedMessage(), e);
                String error = e.getLocalizedMessage();
                if (error == null) {
                    error = e.toString();
                }
                return error;
            }
            ++i;
        }
        return null;
    }

    public void addFactsValidate(String tableName, FactsValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = listener instanceof ModelValidator && this.m_globalValidators.contains((ModelValidator)((Object)listener)) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<FactsValidator> list = this.m_factsValidateListeners.get(propertyName);
        if (list == null) {
            list = new ArrayList();
            list.add(listener);
            this.m_factsValidateListeners.put(propertyName, list);
        } else {
            list.add(listener);
        }
    }

    public void addImportValidate(String importTableName, ImportValidator listener) {
        String propertyName = importTableName + "*";
        ArrayList<ImportValidator> list = this.m_impValidateListeners.get(propertyName);
        if (list == null) {
            list = new ArrayList();
            list.add(listener);
            this.m_impValidateListeners.put(propertyName, list);
        } else {
            list.add(listener);
        }
    }

    public void removeFactsValidate(String tableName, FactsValidator listener) {
        if (tableName == null || listener == null) {
            return;
        }
        String propertyName = listener instanceof ModelValidator && this.m_globalValidators.contains((ModelValidator)((Object)listener)) ? tableName + "*" : tableName + listener.getAD_Client_ID();
        ArrayList<FactsValidator> list = this.m_factsValidateListeners.get(propertyName);
        if (list == null) {
            return;
        }
        list.remove(listener);
        if (list.size() == 0) {
            this.m_factsValidateListeners.remove(propertyName);
        }
    }

    public String fireFactsValidate(MAcctSchema schema, List<Fact> facts, PO po, int time) {
        String error;
        if (schema == null || facts == null || po == null) {
            return null;
        }
        String propertyName = po.get_TableName() + "*";
        ArrayList<FactsValidator> list = this.m_factsValidateListeners.get(propertyName);
        if (list != null && (error = this.fireFactsValidate(schema, facts, po, list, time)) != null && error.length() > 0) {
            return error;
        }
        propertyName = po.get_TableName() + po.getAD_Client_ID();
        list = this.m_factsValidateListeners.get(propertyName);
        if (list != null && (error = this.fireFactsValidate(schema, facts, po, list, time)) != null && error.length() > 0) {
            return error;
        }
        FactsEventData eventData = new FactsEventData(schema, facts, po);
        Event event = EventManager.newEvent("adempiere/acct/factsValidate", new EventProperty("event.data", eventData), new EventProperty("tableName", po.get_TableName()));
        EventManager.getInstance().sendEvent(event);
        @SuppressWarnings("unchecked")
        List<String> errors = (List<String>)event.getProperty("event.errorMessages");
        if (errors != null && !errors.isEmpty()) {
            Collections.reverse(errors);
            StringBuilder eventErrors = new StringBuilder("");
            for (String error2 : errors) {
                eventErrors.append(error2).append("<br>");
            }
            return eventErrors.toString();
        }
        return null;
    }

    private String fireFactsValidate(MAcctSchema schema, List<Fact> facts, PO po, ArrayList<FactsValidator> list, int time) {
        int i = 0;
        while (i < list.size()) {
            FactsValidator validator = null;
            try {
                String error;
                validator = list.get(i);
                if ((validator.getAD_Client_ID() == po.getAD_Client_ID() || validator instanceof ModelValidator && this.m_globalValidators.contains((ModelValidator)((Object)validator))) && (error = validator.factsValidate(schema, facts, po, time)) != null && error.length() > 0) {
                    if (log.isLoggable(Level.FINE)) {
                        log.log(Level.FINE, "po=" + String.valueOf(po) + " schema=" + String.valueOf(schema) + " validator=" + String.valueOf(validator));
                    }
                    return error;
                }
            }
            catch (Exception e) {
                log.log(Level.SEVERE, e.getLocalizedMessage(), e);
                String error = e.getLocalizedMessage();
                if (error == null) {
                    error = e.toString();
                }
                return error;
            }
            ++i;
        }
        return null;
    }

    public void fireImportValidate(ImportProcess process, PO importModel, PO targetModel, int timing) {
        String propertyName = process.getImportTableName() + "*";
        ArrayList<ImportValidator> list = this.m_impValidateListeners.get(propertyName);
        if (list != null) {
            for (ImportValidator validator : list) {
                validator.validate(process, importModel, targetModel, timing);
            }
        }
        ImportEventData eventData = new ImportEventData(process, importModel, targetModel);
        String topic = null;
        if (timing == 40) {
            topic = "adempiere/import/afterImport";
        } else if (timing == 20) {
            topic = "adempiere/import/afterValidate";
        } else if (timing == 30) {
            topic = "adempiere/import/beforeImport";
        } else if (timing == 10) {
            topic = "adempiere/import/beforeValidate";
        }
        Event event = EventManager.newEvent(topic, new EventProperty("event.data", eventData), new EventProperty("importTableName", process.getImportTableName()));
        EventManager.getInstance().sendEvent(event);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder("ModelValidationEngine[");
        sb.append("Validators=#").append(this.m_validators.size()).append(", ModelChange=#").append(this.m_modelChangeListeners.size()).append(", DocValidate=#").append(this.m_docValidateListeners.size()).append("]");
        return sb.toString();
    }

    public StringBuffer getInfoDetail(StringBuffer sb, Properties ctx) {
        ArrayList<ModelValidator> list;
        if (sb == null) {
            sb = new StringBuffer();
        }
        sb.append("=== ModelValidationEngine ===").append(Env.NL);
        sb.append("Validators #").append(this.m_validators.size()).append(Env.NL);
        for (ModelValidator mv : this.m_validators) {
            sb.append(mv.toString()).append(Env.NL);
        }
        sb.append(Env.NL).append(Env.NL);
        sb.append("ModelChange #").append(this.m_modelChangeListeners.size()).append(Env.NL);
        for (String key : this.m_modelChangeListeners.keySet()) {
            list = this.m_modelChangeListeners.get(key);
            for (ModelValidator mv : list) {
                sb.append(key).append(": ").append(mv.toString()).append(Env.NL);
            }
        }
        sb.append(Env.NL).append(Env.NL);
        sb.append("DocValidate #").append(this.m_docValidateListeners.size()).append(Env.NL);
        for (String key : this.m_docValidateListeners.keySet()) {
            list = this.m_docValidateListeners.get(key);
            for (ModelValidator mv : list) {
                sb.append(key).append(": ").append(mv.toString()).append(Env.NL);
            }
        }
        sb.append(Env.NL).append(Env.NL);
        return sb;
    }

    public String afterLoadPreferences(Properties ctx) {
        String errMsg = "";
        int AD_Client_ID = Env.getAD_Client_ID(ctx);
        int i = 0;
        while (i < this.m_validators.size()) {
            ModelValidator validator = this.m_validators.get(i);
            if (AD_Client_ID == validator.getAD_Client_ID() || this.m_globalValidators.contains(validator)) {
                Method m = null;
                try {
                    m = validator.getClass().getMethod("afterLoadPreferences", Properties.class);
                }
                catch (NoSuchMethodException noSuchMethodException) {}
                try {
                    if (m != null) {
                        errMsg = errMsg + String.valueOf(m.invoke(validator, ctx));
                    }
                }
                catch (Exception e) {
                    log.warning(String.valueOf(validator) + ": " + e.getLocalizedMessage());
                }
            }
            ++i;
        }
        Event event = new Event("adempiere/pref/afterLoad", (java.util.Map<String, ?>)null);
        EventManager.getInstance().sendEvent(event);
        return errMsg;
    }

    @Deprecated
    public void beforeSaveProperties() {
        int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
        int i = 0;
        while (i < this.m_validators.size()) {
            ModelValidator validator = this.m_validators.get(i);
            if (AD_Client_ID == validator.getAD_Client_ID() || this.m_globalValidators.contains(validator)) {
                Method m = null;
                try {
                    m = validator.getClass().getMethod("beforeSaveProperties", new Class[0]);
                }
                catch (NoSuchMethodException noSuchMethodException) {}
                try {
                    if (m != null) {
                        m.invoke((Object)validator, new Object[0]);
                    }
                }
                catch (Exception e) {
                    log.warning(String.valueOf(validator) + ": " + e.getLocalizedMessage());
                }
            }
            ++i;
        }
    }
}
