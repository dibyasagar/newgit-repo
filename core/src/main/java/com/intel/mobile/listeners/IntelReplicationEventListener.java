package com.intel.mobile.listeners;

import java.util.HashMap;
import java.util.Map;

import javax.jcr.Session;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.apache.sling.jcr.api.SlingRepository;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.replication.ReplicationAction;
import com.day.cq.replication.ReplicationActionType;
import com.day.cq.replication.Replicator;
import com.day.cq.wcm.api.Page;
import com.intel.mobile.util.IntelUtil;
import com.intel.mobile.util.RepoUtil;

/**
* This is an example listener that listens for replication events and
* logs a message.
*/

@Component (immediate = true, enabled=true, metatype = false, label = "Replication Listener")
@Service(org.osgi.service.event.EventHandler.class)
@Properties ({ @Property(name = "event.topics", value = "ReplicationAction.EVENT_TOPIC") })
public class IntelReplicationEventListener implements EventHandler {
	
	@Reference
    private Replicator replicator;

    @Reference
	private SlingRepository repository;                
    
	@Reference(policy=ReferencePolicy.STATIC)
	private ResourceResolverFactory resolverFactory;
	
    /**
    * default logger
    */
    private static final Logger LOG = LoggerFactory.getLogger(IntelReplicationEventListener.class);
    
    public void handleEvent(Event event) {
    	
    	Session session = null;
    	try {
            /**
             * Check for activate replication action and trigger the workflow.
             */
             final ReplicationAction action = ReplicationAction.fromEvent(event);
             LOG.error("Starting Activation for " + action.getPath());
             if(action != null && replicator != null) {
                 session = repository.loginAdministrative(null);
        		 
                 Map<String, Object> map = new HashMap<String, Object>();
                 map.put("user.session", session);
                 
                 ResourceResolver resolver = resolverFactory.getResourceResolver(map);
                 
                 Resource resource = resolver.getResource(action.getPath());
                 
                 Page page = resource.adaptTo(Page.class);
                 
                 String rootpath = IntelUtil.getRootPath(page);
                 String sitemapPath = rootpath + "/sitemap.html";   
                 
                 LOG.error("Activating sitemap ***** for " + action.getPath());
                 replicator.replicate(session, ReplicationActionType.ACTIVATE, sitemapPath);     
                 resolver.close();
             }
    	} catch(Exception e) {
    		 LOG.error("Exception in ReplicationEventListener : " ,e);
    	}finally{
    		session.logout();
    	}
    	
    }
	
               }
