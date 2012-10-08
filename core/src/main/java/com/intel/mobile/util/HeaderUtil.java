package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.jcr.Node;

import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.day.cq.wcm.api.PageManager;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.designer.Style;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.vo.RetailerDetailsVO;

public class HeaderUtil {

	private static final Logger LOG = LoggerFactory.getLogger(HeaderUtil.class);

	public static List getHeaderInfo( Page currentPage,
			ResourceResolver resolver) {
		List<Map> headerList = new ArrayList<Map>();		
		Object headlinkTitle[] = null;
		Object headlinkUrl[] = null;
		Object showsubpage[] = null;
		String homePagePath = "";
		String rootPagePath = "";
		String SearchIconImage = "";
		String headUrl = "";
		// PageManager pageManager = ;

/*		headlinkTitle = (Object[]) currentStyle.get("headerTitle",
				new Object[0]);
		headlinkUrl = (Object[]) currentStyle.get("headerUrl", new Object[0]);
		showsubpage = (Object[]) currentStyle.get("showsubpage", new Object[0]);
*/
		headlinkTitle = IntelUtil.getConfigValues(currentPage, "header","headerTitle");		
		headlinkUrl = IntelUtil.getConfigValues(currentPage, "header","headerUrl");
		showsubpage = IntelUtil.getConfigValues(currentPage, "header","showsubpage");
			
		if (headlinkTitle != null && headlinkTitle.length > 0) {
			for (int i = 0; i < headlinkTitle.length; i++) {
				Map<String, String> menuMap = new LinkedHashMap<String, String>();				
				headUrl = headlinkUrl[i].toString();

				if (!showsubpage[i].toString().equalsIgnoreCase("yes")) {
					if (headUrl.startsWith("/content")) {
						headUrl = headUrl.concat(".html");
					}
					menuMap.put(headlinkTitle[i].toString(), headUrl);
					
				} else {
					if (headUrl.startsWith("/content")) {
						homePagePath = headUrl;
						menuMap.put(headlinkTitle[i].toString(), null);
						Page navRootPage = resolver.resolve(homePagePath)
								.adaptTo(Page.class);
						// Logic to get and display the child pages if any
						if (navRootPage != null) {
							Iterator<Page> children = navRootPage
									.listChildren();
							while (children.hasNext()) {
								Page child = children.next();
								String url = "";
								url = child.getPath().concat(".html");
								menuMap.put(child.getTitle(), url);
							}
						}
					}
				}
				if(LOG.isDebugEnabled()) {
					LOG.debug("Menumap --------"+menuMap);
				}
				headerList.add(menuMap);				
			}
		}
		if(LOG.isDebugEnabled()) {
			LOG.debug("Headerlist --------"+headerList);
		}
		return headerList;
	}

	public static Map<String,String> getDefaultPage(Page currentPage) {
		Map<String, String> subPages = new LinkedHashMap<String, String>();	
		
		  int j = 0;
          Page localeConfigPage  =null;
          Page tempPage = currentPage;
          String subpageUrl = "";
          while(tempPage != null){
               if(tempPage.getProperties().get("cq:template", "").
                          equals(IntelMobileConstants.LOCALE_CONFIG_TEMPLATE)){
              	 localeConfigPage = tempPage;
              	 break;
               }
               tempPage = tempPage.getParent(); 
          }
           
          if (localeConfigPage != null) {
              Iterator<Page> children2 = localeConfigPage.listChildren();
                      
             if( children2 != null){
              while (children2.hasNext() && j < 4) {
              	Page subpage = children2.next();

                  if(!(subpage.getProperties().get("cq:template", "").toString().trim().
                            equals(IntelMobileConstants.HOME_PAGE_TEMPLATE))){                                            	                                               
                       subpageUrl = subpage.getPath().concat(".html");
                       j++;
                   
                       subPages.put(subpage.getTitle(),subpageUrl);  
                 }
           }
       }
    }      

		return subPages;
	}
}
