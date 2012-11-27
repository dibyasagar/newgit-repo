/**
 * 
 */
package com.intel.mobile.services.impl;

import java.util.Dictionary;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.osgi.framework.Constants;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.services.IntelConfigurationService;

/**
 * @author skarm1
 *
 */

@Component (immediate=true, label="Intel Configuration Service", description = "Intel Configuration Service", metatype=true )
@Service 
@Properties({
	@Property(name = Constants.SERVICE_DESCRIPTION, value = "Intel Configuration Service"),
	@Property(name = Constants.SERVICE_VENDOR, value = "Intel")})

	public class IntelConfigurationServiceImpl implements IntelConfigurationService{

	private static final Logger log = LoggerFactory.getLogger(IntelConfigurationServiceImpl.class);
	
	@Property(label = "Disable Intel Shop Sync Job", boolValue = false , description = "If Intel shop sync job is not required to run give value=true.")
	public static final String DISABLE_INTEL_SHOP_SYNC_JOB = "disableIntelShopSyncJob";

	@Property(label = "Intel Shop API URL", value = "http://shop.intel.com/api", description = "The URL to access Intel Shop API")
	public static final String INTEL_SHOP_API_URL_PROPERTY = "intelShopAPIUrl";

	@Property(label = "Intel Shop API Security Key", value = "IO6+wTWJ+E+uizNDBNTiuQ==", description = "The security key to access Intel Shop API")
	public static final String API_KEY_PROPERTY = "intelShopAPIKey";
			
	@Property(label = "Shop Products Fetch Size",  value = "100", description = "No of products to be retrived per call of Intel Shop API")
	public static final String PAGE_SIZE_PROPERTY = "pageSize";
	
	@Property(label = "Sync SHOP Images ?",  boolValue = false , description = "Do you want to sync shop images with the DAM ?")
	public static final String IS_SYNC_IMAGES_PROPERTY = "isSyncImage";
	
	@Property(label = "Intel ARK API URL", value = "http://odata.intel.com/API/v1_0/Products/", description = "The URL to access Intel ARK API")
	public static final String ARK_API_URL_PROPERTY= "arkApiUrl";
	
	@Property(label = "Intel ARK API Security Key", value = "8B74915ED25D4FA0B734B75BE2030BB6", description = "The security key to access Intel ARK API")
	public static final String ARK_API_KEY_PROPERTY = "arkapikey";
					
	@Property(label = "Fast Search URL", value = "http://search.intel.com/webhandlers/SearchWebHandler.ashx" , description = "Fast Search URL")
	public static final String FAST_SEARCH_URL_PROPERTY= "fastSearchUrl";
	
	@Property(label = "Fast Search Application Id", value = "mobilecq" , description = "Fast Search Application Id")
	public static final String FAST_SEARCH_APP_ID_PROPERTY= "fastSearchAppId";
	
	@Property(label = "WAP Tracking Environment", value = "test" , description = "WAP Tracking Environment")
	public static final String WAP_TRACKING_ENV= "wapTrackingEnv";
	
	@Property(label = "Spec Email Body", value = "Based on your requiremnet intel suggests the following specification for you : {0} \n\n For more information about the Intel, visit m.intel.com. \n\n Please do not reply this mail." , description = "Body of the specification mail that will be sent to the end user.")
	public static final String SPEC_EMAIL_BODY= "specEmailBody";
		
	private String apiKey;
	private String intelShopAPIUrl;
	private String pageSize;
    private String arkApiUrl;
	private String arkApiKey;
	/*private String topSize;*/
	private boolean syncJobDisabled;

	private boolean isSyncImage;
	private String wapTrackingEnv;
	private String fastSearchUrl;
	private String fastSearchAppId;
	private String specEmailBody;
	
	protected void activate(ComponentContext context){

		try {
			log.info("activate method called");
			Dictionary props = context.getProperties();

			apiKey = (String) props.get(API_KEY_PROPERTY);
			intelShopAPIUrl = (String) props.get(INTEL_SHOP_API_URL_PROPERTY);
			pageSize = (String) props.get(PAGE_SIZE_PROPERTY);
			arkApiUrl = (String) props.get(ARK_API_URL_PROPERTY);
			arkApiKey = (String) props.get(ARK_API_KEY_PROPERTY);		
			isSyncImage = (Boolean) props.get(IS_SYNC_IMAGES_PROPERTY);	
			syncJobDisabled = (Boolean) props.get(DISABLE_INTEL_SHOP_SYNC_JOB);
			wapTrackingEnv = (String) props.get(WAP_TRACKING_ENV);	
				
			fastSearchUrl = (String) props.get(FAST_SEARCH_URL_PROPERTY);
			fastSearchAppId = (String) props.get(FAST_SEARCH_APP_ID_PROPERTY);
			specEmailBody = (String) props.get(SPEC_EMAIL_BODY);
		} catch (Exception e){
			log.error(e.getMessage(), e);
		}
	}

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	public String getArkApiUrl() {
		return arkApiUrl;
	}

	public void setArkApiUrl(String arkProcessorApiUrl) {
		this.arkApiUrl = arkProcessorApiUrl;
	}
	public String getArkApiKey() {
	return arkApiKey;
	}
	
	public void setArkApiKey(String arkApiKey) {
		this.arkApiKey = arkApiKey;
	}

	public String getIntelShopAPIUrl() {
		return intelShopAPIUrl;
	}

	public void setIntelShopAPIUrl(String intelShopAPIUrl) {
		this.intelShopAPIUrl = intelShopAPIUrl;
	}

	public boolean isSyncImage() {
		return isSyncImage;
	}

	public void setSyncImage(boolean isSyncImage) {
		this.isSyncImage = isSyncImage;
	}

	public boolean isSyncJobDisabled() {
		return syncJobDisabled;
	}

	public void setSyncJobDisabled(boolean disabled) {
		this.syncJobDisabled = disabled;
	}

	public String getWapTrackingEnv() {
		return wapTrackingEnv;
	}

	public void setWapTrackingEnv(String wapTrackingEnv) {
		this.wapTrackingEnv = wapTrackingEnv;
	}

	public void setFastSearchUrl(String fastSearchUrl) {
		this.fastSearchUrl = fastSearchUrl;
	}

	public void setFastSearchAppId(String fastSearchAppId) {
		this.fastSearchAppId = fastSearchAppId;
	}

	public String getFastSearchUrl() {
		return this.fastSearchUrl;
	}

	public String getFastSearchAppId() {
		return this.fastSearchAppId;
	}

	public String getSpecEmailBody() {
		return specEmailBody;
	}

	public void setSpecEmailBody(String specEmailBody) {
		this.specEmailBody = specEmailBody;
	}
}
