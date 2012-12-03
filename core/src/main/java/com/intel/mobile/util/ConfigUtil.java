package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.Property;
import javax.jcr.PropertyIterator;
import javax.jcr.RepositoryException;

import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.search.ProductDetails;
import com.intel.mobile.vo.RetailerDetailsVO;
import com.intel.mobile.constants.IntelMobileConstants;

public class ConfigUtil {
	
	private static final Logger LOG = LoggerFactory.getLogger(ConfigUtil.class);

	
   public static String getConfigValues(ResourceResolver resolver, String path, String attribute) {
	   if(LOG.isDebugEnabled()) {
			LOG.debug("------Inside getConfigValues------- ");
	   }
	    String value = "";
		Node requiredNode = getConfigNode(path,resolver);
		
		if(requiredNode != null){
		 value = getConfigProperty( requiredNode,attribute );
		}
		return value;
	}

   public static String getFeatureLabels(ResourceResolver resolver, String path, String producttype) {
	   if(LOG.isDebugEnabled()) {
			LOG.debug("------Inside getFeatureLabels------- ");
	   }
		String featureLabelsList = "";
		StringBuffer strBuffer = new StringBuffer();
		PropertyIterator displayProps = null;
		Node requiredNode = getConfigNode(path,resolver);
		if(producttype.equalsIgnoreCase("shop")){	
			try{
			if(requiredNode != null){
			    displayProps = requiredNode.getProperties("feature_*");
			    	
			while(displayProps.hasNext()){
				 String propertyName = "";
				Property tmpProperty = displayProps.nextProperty();
				if(LOG.isDebugEnabled()) {
					LOG.debug("------Property names------- "+tmpProperty.getName());
				}
				 
				if(tmpProperty.getValue().getString().equalsIgnoreCase("yes")){
					if(LOG.isDebugEnabled()) {
						LOG.debug("-----Inside get value------- "); 
					}
					propertyName = tmpProperty.getName().replace("feature_","");
					
					strBuffer.append(propertyName).append(" , ");
				}
				if(LOG.isDebugEnabled()) {
					LOG.debug("------featureLabelsList------- "+strBuffer.toString()); 
				}
			}
			}
			}
			catch (RepositoryException e) {
				
				LOG.error("RepositoryException in getFeatureLabels:"+e.getMessage());
				
			}
		}
		
		else if(producttype.equalsIgnoreCase("cms")){
			try{
				if(requiredNode != null){
				    displayProps = requiredNode.getProperties("featurecms_*");
				    	
				while(displayProps.hasNext()){
					 String propertyName = "";
					Property tmpProperty = displayProps.nextProperty();
					if(LOG.isDebugEnabled()) {
						LOG.debug("------Property names------- "+tmpProperty.getName());
					}
					 
					if(tmpProperty.getValue().getString().equalsIgnoreCase("yes")){
						if(LOG.isDebugEnabled()) {
							LOG.debug("-----Inside get value------- "); 
						}
						propertyName = tmpProperty.getName().replace("featurecms_","");
						
						strBuffer.append(propertyName).append(" , ");
					}
					if(LOG.isDebugEnabled()) {
						LOG.debug("------featureLabelsList------- "+strBuffer.toString());
					}
				}
				}
				}
				catch (RepositoryException e) {
					
					LOG.error("RepositoryException in getFeatureLabels:"+e.getMessage());
					
				}
		
		}
			return strBuffer.toString();
			
		}
	

   public static Map<String, String> getConfigDetailsValues(ResourceResolver resolver, String path) {
	   if(LOG.isDebugEnabled()) {
			LOG.debug("------Inside getConfigDetailsValues------- "); 
	   }
	   Map<String, String> labelValues = new HashMap<String, String>();
	   Node propertyNode = getConfigNode(path,resolver);
	  
	   if( propertyNode != null){
		   if(LOG.isDebugEnabled()) {
				LOG.debug("------Inside labels------ "); 
		   }
		   String showfacebook = getConfigProperty( propertyNode,IntelMobileConstants.SHOW_FACEBOOK_VALUE );
		   if(showfacebook.equalsIgnoreCase("")||showfacebook == null ){
			   showfacebook = "false";
		   }
		   if(LOG.isDebugEnabled()) {
				LOG.debug("------showfacebook ------ "+showfacebook ); 
		   }
		   String showtweeter = getConfigProperty( propertyNode,IntelMobileConstants.SHOW_TWEETER_VALUE);
		   if(showtweeter.equalsIgnoreCase("")||showtweeter == null ){
			   showtweeter = "false";
		   }
		   String showshare = getConfigProperty( propertyNode,IntelMobileConstants.SHOW_SHARE_VALUE);
		   if(showshare.equalsIgnoreCase("")||showshare == null ){
			   showshare = "false";
		   }

           String currencySymbol = getConfigProperty( propertyNode,IntelMobileConstants.PRODUCT_DETAILS_LABELS_CURRENCYSYMBOL);
		   if(currencySymbol.equalsIgnoreCase("")||currencySymbol== null ){
			   currencySymbol = "$";
		   }
		   
		   labelValues .put("showfacebook", showfacebook);
		   labelValues .put("showtweeter", showtweeter);
		   labelValues .put("showshare", showshare);
		   labelValues .put("currencysymbol", currencySymbol);
		   
	   }
	   
		return labelValues;
	}
   public static Node getConfigNode(String path, ResourceResolver resolver) {
	    Node localeNode = null;
	    String localePath = null;
	    Node tempNode = null;
	    try{
	    if(path.contains("/products")){
		localePath = path.substring(0,path.indexOf("/products"));
		tempNode = resolver.resolve(localePath).adaptTo(Node.class);
		if(LOG.isDebugEnabled()) {
			LOG.debug("------tempNode------- "+tempNode.getName()); 
		}
	    }
		
		
		if(tempNode.hasNode("jcr:content/locale")){
			
			localeNode = tempNode.getNode("jcr:content/locale");
			if(LOG.isDebugEnabled()) {
				LOG.debug("------config node------- "+localeNode.getName()); 
			}
		}
		}
		
		catch (RepositoryException e) {
			LOG.error("RepositoryException in getConfigNode:"+e.getMessage());
			
		}
		
		return localeNode;
	}
	
   public static String getConfigProperty( Node node , String property ) {
		
		String propertyValue = "";
		try{
		if(node.hasProperty(property)){
			
			propertyValue = node.getProperty(property).getString();
			if(LOG.isDebugEnabled()) {
				LOG.debug("------propertyValue ------- "+propertyValue); 
			}
		}
		}
		catch (RepositoryException e) {
			LOG.error("RepositoryException in getConfigProperty :"+e.getMessage());
			
		}
		
		
		return propertyValue;
	}
   
	
   public static void setConfigLang( Page currentPage, String langValue) {
	   if(LOG.isDebugEnabled()) {
			LOG.debug("-----Setting jcr language------ "+langValue); 
	   }

	    String value = "";
	    String path = currentPage.getPath();
	    Node tempNode = null;
	    try{
          tempNode = currentPage.getContentResource().adaptTo(Node.class);
 
          if(LOG.isDebugEnabled()) {
  			LOG.debug("-----temp node is------ "+tempNode.getName()); 
          }
		  
			   tempNode.setProperty("jcr:language", langValue); 
			   tempNode.save();

			   if(LOG.isDebugEnabled()) {
					LOG.debug("-----jcr lang property is------ "+tempNode.getProperty("jcr:language").getString()); 
			   }
		
		   
	    }
	    catch (RepositoryException e) {
			LOG.error("RepositoryException in getConfigProperty :"+e.getMessage());
			
		}
	
	}


}
