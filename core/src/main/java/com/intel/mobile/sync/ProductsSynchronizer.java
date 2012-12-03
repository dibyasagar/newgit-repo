/**
 * 
 */
package com.intel.mobile.sync;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.jcr.Binary;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.PathNotFoundException;
import javax.jcr.Property;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.commons.jcr.JcrConstants;
import com.day.cq.dam.api.DamConstants;
import com.day.cq.replication.ReplicationActionType;
import com.day.cq.replication.Replicator;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.IntelConfigurationService;
import com.intel.mobile.util.IntelUtil;
import com.intel.mobile.vo.SyncMessageVO;

/**
 * @author skarm1
 *
 */
public class ProductsSynchronizer {

	private static final Logger log = LoggerFactory.getLogger(ProductsSynchronizer.class);
	
	private long countOfProducts = 0;

	public void syncProducts(Session jcrSession, Map<String, String> productTypesMap, SyncMessageVO messages){

		List<String> localeList = new ArrayList<String>();
		
		// Initializing count of products synchronized to 0
		countOfProducts = 0;
		long startTime = System.currentTimeMillis();
		log.info("Products Synchronization Started at " + System.currentTimeMillis());
		
		try {
			Node intelRootNode = jcrSession.getNode(IntelMobileConstants.INTEL_CONTENT_ROOT_NODE_PATH);
			NodeIterator rootNodeIterator = intelRootNode.getNodes();
			while(rootNodeIterator.hasNext()){
				Node countryNode = rootNodeIterator.nextNode();
				NodeIterator countryNodeIterator = countryNode.getNodes();
				while(countryNodeIterator.hasNext()){
					String msgLocale = null;
					try {
						Node localeNode = countryNodeIterator.nextNode();
						if(localeNode.hasNode("jcr:content/locale")){
							Node localeInfoNode =  localeNode.getNode("jcr:content/locale");
							if(localeInfoNode.hasProperty("localeid")){
								String localeId = localeInfoNode.getProperty("localeid").getString();
								msgLocale = localeId;
								log.info("Starting Product Synchronization for locale - " + localeId);
								syncLocaleSpecificProducts(jcrSession, productTypesMap,localeId,localeNode.getPath(), messages);
								log.info("Completed Product Synchronization for locale - " + localeId);
								localeList.add(localeId);
							}
						}
						StringBuilder sb = new StringBuilder();
						sb.append("Sync Products, Locale - ");
						sb.append(msgLocale);
						messages.addSuccessMessage(sb.toString());
					} catch(Exception e) {
						StringBuilder sb = new StringBuilder();
						sb.append("Sync Products, Locale - ");
						sb.append(msgLocale);
						sb.append(", Exception - ");
						sb.append(e.getMessage());					
						messages.addFailureMessage(sb.toString());					
					}
				}				
			}
			log.debug("localeList :"+localeList);
			messages.addSuccessMessage("Sync Products");			
		} catch (PathNotFoundException e) {
			log.error("PathNotFoundException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		} catch (RepositoryException e) {
			log.error("RepositoryException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		} catch (Exception e) {
			log.error("Exception :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products");
			sb.append(", Exception - ");
			sb.append(e.getMessage());
			messages.addFailureMessage(sb.toString());
		} finally {
			long completedTime = System.currentTimeMillis();			
			long totalTime = (completedTime - startTime)/1000;
			log.info("Products Synchronization Completed at " + completedTime + "--- " + Long.toString(totalTime) + "---" + Long.toString(countOfProducts));
			log.info("Total time taken for Sync - " + totalTime);
			log.info("No. of Products Synced - " + countOfProducts);			
		}
	}

	/**
	 * This method gets all the products from intel-shop-API and create nodes in the CRX repository
	 * @param jcrSession
	 * @throws RepositoryException 
	 * @throws PathNotFoundException 
	 */
	public void syncLocaleSpecificProducts(Session jcrSession, Map<String, String> productTypesMap,String locale,String localePath, SyncMessageVO messages) throws PathNotFoundException, RepositoryException{

		log.debug("productTypesMap ::"+productTypesMap);
		log.debug("Synching Data for locale "+locale+" at path "+localePath);
		long totalModified = 0;
		long totalSynced = 0;
		Map<String, Map<String, Set<String>>> prodCatAttrs = new HashMap<String, Map<String, Set<String>>>();
		
		Map<String, Set<String>> prodAttrValues = null;
		boolean needToReplicate = false;
		
		try {
			BundleContext bundleContext = FrameworkUtil.getBundle(IntelConfigurationService.class).getBundleContext();  
			IntelConfigurationService intelConfigService = (IntelConfigurationService) bundleContext.getService(bundleContext.getServiceReference(IntelConfigurationService.class.getName()));	

			BundleContext bndlContext = FrameworkUtil.getBundle(Replicator.class).getBundleContext();  
			Replicator replicator = (Replicator) bndlContext.getService(bndlContext.getServiceReference(Replicator.class.getName()));	

			StringBuffer intelServiceURL = new StringBuffer();
			intelServiceURL.append(intelConfigService.getIntelShopAPIUrl()+"/productservice/getproducts");
			intelServiceURL.append("?locale=").append(locale);
			intelServiceURL.append("&page=1");
			intelServiceURL.append("&pageSize=1");
			intelServiceURL.append("&apikey=").append(intelConfigService.getApiKey());
			intelServiceURL.append("&format=json");

			URL intelShopAPIUrl = new URL(intelServiceURL.toString());
			InputStream productsStream =  intelShopAPIUrl.openStream();

			String jsonTxt = IOUtils.toString(productsStream, org.apache.commons.lang.CharEncoding.UTF_8);
			JSONObject json = new JSONObject(jsonTxt); 
			int totalResults = (Integer)json.get("totalResults");
			log.debug("totalResults :"+totalResults);
			log.debug("jsonTxt :"+jsonTxt);

			int size = Integer.parseInt(intelConfigService.getPageSize());
			int mod = totalResults%size;
			int noOfAPICall = 0;
			if (totalResults<size) {
				noOfAPICall = 1;
			} else if (mod==0) {
				noOfAPICall = totalResults/size;
			} else {
				noOfAPICall = (totalResults/size)+1;
			}
			log.debug("noOfAPICall :"+noOfAPICall);


			Node intelRootNode = jcrSession.getNode(localePath);
			Node productsNode = null;
			Node productCategoryListingNode = null;
			Node productNode = null;
			Node details = null;

			//Retrieve the "products" page if it already exists
			if(intelRootNode.hasNode(IntelMobileConstants.NODE_NAME_PRODUCTS)){
				productsNode = intelRootNode.getNode(IntelMobileConstants.NODE_NAME_PRODUCTS);
				log.debug("products node exists. Retrieved.");
			}else{
				//Create the "products" page if it doesn't exist
				productsNode =  IntelUtil.createNode(intelRootNode, IntelMobileConstants.NODE_NAME_PRODUCTS, IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE);
				Node jcrContentProducts = productsNode.addNode( IntelMobileConstants.NODE_JCR_CONTENT, IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE_CONTENT);
				jcrContentProducts.setProperty(IntelMobileConstants.PROPERTY_CQ_TEMPLATE, IntelMobileConstants.PRODUCT_DETAILS_TEMPLATE_PATH);
				jcrContentProducts.setProperty(IntelMobileConstants.PROPERTY_JCR_TITLE, "Shop Intel Products");
				jcrContentProducts.setProperty(IntelMobileConstants.PROPERTY_SLING_RESOURCETYPE, IntelMobileConstants.PRODUCT_DETAILS_PAGE_COMPONENT_PATH);
				log.debug("products node created.");
			}


			for(int i=1;i<=noOfAPICall;i++){
				try {
					intelServiceURL.delete(0, intelServiceURL.length());
					intelServiceURL.append(intelConfigService.getIntelShopAPIUrl()+"/productservice/getproducts");
					intelServiceURL.append("?locale=").append(locale);
					intelServiceURL.append("&page=").append(i);
					intelServiceURL.append("&pageSize=").append(intelConfigService.getPageSize());
					intelServiceURL.append("&apikey=").append(intelConfigService.getApiKey());
					intelServiceURL.append("&format=json");

					log.debug("Product API URL :"+intelServiceURL.toString());
					intelShopAPIUrl = new URL(intelServiceURL.toString());
					productsStream =  intelShopAPIUrl.openStream();
					int totalproducts=0;
					int crxproducts=0;

					jsonTxt = IOUtils.toString(productsStream, org.apache.commons.lang.CharEncoding.UTF_8);
					json = new JSONObject(jsonTxt); 
					JSONArray products = json.getJSONArray("products");


					for(int j=0; j<products.length();j++){
						String msgName = null;
						String msgCategoryName = null;
						String productId = null;
						try {
							JSONObject product = products.getJSONObject(j);
							String damURL="";
							//log.info("name : "+product.getString("name"));
							//log.info("value : "+product.getString("value"));
							totalproducts++;
							msgName = product.getString("name");
							productId = product.getString("id");

							//Get the category node if it already exists, or create if it doesn't exist.
							String categoryName = productTypesMap.get(product.getString("categoryId"));
							
							prodAttrValues = prodCatAttrs.get(categoryName);
							if(prodAttrValues == null)
							{
								prodAttrValues = new HashMap<String, Set<String>>();
								prodCatAttrs.put(categoryName, prodAttrValues);
							}
							String normalizedCategoryName = IntelUtil.normalizeName(productTypesMap.get(product.getString("categoryId")));
							msgCategoryName = normalizedCategoryName;

							if(productsNode.hasNode(normalizedCategoryName)){
								productCategoryListingNode = productsNode.getNode(normalizedCategoryName);
							}else{
								productCategoryListingNode =  IntelUtil.createNode(productsNode, normalizedCategoryName, IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE);
								Node jcrContentProductCategory = productCategoryListingNode.addNode( IntelMobileConstants.NODE_JCR_CONTENT, IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE_CONTENT);
								jcrContentProductCategory.setProperty(IntelMobileConstants.PROPERTY_CQ_TEMPLATE, IntelMobileConstants.PRODUCT_LISTING_TEMPLATE_PATH);
								jcrContentProductCategory.setProperty(IntelMobileConstants.PROPERTY_JCR_TITLE, categoryName);
								jcrContentProductCategory.setProperty(IntelMobileConstants.PROPERTY_SLING_RESOURCETYPE, IntelMobileConstants.PRODUCT_LISTING_PAGE_COMPONENT_PATH);
							}

							//if(product.getString("id").equals("219244") || product.getString("id").equals("219248")){

							String normalizedProductName = IntelUtil.normalizeName(product.getString("name"));
							Node jcrContent = null;
							if(productCategoryListingNode.hasNode(normalizedProductName)){
								productNode = productCategoryListingNode.getNode(normalizedProductName);
								jcrContent = productNode.getNode(IntelMobileConstants.NODE_JCR_CONTENT);
								if(jcrContent != null)
								{
									if(jcrContent.hasProperty("cq:lastReplicationAction")) {
										Property prop  = jcrContent.getProperty("cq:lastReplicationAction");
										if(prop != null)
										{
											String activated = prop.getString();
											if(activated != null && activated.equals(ReplicationActionType.ACTIVATE))
											{
												needToReplicate = true;
											}
										}
									}
									jcrContent.setProperty(IntelMobileConstants.PROPERTY_JCR_TITLE, StringEscapeUtils.unescapeHtml(product.getString("name")));
									
									details = jcrContent.getNode(IntelMobileConstants.NODE_NAME_DETAILS);
								}
								//log.info(product.getString("id")+ " - "+normalizedProductName+ " Product Node Exists.");
							}else{
								productNode = productCategoryListingNode.addNode(normalizedProductName,IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE);
								jcrContent =  productNode.addNode( IntelMobileConstants.NODE_JCR_CONTENT, IntelMobileConstants.PRIMARY_TYPE_CQ_PAGE_CONTENT);
								jcrContent.setProperty(IntelMobileConstants.PROPERTY_CQ_TEMPLATE, IntelMobileConstants.PRODUCT_DETAILS_TEMPLATE_PATH);
								jcrContent.setProperty(IntelMobileConstants.PROPERTY_JCR_TITLE, StringEscapeUtils.unescapeHtml(product.getString("name")));
								jcrContent.setProperty(IntelMobileConstants.PROPERTY_SLING_RESOURCETYPE, IntelMobileConstants.PRODUCT_DETAILS_PAGE_COMPONENT_PATH);
								details = jcrContent.addNode(IntelMobileConstants.NODE_NAME_DETAILS,IntelMobileConstants.PRIMARY_TYPE_NT_UNSTRUCTURED);
								//log.info(product.getString("id")+ " - "+normalizedProductName+ " Product Node Created.");
							}
							
							/** Start - Getting Product Offers and Similar Products */
							StringBuffer intelProductUrl = new StringBuffer();
							intelProductUrl.append(intelConfigService.getIntelShopAPIUrl()+"/productservice/getproductbyid");
							intelProductUrl.append("?locale=").append(locale);
							intelProductUrl.append("&id=").append(productId);
							intelProductUrl.append("&apikey=").append(intelConfigService.getApiKey());
							intelProductUrl.append("&emitOffers=").append("true");
							intelProductUrl.append("&emitSimilarProducts=").append("true");
							intelProductUrl.append("&emitMatchingFilters=").append("true");
							intelProductUrl.append("&format=json");
							
							URL intelProductByIdAPIUrl = new URL(intelProductUrl.toString());
							InputStream productDetailStream = intelProductByIdAPIUrl.openStream();

							jsonTxt = IOUtils.toString(productDetailStream, org.apache.commons.lang.CharEncoding.UTF_8);
							json = new JSONObject(jsonTxt); 
							
							if(json.getJSONObject("product").has("productOffers")) {
								JSONArray productOffers = json.getJSONObject("product").getJSONArray("productOffers");
								product.put("productOffers", productOffers);
							}
							
							if(json.has("similarProducts")) {
								JSONArray similarProducts = json.getJSONArray("similarProducts");
								product.put("similarProducts", similarProducts);
							}
							if(json.has("product")) {
								String description = json.getJSONObject("product").getString("description");
								product.put("description", description);
							}

							/** End - Getting Product Offers and Similar Products */							
							
							crxproducts++;

							details.setProperty("LastSyncDate", Calendar.getInstance());
							
							
							boolean changed = IntelUtil.saveAPIDataAsJCRProperty(details, product, prodAttrValues);
							
							if(changed && jcrContent != null) {
								if(jcrSession.getUserID() != null) {
									jcrContent.setProperty(Property.JCR_LAST_MODIFIED_BY, jcrSession.getUserID());
								}								
								jcrContent.setProperty(Property.JCR_LAST_MODIFIED,  Calendar.getInstance());
								totalModified++;
							}
							totalSynced++;
							if(intelConfigService.isSyncImage()){
								try {
									Node damintelRootNode = jcrSession.getNode(IntelMobileConstants.INTEL_DAM_CONTENT_ROOT_NODE_PATH);
									Node damImagesNode = null ;
	
									//Create the "images" node under "/content/dam/intelmobile/shop/products"" if it doesn't exist
									if(damintelRootNode.hasNode(IntelMobileConstants.DAM_NODE_NAME_SHOPIMAGE)){
										log.debug("INTEL_DAM_CONTENT_ROOT_NODE_PATH node exists>>"+IntelMobileConstants.DAM_NODE_NAME_SHOPIMAGE);
										damImagesNode = damintelRootNode.getNode(IntelMobileConstants.DAM_NODE_NAME_SHOPIMAGE);
									}else{
										log.debug("INTEL_DAM_CONTENT_ROOT_NODE_PATH node CREATED>>"+IntelMobileConstants.DAM_NODE_NAME_SHOPIMAGE);
										damImagesNode = IntelUtil.createNode(damintelRootNode, IntelMobileConstants.DAM_NODE_NAME_SHOPIMAGE, IntelMobileConstants.SLING_FOLDER_TYPE);
									}
									
									if(product.getString("picture").toString().length()>0 && product.getString("picture").toString()!=null){									
										damURL=syncImageURL(product.getString("picture"),product.getString("id"),jcrSession,damImagesNode, messages);									
										details.setProperty(IntelMobileConstants.PROPERTY_NAME_DAM_IMAGE_URL,damURL);
									}else{
										log.debug("no url PID "+product.getString("id"));
									}
								}catch (Exception e) {
									log.error("Can not sync dam images ", e);
								}
								
							}

							jcrSession.save();
							//log.info("details :"+productNode);
							if(details != null){
								log.debug("Replicating the node : "+productNode.getPath());
								if(needToReplicate)
								{
									replicator.replicate(jcrSession, ReplicationActionType.ACTIVATE, productNode.getPath());
								}
							}else{
								log.debug("details node is null.");
							}
														
							//}
							StringBuilder sb = new StringBuilder();
							sb.append("Sync Products, Locale - ");
							sb.append(locale);
							sb.append(", Name - ");
							sb.append(msgName);
							sb.append(", Category Name - ");
							sb.append(msgCategoryName);
							messages.addSuccessMessage(sb.toString());					
							
						} catch(Exception e) {
							StringBuilder sb = new StringBuilder();
							sb.append("Sync Products, Locale - ");
							sb.append(locale);
							sb.append(", Name - ");
							sb.append(msgName);
							sb.append(", Category Name - ");
							sb.append(msgCategoryName);
							sb.append(", Exception - ");
							sb.append(e.getMessage());
							messages.addFailureMessage(sb.toString());	
							log.error("Error Occurred - ", e);
						}
					}
					log.debug("totalproducts" +totalproducts);
					log.debug("crxproducts"+crxproducts);
					countOfProducts += crxproducts;
					jcrSession.save();
					
					StringBuilder sb = new StringBuilder();
					sb.append("Sync Products, Locale - ");
					sb.append(locale);
					messages.addSuccessMessage(sb.toString());					
				} catch(Exception e) {
					StringBuilder sb = new StringBuilder();
					sb.append("Sync Products, Locale - ");
					sb.append(locale);
					sb.append(", Exception - ");
					sb.append(e.getMessage());					
					messages.addFailureMessage(sb.toString());																
				}				
			}
			//jcrSession.save();
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products, Locale - ");
			sb.append(locale);
			messages.addSuccessMessage(sb.toString());

		} catch (MalformedURLException e) {
			log.error("MalformedURLException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products, Locale - ");
			sb.append(locale);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());																
		} catch (IOException e) {
			log.error("IOException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products, Locale - ");
			sb.append(locale);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());																
		} catch (JSONException e) {
			log.error("JSONException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products, Locale - ");
			sb.append(locale);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());																
		} catch(Exception e) {
			log.error("Exception :"+e.getMessage());			
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Products, Locale - ");
			sb.append(locale);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());																
		}
		finally{
			if(prodCatAttrs != null)
			{
				Set<String> keys = prodCatAttrs.keySet();
				if(keys != null)
				{
					for(String key : keys)
					{
						Map<String, Set<String>> prodAttrs = prodCatAttrs.get(key);
						log.debug("*** " + key);
						if(prodAttrs != null)
						{
							Set<String> prodAttrsKeys = prodAttrs.keySet();
							if(prodAttrsKeys != null)
							{
								for(String key1 : prodAttrsKeys)
								{
									if(key1.equals("bestPrice") || key1.equals("os") || key1.equals("screen") || key1.equals("weight") 
											|| key1.equals("speed") || key1.equals("ram") || key1.equals("hardDrive") || key1.equals("processor") )
									{
										log.debug("********* " + key1);
										Set<String> attrValues = prodAttrs.get(key1);
										
										if(attrValues != null)
										{
											for(String value : attrValues)
											{
												log.debug("******************** " + value);
											}
										}
									}
								}
							}
						}
					}
				}
			}
			log.info("Total Products in CRX for locale " + locale + " - " + totalSynced);
			log.info("Total Products Created/Modified for locale " + locale + " - " + totalModified);			
		}
		
	}

	public String syncImageURL(String url, String productId,Session jcrSession,Node imageNode, SyncMessageVO messages){

		String damImageURL="";
		try {
			log.debug("url :"+url+", ID :"+productId);
			String temp = url.substring(0,url.lastIndexOf('&'));
			temp= temp.substring(0,temp.lastIndexOf('&'));
			String filename=temp.substring(url.lastIndexOf('/')+1);
			//log.info("filename : "+filename);

			String imageURLExceptSize = url;
			if(url.contains("&height")){
			  imageURLExceptSize = url.substring(0, url.indexOf("&height"));
			}
			log.debug("imageURLExceptSize :: "+imageURLExceptSize);
			URL imageURL = new URL(imageURLExceptSize);
			URLConnection imageUrlConnection = imageURL.openConnection();
			InputStream is = imageUrlConnection.getInputStream();
			String mimeType = imageUrlConnection.getContentType();

			Binary binary = jcrSession.getValueFactory().createBinary(is);

			Node damAssetNode = null;
			Node damJcrContentNode = null;
			Node renditionsNode = null;
			Node damOriginalFileNode = null;
			if(imageNode.hasNode(filename)){
				damAssetNode = imageNode.getNode(filename);
				damJcrContentNode = damAssetNode.getNode(JcrConstants.JCR_CONTENT);
				renditionsNode = damJcrContentNode.getNode(DamConstants.RENDITIONS_FOLDER);
				damOriginalFileNode = renditionsNode.getNode(DamConstants.ORIGINAL_FILE);
				//log.info("Dam Node "+damAssetNode.getPath()+ " exists.");
			}else{
				damAssetNode = imageNode.addNode(filename,DamConstants.NT_DAM_ASSET);
				damJcrContentNode= damAssetNode.addNode(JcrConstants.JCR_CONTENT,DamConstants.NT_DAM_ASSETCONTENT);
				renditionsNode=damJcrContentNode.addNode(DamConstants.RENDITIONS_FOLDER,JcrConstants.NT_FOLDER);
				Node metaDataNode = damJcrContentNode.addNode(DamConstants.METADATA_FOLDER,JcrConstants.NT_UNSTRUCTURED);
				damOriginalFileNode=renditionsNode.addNode(DamConstants.ORIGINAL_FILE,JcrConstants.NT_FILE);
				Node damFileJcrContentNode= damOriginalFileNode.addNode(JcrConstants.JCR_CONTENT,JcrConstants.NT_RESOURCE);
				damFileJcrContentNode.setProperty(JcrConstants.JCR_DATA, binary);
				damFileJcrContentNode.setProperty(JcrConstants.JCR_MIMETYPE, mimeType);
				damFileJcrContentNode.setProperty(JcrConstants.JCR_LASTMODIFIED, Calendar.getInstance());
				//log.info("Dam Node "+damAssetNode.getPath()+ " was created.");
			}

			damImageURL=damOriginalFileNode.getPath().toString();
			jcrSession.save();
			
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Image URL, Product Id - ");
			sb.append(productId);
			messages.addSuccessMessage(sb.toString());					

			//log.info("damImageURL: "+damImageURL);
			return damImageURL;

		} catch (MalformedURLException e) {
			log.error("MalformedURLException :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Image URL, Product Id - ");
			sb.append(productId);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());					
		} catch (IOException e) {
			log.error("IOException :"+e.getMessage());
			e.printStackTrace();
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Image URL, Product Id - ");
			sb.append(productId);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());								
		}
		catch (Exception e) {
			log.error("Exception :"+e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("Sync Image URL, Product Id - ");
			sb.append(productId);
			sb.append(", Exception - ");
			sb.append(e.getMessage());			
			messages.addFailureMessage(sb.toString());					
		}
		return damImageURL; 


	}





}
