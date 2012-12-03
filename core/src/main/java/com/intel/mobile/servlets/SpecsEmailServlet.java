package com.intel.mobile.servlets;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.InvalidQueryException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.search.ISearchDAO;
import com.intel.mobile.search.SearchController;
import com.intel.mobile.search.SearchBeanList;
import com.intel.mobile.search.SearchBean;
import com.intel.mobile.search.SearchDAOImpl;
import com.intel.mobile.services.IntelConfigurationService;
import com.intel.mobile.util.IntelUtil;

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
import org.apache.sling.settings.SlingSettingsService;

import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author skarm1
 *
 */

@Component(immediate = true, metatype = false, label = "Processor Spec Email Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/SpecsEmail") })



public class SpecsEmailServlet extends SlingAllMethodsServlet{



	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(SpecsEmailServlet.class);

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

		LOGGER.info("Entered the doPost method.");
		String emailAddress = request.getParameter("emailAddress");
		String processor = request.getParameter("processor");
		String ram = request.getParameter("ram");
		String hardDrive = request.getParameter("hardDrive");
		String screenSize = request.getParameter("screenSize");
		String portability = request.getParameter("portability");
		String specsLink = request.getParameter("specsLink");

		LOGGER.info("emailAddress : "+emailAddress);
		LOGGER.info("processor : "+processor);
		LOGGER.info("ram : "+ram);
		LOGGER.info("hardDrive : "+hardDrive);
		LOGGER.info("screenSize : "+screenSize);
		LOGGER.info("portability : "+portability);
		LOGGER.info("specsLink : "+specsLink);
		
		StringBuffer spec = new StringBuffer();
		spec.append("Processor : ").append(processor).append("\n");
		spec.append("RAM : ").append(ram).append("\n");
		spec.append("Hard Drive : ").append(hardDrive).append("\n");
		spec.append("Screen Size : ").append(screenSize).append("\n");
		spec.append("Portability : ").append(portability).append("\n");
		spec.append("Spec Link : ").append(specsLink).append("\n");
		
		BundleContext bundleContext = FrameworkUtil.getBundle(SlingSettingsService.class).getBundleContext();  
		IntelConfigurationService intelConfigService = (IntelConfigurationService) bundleContext.getService(bundleContext.getServiceReference(IntelConfigurationService.class.getName()));
		String emailBody =  intelConfigService.getSpecEmailBody();
		Object[] values = new String[] {spec.toString()};	
		emailBody = MessageFormat.format(emailBody, values);
		
		LOGGER.info("emailBody :"+emailBody);
		IntelUtil.sendMail(emailAddress, "noreply@intel.com", intelConfigService.getSpecEmailSubject(), emailBody, null, null, "", "");

	}
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {


	}


}





