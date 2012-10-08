package com.intel.mobile.util;

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

import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;

/**
 * 
 * @author skarm1
 *
 */
public class ArticletUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(ArticletUtil.class);
	public static Map<String, String> getArticleMetaTags(ResourceResolver resolver, Page page) {

		Map<String, String> metaTags = new HashMap<String, String>();
		StringBuffer metaName = new StringBuffer();
		StringBuffer metaValue = new StringBuffer();

		String articleCategory = page.getProperties().get("articleCategory", "");
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("articleCategory :"+articleCategory);
		}
		String rank = null;
		
		metaName.append("Mobile^pagetype;");
		metaValue.append("Mobile^pagetype^Article;");
		
		if(articleCategory!=null && !articleCategory.isEmpty()){
			if(articleCategory.equals("Industry Hot Topics")){
				rank = "2";
			}else if(articleCategory.equals("Intel Programs")){
				rank = "3";
			}else if(articleCategory.equals("Intel Technologies")){
				rank = "4";
			}else if(articleCategory.equals("About Intel")){
				rank = "5";
			}else if(articleCategory.equals("Legal Information")){
				rank = "6";
			}	
			metaName.append("Mobile^mobilecontent;");
			metaValue.append("Mobile^mobilecontent^").append(articleCategory).append(";");
		}
		
		metaTags.put(IntelMobileConstants.META_TAG_SITE_SECTION,rank);
		metaTags.put("reimaginetoplevelcategory", metaName.toString().substring(0, metaName.lastIndexOf(";")));
		metaTags.put("reimaginesublevelcategory", metaValue.toString().substring(0, metaValue.lastIndexOf(";")));

		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("Article metaTags :"+metaTags);
		}
		return metaTags;
	}
}
