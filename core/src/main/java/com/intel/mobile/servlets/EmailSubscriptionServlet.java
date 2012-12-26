package com.intel.mobile.servlets;

import java.io.IOException;
import com.intel.mobile.util.IntelUtil;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * @author ggoswa
 *
 */

@Component(immediate = true, metatype = false, label = "Email Subscription Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/EmailSub") })



public class EmailSubscriptionServlet extends SlingAllMethodsServlet{



	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(EmailSubscriptionServlet.class);

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
		String useremailAddress = request.getParameter("email");
		String sourceemailAddress = request.getParameter("fromemail");
		String destemailAddress = request.getParameter("toemail");
		String subject=request.getParameter("subject");
		if(subject==null)
		subject="";	
		String mailbody=request.getParameter("body");
		LOGGER.info("emailAddress : "+useremailAddress);
		LOGGER.info("source : "+sourceemailAddress);
		LOGGER.info("destination : "+destemailAddress);
		LOGGER.info("subject : "+subject);
		LOGGER.info("mailbody: "+mailbody);
	    StringBuffer useremailBody = new StringBuffer();
		useremailBody.append(mailbody).append("\n");
		
		IntelUtil.sendMail(useremailAddress,sourceemailAddress,subject, mailbody.toString(), null, null, "", "");
		
      
	
	}
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {


	}


}





