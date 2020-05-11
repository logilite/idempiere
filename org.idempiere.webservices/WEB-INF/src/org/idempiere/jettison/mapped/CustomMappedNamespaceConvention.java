/**
 * 
 */
package org.idempiere.jettison.mapped;

import java.util.HashMap;
import java.util.Map;

import javax.xml.namespace.QName;

import org.codehaus.jettison.Node;
import org.codehaus.jettison.mapped.Configuration;
import org.codehaus.jettison.mapped.MappedNamespaceConvention;

/**
 * @author hengsin
 *
 */
public class CustomMappedNamespaceConvention extends MappedNamespaceConvention {

	private Map<String, String> namespacePrefix;
	private Map<String, String> namespacePrefixReversed;
	
	/**
	 * @param config
	 */
	public CustomMappedNamespaceConvention(Configuration config) {
		super(config);
		namespacePrefix = new HashMap<String, String>();
		namespacePrefixReversed = new HashMap<String, String>();
	}
	
	/**
	 * @param prefix namespace prefix
	 * @param uri namespace uri
	 */
	public void addNamespacePrefix(String prefix, String uri) {
		namespacePrefix.put(uri, prefix);
		namespacePrefixReversed.put(prefix, uri);
	}

	/* (non-Javadoc)
	 * @see org.codehaus.jettison.mapped.MappedNamespaceConvention#createQName(java.lang.String, org.codehaus.jettison.Node)
	 */
	@Override
	public QName createQName(String rootName, Node node) {
		int dot = rootName.lastIndexOf( '.' );
        QName qname = null;
        String local = rootName;

        if ( dot == -1 ) {
            dot = 0;
        }
        else {
            local = local.substring( dot + 1 );
        }

        String jns = rootName.substring( 0, dot );
        String xns = (String) getNamespaceURI( jns );

        if ( xns == null ) {
            qname = new QName( rootName );
        }
        else {
        	String prefix = namespacePrefix.get(xns);
        	if (prefix != null && prefix.trim().length() > 0)
        	{
        		qname = new QName( xns, local, prefix );
        		if (node.getObject() != null && namespacePrefixReversed.isEmpty())
        			node.setNamespace(prefix, xns);
        	}
        	else
        		qname = new QName( xns, local );
        }

        if (!namespacePrefixReversed.isEmpty()) {
        	node.setNamespaces(namespacePrefixReversed);
        }
        return qname;
	}

	
}
