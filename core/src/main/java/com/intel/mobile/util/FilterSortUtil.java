package com.intel.mobile.util;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;

public class FilterSortUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(ProductUtil.class);
	public static final String TAG_BASE_PATH = "intelmobile:";
	public static final String TAG_SECTION_SEARCH = "search";
	public static final String TAG_SECTION_PRODUCTS = "products";
	
	public static Map<String, Map<String, String>> getProductFilters(ResourceResolver resolver, Page page, String section, String category) {
		Map<String, Map<String, String>> filters = new LinkedHashMap<String, Map<String, String>>();
		TagManager tagManager = resolver.adaptTo(TagManager.class);
		try {
			//String category = page.getName();
			String locale = IntelUtil.getLocale(page);
			String tagPath = "";
			if(section.equals(TAG_SECTION_SEARCH)) {
				tagPath = TAG_BASE_PATH + locale 
				+ "/" + section + "/filters";				
			} else if(section.equals(TAG_SECTION_PRODUCTS)) {
				tagPath = TAG_BASE_PATH + locale 
				+ "/" + section + "/" + category + "/filters";								
			}
			if(LOGGER.isDebugEnabled()) {
				LOGGER.debug(">>>>Tag Path - " + tagPath);
			}
			Tag tag = tagManager.resolve(tagPath);
			if(tag != null) {
				Iterator<Tag> tagList = tag.listChildren();
				while(tagList.hasNext()) {
					Tag filterTag = (Tag) tagList.next();
					try {
						String filterTitle = filterTag.getTitle();
						String filterName = filterTag.getName();
						Map<String, String> subFilterMap = new LinkedHashMap<String, String>();
						Iterator<Tag> subFilterTagList = filterTag.listChildren();
						while(subFilterTagList.hasNext()) {
							Tag subFilterTag = (Tag)subFilterTagList.next();
							subFilterMap.put(subFilterTag.getName(), subFilterTag.getTitle());
						}
						if(!subFilterMap.isEmpty()){
							filters.put(filterName + "`" + filterTitle, subFilterMap);	
						}															
						if(LOGGER.isDebugEnabled()) {
							LOGGER.debug("getProductFilters() - Filter Title - " + filterTitle + ", Sub Filters - " + subFilterMap);
						}
					} catch(Exception e) {
						LOGGER.error("getProductFilters() - Exception occured while processing tag for - " + filterTag.getTitle());
					}
				}				
			}			
		} catch(Exception e) {
			LOGGER.error("getProductFilters() - Exception occured - " + e);
		}
		return filters;		
	}
	public static Map<String, String> getProductSortOptions(ResourceResolver resolver, Page page, String section, String category) {
		Map<String, String> sortoptions = new LinkedHashMap<String, String>();
		TagManager tagManager = resolver.adaptTo(TagManager.class);
		try {
			//String category = page.getName();
			String locale = IntelUtil.getLocale(page);
			String tagPath = "";
			if(section.equals(TAG_SECTION_SEARCH)) {
				tagPath = TAG_BASE_PATH + locale 
				+ "/" + section + "/sort";			
				if(LOGGER.isDebugEnabled()) {
					LOGGER.debug(">>>>Tag Path - " + tagPath);
				}
				Tag tag = tagManager.resolve(tagPath);
				if(tag!=null) {
					Iterator<Tag> tagList = tag.listChildren();
					while(tagList.hasNext()) {
						Tag sortTag = (Tag) tagList.next();
							String sortName = sortTag.getName();
							String sortTitle = sortTag.getTitle();	
							sortoptions.put(sortName+":ascending", sortTitle);
						}									
				}
			} else if(section.equals(TAG_SECTION_PRODUCTS)) {
				tagPath = TAG_BASE_PATH + locale 
				+ "/" + section + "/" + category + "/sort";					
				if(LOGGER.isDebugEnabled()) {
					LOGGER.debug(">>>>Tag Path - " + tagPath);
				}
				Tag tag = tagManager.resolve(tagPath);
				if(tag!=null) {
					Iterator<Tag> tagList = tag.listChildren();
					while(tagList.hasNext()) {
						Tag sortTag = (Tag) tagList.next();
							String sortName = sortTag.getName();
							String sortTitle = sortTag.getTitle();
							sortTitle = sortTitle.replaceAll(" ", "");
							Iterator<Tag> sortTagList = sortTag.listChildren();
								while(sortTagList.hasNext()) {
									try {							
										Tag sortoptionTag = (Tag)sortTagList.next();
										sortoptions.put(sortName + ":" + sortoptionTag.getName(), 
												sortoptionTag.getTitle());
										if(LOGGER.isDebugEnabled()) {
											LOGGER.debug("getProductFilters() - Sort Title - " 
												+ sortTitle + ", Sub Sort - " + sortoptionTag.getTitle());
										}
									} catch(Exception e) {
											LOGGER.error("getProductSortOptions() - Exception occured while processing tag for - " + sortName);
									}
								}
						}						
				}			
			}			

		} catch(Exception e) {
			LOGGER.error("getProductSortOptions() - Exception occured - " + e);
		}
		return sortoptions;		
	}	
}
