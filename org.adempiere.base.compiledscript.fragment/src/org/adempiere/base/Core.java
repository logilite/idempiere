/*
 * Decompiled with CFR 0.152.
 */
package org.adempiere.base;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import javax.script.Compilable;
import javax.script.CompiledScript;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import org.adempiere.base.AbstractProductPricing;
import org.adempiere.base.ColumnCalloutManager;
import org.adempiere.base.DefaultAnnotationBasedEventManager;
import org.adempiere.base.DefaultProcessFactory;
import org.adempiere.base.DefaultTaxLookup;
import org.adempiere.base.IAddressValidationFactory;
import org.adempiere.base.IBankStatementLoaderFactory;
import org.adempiere.base.IBankStatementMatcherFactory;
import org.adempiere.base.IColumnCallout;
import org.adempiere.base.ICreditManager;
import org.adempiere.base.ICreditManagerFactory;
import org.adempiere.base.IDictionaryService;
import org.adempiere.base.IKeyStore;
import org.adempiere.base.ILogin;
import org.adempiere.base.ILoginFactory;
import org.adempiere.base.IMappedColumnCalloutFactory;
import org.adempiere.base.IMappedDocumentFactory;
import org.adempiere.base.IModelValidatorFactory;
import org.adempiere.base.IPaymentExporterFactory;
import org.adempiere.base.IPaymentProcessorFactory;
import org.adempiere.base.IProcessFactory;
import org.adempiere.base.IProductPricing;
import org.adempiere.base.IProductPricingFactory;
import org.adempiere.base.IReplenishFactory;
import org.adempiere.base.IResourceFinder;
import org.adempiere.base.IServiceHolder;
import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.IShipmentProcessorFactory;
import org.adempiere.base.ITaxLookup;
import org.adempiere.base.ITaxProviderFactory;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.upload.IUploadService;
import org.adempiere.model.IAddressValidation;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.ITaxProvider;
import org.adempiere.model.MShipperFacade;
import org.adempiere.util.DefaultReservationTracerFactory;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.impexp.BankStatementLoaderInterface;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.model.Callout;
import org.compiere.model.I_AD_PrintHeaderFooter;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MPaymentProcessor;
import org.compiere.model.MRule;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTaxProvider;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.PaymentInterface;
import org.compiere.model.PaymentProcessor;
import org.compiere.model.StandardTaxProvider;
import org.compiere.process.ProcessCall;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.PaymentExport;
import org.compiere.util.ReplenishInterface;
import org.compiere.util.Util;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterService;
import org.idempiere.distributed.IMessageService;
import org.idempiere.fa.service.api.DepreciationFactoryLookupDTO;
import org.idempiere.fa.service.api.IDepreciationMethod;
import org.idempiere.fa.service.api.IDepreciationMethodFactory;
import org.idempiere.model.IMappedModelFactory;
import org.idempiere.print.IPrintHeaderFooter;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.process.IMappedProcessFactory;

