package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Component (immediate = true, metatype = false, label = "Search Suggestions Servlet")
@Service (value = javax.servlet.Servlet.class)
@Properties ({ @Property(name = "sling.servlet.paths", value = "/bin/SearchSuggestions") })

public class SearchSuggestionsServlet extends SlingAllMethodsServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = 
		LoggerFactory.getLogger(SearchSuggestionsServlet.class);
	
	//@Reference
	//private SlingRepository repository;
	
	private Session jcrSession;

	public void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
	}
	
	protected void doGet(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
		LOGGER.info(">>>>Search Text"+request.getParameter("stext"));
		jcrSession = request.getResourceResolver().adaptTo(Session.class);
		searchSuggestions(request, response);
	}
	
	@SuppressWarnings("deprecation")
	private void searchSuggestions(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {
			try {
				String searchText = request.getParameter("stext");
				ArrayList<String> results = new ArrayList<String>();
				String queryText = "select * from nt:base where jcr:path like " +
						"'/content/intelmobile/%' and contains(jcr:title, '"+
						searchText+"') order by jcr:score desc";
				
				QueryManager queryManager = jcrSession.getWorkspace().getQueryManager();
				Query query = queryManager.createQuery(queryText, Query.SQL);
				QueryResult result = query.execute();
			    NodeIterator iterator = result.getNodes();
			    while(iterator.hasNext()) {
			    	Node node = iterator.nextNode();
			    	results.add(node.getProperty("jcr:title").getString());
			    }
				JSONObject json = new JSONObject();
				json.put("values", results);
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
