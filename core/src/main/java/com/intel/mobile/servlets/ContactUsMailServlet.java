package com.intel.mobile.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.util.IntelUtil;
import com.intel.mobile.util.Status;

@Component(immediate = true, metatype = false, label = "Conatct Us Email Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/contactUs") })



public class ContactUsMailServlet extends SlingAllMethodsServlet{



	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(ContactUsMailServlet.class);

		public void doPost(SlingHttpServletRequest request,
			SlingHttpServletResponse response) throws IOException {

		LOGGER.info("Entered the doPost method of contact us mail.");
		String fromAddress = request.getParameter("fromAddress");
		String toAddress = request.getParameter("toAddress");
		String signupInfo = request.getParameter("signup");
		String firstName=request.getParameter("firstName");
		String datetime=request.getParameter("datetime");
		//String body= datetime + firstName + fromAddress + signupInfo;
		StringBuffer body = new StringBuffer();
		body.append("Date/Time: ").append(datetime).append("<br />");
		body.append("Name: ").append(firstName).append("<br />");
		body.append("Email: ").append(fromAddress).append("<br />");
		if(signupInfo!=null)
		body.append("Subscription: ").append(signupInfo).append("<br />");
		String subject=request.getParameter("subject");	
		LOGGER.info("Subject : "+subject);
		LOGGER.info("fromAddress : "+fromAddress);
		LOGGER.info("toAddress : "+toAddress);
		LOGGER.info("signupInfo :"+signupInfo);
		LOGGER.info("body :"+body.toString());
		Status status=IntelUtil.sendMail(toAddress,fromAddress,subject,body.toString(), null, null, "", "");
		LOGGER.info("You have successfully made Ajax Call:" + toAddress);
		LOGGER.info("status : "+status);
		
	}
	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {


	}


}





