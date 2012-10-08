package com.intel.mobile.util;

import java.util.Map;

import javax.servlet.jsp.PageContext;

import org.apache.sling.api.request.RequestPathInfo;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.IntelConfigurationService;


public class ComponentsUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(ComponentsUtil.class);
	
	public static void processSiteSearch(PageContext pageContext, 
											Page currentPage, 
											RequestPathInfo requestPathInfo,
											ValueMap properties){				
		try {
			String rootPath = IntelUtil.getRootPath(currentPage);
			IntelConfigurationService intelConfig = IntelUtil
					.getIntelConfigService();

			String selectors[] = requestPathInfo.getSelectors();
			String searchTerm = "";
			String searchScope = "intelmobile";
			String searchType = "allword";
			
			if (selectors.length >= 2) {
				searchTerm = selectors[0];
				searchScope = selectors[1];
				if (!(searchScope.equals("intel") || searchScope
						.equals("intelmobile"))) {
					searchScope = "intelmobile";
				}
			} else {
				if (selectors.length == 1) {
					searchTerm = selectors[0];
				}
			}
			searchTerm = searchTerm.replaceAll("2EDOT46", ".");

			if(searchTerm.length()>0) {
				if(searchTerm.substring(0,1).equals("\"") 
						&& searchTerm.substring(searchTerm.length()-1,searchTerm.length()).equals("\"")) {
					searchType = "exactphrase";
				}
			}
			searchTerm = searchTerm.replaceAll("\"", "");
			searchTerm = searchTerm.replaceAll("\'", "");
					
			pageContext.setAttribute("searchScope", searchScope);
			pageContext.setAttribute("productnameMeta",
					IntelMobileConstants.META_TAG_FILTER_PRODUCT_NAME);
			pageContext.setAttribute("categoryMeta",
					IntelMobileConstants.META_TAG_FILTER_CATEGORY);
			pageContext.setAttribute("priceMeta",
					IntelMobileConstants.META_TAG_FILTER_PRICE);
			pageContext.setAttribute("pictureurlMeta",
					IntelMobileConstants.META_TAG_FILTER_PICTURE_URL);
			pageContext.setAttribute("taglineMeta",
					IntelMobileConstants.META_TAG_FILTER_TAG_LINE);
			pageContext.setAttribute("productpathMeta",
					IntelMobileConstants.META_TAG_PRODUCT_PATH);
			pageContext
					.setAttribute("localecode", IntelUtil.getLocale(currentPage));
			pageContext.setAttribute("fastSearchUrl",
					intelConfig.getFastSearchUrl());
			pageContext.setAttribute("currentPageName", currentPage.getName());
			pageContext.setAttribute("searchtext", searchTerm);
			pageContext.setAttribute("searchtype", searchType);
			pageContext.setAttribute("relateditemsno",
					properties.get("relateditemsno", "0"));
			pageContext.setAttribute("rootPath", rootPath);			
			
		} catch(Exception e) {
			LOGGER.error("[processSiteSearch] Exception occurred - ",e);
		}
	}
	public static void processProductListing(ResourceResolver resourceResolver,
			PageContext pageContext, Page currentPage, ValueMap properties) {

			try {
				  int noOfProducts = 12;
				  String strCMSLinkText = properties.get("linkdispcopy", "");
				  String truncateCharValue = properties.get("truncatechar", "0"); ;
				  String rootPath = IntelUtil.getRootPath(currentPage);
				  if(rootPath != null && rootPath.length()!=0) {
					  rootPath = resourceResolver.map(rootPath);
				  } else {
					  rootPath = "";
				  }
				  String linkdispurl = properties.get("linkdispurl", "");
				  linkdispurl = linkdispurl.trim();
				  if(linkdispurl != null && linkdispurl.length()!=0) {
					  linkdispurl = resourceResolver.map(linkdispurl);
				  } else {
					  linkdispurl = "";
				  }
				  
				  int truncValue = Integer.parseInt(truncateCharValue);
				  strCMSLinkText = strCMSLinkText.trim();
				  if(strCMSLinkText.length() > truncValue && truncValue != 0 ){				      
				      strCMSLinkText = strCMSLinkText.substring(0,truncValue).concat("...");
				  }
				  if(strCMSLinkText.length() > 0) {
					  noOfProducts = 11;
				  }
				  pageContext.setAttribute("currentPageTitle",currentPage.getTitle());
				  pageContext.setAttribute("currentPageName",currentPage.getName());
				  pageContext.setAttribute("currentPagePath",resourceResolver.map(currentPage.getPath()));
				  pageContext.setAttribute("rootPath",rootPath);
				  pageContext.setAttribute("cmsTileUrl",linkdispurl);
				  pageContext.setAttribute("cmsTileImage",properties.get("imgFileReference", ""));
				  pageContext.setAttribute("cmsTileText",strCMSLinkText.trim());
				  pageContext.setAttribute("productnameMeta",IntelMobileConstants.META_TAG_FILTER_PRODUCT_NAME);
				  pageContext.setAttribute("priceMeta",IntelMobileConstants.META_TAG_FILTER_PRICE);
				  pageContext.setAttribute("pictureurlMeta",IntelMobileConstants.META_TAG_FILTER_PICTURE_URL);
				  pageContext.setAttribute("taglineMeta",IntelMobileConstants.META_TAG_FILTER_TAG_LINE);
				  pageContext.setAttribute("productpathMeta",IntelMobileConstants.META_TAG_PRODUCT_PATH);
				  pageContext.setAttribute("productidMeta",IntelMobileConstants.META_TAG_FILTER_PRODUCT_ID);
				  pageContext.setAttribute("prodListTitle",properties.get("prodlisttitle", "Introducing"));
				  pageContext.setAttribute("noOfProducts",noOfProducts);
				
				  String category = currentPage.getName();
				  Map<String,Object> results = ProductUtil.getProductListing(category, noOfProducts);
				  pageContext.setAttribute("results", results);				
			} catch(Exception e) {
				LOGGER.error("[processProductListing] Exception occurred - ",e);
			}
	}
	
	public static void processSortFilter(ResourceResolver resourceResolver,
			PageContext pageContext, Page currentPage, ValueMap properties) {
		try {
		    IntelConfigurationService intelConfig = IntelUtil.getIntelConfigService();
		    
			ValueMap valueMap = currentPage.getProperties();
			String templateType = valueMap.get("cq:template",String.class);
			
			String section = "search";
			String category = "";
			if(templateType!= null 
					&& templateType.endsWith("/productlisting")) { 
				section = "products";
				category = currentPage.getName();
			}

			Map<String, Map<String, String>> filters = 
		    	FilterSortUtil.getProductFilters(resourceResolver, currentPage, section, category);

		 	Map<String, String> sortoptions = 
				FilterSortUtil.getProductSortOptions(resourceResolver, currentPage, section, category);
		 	
		 	String localecode = IntelUtil.getLocale(currentPage);
		 	
		 	String showhide = properties.get("showhide", "showboth");
		 	
			pageContext.setAttribute("fastSearchUrl",intelConfig.getFastSearchUrl());
			pageContext.setAttribute("fastSearchAppId",intelConfig.getFastSearchAppId());
		 	pageContext.setAttribute("localecode", localecode);
		 	pageContext.setAttribute("category", category);
		 	pageContext.setAttribute("categoryMeta", IntelMobileConstants.META_TAG_FILTER_CATEGORY);
		 	pageContext.setAttribute("pagetypeMeta", IntelMobileConstants.META_TAG_FILTER_PAGETYPE);
		 	pageContext.setAttribute("localecodeMeta", IntelMobileConstants.META_TAG_LOCALE_CODE);
		 	pageContext.setAttribute("section", section);
			pageContext.setAttribute("filters", filters);
			pageContext.setAttribute("sortoptions", sortoptions);	
			pageContext.setAttribute("showhide", showhide);
		} catch(Exception e) {
			LOGGER.error("[processSortFilter] Exception occurred - ",e);
		}
	}
}
