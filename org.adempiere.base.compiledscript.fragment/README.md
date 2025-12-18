# iDempiere CompiledScript Cache Fragment

## Overview

This OSGi fragment bundle adds CompiledScript caching to iDempiere's JSR-223 script execution. Scripts (Groovy, BeanShell, Jython) are compiled once and cached, providing significant performance improvements for repeated script executions.

## Performance Results

| Metric | Value |
|--------|-------|
| First execution (cold JVM) | ~290ms |
| Cached executions | ~1.7-3ms |
| Performance improvement | **100-170x faster** |

## How It Works

1. When a script rule (AD_Rule) is executed for the first time, the script is compiled and the CompiledScript object is cached using iDempiere's CCache mechanism.

2. Subsequent executions retrieve the pre-compiled script from cache and execute it directly.

3. Cache is automatically invalidated when AD_Rule records are modified through iDempiere's persistence layer, or when the server cache is reset via REST API.

## Files Modified

The fragment overrides these classes from org.adempiere.base:

| Class | Changes |
|-------|---------|
| `org.adempiere.base.Core` | Added CompiledScript cache and `getCompiledScript(MRule)` method |
| `org.compiere.model.MRule` | Added `setContext(Bindings, ctx, windowNo)` overload for CompiledScript |
| `org.compiere.model.ModelValidationEngine` | Updated 3 script execution points to use CompiledScript |
| `org.compiere.process.ProcessUtil` | Updated `startScriptProcess()` to use CompiledScript |

## Deployment

### Install

1. Copy the JAR to `/opt/idempiere-server/plugins/`

2. Add to bundles.info:
   ```
   org.adempiere.base.compiledscript.fragment,1.0.0.qualifier,plugins/org.adempiere.base.compiledscript.fragment-1.0.0-SNAPSHOT.jar,4,false
   ```

3. Restart iDempiere server

### Verify

```bash
# Check fragment is resolved (attached to host bundle)
telnet localhost 12612
ss | grep compiledscript
# Should show: RESOLVED org.adempiere.base.compiledscript.fragment
```

## Building

```bash
cd org.adempiere.base.compiledscript.fragment
mvn clean package
```

The JAR will be in `target/org.adempiere.base.compiledscript.fragment-1.0.0-SNAPSHOT.jar`

## Dependencies

The fragment requires these JARs in the `lib/` directory (not included in repo):

- `org.adempiere.base_11.0.0.202503171129.jar` - From iDempiere server plugins
- `org.osgi.service.event_1.4.1.202109301733.jar` - From iDempiere server plugins

## Technical Notes

### Cache Key
The cache uses `AD_Rule_ID` (Integer) as the key, matching how MRule caches work.

### Cache Size
Default cache size is 100 entries, sufficient for most installations.

### Compilable Engines
Only script engines implementing `javax.script.Compilable` will be cached:
- Groovy: Yes (primary use case)
- BeanShell: Yes
- Jython: Yes

### Cache Invalidation
- **Automatic**: When AD_Rule is saved through iDempiere UI or API
- **Manual**: Via REST API cache reset: `DELETE /api/v1/caches`
- **Server restart**: All caches cleared

### Direct SQL Updates
Direct SQL updates to AD_Rule do NOT trigger automatic cache invalidation (requires iDempiere's event system). Use REST API cache reset after direct SQL changes.

## Version Compatibility

Built for iDempiere 11.0.0 (Logilite build 202503171129).

## License

Same as iDempiere - GPLv2
