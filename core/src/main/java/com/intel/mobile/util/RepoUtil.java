
package com.intel.mobile.util;

import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.SimpleCredentials;
import org.apache.sling.jcr.api.SlingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.config.Config;
import com.intel.mobile.constants.IntelMobileConstants;


public class RepoUtil {
	
	private static final Logger LOG = LoggerFactory.getLogger(RepoUtil.class);
	
	/**
	 * 
	 * @return javax.jcr.Session
	 * @throws RepositoryException
	 * @description This method returns JCR Session 
	 */
	public static Session login(SlingRepository repository) throws RepositoryException {
		if( LOG.isDebugEnabled()){
			LOG.debug("login - START");
		}
		try {			
			 String defaultWorkspace = repository.getDefaultWorkspace();
			 LOG.debug( "Performing adminstrative login to default workspace " + defaultWorkspace );
	         Session session = repository.loginAdministrative(defaultWorkspace);
			 return session;
		} catch (Exception e) {
			throw new RepositoryException("Impossible to login ", e);
		} finally {
			if( LOG.isDebugEnabled()){
				LOG.debug("login - END");
			}
		}
	}
	
}
