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
import org.apache.sling.api.SlingHttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RecommendationDetails {

	
	private static final Logger LOG = LoggerFactory.getLogger(RecommendationDetails.class);
	
	
	public void decorateRecommendationDetail(HttpServletRequest request){

		//String id = request.getParameter("id");
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		Session session = slingRequest.getResourceResolver().adaptTo(Session.class);
		
		String queryStatement = "";
		//queryStatement = "select * from sling:Folder where jcr:path like '/content/intel/en/shop/products/%' AND id ='"+ id +"'";
		
		queryStatement = "select * from sling:Folder where jcr:path like '/content/intel/en/shop/processortypes/%' AND gaming='Moderate' and multitasking='Often' and photos_videos='Professional' and communication='Video Chat'";
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
				}

				if(tmpNode.hasProperty("gaming")){
					request.setAttribute("gaming", tmpNode.getProperty("gaming").getString());
				}

				if(tmpNode.hasProperty("multitasking")){
					request.setAttribute("multitasking", tmpNode.getProperty("multitasking").getString());
				}
				if(tmpNode.hasProperty("photos_videos")){
					request.setAttribute("photos_videos", tmpNode.getProperty("photos_videos").getString());
				}
				if(tmpNode.hasProperty("communication")){
					request.setAttribute("communication", tmpNode.getProperty("communication").getString());
				}
				if(tmpNode.hasProperty("id")){
					request.setAttribute("id", tmpNode.getProperty("id").getString());
				}
				
			}
		} catch (RepositoryException e) {
			LOG.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		}
	}
}
