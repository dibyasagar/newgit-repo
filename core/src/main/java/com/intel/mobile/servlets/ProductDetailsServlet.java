package com.intel.mobile.servlets;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.jcr.api.SlingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.JcrTagManagerFactory;
import com.day.cq.tagging.TagManager;
import com.intel.mobile.util.ProductUtil;
import com.intel.mobile.util.RepoUtil;
import com.day.cq.i18n.I18n;

@Component(immediate = true, metatype = false, label = "Product Details Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/ProductDetails") })

public class ProductDetailsServlet extends SlingAllMethodsServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(ProductDetailsServlet.class);

	@Reference
	private SlingRepository repository;

	@Reference
	private JcrTagManagerFactory jcrTagManagerFactory;
	 
	private Session jcrSession;

	public void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {

	}
	
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {

		String paramPaths = request.getParameter("products");
		String paramLocale = request.getParameter("locale");
		String paramCategory = request.getParameter("category");
		response.setContentType("application/json;charset=utf-8");
	

		try {
			if(paramPaths != null && paramLocale != null && paramCategory != null) {
				
				JSONObject jsonResponse = new JSONObject();
				
				jcrSession = RepoUtil.login(repository);
				TagManager tagManager = jcrTagManagerFactory.getTagManager(jcrSession);
				
				String[] arrayPaths = paramPaths.split(",");
				
				String[] arrayLocale = paramLocale.split("_");
				Locale locale = null;
				if(arrayLocale.length==1) {
					locale = new Locale(arrayLocale[0]);
				} else {
					locale = new Locale(arrayLocale[0], arrayLocale[1]);
				}

				I18n i18n =  new I18n(request.getResourceBundle(locale));				
				
				Map<String, String> featuresMap = ProductUtil.getFeaturesList(tagManager,
						locale, paramCategory);
				JSONObject keyList = new JSONObject();
				for(String key:featuresMap.keySet()) {
					String value = featuresMap.get(key);
					keyList.put(key, i18n.get(value));
				}
				
				jsonResponse.put("features", keyList);
				
				JSONArray productList = new JSONArray();
				for(String path:arrayPaths) {
					try {
						Node node = jcrSession.getNode(path + "/jcr:content/details");
						JSONObject productDetails = new JSONObject();
						productDetails.put("picture", node.getProperty("picture").getString());
						productDetails.put("name", node.getProperty("name").getString());
						if(node.hasProperty("bestPrice")) {
							productDetails.put("bestPrice", node.getProperty("bestPrice").getString());	
						} else {
							productDetails.put("bestPrice", "");
						}						
						productDetails.put("path", path);
						for(Entry<String, String> entry: featuresMap.entrySet()) {
							if(node.hasProperty(entry.getKey())) {
								String value = node.getProperty(entry.getKey()).getString();
								if(entry.getKey().matches("[1-9][0-9]*")) {
									String s = value.substring(value.indexOf("|")+1);					
									value = s;
								} 								
								productDetails.put(entry.getKey(),value);
							}			
						}
						productList.put(productDetails);						
					} catch(RepositoryException e) {
						LOGGER.error("[doGet] - Error processing path - " + path, e);
					}
				}	
				jsonResponse.put("products", productList);								
				response.getWriter().write(jsonResponse.toString());
				jcrSession.logout();
			} else {
				response.getWriter().write("Not Enough Parameters");
			}
		} catch(Exception e) {
			e.printStackTrace(response.getWriter());
		}
	}	
}
