/**
 * 
 */
package com.intel.mobile.config;


import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * This class loads intel.properties file into Resource Bundle.
 * intel.properties file contains static text which should be used as email content.
 * @author skarm1
 *
 */
public class Config {
	/**
	 * Logger Instance
	 */
	private static final Logger LOG = LoggerFactory.getLogger(Config.class);
	
	/**
	 * Intel Resource bundle for intel.properties
	 */
	private static ResourceBundle intelBundle;
	
	/**
	 * Instance of the class
	 */
	private static Config config = new Config();
	
	/**
	 * Private constructor
	 */
	private Config() {
		intelBundle = ResourceBundle.getBundle("intel");
		if( LOG.isDebugEnabled()){
		LOG.debug("Bundle 'intel' loaded successfully");
		}
	}
	
	/**
	 * Get Instance method for singleton access
	 * @return Config
	 */
	public static Config getInstance() {
		return config;
	}
	
	/**
	 * This method returns the value for the key used in intel.properties file
	 * @param key
	 * @return Value
	 */
	public String getString(String key) {
		String value = null;
		try {
			value = intelBundle.getString(key);
		} catch (MissingResourceException e) {
			LOG.error("Missing Resource Exception:"+e.getMessage());
			LOG.debug("Exception",e);
		}
		return value;
	}
	
}
