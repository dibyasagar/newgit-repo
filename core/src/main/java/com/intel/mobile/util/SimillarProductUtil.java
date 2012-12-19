package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;

import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.Value;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import org.apache.felix.scr.annotations.Reference;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.jcr.api.SlingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.vo.SmillarProductsVO;
public class SimillarProductUtil {
	
	@Reference
	
	
	private static final Logger LOG = LoggerFactory.getLogger(SimillarProductUtil.class);
	
	public static List getShopSimilarInfo(Page currentPage,ResourceResolver resolver) {
		
		String name = "";
        String picture = "";
        String bestPrice = "";
	    String url = "";
	    String id = "";
	    String categoryPath = "";
	    String prodName = "";
	   
	    Page categoryPage = currentPage.getParent();
	    //LOG.info("-----categoryPage ----"+categoryPage.getPath());
	    List<SmillarProductsVO> similarResultList = new ArrayList<SmillarProductsVO>();
	   
         try{
        	 Node detailNode = currentPage.getContentResource().getChild("details").adaptTo(Node.class);
        	 if(LOG.isDebugEnabled()) {
     			LOG.debug("---detailNode-----"+detailNode.getName());
        	 }
             if(detailNode.hasNode("shopsimilarproducts")) {
        		Node similarProductnode = detailNode.getNode("shopsimilarproducts");
        		NodeIterator similarNode = similarProductnode.getNodes();
        		//long Count = similarNode.getSize();
        		
        		while(similarNode.hasNext()){
        			 Node tmpNode = similarNode.nextNode();
        			if(tmpNode.hasProperty("name") && tmpNode.getProperty("name")!= null) {
        			    	name = tmpNode.getProperty("name").getString();
        			    	prodName = IntelUtil.normalizeName(name);
        			    	//url = categoryPage.getPath()+"/"+prodName;
        			    	url = getProductUrl(categoryPage,prodName,resolver);
        			    }
        			if(url != null && url != "")  { 
        			    if(tmpNode.hasProperty("picture") && tmpNode.getProperty("picture") != null) {
        			    	picture = tmpNode.getProperty("picture").getString();
        			    }
        			    if(tmpNode.hasProperty("bestPrice") && tmpNode.getProperty("bestPrice") != null) {
        			    	bestPrice = tmpNode.getProperty("bestPrice").getString();
        			    }
        			   
        			    SmillarProductsVO productsInfo = new SmillarProductsVO(name, picture,bestPrice,url);
        			    if(!similarResultList.contains(productsInfo)) {
        			    similarResultList.add(productsInfo);
        			    }
        			}
        			//LOG.info("---similarResultList-----"+similarResultList);
        			
        			    if(LOG.isDebugEnabled()) {
        					LOG.debug("---similarResultList-----"+similarResultList);
        			    }
        		   
        		}
        	}
         
        }
         catch (RepositoryException e) {
 			LOG.error("RepositoryException in getShopSimilarInfo :"+e.getMessage());
 		}
	
         return similarResultList;
}
public  static String getProductUrl(Page categoryPage,String prodName,ResourceResolver resolver) {
		
        String productUrl = "";
		//String queryStatement = "";
		//String pageStats = "";
		String tempUrl = categoryPage.getPath()+"/"+prodName;
		Page reqPage = resolver.resolve(tempUrl).adaptTo(Page.class);
	   if(reqPage.getProperties().get("cq:lastReplicationAction", "").equals("Activate")){
		   productUrl = tempUrl;
	   }
		return productUrl;
		
	} 

public static List getCmsSimilarProducts(String reqPages[],ResourceResolver resolver ) {
	
	 String pagePath = null;
	 String name = "";
     String picture = "";
     String bestPrice = "";
     String url = "";
	 List<SmillarProductsVO> cmsSimilarList  = new ArrayList<SmillarProductsVO>();
	 
	 if (reqPages != null && reqPages.length >0)
	 {
			for (int i = 0; i < reqPages.length; i++) {
				url = reqPages[i].toString();
				if(LOG.isDebugEnabled()) {
					LOG.debug("---url -----" + url.toString());
				}
				Resource root = resolver.getResource(url
						+ "/jcr:content/details");
				if (root != null) {
					if(LOG.isDebugEnabled()) {
						LOG.debug("---root -----" + root.getName());
					}
					ValueMap map = root.adaptTo(ValueMap.class);
					if(LOG.isDebugEnabled()) {
						LOG.debug("---Map-----" + map);
					}
					if (map.get("name") != null) {
						name = map.get("name").toString();
					}
					if (map.get("picture") != null) {
						picture = map.get("picture").toString();
					}
					if (map.get("bestPrice") != null) {
						bestPrice = map.get("bestPrice").toString();
					}
				
					SmillarProductsVO productsInfo = new SmillarProductsVO(name,
							picture, bestPrice, url);
					cmsSimilarList.add(productsInfo);
				}
				if(LOG.isDebugEnabled()) {
					LOG.debug("---cmsSimilarList-----" + cmsSimilarList);
				}
			}

		}
	  return cmsSimilarList; 	
     }

}
