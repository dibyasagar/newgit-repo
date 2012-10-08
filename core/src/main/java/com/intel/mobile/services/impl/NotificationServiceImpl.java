package com.intel.mobile.services.impl;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.InternetAddress;

import org.apache.commons.mail.HtmlEmail;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.osgi.framework.Constants;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.mailer.MessageGateway;
import com.day.cq.mailer.MessageGatewayService;
import com.intel.mobile.services.NotificationService;

/**
 * 
 * @author ujverm
 *
 */

@Component (immediate=true, label="Notification Service", description = "Notification Service", metatype=true )
@Service 
@Properties({
	@Property(name = Constants.SERVICE_DESCRIPTION, value = "Notification Service"),
	@Property(name = Constants.SERVICE_VENDOR, value = "Intel")})

public class NotificationServiceImpl implements NotificationService {

	@Reference (policy=ReferencePolicy.STATIC)	
 	private MessageGatewayService messageGatewayService;

	private static final Logger LOGGER = 
		LoggerFactory.getLogger(NotificationServiceImpl.class);
	
	@Property(label = "Recipient Email Addresses", value = "", description = "Email addresses to send messages.")
	public static final String NOTIFICATION_EMAIL_ADDR = "notificationEmailAddr";
	
	@Property(label = "Sender's Email Address", value = "", description = "Email address to use for Sender")
	public static final String FROM_EMAIL_ADDR = "fromEmailAddr";
	
	@Property(label = "Send Success Notifications",  boolValue = true , description = "Do you want to send success notifications ?")
	public static final String SEND_SUCCESS_NOTIFICATION = "sendSuccessNotifications";

	@Property(label = "Send Failure Notifications",  boolValue = true , description = "Do you want to send failure notifications ?")
	public static final String SEND_FAILURE_NOTIFICATION = "sendFailureNotifications";

	
	private String notificationEmailAddr;
	private String fromEmailAddr;
	private boolean sendSuccessNotifications;
	private boolean sendFailureNotifications;
	
	protected void activate(ComponentContext context){

		try {
			LOGGER.debug("activate method called");
			Dictionary props = context.getProperties();

			notificationEmailAddr = (String) props.get(NOTIFICATION_EMAIL_ADDR);
			fromEmailAddr = (String) props.get(FROM_EMAIL_ADDR);
			sendSuccessNotifications = (Boolean) props.get(SEND_SUCCESS_NOTIFICATION);
			sendFailureNotifications = (Boolean) props.get(SEND_FAILURE_NOTIFICATION);
		} catch (Exception e){
			LOGGER.error(e.getMessage(), e);
		}
	}
	
	public void notifyErrorMessages(List<String> messages, String service) {
		if(sendFailureNotifications) {
			LOGGER.error("Notify error message called with parameter - " + messages);
			HtmlEmail email = new HtmlEmail();
		 	List<InternetAddress> emailAddresses = new ArrayList<InternetAddress>();	 	
		 	StringBuilder emailMessage = new StringBuilder();
		 	
		 	emailMessage.append("<p>Following errors occurred while running ");
		 	emailMessage.append(service);
		 	emailMessage.append(":<br /><ol>");
		 	for(String msg:messages) {
		 		emailMessage.append("<li>");
		 		emailMessage.append(msg);
		 		emailMessage.append("</li>");
		 	}
		 	emailMessage.append("</ol></p>");
		 	emailMessage.append("<p>Please contact your administrator or check logs for more information.");
		 	
		 	try {
		 		String emails[] = notificationEmailAddr.split(",");

		 		for(int i=0;i<emails.length;i++) {
		 			if(isEmailCorrect(emails[i])) {
			 			InternetAddress address = new InternetAddress(emails[i].trim());
			 			emailAddresses.add(address);	 				
		 			} 
		 		}
		 		
		 		email.setTo(emailAddresses);
		 		email.setFrom(fromEmailAddr);
		 		email.setSubject("Notification: Intel " + service + " errors");
		 		email.setHtmlMsg(emailMessage.toString());
		 		MessageGateway<HtmlEmail> messageGateway = messageGatewayService.getGateway(HtmlEmail.class);
		 		if(messageGateway != null){
		 			messageGateway.send(email);
		 		}
		 		else {
		 			LOGGER.error("Message gateway is null will not be able to send mail");
		 		}
		 			
	      } catch (Exception e ) {
	            LOGGER.error( "Fatal error while sending failure notification ", e );
	        }					
		}
	}
	
	public void notifySuccessMessages(List<String> messages, String service) {
		if(sendSuccessNotifications) {		
		 	HtmlEmail email = new HtmlEmail();
		 	List<InternetAddress> emailAddresses = new ArrayList<InternetAddress>();	 	
		 	StringBuilder emailMessage = new StringBuilder();
		 	
		 	emailMessage.append("<p>");	 	
		 	emailMessage.append(service);
		 	emailMessage.append(" completed successfully. Following are the notes:");
		 	emailMessage.append(":<br /><ol>");
		 	for(String msg:messages) {
		 		emailMessage.append("<li>");
		 		emailMessage.append(msg);
		 		emailMessage.append("</li>");
		 	}
		 	emailMessage.append("</ol></p>");
		 	
		 	try {
		 		String emails[] = notificationEmailAddr.split(",");
	
		 		for(int i=0;i<emails.length;i++) {
		 			if(isEmailCorrect(emails[i])) {
			 			InternetAddress address = new InternetAddress(emails[i].trim());
			 			emailAddresses.add(address);	 				
		 			} 
		 		}
		 		
		 		email.setTo(emailAddresses);
		 		email.setFrom(fromEmailAddr);
		 		email.setSubject("Notification: Intel " + service + " success");
		 		email.setHtmlMsg(emailMessage.toString());
		 		MessageGateway<HtmlEmail> messageGateway = messageGatewayService.getGateway(HtmlEmail.class);
		 		if(messageGateway != null) {
		 			messageGateway.send(email);
		 		}
	      } catch (Exception e ) {           
	            LOGGER.error( "Fatal error while sending success notification ", e );
	        }
		}
	}	
	
	public boolean isEmailCorrect(String email) {
		
		final String EMAIL_PATTERN = 
            "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
		
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();		
	}
}
