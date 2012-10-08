/**
 * 
 */
package com.intel.mobile.services;

/**
 * @author skarm1
 *
 */
public interface IntelConfigurationService {

	public String getApiKey();
	public void setApiKey(String apiKey);
	public String getIntelShopAPIUrl();
	public void setIntelShopAPIUrl(String intelShopAPIUrl);
	public String getPageSize();
	public void setPageSize(String pageSize);
	public String getArkApiUrl();
	public void setArkApiUrl(String arkProcessorApiUrl);
	public String getArkApiKey();
	public void setArkApiKey(String arkApiKey);
	/*public String getTopSize();
	public void setTopSize(String topSize);*/	
	public boolean isSyncJobDisabled();
	public void setSyncJobDisabled(boolean disabled);
	public boolean isSyncImage();
	public void setSyncImage(boolean isSyncImage);

	public String getWapTrackingEnv();
	public void setWapTrackingEnv(String wapTrackingEnv);
    public void setFastSearchUrl(String fastSearchUrl);
	public void setFastSearchAppId(String fastSearchAppId);
	public String getFastSearchUrl();
	public String getFastSearchAppId();

}
