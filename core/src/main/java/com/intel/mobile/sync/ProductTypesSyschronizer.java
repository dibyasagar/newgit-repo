/**
 * 
 */
package com.intel.mobile.sync;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.io.IOUtils;
import org.apache.felix.scr.annotations.Reference;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.IntelConfigurationService;
import com.intel.mobile.services.impl.IntelConfigurationServiceImpl;
import com.intel.mobile.services.impl.ShopSchedulerServiceImpl;
import com.intel.mobile.util.IntelUtil;
import com.intel.mobile.vo.SyncMessageVO;

/**
 * @author skarm1
 *
 */
public class ProductTypesSyschronizer {

	private static final Logger log = LoggerFactory.getLogger(ProductTypesSyschronizer.class);
	
	
	/**
	 * This method gets all the Product Types from intel-shop-API and create nodes in the CRX repository
	 * @param jcrSession
	 * @throws RepositoryException 
	 * @throws PathNotFoundException 
	 */
	public Map<String, String> syncProductTypes(Session jcrSession, SyncMessageVO messages) throws PathNotFoundException, RepositoryException{

		Map<String, String> productTypesMap = new HashMap<String, String>();
		
		try {
			BundleContext bundleContext = FrameworkUtil.getBundle(IntelConfigurationService.class).getBundleContext();  
			IntelConfigurationService intelConfigService = (IntelConfigurationService) bundleContext.getService(bundleContext.getServiceReference(IntelConfigurationService.class.getName()));	
		
			StringBuffer intelServiceURL = new StringBuffer();
			intelServiceURL.append(intelConfigService.getIntelShopAPIUrl()+"/helperservice/getproducttypes");
			intelServiceURL.append("?&apikey=").append(intelConfigService.getApiKey());
			intelServiceURL.append("&format=json");
			log.info("ProductTypes APi URL ::"+intelServiceURL.toString());
			URL intelShopAPIUrl = new URL(intelServiceURL.toString());
			InputStream productTypesStream =  intelShopAPIUrl.openStream();

			String jsonTxt = IOUtils.toString(productTypesStream);
			JSONObject json = new JSONObject(jsonTxt); 
			JSONArray items = json.getJSONArray("items");

			//Commenting this part as product types need not to be created in CRX
			
		/*	Node intelRootNode = jcrSession.getNode(IntelMobileConstants.INTEL_CONTENT_LOCALE_ENGLISH_NODE_PATH);
			Node shopNode = null ;
			Node productTypesNode = null;
			if(intelRootNode.hasNode(IntelMobileConstants.NODE_NAME_SHOP)){
				shopNode = intelRootNode.getNode(IntelMobileConstants.NODE_NAME_SHOP);
			}else{
				shopNode = IntelUtil.createNode(intelRootNode, IntelMobileConstants.NODE_NAME_SHOP, IntelMobileConstants.SLING_FOLDER_TYPE);
			}

			if(shopNode.hasNode(IntelMobileConstants.NODE_NAME_PRODUCTTYPES)){
				productTypesNode = shopNode.getNode(IntelMobileConstants.NODE_NAME_PRODUCTTYPES);
				productTypesNode.remove();
			}
			productTypesNode =  IntelUtil.createNode(shopNode, IntelMobileConstants.NODE_NAME_PRODUCTTYPES, IntelMobileConstants.SLING_FOLDER_TYPE);*/

			for(int i=0; i<items.length();i++){
				String msgName = null;
				try {
					JSONObject item = items.getJSONObject(i);
					msgName = item.getString("name");
					/*log.info("name : "+item.getString("name"));
					log.info("value : "+item.getString("value"));*/
					//Commenting this part as product types need not to be created in CRX
					/*Node productTypeNode = productTypesNode.addNode(IntelMobileConstants.NODE_NAME_PRODUCTTYPE+i);
					productTypeNode.setProperty(IntelMobileConstants.PROPERTY_NAME_NAME, item.getString("name"));
					productTypeNode.setProperty(IntelMobileConstants.PROPERTY_NAME_VALUE, item.getString("value"));*/
					productTypesMap.put(item.getString("value"), item.getString("name"));
					
					StringBuilder sb = new StringBuilder();
					sb.append("Sync Product Types, Name - ");
					sb.append(msgName);
					messages.addSuccessMessage(sb.toString());					
				} catch(Exception e) {					
					StringBuilder sb = new StringBuilder();
					if(msgName != null) {
						sb.append("Sync Product Types, Name - ");
						sb.append(msgName);
					} else {
						sb.append("Sync Product Types");
					}
					sb.append(", Exception - ");
					sb.append(e.getMessage());				
					messages.addFailureMessage(sb.toString());				
				}
			}
			jcrSession.save();
			messages.addSuccessMessage("Sync Product Types");
			log.info("jsonTxt :"+jsonTxt);

		} catch (MalformedURLException e) {
			log.error("MalformedURLException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Product Types");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		} catch (IOException e) {
			log.error("IOException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Product Types");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		} catch (JSONException e) {
			log.error("JSONException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Product Types");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		}
		
		return productTypesMap;
	}
	

	
}
