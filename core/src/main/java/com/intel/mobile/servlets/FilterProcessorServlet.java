package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;

import org.apache.sling.api.servlets.SlingAllMethodsServlet;


@Component(immediate = true, metatype = false, label = "Filter Processor Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/FilterProcessor") })

public class FilterProcessorServlet extends SlingAllMethodsServlet{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(FilterProcessorServlet.class);
	
	
	
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
		
		LOGGER.info("Inside doGet of FilterProcessorServlet");
		
		String path = request.getParameter("pagePath");
		HttpSession session = request.getSession();
		Map requestmap = request.getParameterMap() ;

		LOGGER.info("Map in coming from Request in Process Filter" + requestmap);
		Map filterMap = (Map)session.getAttribute("filterMap");

		LOGGER.info("Filter Map >>>>>>" + filterMap);

		String filterName = request.getParameter("filterName");
		LOGGER.info("Filter Name : " + filterName);

		if(filterMap == null) {
			filterMap = new HashMap<String, List>();
		}
		Set keySet = requestmap.keySet();

		Iterator iter = keySet.iterator();
		List<String> keyList = new ArrayList<String>();


		while (iter.hasNext()) {
		  	String paramName = (String)iter.next();
		  	LOGGER.info("Keys in Request/value in Process Filter>>" + paramName + "/" + requestmap.get(paramName));
			if(!paramName.equals("pagePath") && !paramName.equals("filterName")){
				keyList.add(paramName) ;
			}
		}

		LOGGER.info("KeyList in processfilter after extracting the Key values from Request" + keyList);

		filterMap.put(filterName ,keyList);

		LOGGER.info("Filter Map in Process filter , will hold the filter type and list of subfilters selected :: " +filterMap);

		session.setAttribute("filterMap",filterMap);
		session.setAttribute("category", path);
		//getServletContext().getRequestDispatcher("/content/intelmobile/en/products/223.filter.html").forward(request, response);
		
		LOGGER.info("Path :" + path);
		
		
		
		
		response.sendRedirect(path.concat(".filter.html"));

		
		
		
	}
	
	
	
	
	
	
	
	

}
