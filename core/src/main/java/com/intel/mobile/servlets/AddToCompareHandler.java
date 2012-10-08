package com.intel.mobile.servlets;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.jcr.Node;
import javax.jcr.Property;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.intel.mobile.filter.ProductListingFilter;


/**
 * 
 * @author smukh5
 *
 */


public class AddToCompareHandler {
	
	private static final String FEATURES_TAG_PATH = "intelmobile:en_US/products/";
	private static final Logger log = LoggerFactory.getLogger(AddToCompareHandler.class);
	
	
	public Map<String,Map<String, String>> getProducts(HttpServletRequest request , String category , Locale locale){
		
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		ResourceResolver resourceResolver = slingRequest.getResourceResolver();
		log.info("Inside AddToCompareHandler : getProducts --> ");
		//Map<M> features = new ArrayList<String>();
		
		
		
		// TODO : This productList will be populated from the paths taken from session .
		List<String> productList = new ArrayList<String>();
		productList.add("/content/intelmobile/en_US/products/laptop/lenovo-ideapad-215129u");
		productList.add("/content/intelmobile/en_US/products/laptop/toshiba-satellite-s875s7242");
		productList.add("/content/intelmobile/en_US/products/laptop/asus-k55vd-ds71");
		productList.add("/content/intelmobile/en_US/products/laptop/hp-dv6t-quad");
		productList.add("/content/intelmobile/en_US/products/laptop/cyberpower-xplorer-x6-9300-notebook");
		productList.add("/content/intelmobile/en_US/products/laptop/lenovo-ideapad-209942u");
		
		// Get the size of the list from session . Will give the number of products added .
		
		//List<Map<String,String>> productListSession = (List<Map<String,String>>)request.getSession().getAttribute("sessionMapList");
		
		
		List<Map<String,String>> productListSession = new ArrayList<Map<String,String>>();
		log.info("Product List Session in AddtoCompareHandler : " + productListSession);
		
		Map<String,String> sessionMap1  = new HashMap<String,String>();
		Map<String,String> sessionMap2  = new HashMap<String,String>();
		Map<String,String> sessionMap3  = new HashMap<String,String>();
		
		sessionMap1.put("productTitle", "Komputer IntelÂ® | Laptop Ultrabookâ?¢");
		sessionMap2.put("productTitle", "Komputer IntelÂ® | Laptop Ultrabookâ?¢");
		sessionMap3.put("productTitle", "IntelÂ® Computers | Ultrabookâ?¢ Laptops");
		
		sessionMap1.put("productImage", "/etc/designs/intelmobile/img/FPO-ProdGridView-tile1.jpg");
		sessionMap2.put("productImage", "/etc/designs/intelmobile/img/FPO-ProdGridView-tile1.jpg");
		sessionMap3.put("productImage", "/etc/designs/intelmobile/img/FPO-ProdGridView-tile1.jpg");
		
		
		sessionMap1.put("productPath", "/content/intelmobile/en_US/products/laptop/lenovo-ideapad-215129u");
		sessionMap2.put("productPath", "/content/intelmobile/en_US/products/laptop/toshiba-satellite-s875s7242");
		sessionMap3.put("productPath", "/content/intelmobile/en_US/products/laptop/asus-k55vd-ds71");
		
		sessionMap1.put("productPrice", "$299");
		sessionMap2.put("productPrice", "$399");
		sessionMap3.put("productPrice", "$499");
		
		
		
		request.getSession().removeAttribute("sessionMapList");
		
		
		productListSession.add(sessionMap1);
		productListSession.add(sessionMap2);
		productListSession.add(sessionMap3);
		
		request.getSession().setAttribute("sessionMapList",productListSession);
		log.info("Product List Session in AddtoCompareHandler after hardcoding : " + productListSession);
		
		
		int productCount = 0 ;
		if (productListSession != null){
		productCount = productListSession.size();
		
		}
		
		log.info("Product Count in AddToCompareHandler : " + productCount);
		if(productListSession == null){
			return null;
		}
		
		List<String> fTags = getFeatureTags(request,category,locale);
		
		Map<String,String> featureMap ;
		
		Map<String,Map<String,String>> featureMapList = new HashMap<String,Map<String,String>>();
		int i=0;
		for(Map sessionMap : productListSession)
		{
			featureMap = new HashMap<String,String>() ;
			String path = productList.get(i++);
			log.info("Path in getProducts in AddToCompareHandler : " + path) ;
			Resource root = resourceResolver.getResource(path + "/jcr:content/details"); 
			log.info("Root Resource in getProducts in AddToCompareHandler : " + root) ;
			ValueMap vMap = root.adaptTo(ValueMap.class);
			log.info("Valuemap in getProducts in AddToCompareHandler : " + vMap) ;
			for(String fName : fTags){
				featureMap.put(fName , (String)vMap.get(fName));
			}
			
			featureMapList.put(path,featureMap);

		}
		
		log.info("featureMapList in getProducts in AddToCompareHandler : " + featureMapList) ;
		return featureMapList;
		
		
	}
	
	public List<String> getFeatureTags(HttpServletRequest request , String category , Locale locale)
	{
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		ResourceResolver resourceResolver = slingRequest.getResourceResolver();
		TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
		List<String> features = new ArrayList<String>();
		try {
			String tagPath = FEATURES_TAG_PATH + "laptop" + "/features";
			log.info(">>>>Tag Path - " + tagPath);
			log.info(">>>>Page Locale - " + locale);
			Tag tag = tagManager.resolve(tagPath);
			Iterator<Tag> tagList = tag.listChildren();
			while(tagList.hasNext()) {
				Tag attribute = (Tag) tagList.next();
				try {
						String attributeTitle = attribute.getName();
						features.add(attributeTitle);
									
				} catch(Exception e) {
					log.error("getFeatures() - Exception occured while processing tag for - " + attribute.getName());
				}
			}
			
		} catch(Exception e) {
			log.error("getFeatures() - Exception occured - " + e);
		}
		
		log.info("features in getProducts in AddToCompareHandler : " + features) ;
		return features ;
		
	}

}
