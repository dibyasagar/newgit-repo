package com.intel.mobile.util;

import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.Property;
import javax.jcr.PropertyIterator;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;

import org.apache.commons.io.IOUtils;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.IntelConfigurationService;
import com.intel.mobile.vo.ProductDetailsVo;

/**
 * 
 * @author ujverm
 *
 */
public class ProductUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ProductUtil.class);
	private static final String PROPERTY_ARK_PRODUCT_ID = "750";
	private static final String PROPERTY_ARK_DEEP_LINK = "Link";
	private static final String FEATURES_TAG_PATH = "intelmobile:";
	
	
	public static Map<String, String> getProcessorSpec(Page page) throws Exception{
		if(LOGGER.isDebugEnabled())	LOGGER.debug("Method Start with parameter Page - " + page.getPath());
		Map<String, String> specs = new HashMap<String, String>();
		String linkURL = "";
		String arkProductId = null;
		try {
			Node detailNode = page.getContentResource().getChild("details").adaptTo(Node.class);
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug("Detail node path - " + detailNode.getPath());
			}
			PropertyIterator pIterator = detailNode.getProperties("1* | 2* | 3* | 4* | 5* | 6* | 7* | 8* | 9*");
			while(pIterator.hasNext()) {
				try {
					Property property = pIterator.nextProperty();
					if(property.getValue() != null && property.getValue().getString().length()>0) {
						String s = property.getValue().getString();
						String s1 = s.substring(0, s.indexOf("|"));
						String s2 = s.substring(s.indexOf("|")+1);					
						if(s2 != null && s2.length()>0 && !s2.trim().equals("?"))
						{	
							specs.put(s1, s2);
						}
						if(property.getName().equals(PROPERTY_ARK_PRODUCT_ID)) arkProductId = s2;
					}					
				} catch(Exception e) {
					LOGGER.error("[getProcessorSpec]Error while iterating ARK properties - " + e.toString());
				}
			}
			try {
				if(arkProductId != null) {
									
					//Sample API Link = http://odata.intel.com/API/v1_0/Products/Processors?&$format=json&api_key=8B74915ED25D4FA0B734B75BE2030BB6&$filter=ProductId%20eq%2065523
					if(LOGGER.isDebugEnabled()) {
						LOGGER.debug("Getting Deep Link for ARK Product ID : "+arkProductId);
					}
					StringBuffer arkURL = new StringBuffer();
					arkURL.append(IntelUtil.getIntelConfigService().getArkApiUrl()).append(IntelMobileConstants.ARK_PRODUCT_TYPE_PROCESSORS).append("?");
					arkURL.append("$format=json");
					arkURL.append("&api_key=").append(IntelUtil.getIntelConfigService().getArkApiKey());
					arkURL.append("&$filter=ProductId%20eq%20").append(arkProductId);
					if(LOGGER.isDebugEnabled()) {
						LOGGER.debug("arkURL : "+arkURL);
					}
					URL arkAPIUrl = new URL(arkURL.toString());
					InputStream arkProductStream =  arkAPIUrl.openStream();
					String jsonTxt = IOUtils.toString(arkProductStream);
					JSONObject json = new JSONObject(jsonTxt); 
					JSONArray dArray = json.getJSONArray("d");
					if(dArray.length()>0){
					linkURL = dArray.getJSONObject(0).getString("Link");
					if(LOGGER.isDebugEnabled()) {
						LOGGER.debug("Deep Link :"+linkURL);
					}
					
					/* Manipulation of ARK link Start */
					String arkLinkPrefix = IntelUtil.getConfigValue(page,"processorspecs", "arklinkprefix","/m");
					if(LOGGER.isDebugEnabled()){
					LOGGER.debug("arkLinkPrefix :"+arkLinkPrefix);
					}
					linkURL = linkURL.replace("/products/", arkLinkPrefix+"/products/");
					if(LOGGER.isDebugEnabled()) {
						LOGGER.debug("ARK product link :"+linkURL);
					}
					/* Manipulation of ARK link End */
	
					specs.put("linkURL", linkURL);	
				} 
			}
					else {
					LOGGER.error("Error while retreiving Product Id - Product Id not available");
				}
			} catch(Exception e) {
				LOGGER.error("[getProcessorSpec] Error while retrieving ARK Product Node - " + e.toString());
			}
		} catch(Exception e) {
			LOGGER.error("[getProcessorSpec] Error Occurred - " + e.toString());
		}
		if(LOGGER.isDebugEnabled())	LOGGER.debug("Method End with return value - " + specs);
		return specs;
	}
	
	public static Map<String, String> getProductMetaTags(ResourceResolver resolver, Page page) {
		
		Map<String, String> metaTags = new HashMap<String, String>();
		String metaName ="";
		String metaValue = "";
		
		String category = page.getParent().getName();
		String locale = IntelUtil.getLocale(page);

		metaTags.put(IntelMobileConstants.META_TAG_SITE_SECTION,"1");
		
		try {
			String description = "";
			Node jcrNode = page.getContentResource().adaptTo(Node.class);
			if(jcrNode.hasProperty("jcr:description")) {
				description = jcrNode.getProperty("jcr:description").getString();
				if(description != null && description.length()>0) {
					metaTags.put(IntelMobileConstants.META_TAG_DESCRIPTION, description);					
				}
			}			
		} catch(Exception e) {
			LOGGER.error("getProductMetaTags() - Error while retrieving jcr:description property ", e);
		}
		
		
		
		metaName= "Mobile^" +IntelMobileConstants.META_TAG_FILTER_PAGETYPE+";Mobile^" + IntelMobileConstants.META_TAG_FILTER_CATEGORY+";";						
		metaValue = "Mobile^" +IntelMobileConstants.META_TAG_FILTER_PAGETYPE+"^Product;Mobile^" + IntelMobileConstants.META_TAG_FILTER_CATEGORY+"^" + category + ";";

		metaName += "Mobile^" + IntelMobileConstants.META_TAG_PRODUCT_PATH + ";";
		metaValue += "Mobile^" + IntelMobileConstants.META_TAG_PRODUCT_PATH + "^" + page.getPath() + ";";
		
		try {
			Node detailNode = page.getContentResource().getChild("details").adaptTo(Node.class);	
					
			/* Meta Tags generation for Filter */
			try {
				Map<String, String> filterList = getFilterTagsMasterList();
				for(String metaname:filterList.keySet()) {
						String crxattr = filterList.get(metaname);
						String name = "";
						String value = "";
						try {
						if(detailNode.hasProperty(crxattr)) {
							name = metaname;
							value = detailNode.getProperty(crxattr).getString();
							value = value.trim();
							
							if(value.length()>0) {
								if(crxattr.matches("[1-9][0-9]*")) {
									String s = value.substring(value.indexOf("|")+1);					
									value = s;
								} 
								value = value.replaceAll("\"", "");
								/* Check if the value is numeric*/
/*								if(value.substring(0,1).matches("[0-9]") && 
										!name.equals(IntelMobileConstants.META_TAG_FILTER_PRODUCT_ID)) {
									String temp = value;
									if(temp.indexOf(" ") > 0) {
										temp = temp.substring(0,temp.indexOf(" "));			
									}
									if(temp.indexOf("\"") > 0) {
				                        temp = temp.substring(0,temp.indexOf("\""));                    
									}										
									if(temp.indexOf(",") > 0) {
				                        temp = temp.replaceAll(",","");                    
									}																												
									if(temp.matches("^(?:[0-9]\\d*|0)?(?:\\.\\d+)?$")) {										
										metaTags.put(name, temp);
										value = temp;
									}
								}	*/										
							}
							
						} else {
							if(LOGGER.isDebugEnabled()) {
								LOGGER.debug("getProductMetaTags() - attribute not found - " + crxattr);
							}
						}					
							
						if(value != null && value.length()>0) {
							metaName= metaName + "Mobile^" + name + ";";
							metaValue = metaValue + "Mobile^" + name + "^" + value + ";";							
						}
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getProductMetaTags() - Meta name - " + name + ", Value - " + value);
						}
					} catch(Exception e) {
						LOGGER.error("getProductMetaTags() - Exception occured while processing tag for - " + crxattr);
					}
				}
			} catch(Exception e) {
				LOGGER.error("getProductMetaTags() - while generating filter meta tags - " + e);
			}
			if(metaValue.length()>0) {
				metaTags.put("reimaginetoplevelcategory", 
						metaName.substring(0, metaName.lastIndexOf(";")));
				metaTags.put("reimaginesublevelcategory", 
						metaValue.substring(0, metaValue.lastIndexOf(";")));			
			}
			
			/* Meta Tags generation for Sort */
			try {			
				Map<String, String> sortList = getSortTagsMasterList();
				for(String metaname:sortList.keySet()) {				
					String crxattr = sortList.get(metaname);
					String name = "";
					String value = "";
					try {
						if(detailNode.hasProperty(crxattr)) {
						name = metaname;
						value = detailNode.getProperty(crxattr).getString();
						value = value.trim();
							
							if(value.length()>0) {
								if(crxattr.matches("[1-9][0-9]*")) {
									String s = value.substring(value.indexOf("|")+1);					
									value = s;
								} 
	
								/* Check if the value is numeric*/
								if(value.substring(0,1).matches("[0-9]")) {
									String temp = value.replaceAll(",", "");
									if(temp.indexOf(" ") > 0) {
										temp = temp.substring(0,temp.indexOf(" "));			
									}
									if(temp.indexOf("\"") > 0) {
				                        temp = temp.substring(0,temp.indexOf("\""));                    
									}						
									if(temp.indexOf(",") > 0) {
				                        temp = temp.replaceAll(",","");                    
									}																												
									if(temp.matches("^(?:[0-9]\\d*|0)?(?:\\.\\d+)?$")) {
										value = temp;
									}
								}
							}
							
						} else {
							if(LOGGER.isDebugEnabled()) {
								LOGGER.debug("getProductMetaTags() - attribute not found - " + crxattr);	
							}							
						}					
						if(value != null && value.length()>0) {
							if(!metaTags.keySet().contains(name)) {
								metaTags.put(name, value);
							}
						}
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getProductMetaTags() - Meta name - " + name + ", Value - " + value);
						}
					} catch(Exception e) {
						LOGGER.error("getProductMetaTags() - Exception occured while processing tag for - " + crxattr);
					}
				}
			} catch(Exception e) {
				LOGGER.error("getProductMetaTags() - Exception occured while generating sort meta tags - " + e);
			}
			
		} catch(Exception e) {
			LOGGER.error("getProductMetaTags() - Exception occured - " + e);
		}

		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("getProductMetaTags() - Final Meta name - " 
				+ metaName + ", Final Value - " + metaValue);
		}
		return metaTags;
	}		
	
	public static Map<String, String> getFeatures(ResourceResolver resolver, Page page) {
		Map<String, String> features = new LinkedHashMap<String, String>();
		TagManager tagManager = resolver.adaptTo(TagManager.class);
		try {
			String category = page.getParent().getName();
			String locale = IntelUtil.getLocale(page);
			Node detailNode = page.getContentResource().getChild("details").adaptTo(Node.class);			
			String tagPath = FEATURES_TAG_PATH + locale + "/products/" + category + "/features";
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Tag Path - " + tagPath);
			}
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Detail Node Path - " + detailNode.getPath());
			}
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Page Locale - " + locale);
			}
			Tag tag = tagManager.resolve(tagPath);
			if(tag != null){
			Iterator<Tag> tagList = tag.listChildren();
			while(tagList.hasNext()) {
				Tag attribute = (Tag) tagList.next();
				try {
					if(detailNode.hasProperty(attribute.getName())) {
						String attributeTitle = attribute.getTitle();
						String attributeValue = detailNode.getProperty(attribute.getName()).getString();
						if(attributeValue != null && attributeValue.length()>0) {
							features.put(attributeTitle, attributeValue);	
						}					
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getFeatures() - Attribute - " + attributeTitle + ", Value - " + attributeValue);
						}
					} else {
						LOGGER.error("getFeatures() - attribute not found - " + attribute.getName());
					}					
				} catch(Exception e) {
					LOGGER.error("getFeatures() - Exception occured while processing tag for - " + attribute.getName());
				}
			}}
		} catch(Exception e) {
			LOGGER.error("getFeatures() - Exception occured - " ,e);
		}
		return features;
	}
	
	public static Map<String, String> getFeaturesList(ResourceResolver resolver, Locale locale, String category) {
		Map<String, String> featuresMap = new LinkedHashMap<String, String>();
		
		TagManager tagManager = resolver.adaptTo(TagManager.class);
		try {
		
			String tagPath = FEATURES_TAG_PATH + locale.toString() + "/products/" + category + "/features";
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Tag Path - " + tagPath);
			}
			Tag tag = tagManager.resolve(tagPath);
			Iterator<Tag> tagList = tag.listChildren();
			while(tagList.hasNext()) {
				Tag attribute = (Tag) tagList.next();
				try {
						String tagName = attribute.getName();
						String tagTitle = attribute.getTitle();
						featuresMap.put(tagName, tagTitle);	
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getFeaturesList() - Attribute - " + tagName + ", Value - " + tagTitle);
						}
				} catch(Exception e) {
					LOGGER.error("getFeatures() - Exception occured while processing tag for - " + attribute);
				}
			}
		} catch(Exception e) {
			LOGGER.error("getFeaturesList() - Exception occured - " + e);
		}
		return featuresMap;		
	}
	
	public static Map<String, String> getFeaturesList(TagManager tagManager, Locale locale, String category) {
		Map<String, String> featuresMap = new LinkedHashMap<String, String>();
		
		try {
		
			String tagPath = FEATURES_TAG_PATH + locale.toString() + "/products/" + category + "/features";
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Tag Path - " + tagPath);
			}
			Tag tag = tagManager.resolve(tagPath);
			Iterator<Tag> tagList = tag.listChildren();
			while(tagList.hasNext()) {
				Tag attribute = (Tag) tagList.next();
				try {
						String tagName = attribute.getName();
						String tagTitle = attribute.getTitle();
						featuresMap.put(tagName, tagTitle);	
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getFeaturesList() - Attribute - " + tagName + ", Value - " + tagTitle);
						}
				} catch(Exception e) {
					LOGGER.error("getFeatures() - Exception occured while processing tag for - " + attribute);
				}
			}
		} catch(Exception e) {
			LOGGER.error("getFeaturesList() - Exception occured - " + e);
		}
		return featuresMap;		
	}
	
	private static Map<String, String> getFilterTagsMasterList() {
		Map<String, String> metaTagsMaster = new HashMap<String, String>();
		
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PRODUCT_ID, 
				IntelMobileConstants.CRX_ATTR_PRODUCT_ID);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_TAG_LINE, 
				IntelMobileConstants.CRX_ATTR_TAG_LINE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PRODUCT_NAME, 
				IntelMobileConstants.CRX_ATTR_PRODUCT_NAME);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PICTURE_URL,
				IntelMobileConstants.CRX_ATTR_PICTURE_URL);		
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_CAPACITY, 
				IntelMobileConstants.CRX_ATTR_CAPACITY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_RAM, 
				IntelMobileConstants.CRX_ATTR_RAM);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PROCESSOR_FAMILY, 
				IntelMobileConstants.CRX_ATTR_PROCESSOR_FAMILY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PRICE, 
				IntelMobileConstants.CRX_ATTR_PRICE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_MANUFACTURER, 
				IntelMobileConstants.CRX_ATTR_MANUFACTURER);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_HARD_DRIVE_SIZE, 
				IntelMobileConstants.CRX_ATTR_HARD_DRIVE_SIZE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_OPERATING_SYSTEM, 
				IntelMobileConstants.CRX_ATTR_OPERATING_SYSTEM);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PROCESSOR, 
				IntelMobileConstants.CRX_ATTR_PROCESSOR);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_SCREEN_SIZE, 
				IntelMobileConstants.CRX_ATTR_SCREEN_SIZE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_SSD_FAMILY, 
				IntelMobileConstants.CRX_ATTR_SSD_FAMILY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_FORM_FACTOR, 
				IntelMobileConstants.CRX_ATTR_FORM_FACTOR);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_INTERFACE, 
				IntelMobileConstants.CRX_ATTR_INTERFACE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_PLATFORM, 
				IntelMobileConstants.CRX_ATTR_PLATFORM);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_CARRIER, 
				IntelMobileConstants.CRX_ATTR_CARRIER);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_COUNTRY, 
				IntelMobileConstants.CRX_ATTR_COUNTRY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_CONVERTABILITY, 
				IntelMobileConstants.CRX_ATTR_CONVERTABILITY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_WIFI, 
				IntelMobileConstants.CRX_ATTR_WIFI);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_3G, 
				IntelMobileConstants.CRX_ATTR_3G);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_THICKNESS, 
				IntelMobileConstants.CRX_ATTR_THICKNESS);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_WEIGHT, 
				IntelMobileConstants.CRX_ATTR_WEIGHT);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_BOARDFAMILY, 
				IntelMobileConstants.CRX_ATTR_BOARDFAMILY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_BOARDFORMFACTOR, 
				IntelMobileConstants.CRX_ATTR_BOARDFORMFACTOR);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_BOARDSERIES, 
				IntelMobileConstants.CRX_ATTR_BOARDSERIES);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_CHIPSET, 
				IntelMobileConstants.CRX_ATTR_CHIPSET);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_INTEGRETEDGRAPHICS, 
				IntelMobileConstants.CRX_ATTR_INTEGRETEDGRAPHICS);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_MEMORY, 
				IntelMobileConstants.CRX_ATTR_MEMORY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_SOCKET, 
				IntelMobileConstants.CRX_ATTR_SOCKET);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_CAPACITY, 
				IntelMobileConstants.CRX_ATTR_CAPACITY);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_FORM_FACTOR, 
				IntelMobileConstants.CRX_ATTR_FORM_FACTOR);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_SEQ_READ_WRITE, 
				IntelMobileConstants.CRX_ATTR_SEQ_READ_WRITE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_INTERFACE, 
				IntelMobileConstants.CRX_ATTR_INTERFACE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_FILTER_RAN_READ_WRITE , 
				IntelMobileConstants.CRX_ATTR_RAN_READ_WRITE);
				
		
		return metaTagsMaster;
	}

	private static Map<String, String> getSortTagsMasterList() {
		Map<String, String> metaTagsMaster = new HashMap<String, String>();
		
		metaTagsMaster.put(IntelMobileConstants.META_TAG_SORT_PRICE, 
				IntelMobileConstants.CRX_ATTR_PRICE);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_SORT_MANUFACTURER, 
				IntelMobileConstants.CRX_ATTR_MANUFACTURER);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_SORT_PLATFORM, 
				IntelMobileConstants.CRX_ATTR_PLATFORM);
		metaTagsMaster.put(IntelMobileConstants.META_TAG_SORT_PRODUCT_NAME, 
				IntelMobileConstants.CRX_ATTR_PRODUCT_NAME);
		
		return metaTagsMaster;
	}
	
	public static Map<String, Object> getProductListing(String product, int noOfProducts, Page currentPage) {
		Map<String, Object> results = new HashMap<String, Object>();

		results.put("totalCount", null);
		results.put("results", "0");		

		try {
		
			IntelConfigurationService intelConfig = 
				IntelUtil.getIntelConfigService();
			
			
			String fastUrl = intelConfig.getFastSearchUrl();
			String language = intelConfig.getFastSearchAppId(); //Application Id
	
			StringBuffer searchUrlString = new StringBuffer();
			searchUrlString.append(fastUrl);
			searchUrlString.append("?q1=").append(language);
			//searchUrlString.append("&q2=en");
			searchUrlString.append("&q2=").append(IntelUtil.getLocaleLanguage(currentPage));
			searchUrlString.append("&q3="+noOfProducts);
			searchUrlString.append("&q6=0");
			searchUrlString.append("&q10=localecode:"+IntelUtil.getLocale(currentPage)+":exactphrase~reimaginesublevelcategory:Mobile^pagetype^Product:anyword~reimaginesublevelcategory:Mobile^category^").append(product).append(":anyword");
			searchUrlString.append("&q11=reimaginesublevelcategory,url");
			searchUrlString.append("&q23=:");
			searchUrlString.append("&q24=~");
			searchUrlString.append("&q32=and");
	
			LOGGER.info("searchUrlString :"+searchUrlString.toString());
			URL searchUrl = new URL(searchUrlString.toString());
			InputStream resultsStream = searchUrl.openStream();
			
			String jsonTxt = IOUtils.toString(resultsStream,"UTF-8");
			//LOGGER.info("---jsonTxt ---"+jsonTxt);
			JSONObject json = new JSONObject(jsonTxt); 
			String totalResults = json.getString("TotalCount");
			List<Map<String,String>> resultsList =
				new ArrayList<Map<String,String>>();
			
			if(!totalResults.equals("0")) {
				JSONArray resultset = json.getJSONArray("ResultSet");
								
		
					for(int i=0;i<resultset.length();i++) {
						Map<String, String> item = new HashMap<String, String>();
						JSONArray fieldList = 
							resultset.getJSONObject(i).getJSONArray("FieldList");
						String itemValue = fieldList.getJSONObject(0).getString("FieldValue");
						//LOGGER.info("---itemvalue---"+itemValue);
						URL url = new URL(fieldList.getJSONObject(1).getString("FieldValue"));
						String itemUrl = url.getPath();
						
						item.put("productName", 
								parseFieldFromResponse(itemValue, 
										IntelMobileConstants.META_TAG_FILTER_PRODUCT_NAME));
		
						item.put("price", 
								parseFieldFromResponse(itemValue, 
										IntelMobileConstants.META_TAG_FILTER_PRICE));
		
						item.put("tagLine", 
								parseFieldFromResponse(itemValue,
										IntelMobileConstants.META_TAG_FILTER_TAG_LINE));
		
						String productPath = parseFieldFromResponse(itemValue, IntelMobileConstants.META_TAG_PRODUCT_PATH);
						
						item.put("productPath", productPath);
						
						item.put("pictureUrl", 
								parseFieldFromResponse(itemValue, 
										IntelMobileConstants.META_TAG_FILTER_PICTURE_URL));
						
						item.put("productId", productPath.substring(productPath.lastIndexOf("/")+1));
						
						item.put("productUrl", itemUrl);
						//LOGGER.info("---item---"+item);
						resultsList.add(item);
					}				
			}
				results.put("totalCount", totalResults);
				results.put("results", resultsList);
		} catch(Exception e) {
			LOGGER.error("[getProductListing] Error Occurred - ",e);
		}
		
		return results;		
	}
	private static String parseFieldFromResponse(String response,String field) {
	    String value = ""; 
	    field = "Mobile^" + field;
	    int start = response.indexOf(field);    
	    if(start != -1) {
	        int end = response.indexOf(";",start);
	        if(end == -1) {
	            response = response.substring(start);
	            } else {
	            response = response.substring(start,end);
	        }
	        value = response.substring(response.lastIndexOf("^")+1,response.length());
	    }
	    return value;
	}
	
	public static ProductDetailsVo getWapData(Page page) throws Exception{
		
		ProductDetailsVo productDetailsVo = new ProductDetailsVo();
		Node detailNode = page.getContentResource().getChild("details").adaptTo(Node.class);
		
		if(detailNode.hasProperty("name")){
			productDetailsVo.setName(detailNode.getProperty("name").getString());
		}
		if(detailNode.hasProperty("manufacturer")){
			productDetailsVo.setManufacturer(detailNode.getProperty("manufacturer").getString());
		}
		if(detailNode.hasProperty("processor")){
			productDetailsVo.setProcessor(detailNode.getProperty("processor").getString());
		}
		if(detailNode.hasProperty("bestPrice")){
			productDetailsVo.setPrice(detailNode.getProperty("bestPrice").getString());
		}
		if(detailNode.hasProperty("735")){
			String forFactorvalue = detailNode.getProperty("735").getString();
			if(forFactorvalue.contains("\\|")){
			   productDetailsVo.setFormFactor(forFactorvalue.split("\\|")[1]);
			}else{
			   productDetailsVo.setFormFactor(forFactorvalue);
			}
			
		}
		
		return productDetailsVo;
		
	}
	
}
