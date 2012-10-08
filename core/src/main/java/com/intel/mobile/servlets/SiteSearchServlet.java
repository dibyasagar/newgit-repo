package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.InvalidQueryException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import com.intel.mobile.search.ISearchDAO;
import com.intel.mobile.search.SearchController;
import com.intel.mobile.search.SearchBeanList;
import com.intel.mobile.search.SearchBean;
import com.intel.mobile.search.SearchDAOImpl;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.jcr.api.SlingRepository;

import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(immediate = true, metatype = false, label = "Site Search Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/SiteSearch") })


public class SiteSearchServlet extends SlingAllMethodsServlet{
	

	
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(SiteSearchServlet.class);

	@Reference
	private SlingRepository repository;

	private Session jcrSession;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.sling.api.servlets.SlingAllMethodsServlet#doPost(org.apache
	 * .sling.api.SlingHttpServletRequest,
	 * org.apache.sling.api.SlingHttpServletResponse)
	 */
	public void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {


	}
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
		
			LOGGER.info("Keyword***"+request.getParameter("keyword"));
			doKeywordSearch(request, response);
		}
	
		@SuppressWarnings("deprecation")
		private void doKeywordSearch(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
			try{
                
				//String requestSearchQuery = StringEscapeUtils.escapeXml(request.getParameter("search-text"));
				ArrayList<String> resultList = new ArrayList<String>();
				String requestSearchQuery = request.getParameter("keyword");
				String langCode = request.getParameter("langcode");
				//String langCode = currentPage.getLanguage(false).getLanguage();
				//String country = currentPage.getLanguage(false).getCountry();
				String url = "http://search.intel.com/SearchLookup/DataProvider.ashx";
				String m = "GetTypeAheadSuggestions";
				String languageCode = "en_US"; // lang e.g. en
				String searchRealm = "Mobile"; // # of results
				String includeBestMatch = "yes";
				//String q10 = "url:" + siteName + ":exactphrase^urls:"+deviceGroupName+".html:exactphrase";        // url:intel-xx:exactphrase
				String searchPhrase=requestSearchQuery;                   // required fields
				String limit = "10";                                       // q10's separator
				String callback= "jsonp1342678216030";                                       //q10's multifield separator
				String searchErrCode = "";
				String searchErrMsg = "";
				int searchTotalCount = 0;
				//java.util.ArrayList<SearchBean> resultsList = null;

				if (requestSearchQuery != null && requestSearchQuery !="") {
				  
					SearchDAOImpl searchDAO = new SearchDAOImpl();
					resultList = searchDAO.getQuickResults(url, m,languageCode,searchRealm,includeBestMatch,searchPhrase,limit,callback);
				        LOGGER.info("After resultsList" );
				        //SearchBeanLeforeist searchBeanList = new SearchBeanList();;
				        	
                         //resultsList = (java.util.ArrayList<SearchBean>)searchBeanList.getSearchBeans();
                        // LOGGER.info("SearchBeans*** : "+searchBeanList.getSearchBeans().toString());
                        
				       // searchErrCode = searchBeanList.getErrorCode();
				        //log.info("searchErrCode"+searchErrCode );
				       // searchErrMsg = searchBeanList.getErrorMessage();
				        //searchTotalCount = searchBeanList.getTotalCount();
				        
				      
				        JSONObject object = new JSONObject();
				    
				       // object.put("name",);
						object.put("value",resultList);
						
						
						response.setContentType("application/json;charset=utf-8");
						//response.setContentType("application/json");
						response.getWriter().write(object.toString());
						LOGGER.info("jsonResponse*** : "+object.toString());
			
				    } 
                 }
			catch (JSONException e) {
				LOGGER.error("JSONException :"+e.getMessage());
				e.printStackTrace();
			} 
			}
		}

	
	


