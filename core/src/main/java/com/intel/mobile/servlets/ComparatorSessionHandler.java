package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

/**
 * 
 * @author smukh5
 *
 */



@Component(immediate = true, metatype = false, label = "Comparator Session Handler")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/ComparatorSessionHandler") })

public class ComparatorSessionHandler extends SlingAllMethodsServlet {
	
	private static final Logger log = LoggerFactory.getLogger(ComparatorSessionHandler.class);
	
	List<HashMap<String,String>> sessionMapList = new ArrayList<HashMap<String,String>>();
	
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
		
		
		log.info("Inside doGet of ComparatorSessionHandler");
		HttpSession session = request.getSession();
		
		if(session.getAttribute("sessionMapList") != null)
		log.info("sessionMapList in session " + session.getAttribute("sessionMapList")) ;
		
		try{
			
			String categorytype = "";
			
			if(request.getParameter("categorytype") != null){
				categorytype = (String)request.getParameter("categorytype") ;
			}
			
			/*if(!categorytype.equalsIgnoreCase((String)request.getSession().getAttribute(categorytype))){
				
				// TODO ::  Show Error Message Logic
				
			}*/
			
			String productPath = "" ;
			String productTitle = "" ;
			String catPagePath = "" ;
			
			if((String)request.getParameter("productPath") != null && (String)request.getParameter("productTitle") != null && (String)request.getParameter("catPagePath") != null){	
				productPath  = (String)request.getParameter("productPath") ;
				productTitle = (String)request.getParameter("productTitle") ; 
				catPagePath  = (String)request.getParameter("catPagePath");
				log.info("Category Type :" + categorytype);
				log.info("Product Path :" + productPath);
				log.info("Product Title :" + productTitle);
				log.info("Cat Page Path :" + catPagePath);
			}
			
			
			
			HashMap<String,String> productMap = new HashMap<String, String>();
			
			productMap.put("productPath", productPath);
			productMap.put("productTitle", productTitle);
			productMap.put("productImage", "/etc/designs/intelmobile/img/FPO-ProdGridView-tile1.jpg");
			productMap.put("productPrice", "$299");
			
			
			// TODO :: Add logic to restrict the max no of products added for compare .
			if(sessionMapList.size() < 6){
				sessionMapList.add(productMap);
			}
			
			log.info("Before setting in session --> sessionMapList " + sessionMapList);
			
			session.removeAttribute("categoryType");
			session.removeAttribute("sessionMapList");
			session.setAttribute("categoryType", categorytype);
			session.setAttribute("sessionMapList", sessionMapList);
			
			
			
			
			JSONObject json = new JSONObject();
			json.put("product",sessionMapList);
	
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().write(json.toString());
			log.info("JSON returns - " + json.toString());	
			
			//response.sendRedirect(catPagePath.concat(".html"));
			
			
			
			log.info("Session Data --> sessionMapList" + session.getAttribute("sessionMapList"));
		
		
		}
		catch (Exception e){
			
			log.info("Code screwed up !! " + e.getMessage());
			e.printStackTrace();
		}
		
	}

}