public class Core {
    public static final String SCRIPT_ENGINE_FACTORY_CACHE_TABLE_NAME = "_ScriptEngineFactory_Cache";
    public static final String IPROCESS_FACTORY_CACHE_TABLE_NAME = "_IProcessFactory_Cache";
    public static final String IRESOURCE_FINDER_CACHE_TABLE_NAME = "_IResourceFinder_Cache";
    public static final String IDEPRECIATION_METHOD_FACTORY_CACHE_TABLE_NAME = "_IDepreciationMethodFactory_Cache";
    public static final String IPAYMENT_EXPORTER_FACTORY_CACHE_TABLE_NAME = "_IPaymentExporterFactory_Cache";
    public static final String IREPLENISH_FACTORY_CACHE_TABLE_NAME = "_IReplenishFactory_Cache";
    public static final String ITAX_PROVIDER_FACTORY_CACHE_TABLE_NAME = "_ITaxProviderFactory_Cache";
    public static final String IADDRESS_VALIDATION_FACTORY_CACHE_TABLE_NAME = "_IAddressValidationFactory_Cache";
    public static final String IBANK_STATEMENT_MATCHER_FACTORY_CACHE_TABLE_NAME = "_IBankStatementMatcherFactory_Cache";
    public static final String IBANK_STATEMENT_LOADER_FACTORY_CACHE_TABLE_NAME = "_IBankStatementLoaderFactory_Cache";
    public static final String IMODEL_VALIDATOR_FACTORY_CACHE_TABLE_NAME = "_IModelValidatorFactory_Cache";
    public static final String ISHIPMENT_PROCESSOR_FACTORY_CACHE_TABLE_NAME = "_IShipmentProcessorFactory_Cache";
    public static final String IPAYMENT_PROCESSOR_FACTORY_CACHE_TABLE_NAME = "_IPaymentProcessorFactory_Cache";
    public static final String IPRINT_HEADER_FOOTER_CACHE_TABLE_NAME = "_IIPrintHeaderFooterCache";
    public static final String COMPILED_SCRIPT_CACHE_TABLE_NAME = "AD_Rule";
    private static final CLogger s_log = CLogger.getCLogger(Core.class);
    private static final CCache<String, IServiceReferenceHolder<IResourceFinder>> s_resourceFinderCache = new CCache("_IResourceFinder_Cache", "IResourceFinder", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IProcessFactory>> s_processFactoryCache = new CCache("_IProcessFactory_Cache", "IProcessFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IModelValidatorFactory>> s_modelValidatorFactoryCache = new CCache("_IModelValidatorFactory_Cache", "IModelValidatorFactory", 100, false);
    private static IServiceReferenceHolder<IKeyStore> s_keystoreServiceReference = null;
    private static final CCache<String, IServiceReferenceHolder<IPaymentProcessorFactory>> s_paymentProcessorFactoryCache = new CCache("_IPaymentProcessorFactory_Cache", "IPaymentProcessorFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IBankStatementLoaderFactory>> s_bankStatementLoaderFactoryCache = new CCache("_IBankStatementLoaderFactory_Cache", "IBankStatementLoaderFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IBankStatementMatcherFactory>> s_bankStatementMatcherFactoryCache = new CCache("_IBankStatementMatcherFactory_Cache", "IBankStatementMatcherFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IShipmentProcessorFactory>> s_shipmentProcessorFactoryCache = new CCache("_IShipmentProcessorFactory_Cache", "IShipmentProcessorFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IAddressValidationFactory>> s_addressValidationFactoryCache = new CCache("_IAddressValidationFactory_Cache", "IAddressValidationFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<ITaxProviderFactory>> s_taxProviderFactoryCache = new CCache("_ITaxProviderFactory_Cache", "ITaxProviderFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IReplenishFactory>> s_replenishFactoryCache = new CCache("_IReplenishFactory_Cache", "IReplenishFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<ScriptEngineFactory>> s_scriptEngineFactoryCache = new CCache("_ScriptEngineFactory_Cache", "ScriptEngineFactory", 100, false);
    private static final CCache<String, IServiceReferenceHolder<IPaymentExporterFactory>> s_paymentExporterFactory = new CCache("_IPaymentExporterFactory_Cache", "IPaymentExporterFactory", 100, false);
    private static IServiceReferenceHolder<IProductPricingFactory> s_productPricingFactoryCache = null;
    private static final CCache<String, IServiceReferenceHolder<IDepreciationMethodFactory>> s_depreciationMethodFactoryCache = new CCache("_IDepreciationMethodFactory_Cache", "IDepreciationMethodFactory", 100, false);
    private static IServiceReferenceHolder<IMessageService> s_messageServiceReference = null;
    private static IServiceReferenceHolder<IClusterService> s_clusterServiceReference = null;
    private static IServiceReferenceHolder<ICacheService> s_cacheServiceReference = null;
    private static IServiceReferenceHolder<IDictionaryService> s_dictionaryServiceReference = null;
    private static IServiceReferenceHolder<IMappedModelFactory> s_mappedModelFactoryReference = null;
    private static IServiceReferenceHolder<IMappedProcessFactory> s_mappedProcessFactoryReference = null;
    private static IServiceReferenceHolder<IMappedDocumentFactory> s_mappedDocumentFactoryReference = null;
    private static IServiceReferenceHolder<IEventManager> s_eventManagerReference = null;
    private static final CCache<String, IServiceReferenceHolder<IPrintHeaderFooter>> s_printHeaderFooterCache = new CCache("_IIPrintHeaderFooterCache", "IPrintHeaderFooterFactory", 100, false);
    private static final CCache<Integer, CompiledScript> s_compiledScriptCache = new CCache<Integer, CompiledScript>(COMPILED_SCRIPT_CACHE_TABLE_NAME, "CompiledScript", 100, false);

    public static IResourceFinder getResourceFinder() {
        return new IResourceFinder(){

            @Override
            public URL getResource(String name) {
                IServiceReferenceHolder<IResourceFinder> cache = s_resourceFinderCache.get(name);
                if (cache != null) {
                    URL url;
                    IResourceFinder service = cache.getService();
                    if (service != null && (url = service.getResource(name)) != null) {
                        return url;
                    }
                    s_resourceFinderCache.remove(name);
                }
                List<IServiceReferenceHolder<IResourceFinder>> f = Service.locator().list(IResourceFinder.class).getServiceReferences();
                for (IServiceReferenceHolder<IResourceFinder> finder : f) {
                    URL url;
                    IResourceFinder service = finder.getService();
                    if (service == null || (url = service.getResource(name)) == null) continue;
                    s_resourceFinderCache.put(name, finder);
                    return url;
                }
                return null;
            }
        };
    }

    public static List<IColumnCallout> findCallout(String tableName, String columnName) {
        return ColumnCalloutManager.findCallout(tableName, columnName);
    }

    public static Callout getCallout(String className, String methodName) {
        return ColumnCalloutManager.getCallout(className, methodName);
    }

    public static ProcessCall getProcess(String processId) {
        List<IServiceReferenceHolder<IProcessFactory>> factories;
        IServiceReferenceHolder<IProcessFactory> cache = s_processFactoryCache.get(processId);
        if (cache != null) {
            ProcessCall process;
            IProcessFactory service = cache.getService();
            if (service != null && (process = service.newProcessInstance(processId)) != null) {
                return process;
            }
            s_processFactoryCache.remove(processId);
        }
        if ((factories = Core.getProcessFactories()) != null && !factories.isEmpty()) {
            for (IServiceReferenceHolder<IProcessFactory> factory : factories) {
                ProcessCall process;
                IProcessFactory service = factory.getService();
                if (service == null || (process = service.newProcessInstance(processId)) == null) continue;
                s_processFactoryCache.put(processId, factory);
                return process;
            }
        }
        return null;
    }

    private static List<IServiceReferenceHolder<IProcessFactory>> getProcessFactories() {
        List<IServiceReferenceHolder<IProcessFactory>> factories = null;
        int maxIterations = 5;
        int waitMillis = 1000;
        int iterations = 0;
        boolean foundDefault = false;
        while (true) {
            if ((factories = Service.locator().list(IProcessFactory.class).getServiceReferences()) != null && !factories.isEmpty()) {
                for (IServiceReferenceHolder<IProcessFactory> factory : factories) {
                    IProcessFactory service = factory.getService();
                    if (!(service instanceof DefaultProcessFactory)) continue;
                    foundDefault = true;
                    break;
                }
            }
            if (foundDefault || ++iterations >= maxIterations) break;
            try {
                Thread.sleep(waitMillis);
            }
            catch (InterruptedException interruptedException) {}
        }
        return factories;
    }

    public static ModelValidator getModelValidator(String validatorId) {
        List<IServiceReferenceHolder<IModelValidatorFactory>> factoryList;
        IServiceReferenceHolder<IModelValidatorFactory> cache = s_modelValidatorFactoryCache.get(validatorId);
        if (cache != null) {
            ModelValidator validator;
            IModelValidatorFactory service = cache.getService();
            if (service != null && (validator = service.newModelValidatorInstance(validatorId)) != null) {
                return validator;
            }
            s_modelValidatorFactoryCache.remove(validatorId);
        }
        if ((factoryList = Service.locator().list(IModelValidatorFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IModelValidatorFactory> factory : factoryList) {
                ModelValidator validator;
                IModelValidatorFactory service = factory.getService();
                if (service == null || (validator = service.newModelValidatorInstance(validatorId)) == null) continue;
                s_modelValidatorFactoryCache.put(validatorId, factory);
                return validator;
            }
        }
        return null;
    }

    public static IKeyStore getKeyStore() {
        IKeyStore keystoreService = null;
        if (s_keystoreServiceReference != null && (keystoreService = s_keystoreServiceReference.getService()) != null) {
            return keystoreService;
        }
        IServiceReferenceHolder<IKeyStore> serviceReference = Service.locator().locate(IKeyStore.class).getServiceReference();
        if (serviceReference != null) {
            keystoreService = serviceReference.getService();
            s_keystoreServiceReference = serviceReference;
        }
        return keystoreService;
    }

    public static PaymentProcessor getPaymentProcessor(MBankAccountProcessor mbap, PaymentInterface mp) {
        List<IServiceReferenceHolder<IPaymentProcessorFactory>> factoryList;
        MPaymentProcessor mpp;
        String className;
        if (s_log.isLoggable(Level.FINE)) {
            s_log.fine("create for " + String.valueOf(mbap));
        }
        if ((className = (mpp = new MPaymentProcessor(mbap.getCtx(), mbap.getC_PaymentProcessor_ID(), mbap.get_TrxName())).getPayProcessorClass()) == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "No PaymentProcessor class name in " + String.valueOf(mbap));
            return null;
        }
        PaymentProcessor myProcessor = null;
        IServiceReferenceHolder<IPaymentProcessorFactory> cache = s_paymentProcessorFactoryCache.get(className);
        if (cache != null) {
            PaymentProcessor processor;
            IPaymentProcessorFactory service = cache.getService();
            if (service != null && (processor = service.newPaymentProcessorInstance(className)) != null) {
                myProcessor = processor;
            }
            if (myProcessor == null) {
                s_paymentProcessorFactoryCache.remove(className);
            }
        }
        if (myProcessor == null && (factoryList = Service.locator().list(IPaymentProcessorFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IPaymentProcessorFactory> factory : factoryList) {
                PaymentProcessor processor;
                IPaymentProcessorFactory service = factory.getService();
                if (service == null || (processor = service.newPaymentProcessorInstance(className)) == null) continue;
                myProcessor = processor;
                s_paymentProcessorFactoryCache.put(className, factory);
                break;
            }
        }
        if (myProcessor == null) {
            s_log.log(Level.SEVERE, "Not found in service/extension registry and classpath");
            return null;
        }
        myProcessor.initialize(mbap, mp);
        return myProcessor;
    }

    public static BankStatementLoaderInterface getBankStatementLoader(String className) {
        List<IServiceReferenceHolder<IBankStatementLoaderFactory>> factoryList;
        if (className == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "No BankStatementLoaderInterface class name");
            return null;
        }
        BankStatementLoaderInterface myBankStatementLoader = null;
        IServiceReferenceHolder<IBankStatementLoaderFactory> cache = s_bankStatementLoaderFactoryCache.get(className);
        if (cache != null) {
            BankStatementLoaderInterface loader;
            IBankStatementLoaderFactory service = cache.getService();
            if (service != null && (loader = service.newBankStatementLoaderInstance(className)) != null) {
                myBankStatementLoader = loader;
            }
            if (myBankStatementLoader == null) {
                s_bankStatementLoaderFactoryCache.remove(className);
            }
        }
        if (myBankStatementLoader == null && (factoryList = Service.locator().list(IBankStatementLoaderFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IBankStatementLoaderFactory> factory : factoryList) {
                BankStatementLoaderInterface loader;
                IBankStatementLoaderFactory service = factory.getService();
                if (service == null || (loader = service.newBankStatementLoaderInstance(className)) == null) continue;
                myBankStatementLoader = loader;
                s_bankStatementLoaderFactoryCache.put(className, factory);
                break;
            }
        }
        if (myBankStatementLoader == null) {
            s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
            return null;
        }
        return myBankStatementLoader;
    }

    public static BankStatementMatcherInterface getBankStatementMatcher(String className) {
        List<IServiceReferenceHolder<IBankStatementMatcherFactory>> factoryList;
        if (className == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "No BankStatementMatcherInterface class name");
            return null;
        }
        BankStatementMatcherInterface myBankStatementMatcher = null;
        IServiceReferenceHolder<IBankStatementMatcherFactory> cache = s_bankStatementMatcherFactoryCache.get(className);
        if (cache != null) {
            BankStatementMatcherInterface matcher;
            IBankStatementMatcherFactory service = cache.getService();
            if (service != null && (matcher = service.newBankStatementMatcherInstance(className)) != null) {
                myBankStatementMatcher = matcher;
            }
            if (myBankStatementMatcher == null) {
                s_bankStatementMatcherFactoryCache.remove(className);
            }
        }
        if (myBankStatementMatcher == null && (factoryList = Service.locator().list(IBankStatementMatcherFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IBankStatementMatcherFactory> factory : factoryList) {
                BankStatementMatcherInterface matcher;
                IBankStatementMatcherFactory service = factory.getService();
                if (service == null || (matcher = service.newBankStatementMatcherInstance(className)) == null) continue;
                myBankStatementMatcher = matcher;
                s_bankStatementMatcherFactoryCache.put(className, factory);
                break;
            }
        }
        if (myBankStatementMatcher == null) {
            s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
            return null;
        }
        return myBankStatementMatcher;
    }

    public static IShipmentProcessor getShipmentProcessor(MShipperFacade sf) {
        List<IServiceReferenceHolder<IShipmentProcessorFactory>> factoryList;
        String className;
        if (s_log.isLoggable(Level.FINE)) {
            s_log.fine("create for " + String.valueOf(sf));
        }
        if ((className = sf.getShippingProcessorClass()) == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "Shipment processor or class not defined for shipper " + String.valueOf(sf));
            return null;
        }
        IServiceReferenceHolder<IShipmentProcessorFactory> cache = s_shipmentProcessorFactoryCache.get(className);
        if (cache != null) {
            IShipmentProcessor processor;
            IShipmentProcessorFactory service = cache.getService();
            if (service != null && (processor = service.newShipmentProcessorInstance(className)) != null) {
                return processor;
            }
            s_shipmentProcessorFactoryCache.remove(className);
        }
        if ((factoryList = Service.locator().list(IShipmentProcessorFactory.class).getServiceReferences()) == null) {
            return null;
        }
        for (IServiceReferenceHolder<IShipmentProcessorFactory> factory : factoryList) {
            IShipmentProcessor processor;
            IShipmentProcessorFactory service = factory.getService();
            if (service == null || (processor = service.newShipmentProcessorInstance(className)) == null) continue;
            s_shipmentProcessorFactoryCache.put(className, factory);
            return processor;
        }
        return null;
    }

    public static IAddressValidation getAddressValidation(MAddressValidation validation) {
        List<IServiceReferenceHolder<IAddressValidationFactory>> factoryList;
        String className = validation.getAddressValidationClass();
        if (className == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "Address validation class not defined: " + String.valueOf(validation));
            return null;
        }
        IServiceReferenceHolder<IAddressValidationFactory> cache = s_addressValidationFactoryCache.get(className);
        if (cache != null) {
            IAddressValidation processor;
            IAddressValidationFactory service = cache.getService();
            if (service != null && (processor = service.newAddressValidationInstance(className)) != null) {
                return processor;
            }
            s_addressValidationFactoryCache.remove(className);
        }
        if ((factoryList = Service.locator().list(IAddressValidationFactory.class).getServiceReferences()) == null) {
            return null;
        }
        for (IServiceReferenceHolder<IAddressValidationFactory> factory : factoryList) {
            IAddressValidation processor;
            IAddressValidationFactory service = factory.getService();
            if (service == null || (processor = service.newAddressValidationInstance(className)) == null) continue;
            s_addressValidationFactoryCache.put(className, factory);
            return processor;
        }
        return null;
    }

    public static ITaxProvider getTaxProvider(MTaxProvider provider) {
        ITaxProvider calculator = null;
        if (provider != null) {
            List<IServiceReferenceHolder<ITaxProviderFactory>> factoryList;
            if (provider.getC_TaxProvider_ID() == 0) {
                return new StandardTaxProvider();
            }
            if (!provider.isActive()) {
                s_log.log(Level.SEVERE, "Tax provider is inactive: " + String.valueOf(provider));
                return null;
            }
            String className = provider.getTaxProviderClass();
            if (className == null || className.length() == 0) {
                s_log.log(Level.SEVERE, "Tax provider class not defined: " + String.valueOf(provider));
                return null;
            }
            IServiceReferenceHolder<ITaxProviderFactory> cache = s_taxProviderFactoryCache.get(className);
            if (cache != null) {
                ITaxProviderFactory service = cache.getService();
                if (service != null && (calculator = service.newTaxProviderInstance(className)) != null) {
                    return calculator;
                }
                s_taxProviderFactoryCache.remove(className);
            }
            if ((factoryList = Service.locator().list(ITaxProviderFactory.class).getServiceReferences()) == null) {
                return null;
            }
            for (IServiceReferenceHolder<ITaxProviderFactory> factory : factoryList) {
                ITaxProviderFactory service = factory.getService();
                if (service == null || (calculator = service.newTaxProviderInstance(className)) == null) continue;
                s_taxProviderFactoryCache.put(className, factory);
                return calculator;
            }
        }
        return null;
    }

    public static ReplenishInterface getReplenish(String className) {
        List<IServiceReferenceHolder<IReplenishFactory>> factoryList;
        if (className == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "No ReplenishInterface class name");
            return null;
        }
        ReplenishInterface myReplenishInstance = null;
        IServiceReferenceHolder<IReplenishFactory> cache = s_replenishFactoryCache.get(className);
        if (cache != null) {
            ReplenishInterface loader;
            IReplenishFactory service = cache.getService();
            if (service != null && (loader = service.newReplenishInstance(className)) != null) {
                myReplenishInstance = loader;
            }
            if (myReplenishInstance == null) {
                s_replenishFactoryCache.remove(className);
            }
        }
        if (myReplenishInstance == null && (factoryList = Service.locator().list(IReplenishFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IReplenishFactory> factory : factoryList) {
                ReplenishInterface loader;
                IReplenishFactory service = factory.getService();
                if (service == null || (loader = service.newReplenishInstance(className)) == null) continue;
                myReplenishInstance = loader;
                s_replenishFactoryCache.put(className, factory);
                break;
            }
        }
        if (myReplenishInstance == null) {
            s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
            return null;
        }
        return myReplenishInstance;
    }

    public static ScriptEngine getScriptEngine(String engineName) {
        List<IServiceReferenceHolder<ScriptEngineFactory>> factoryList;
        ScriptEngineManager manager = new ScriptEngineManager(Core.class.getClassLoader());
        ScriptEngine engine = manager.getEngineByName(engineName);
        if (engine != null) {
            return engine;
        }
        IServiceReferenceHolder<ScriptEngineFactory> cache = s_scriptEngineFactoryCache.get(engineName);
        if (cache != null) {
            ScriptEngineFactory service = cache.getService();
            if (service != null) {
                return service.getScriptEngine();
            }
            s_scriptEngineFactoryCache.remove(engineName);
        }
        if ((factoryList = Service.locator().list(ScriptEngineFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<ScriptEngineFactory> factory : factoryList) {
                ScriptEngineFactory service = factory.getService();
                if (service == null) continue;
                for (String name : service.getNames()) {
                    if (!engineName.equals(name)) continue;
                    s_scriptEngineFactoryCache.put(engineName, factory);
                    return service.getScriptEngine();
                }
            }
        }
        return null;
    }

    /**
     * Get a CompiledScript from cache, compiling and caching if necessary.
     * @param rule the MRule containing the script to compile
     * @return CompiledScript or null if compilation is not supported or fails
     */
    public static CompiledScript getCompiledScript(MRule rule) {
        if (rule == null || rule.getScript() == null || rule.getScript().isEmpty()) {
            return null;
        }
        Integer key = Integer.valueOf(rule.getAD_Rule_ID());
        CompiledScript compiled = s_compiledScriptCache.get(key);
        if (compiled != null) {
            return compiled;
        }
        ScriptEngine engine = getScriptEngine(rule.getEngineName());
        if (engine == null) {
            s_log.log(Level.WARNING, "Script engine not found: " + rule.getEngineName());
            return null;
        }
        if (!(engine instanceof Compilable)) {
            if (s_log.isLoggable(Level.FINE)) {
                s_log.fine("Script engine " + rule.getEngineName() + " does not support compilation");
            }
            return null;
        }
        try {
            compiled = ((Compilable) engine).compile(rule.getScript());
            s_compiledScriptCache.put(key, compiled);
            if (s_log.isLoggable(Level.FINE)) {
                s_log.fine("Compiled and cached script: " + rule.getValue());
            }
            return compiled;
        } catch (ScriptException e) {
            s_log.log(Level.SEVERE, "Failed to compile script: " + rule.getValue(), e);
            return null;
        }
    }

    public static PaymentExport getPaymentExporter(String className) {
        List<IServiceReferenceHolder<IPaymentExporterFactory>> factoryList;
        if (className == null || className.length() == 0) {
            s_log.log(Level.SEVERE, "No PaymentExporter class name");
            return null;
        }
        PaymentExport myPaymentExporter = null;
        IServiceReferenceHolder<IPaymentExporterFactory> cache = s_paymentExporterFactory.get(className);
        if (cache != null) {
            PaymentExport exporter;
            IPaymentExporterFactory service = cache.getService();
            if (service != null && (exporter = service.newPaymentExporterInstance(className)) != null) {
                myPaymentExporter = exporter;
            }
            if (myPaymentExporter == null) {
                s_paymentExporterFactory.remove(className);
            }
        }
        if (myPaymentExporter == null && (factoryList = Service.locator().list(IPaymentExporterFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IPaymentExporterFactory> factory : factoryList) {
                PaymentExport exporter;
                IPaymentExporterFactory service = factory.getService();
                if (service == null || (exporter = service.newPaymentExporterInstance(className)) == null) continue;
                myPaymentExporter = exporter;
                s_paymentExporterFactory.put(className, factory);
                break;
            }
        }
        if (myPaymentExporter == null) {
            s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
            return null;
        }
        return myPaymentExporter;
    }

    public static synchronized IProductPricing getProductPricing() {
        AbstractProductPricing myProductPricing;
        IProductPricingFactory service;
        IServiceReferenceHolder<IProductPricingFactory> factoryReference;
        if (s_productPricingFactoryCache != null) {
            AbstractProductPricing myProductPricing2;
            IProductPricingFactory service2 = s_productPricingFactoryCache.getService();
            if (service2 != null && (myProductPricing2 = service2.newProductPricingInstance()) != null) {
                return myProductPricing2;
            }
            s_productPricingFactoryCache = null;
        }
        if ((factoryReference = Service.locator().locate(IProductPricingFactory.class).getServiceReference()) != null && (service = factoryReference.getService()) != null && (myProductPricing = service.newProductPricingInstance()) != null) {
            s_productPricingFactoryCache = factoryReference;
            return myProductPricing;
        }
        return null;
    }

    public static IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO) {
        List<IServiceReferenceHolder<IDepreciationMethodFactory>> factoryList;
        String cacheKey = factoryLookupDTO.depreciationType;
        IServiceReferenceHolder<IDepreciationMethodFactory> cache = s_depreciationMethodFactoryCache.get(cacheKey);
        if (cache != null) {
            IDepreciationMethod depreciationMethod;
            IDepreciationMethodFactory service = cache.getService();
            if (service != null && (depreciationMethod = service.getDepreciationMethod(factoryLookupDTO)) != null) {
                return depreciationMethod;
            }
            s_depreciationMethodFactoryCache.remove(cacheKey);
        }
        if ((factoryList = Service.locator().list(IDepreciationMethodFactory.class).getServiceReferences()) != null) {
            for (IServiceReferenceHolder<IDepreciationMethodFactory> factory : factoryList) {
                IDepreciationMethod depreciationMethod;
                IDepreciationMethodFactory service = factory.getService();
                if (service == null || (depreciationMethod = service.getDepreciationMethod(factoryLookupDTO)) == null) continue;
                s_depreciationMethodFactoryCache.put(cacheKey, factory);
                return depreciationMethod;
            }
        }
        return null;
    }

    public static ILogin getLogin(Properties ctx) {
        List<ILoginFactory> factories = Service.locator().list(ILoginFactory.class).getServices();
        if (factories != null && !factories.isEmpty()) {
            for (ILoginFactory factory : factories) {
                ILogin login = factory.newLoginInstance(ctx);
                if (login == null) continue;
                return login;
            }
        }
        return null;
    }

    public static synchronized IMessageService getMessageService() {
        IMessageService messageService = null;
        if (s_messageServiceReference != null && (messageService = s_messageServiceReference.getService()) != null) {
            return messageService;
        }
        IServiceReferenceHolder<IMessageService> serviceReference = Service.locator().locate(IMessageService.class).getServiceReference();
        if (serviceReference != null) {
            messageService = serviceReference.getService();
            s_messageServiceReference = serviceReference;
        }
        return messageService;
    }

    public static synchronized IClusterService getClusterService() {
        IClusterService clusterService = null;
        if (s_clusterServiceReference != null && (clusterService = s_clusterServiceReference.getService()) != null) {
            return clusterService;
        }
        IServiceReferenceHolder<IClusterService> serviceReference = Service.locator().locate(IClusterService.class).getServiceReference();
        if (serviceReference != null) {
            clusterService = serviceReference.getService();
            s_clusterServiceReference = serviceReference;
        }
        return clusterService;
    }

    public static synchronized ICacheService getCacheService() {
        ICacheService cacheService = null;
        if (s_cacheServiceReference != null && (cacheService = s_cacheServiceReference.getService()) != null) {
            return cacheService;
        }
        IServiceReferenceHolder<ICacheService> serviceReference = Service.locator().locate(ICacheService.class).getServiceReference();
        if (serviceReference != null) {
            cacheService = serviceReference.getService();
            s_cacheServiceReference = serviceReference;
        }
        return cacheService;
    }

    public static synchronized IDictionaryService getDictionaryService() {
        IDictionaryService ids = null;
        if (s_dictionaryServiceReference != null && (ids = s_dictionaryServiceReference.getService()) != null) {
            return ids;
        }
        IServiceReferenceHolder<IDictionaryService> serviceReference = Service.locator().locate(IDictionaryService.class).getServiceReference();
        if (serviceReference != null) {
            ids = serviceReference.getService();
            s_dictionaryServiceReference = serviceReference;
        }
        return ids;
    }

    public static IMappedModelFactory getMappedModelFactory() {
        IMappedModelFactory modelFactoryService = null;
        if (s_mappedModelFactoryReference != null && (modelFactoryService = s_mappedModelFactoryReference.getService()) != null) {
            return modelFactoryService;
        }
        IServiceReferenceHolder<IMappedModelFactory> serviceReference = Service.locator().locate(IMappedModelFactory.class).getServiceReference();
        if (serviceReference != null) {
            modelFactoryService = serviceReference.getService();
            s_mappedModelFactoryReference = serviceReference;
        }
        return modelFactoryService;
    }

    public static IMappedProcessFactory getMappedProcessFactory() {
        IMappedProcessFactory processFactoryService = null;
        if (s_mappedProcessFactoryReference != null && (processFactoryService = s_mappedProcessFactoryReference.getService()) != null) {
            return processFactoryService;
        }
        IServiceReferenceHolder<IMappedProcessFactory> serviceReference = Service.locator().locate(IMappedProcessFactory.class).getServiceReference();
        if (serviceReference != null) {
            processFactoryService = serviceReference.getService();
            s_mappedProcessFactoryReference = serviceReference;
        }
        return processFactoryService;
    }

    public static IMappedColumnCalloutFactory getMappedColumnCalloutFactory() {
        return ColumnCalloutManager.getMappedColumnCalloutFactory();
    }

    public static IMappedDocumentFactory getMappedDocumentFactory() {
        IMappedDocumentFactory factoryService = null;
        if (s_mappedDocumentFactoryReference != null && (factoryService = s_mappedDocumentFactoryReference.getService()) != null) {
            return factoryService;
        }
        IServiceReferenceHolder<IMappedDocumentFactory> serviceReference = Service.locator().locate(IMappedDocumentFactory.class).getServiceReference();
        if (serviceReference != null) {
            factoryService = serviceReference.getService();
            s_mappedDocumentFactoryReference = serviceReference;
        }
        return factoryService;
    }

    public static IEventManager getEventManager() {
        IEventManager eventManager = null;
        if (s_eventManagerReference != null && (eventManager = s_eventManagerReference.getService()) != null) {
            return eventManager;
        }
        IServiceReferenceHolder<IEventManager> serviceReference = Service.locator().locate(IEventManager.class).getServiceReference();
        if (serviceReference != null) {
            eventManager = serviceReference.getService();
            s_eventManagerReference = serviceReference;
        }
        return eventManager;
    }

    public static List<IUploadService> getUploadServices() {
        ArrayList<IUploadService> services = new ArrayList<IUploadService>();
        List<MAuthorizationAccount> accounts = MAuthorizationAccount.getAuthorizedAccouts(Env.getAD_User_ID(Env.getCtx()), "Document");
        for (MAuthorizationAccount account : accounts) {
            IUploadService service = Core.getUploadService(account);
            if (service == null) continue;
            services.add(service);
        }
        return services;
    }

    public static IUploadService getUploadService(MAuthorizationAccount account) {
        String provider = account.getAD_AuthorizationCredential().getAD_AuthorizationProvider().getName();
        ServiceQuery query = new ServiceQuery();
        query.put("provider", provider);
        IServiceHolder<IUploadService> holder = Service.locator().locate(IUploadService.class, query);
        if (holder != null) {
            return holder.getService();
        }
        return null;
    }

    public static IPrintHeaderFooter getPrintHeaderFooter(I_AD_PrintHeaderFooter printHeaderFooter) {
        IServiceReferenceHolder<IPrintHeaderFooter> serviceReference;
        String componentName = printHeaderFooter.getSourceClassName();
        if (Util.isEmpty(componentName, true)) {
            s_log.log(Level.SEVERE, "Print Header/Footer source class not defined: " + String.valueOf(printHeaderFooter));
            return null;
        }
        IServiceReferenceHolder<IPrintHeaderFooter> cache = s_printHeaderFooterCache.get(componentName);
        if (cache != null) {
            IPrintHeaderFooter service = cache.getService();
            if (service != null) {
                return service;
            }
            s_printHeaderFooterCache.remove(componentName);
        }
        if ((serviceReference = Service.locator().locate(IPrintHeaderFooter.class, componentName, null).getServiceReference()) == null) {
            return null;
        }
        IPrintHeaderFooter service = serviceReference.getService();
        if (service != null) {
            s_printHeaderFooterCache.put(componentName, serviceReference);
            return service;
        }
        return null;
    }

    public static IReservationTracerFactory getReservationTracerFactory() {
        IServiceHolder<IReservationTracerFactory> serviceHolder = Service.locator().locate(IReservationTracerFactory.class);
        if (serviceHolder != null && serviceHolder.getService() != null) {
            return serviceHolder.getService();
        }
        return DefaultReservationTracerFactory.getInstance();
    }

    public static ITaxLookup getTaxLookup() {
        String service = MSysConfig.getValue("TAX_LOOKUP_SERVICE", DefaultTaxLookup.class.getName(), Env.getAD_Client_ID(Env.getCtx()));
        IServiceHolder<ITaxLookup> serviceHolder = Service.locator().locate(ITaxLookup.class, service, null);
        if (serviceHolder != null) {
            return serviceHolder.getService();
        }
        return new DefaultTaxLookup();
    }

    public static DefaultAnnotationBasedEventManager getDefaultAnnotationBasedEventManager() {
        IServiceReferenceHolder<DefaultAnnotationBasedEventManager> serviceReference = Service.locator().locate(DefaultAnnotationBasedEventManager.class).getServiceReference();
        if (serviceReference != null) {
            return serviceReference.getService();
        }
        return null;
    }

    public static ICreditManager getCreditManager(PO po) {
        if (po == null) {
            s_log.log(Level.SEVERE, "Invalid PO");
            return null;
        }
        ICreditManager myCreditManager = null;
        List<ICreditManagerFactory> factoryList = Service.locator().list(ICreditManagerFactory.class).getServices();
        if (factoryList != null) {
            for (ICreditManagerFactory factory : factoryList) {
                myCreditManager = factory.getCreditManager(po);
                if (myCreditManager != null) break;
            }
        }
        if (myCreditManager == null) {
            s_log.log(Level.CONFIG, "For " + po.get_TableName() + " not found any service/extension registry.");
            return null;
        }
        return myCreditManager;
    }

    public static IReportRenderer<IReportRendererConfiguration> getReportRenderer(String id) {
        IReportRenderer renderer = null;
        List<IServiceReferenceHolder<IReportRenderer>> rendererReferences = Service.locator().list(IReportRenderer.class).getServiceReferences();
        for (IServiceReferenceHolder<IReportRenderer> holder : rendererReferences) {
            renderer = holder.getService();
            if (!renderer.getId().equals(id)) continue;
            return renderer;
        }
        return null;
    }
}
