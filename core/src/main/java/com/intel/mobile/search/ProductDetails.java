package com.intel.mobile.search;

import javax.jcr.Node;
import javax.jcr.Value;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

import org.apache.sling.api.SlingHttpServletRequest;
import org.omg.CORBA.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.vo.ProductDetailsVo;
import com.intel.mobile.constants.IntelMobileConstants;;

public class ProductDetails {


	private static final Logger LOG = LoggerFactory.getLogger(ProductDetails.class);

	public void decorateProduct(HttpServletRequest request){

		String id = request.getParameter("id");
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		Session session = slingRequest.getResourceResolver().adaptTo(Session.class);

		String queryStatement = "";
		queryStatement = "select * from nt:unstructured where jcr:path like '"+IntelMobileConstants.PRODUCT_PATH+"' AND id ='"+ id +"'";
		LOG.info("queryStatement: "+queryStatement); 
		QueryManager queryManager;
		try {
			queryManager = session.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qResult = query.execute();

			NodeIterator itr = qResult.getNodes();
			if(itr.hasNext()){

				Node tmpNode = itr.nextNode();
				if(tmpNode.hasProperty("name")){
					request.setAttribute("productName", tmpNode.getProperty("name").getString());
					LOG.info("PRODUCT NAME : "+tmpNode.getProperty("name").getString()); 
				}

				if(tmpNode.hasProperty("bestPrice")){
					request.setAttribute("price", tmpNode.getProperty("bestPrice").getString());
				}

				if(tmpNode.hasProperty("processor")){
					request.setAttribute("processor", tmpNode.getProperty("processor").getString());
				}
				if(tmpNode.hasProperty("hardDrive")){
					request.setAttribute("hardDrive", tmpNode.getProperty("hardDrive").getString());
				}
				if(tmpNode.hasProperty("screen")){
					request.setAttribute("screen", tmpNode.getProperty("screen").getString());
				}
				if(tmpNode.hasProperty("os")){
					request.setAttribute("operatingSystem", tmpNode.getProperty("os").getString());
				}
				if(tmpNode.hasProperty("picture")){
					request.setAttribute("productImage", tmpNode.getProperty("picture").getString());
				}
				if(tmpNode.hasProperty("processorNumber")){
					request.setAttribute("pNumber", tmpNode.getProperty("processorNumber").getString());
				}
				
				
			}
		} catch (RepositoryException e) {
			LOG.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		}
	}
	public void getProductList(HttpServletRequest request){
		
		
		String prodDetail_path="";
		String name = "";
        String price = "";
	    String processor = "";
	    String hardDrive = "";
	    String ram = "";
	    String image = "";
	    String id = "";
		String productvalue = request.getParameter("pid");
		String processorvalue =request.getParameter("prid");
		String brandvalue = request.getParameter("bValue");
		List<ProductDetailsVo> productResultList = new ArrayList<ProductDetailsVo>();
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		Session session = slingRequest.getResourceResolver().adaptTo(Session.class);
		String queryStatement = "";
		queryStatement = "select * from nt:unstructured where jcr:path like '"+IntelMobileConstants.PRODUCT_PATH+"' AND categoryId='" + productvalue +"' AND processorId='" + processorvalue + "' AND manufacturer='"+ brandvalue +"'";
		LOG.info("queryStatement: "+queryStatement);   
		QueryManager queryManager;
		try {
			queryManager = session.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qResult = query.execute();
            NodeIterator itr = qResult.getNodes();
            
            prodDetail_path = IntelMobileConstants.PRODUCT_DETAIL_PAGES_PATH;
			while(itr.hasNext()){
                Node tmpNode = itr.nextNode();
                if(tmpNode.hasProperty("name")){
                	name = tmpNode.getProperty("name").getString();
				}

				if(tmpNode.hasProperty("bestPrice")){
					price = tmpNode.getProperty("bestPrice").getString();
				}

				if(tmpNode.hasProperty("processor")){
					processor = tmpNode.getProperty("processor").getString();
				}
				if(tmpNode.hasProperty("hardDrive")){
					hardDrive = tmpNode.getProperty("hardDrive").getString();
				}
				if(tmpNode.hasProperty("ram")){
					ram = tmpNode.getProperty("ram").getString();
				}
				
				if(tmpNode.hasProperty("picture")){
					image = tmpNode.getProperty("picture").getString();
				}
				if(tmpNode.hasProperty("id")){
					id = tmpNode.getProperty("id").getString();
				}
				ProductDetailsVo productFeature = new ProductDetailsVo(name, price, processor, hardDrive, ram,image,id);
				productResultList.add(productFeature);
			}
			LOG.info("productResultList: "+productResultList);
			request.setAttribute("productlist", productResultList);
			request.setAttribute("productdetail_path", prodDetail_path);
	}
		catch (RepositoryException e) {
			LOG.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		}
	}
	
}
