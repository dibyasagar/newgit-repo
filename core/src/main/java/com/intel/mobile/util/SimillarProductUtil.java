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
	
	public static List getShopSimilarInfo(Page currentPage,Session session) {
		
		String name = "";
        String picture = "";
        String bestPrice = "";
	    String url = "";
	    String id = "";
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
        			 
        			 if(tmpNode.hasProperty("id") && tmpNode.getProperty("id") != null) {
     			    	id = tmpNode.getProperty("id").getString();
     			    	url = getProductUrl(id,session,currentPage);
     			     }
        			  if(url != null && url != "")  { 
        			    if(tmpNode.hasProperty("name") && tmpNode.getProperty("name")!= null) {
        			    	name = tmpNode.getProperty("name").getString();
        			    }
        			    if(tmpNode.hasProperty("picture") && tmpNode.getProperty("picture") != null) {
        			    	picture = tmpNode.getProperty("picture").getString();
        			    }
        			    if(tmpNode.hasProperty("bestPrice") && tmpNode.getProperty("bestPrice") != null) {
        			    	bestPrice = tmpNode.getProperty("bestPrice").getString();
        			    }
        			   
        			    SmillarProductsVO productsInfo = new SmillarProductsVO(name, picture,bestPrice,url);
        			    similarResultList.add(productsInfo);
        			    if(LOG.isDebugEnabled()) {
        					LOG.debug("---similarResultList-----"+similarResultList);
        			    }
        		   }
        		}
        	}
         
        }
         catch (RepositoryException e) {
 			LOG.error("RepositoryException in getShopSimilarInfo :"+e.getMessage());
 		}
	
         return similarResultList;
}
public  static String getProductUrl(String id,Session session,Page currentPage) {
		
        String productUrl = "";
		String queryStatement = "";
		String pageStats = "";
		String rootPath = IntelUtil.getRootPath(currentPage);
		String productpath = rootPath+IntelMobileConstants.SIMILAR_PRODUCT_PATH;
		try{
    	queryStatement = "select * from nt:unstructured where jcr:path like '"+productpath+"' AND id ='"+id+"'"  ;
    	if(LOG.isDebugEnabled()) {
			LOG.debug("queryStatement------"+queryStatement);
    	}
		//jcrSession = RepoUtil.login(repository);
		QueryManager queryManager = session.getWorkspace().getQueryManager();
		//QueryManager queryManager = jcrSession.getWorkspace().getQueryManager();
		String stmt = queryStatement;
		Query query = queryManager.createQuery(stmt, Query.SQL);
		QueryResult qr = query.execute();
		if(qr != null){
		NodeIterator itr = qr.getNodes();
		if(itr.hasNext()){
			
			Node node = itr.nextNode();
			String nodePath = node.getPath();
			Node jcrNode = node.getParent();
			if(LOG.isDebugEnabled()) {
				LOG.debug("jcrNode------"+jcrNode.getPath());
			}
			if(LOG.isDebugEnabled()) {
				LOG.debug("Nodepath-------"+nodePath);
			}

				if (jcrNode.hasProperty("cq:lastReplicationAction")){
					pageStats = jcrNode.getProperty("cq:lastReplicationAction").getString();
					if(LOG.isDebugEnabled()) {
						LOG.debug("----status of page------"+pageStats);	
					}
				}	 
         if(pageStats != null && !pageStats.equalsIgnoreCase("")){
		  if(pageStats.equalsIgnoreCase("Activate")){
			productUrl = nodePath.replace("/jcr:content/details","" ) ;
			if(LOG.isDebugEnabled()) {
				LOG.debug("productUrl-------"+productUrl);
			}
			}
		}
		}
		}
		}
		catch (RepositoryException e) {
			LOG.error("RepositoryException in getProductUrl :"+e.getMessage());
			
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
