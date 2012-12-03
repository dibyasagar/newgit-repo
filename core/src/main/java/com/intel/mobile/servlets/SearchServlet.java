package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;
import com.day.cq.wcm.foundation.Search;


@Component (immediate = true, metatype = false, label = "Search Servlet")
@Service (value = javax.servlet.Servlet.class)
@Properties ({ @Property(name = "sling.servlet.paths", value = "/bin/Search") })

public class SearchServlet extends SlingAllMethodsServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = 
		LoggerFactory.getLogger(SearchServlet.class);
	
	private Session jcrSession;
	
	public void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {		
	}
	
	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
		jcrSession = request.getResourceResolver().adaptTo(Session.class);
		LOGGER.info(">>>>Search Text"+request.getParameter("stext"));
		doSearch(request, response);
	}
	
/*	private void doSearch(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
			try {

				Search search = new Search(request);				
				search.setHitsPerPage(10);						
				List<JSONObject> resultPages = new ArrayList<JSONObject>();
				long totalMatches = 0;
				
				{
					search.setSearchIn("/content/dam");
					Result result = search.getResult();			
					totalMatches += result.getTotalMatches();
					List<Hit> hits = result.getHits();
					Iterator<Hit> itr = hits.iterator();
					while(itr.hasNext()) {
						Hit hit = itr.next();
						JSONObject obj = new JSONObject();
						obj.put("title", hit.getTitle());
						obj.put("url", hit.getURL());
						obj.put("excerpt", hit.getExcerpt());
						resultPages.add(obj);
					}	
				}				
				
				JSONObject json = new JSONObject();
				json.put("totalrecords",totalMatches);
				json.put("results", resultPages);
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().write(json.toString());
				LOGGER.info("JSON returns - " + json.toString());	
			} catch(RepositoryException re) {
				LOGGER.error("Repository Exception " + re.toString());
				re.printStackTrace();
			} catch(JSONException je) {
				LOGGER.error("JSON Exception " + je.toString());
				je.printStackTrace();
			} 		
	}*/
	
	private void doSearch(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
		try {
			Bundle bundle = FrameworkUtil.getBundle(com.day.cq.search.QueryBuilder.class);
			BundleContext bndlContext = bundle.getBundleContext();  
			ServiceReference srvReference = bndlContext.getServiceReference(QueryBuilder.class.getName());
			QueryBuilder builder = (QueryBuilder) bndlContext.getService(srvReference);
			
			String keyword = request.getParameter("q");
			String startIndex = request.getParameter("start");
			if(startIndex == null || startIndex.length()==0) startIndex = "0";
			String sort = request.getParameter("sort");
			String orderBy = "jcr:score";
			if(sort == null || sort.length()==0) {
				sort = "desc";
			} else {
				orderBy = "jcr:title";				
			}
			String searchPath = "/content/";
			
			
			LOGGER.info("Search parameters - " + keyword + "////" + startIndex);
			
			Map<String, String> map = new HashMap<String, String>();
		    map.put("fulltext", keyword);
		    map.put("path", searchPath);
		    
		    map.put("group.p.or", "true");
		    map.put("group.1_path", "/content/intelmobile");
		    map.put("group.2_path", "/content/dam/geometrixx/documents");
		    map.put("property","jcr:primaryType");
		    map.put("property.1_value","cq:Page");
		    map.put("property.2_value","dam:Asset");		    
		    map.put("orderby", "@jcr:content/" + orderBy);
		    map.put("orderby.index", "true");
		    map.put("orderby.sort", sort);
		    
		    
		    Query query = builder.createQuery(PredicateGroup.create(map), jcrSession);
		       	LOGGER.info("***Search Query :: "+query.toString());
		    	LOGGER.info("Predicate Map :"+map);
		      
		    query.setStart(Integer.parseInt(startIndex));
	        query.setHitsPerPage(10);
	
			List<JSONObject> resultPages = new ArrayList<JSONObject>();
			long totalMatches = 0;
			
			{
				SearchResult result = query.getResult();			
				totalMatches += result.getTotalMatches();
				List<Hit> hits = result.getHits();
				Iterator<Hit> itr = hits.iterator();
				while(itr.hasNext()) {
					Hit hit = itr.next();
					JSONObject obj = new JSONObject();
					obj.put("title", hit.getTitle());
					obj.put("url", hit.getPath());
					obj.put("excerpt", hit.getExcerpt());
					resultPages.add(obj);
				}	
			}				
			
			JSONObject json = new JSONObject();
			json.put("totalrecords",totalMatches);
			json.put("results", resultPages);
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().write(json.toString());
			LOGGER.info("JSON returns - " + json.toString());	
		} catch(RepositoryException re) {
			LOGGER.error("Repository Exception " + re.toString());
			re.printStackTrace();
		} catch(JSONException je) {
			LOGGER.error("JSON Exception " + je.toString());
			je.printStackTrace();
		} 	
	}
}
