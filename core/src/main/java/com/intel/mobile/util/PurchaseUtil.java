package com.intel.mobile.util;


import java.util.ArrayList;
import java.util.List;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.vo.RetailerDetailsVO;;

public class PurchaseUtil {
	
	
	private static final Logger LOG = LoggerFactory.getLogger(PurchaseUtil.class);
	
	public static List getRetailerInfo(Page currentPage) {
		String logo="";
		String name = "";
        String price = "";
	    String url = "";
	    List<RetailerDetailsVO> retailerResultList = new ArrayList<RetailerDetailsVO>();
		
	
         Node detailNode = currentPage.getContentResource().getChild("details").adaptTo(Node.class);
         try{
         if(detailNode.hasNode("shopproductoffers")) {
        		Node shopProductnode = detailNode.getNode("shopproductoffers");
        		NodeIterator purchaseNode = shopProductnode.getNodes();
        		long Count = purchaseNode.getSize();
        		
        		while(purchaseNode.hasNext()){
        			 Node tmpNode = purchaseNode.nextNode();
        			    if(tmpNode.hasProperty("logo") && tmpNode.getProperty("logo") != null) {
        			    	logo = tmpNode.getProperty("logo").getString();
        			    }
        			    if(tmpNode.hasProperty("name") && tmpNode.getProperty("name")!= null) {
        			    	name = tmpNode.getProperty("name").getString();
        			    }
        			    if(tmpNode.hasProperty("price") && tmpNode.getProperty("price") != null) {
        			    	price = tmpNode.getProperty("price").getString();
        			    }
        			    if(tmpNode.hasProperty("url") && tmpNode.getProperty("url") != null) {
        			    	url = tmpNode.getProperty("url").getString();
        			    }
        			    RetailerDetailsVO retailerInfo = new RetailerDetailsVO(logo,name, price,url);
                		retailerResultList.add(retailerInfo);
        		}
        		
        		
         }
         

         }
         catch (RepositoryException e) {
 			LOG.error("RepositoryException in getRetailerInfo :"+e.getMessage());
 			
 		}
	
         return retailerResultList;
}
}
