/**
 * 
 */
package com.intel.mobile.util;

import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.MessageFormat;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import javax.jcr.Value;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONObject;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.commons.jcr.JcrConstants;
import com.day.cq.mailer.MailService;
import com.day.cq.mailer.MailingException;
import com.day.cq.wcm.api.Page;

import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.services.IntelConfigurationService;


/**
 * @author skarm1
 *
 */
public class IntelUtil {

	private static final Logger log = LoggerFactory.getLogger(IntelUtil.class);

	/**
	 * 
	 * @param rootNode, nodeTitle
	 * @return
	 * @throws RepositoryException
	 * @description This method is to create redirect mapping node in JCR
	 */
	public static Node createNode(Node rootNode, String nodeTitle, String primaryType) throws RepositoryException {

		if(log.isDebugEnabled()) {
			log.debug("createNode: START");
		}
		Node node = rootNode.addNode(nodeTitle);
		node.setPrimaryType(primaryType);
		if(log.isDebugEnabled()) {
			log.debug("createNode: END");
		}
		return node;
	}
	public static void saveAPIDataAsJCRProperty(Node node, JSONObject jsonObject){
		saveAPIDataAsJCRProperty(node, jsonObject, null);
	}

	public static boolean saveAPIDataAsJCRProperty(Node node, JSONObject jsonObject, Map<String, Set<String>> prodAttrValues){
		Set<String> attrValues = null;

		boolean changed = false;
		try {
			log.debug("Entering saveAPIDataAsJCRProperty :"+node.getName());
		} catch (RepositoryException e1) {
			log.error("RepositoryException :"+e1.getMessage());
		}

		Iterator<String> itr = jsonObject.keys();

		while(itr.hasNext()){
			String key = itr.next();
			log.debug("itr.next() : "+key);
			try{

				/*If the jsonObject contains the key  "additionalProperties" */
				if(key.equals("additionalProperties")){
					JSONArray additionalProperties = jsonObject.getJSONArray(key);
					for(int i=0;i<additionalProperties.length();i++){
						JSONObject property = additionalProperties.getJSONObject(i);
						boolean same = false;
						if(node.hasProperty(property.getString("id")) 
								&& node.getProperty(property.getString("id")).getString().equals(
										StringEscapeUtils.unescapeXml(property.getString("name"))+"|"+StringEscapeUtils.unescapeXml(property.getString("value")))) {
							same = true;
						}
						if(!same) {
							node.setProperty(property.getString("id"), StringEscapeUtils.unescapeXml(property.getString("name"))+"|"+StringEscapeUtils.unescapeXml(property.getString("value")));

							changed = true;
						}						
					}
				} else if(key.equals("productOffers")){
					if(log.isDebugEnabled()) {
						log.debug("Inside Product offers - " + jsonObject.getJSONArray(key));
					}
					try {
						JSONArray productOffers = jsonObject.getJSONArray(key);
						Node productOffersNode = null;
						if(node.hasNode(IntelMobileConstants.NODE_NAME_PRODUCT_OFFERS)) {
							productOffersNode = node.getNode(IntelMobileConstants.NODE_NAME_PRODUCT_OFFERS);
//							productOffersNode.remove();

						} else {
							productOffersNode = node.addNode(IntelMobileConstants.NODE_NAME_PRODUCT_OFFERS, IntelMobileConstants.PRIMARY_TYPE_NT_UNSTRUCTURED);	
						}	
						log.info("Product Offers :"+productOffers);
						log.info("product offer node :"+productOffersNode);
						for(int i=0;i<productOffers.length();i++){
							JSONObject property = productOffers.getJSONObject(i);
							String nodeName = StringEscapeUtils.unescapeXml(property.getString("name"));
							nodeName = normalizeName(nodeName);
							log.info("Entering nodeName :"+nodeName);
							try {						
								Node retailerNode = null; 
								if(productOffersNode.hasNode(nodeName)) {
									retailerNode = productOffersNode.getNode(nodeName);
								} else {
									retailerNode = productOffersNode.addNode(nodeName,IntelMobileConstants.PRIMARY_TYPE_NT_UNSTRUCTURED);	
								}
								log.info("Entering retailerNode :"+retailerNode);						
								Iterator<String> offersItr = property.keys();
								while(offersItr.hasNext()) {
									String offersKey = (String)offersItr.next();		
									log.info("Inside offersItr :"+offersKey );	
									boolean same = false;
									if(retailerNode.hasProperty(offersKey) 
											&& retailerNode.getProperty(offersKey).getString().equals(
													property.getString(offersKey))) {
										same = true;
									}
									if(!same) {									
										retailerNode.setProperty(offersKey, property.getString(offersKey));
										changed = true;
									}
								}							
							} catch(Exception e) {
								log.error("[saveAPIDataAsJCRProperty] error occurred while saving product offers node - " + nodeName, e);
							}
						}					
					} catch(Exception e) {
						log.error("[saveAPIDataAsJCRProperty] error occurred while saving product offers ", e);
					}
				} else if(key.equals("similarProducts")){
					if(log.isDebugEnabled()) {
						log.debug("Inside Similar Products - " + jsonObject.getJSONArray(key));
					}
					try {
						JSONArray productOffers = jsonObject.getJSONArray(key);
						Node similarProductsNode = null;
						if(node.hasNode(IntelMobileConstants.NODE_NAME_SIMILAR_PRODUCTS)) {
							similarProductsNode = node.getNode(IntelMobileConstants.NODE_NAME_SIMILAR_PRODUCTS);
//							similarProductsNode.remove();

						} else {
							similarProductsNode = node.addNode(IntelMobileConstants.NODE_NAME_SIMILAR_PRODUCTS, IntelMobileConstants.PRIMARY_TYPE_NT_UNSTRUCTURED);	
						}						
						for(int i=0;i<productOffers.length();i++){
							JSONObject property = productOffers.getJSONObject(i);
							String nodeName = property.getString("id");
							try {
								nodeName = normalizeName(nodeName);
								Node productNode = null;
								if(similarProductsNode.hasNode(nodeName)) {
									productNode = similarProductsNode.getNode(nodeName);
								} else {
									productNode = similarProductsNode.addNode(nodeName,IntelMobileConstants.PRIMARY_TYPE_NT_UNSTRUCTURED);
								}
								Iterator<String> similarItr = property.keys();
								while(similarItr.hasNext()) {
									String similarKey = (String)similarItr.next();	
									
									boolean same = false;
									if(productNode.hasProperty(similarKey) 
											&& productNode.getProperty(similarKey).getString().equals(
													property.getString(similarKey))) {
										same = true;
									}
									if(!same) {																		
										productNode.setProperty(similarKey, property.getString(similarKey));
										changed = true;
									}
								}							
							} catch(Exception e) {
								log.error("[saveAPIDataAsJCRProperty] error occurred while saving similar product - " + nodeName, e);
							}
						}									
					} catch(Exception e) {
						log.error("[saveAPIDataAsJCRProperty] error occurred while saving similar product", e);
					}
				}
				else{
					String value = jsonObject.getString(key);


					boolean same = false;
					if(node.hasProperty(key) 
							&& node.getProperty(key).getString().equals(
									StringEscapeUtils.unescapeXml(value))) {
						same = true;
					}
//					log.info(((same==true)?"Not Changed, ":"Changed, ")+"Product Synchroniser - " + node.getParent().getParent().getName() + ", Previous Value " + node.getProperty(key).getString() + ", New Value - " + StringEscapeUtils.unescapeXml(value));
					if(!same) {									
						node.setProperty(key, StringEscapeUtils.unescapeXml(value));
						changed = true;
					}
					if(prodAttrValues != null)
					{
						attrValues = prodAttrValues.get(key);
						if(attrValues == null)
						{
							attrValues = new HashSet<String>();

						}
						attrValues.add(StringEscapeUtils.unescapeXml(value));
						prodAttrValues.put(key, attrValues);

							
					}
				}

			} catch (Exception e) {
				String exceptionMsg = e.getMessage();
				if(exceptionMsg != null && exceptionMsg.length() > 50)
				{
					exceptionMsg = exceptionMsg.substring(0, 50);
				}
				log.error("Exception :"+exceptionMsg);
			}


		}

		return changed;
	}

	public static String normalizeName(String productName){
		/*
		StringBuilder nodeNameBuilder;
		if(productName != null)
		{
			String pName = productName.replace(' ' , '-');
			nodeNameBuilder = new StringBuilder();
			char[] nameInChars = pName.toCharArray();
			for(char c : nameInChars)
			{
				if(Character.isLetterOrDigit(c) || '-' == c)
				{
					nodeNameBuilder.append(c);
				}
			}
			return nodeNameBuilder.toString().toLowerCase();
		}
		return null;
		*/
		if(productName != null) {
			String pName = productName.replace(' ' , '-');
			String normString = pName.replaceAll("[^A-Za-z0-9-]", "");
			return normString.toLowerCase();
		}
		return null;
	}

	/*
	 *  This method returns the current locale.
	 *  Accepts the currentPage Page Object.
	 */
	public static String getLocale(Page currentPage){
		String locale=IntelMobileConstants.DEFALUT_LOCALE;
		String jcrLanguage= null;
		if(log.isDebugEnabled()) {
			log.debug("Inside getLocale Method");
		}
		while(currentPage != null){
			if(currentPage.getProperties().get("cq:template", "").
					equals(IntelMobileConstants.LOCALE_CONFIG_TEMPLATE)){
				if(log.isDebugEnabled()) {
					log.debug("found localconfig template page ..." + currentPage.getName());
				}
				jcrLanguage = currentPage.getProperties().get("jcr:language", "");
				if(jcrLanguage !=null && (!jcrLanguage.toString().trim().equals(""))){
					if(log.isDebugEnabled()) {
						log.debug("current Locale is ..." + locale);
					}
					locale = jcrLanguage;
					break;
				}        	 
			}        	
			currentPage = currentPage.getParent();
		}
		if(log.isDebugEnabled()) {
			log.debug("retuning from getLocale method and locale is ....." + locale);
		}
		if(locale.equals("en_GB")){
			locale = "en_UK";
		}
		return locale;
	}
	/*
	 *  This method returns the current locale.
	 *  Accepts the currentPage Page Object.
	 */
	public static String getLocaleWithoutChangingUK(Page currentPage){
		String locale=IntelMobileConstants.DEFALUT_LOCALE;
		String jcrLanguage= null;
		if(log.isDebugEnabled()) {
			log.debug("Inside getLocale Method");
		}
		while(currentPage != null){
			if(currentPage.getProperties().get("cq:template", "").
					equals(IntelMobileConstants.LOCALE_CONFIG_TEMPLATE)){
				if(log.isDebugEnabled()) {
					log.debug("found localconfig template page ..." + currentPage.getName());
				}
				jcrLanguage = currentPage.getProperties().get("jcr:language", "");
				if(jcrLanguage !=null && (!jcrLanguage.toString().trim().equals(""))){
					if(log.isDebugEnabled()) {
						log.debug("current Locale is ..." + locale);
					}
					locale = jcrLanguage;
					break;
				}        	 
			}        	
			currentPage = currentPage.getParent();
		}
		if(log.isDebugEnabled()) {
			log.debug("retuning from getLocale method and locale is ....." + locale);
		}

		return locale;
	}

	public static String getLocaleLanguage(Page currentPage){
		String locale = getLocale(currentPage);
		String lang = "";
		if(locale != null && locale.indexOf("_") > 0)
		{
			lang = locale.substring(0, locale.indexOf("_"));
			log.debug("Language :"+lang);
		}
		
		return lang;
	}
	
	/*
	 *  This method returns the current root node.
	 *  Accepts the currentPage Page Object.
	 */
	public static String getRootPath(Page currentPage){
		String rootPath=IntelMobileConstants.DEFALUT_ROOT_PATH;
		if(log.isDebugEnabled()) {
			log.debug("Inside getRootPath Method");
		}
		//log.info("current page path : "+currentPage.getPath());
		while(currentPage != null){
			if(currentPage.getProperties().get("cq:template", "").
					equals(IntelMobileConstants.LOCALE_CONFIG_TEMPLATE)){
				rootPath = currentPage.getPath();
				if(log.isDebugEnabled()) {
					log.debug("found localconfig template page path is... " + currentPage.getPath());
				}
			}
			currentPage	= currentPage.getParent();
		}
		return rootPath;
	}


	public static String getTemplateName(Page currentPage){

		String templatePath = currentPage.getProperties().get("cq:template", "");	
		return templatePath.substring(templatePath.lastIndexOf("/")+1);
	}

	public static int getComponentId(Resource resource){

		Node componentCellNode = resource.adaptTo(Node.class);
		String comppnentCellName = null;
		int componentCustomId = 1;
		if(componentCellNode!=null){
			try {
				comppnentCellName = componentCellNode.getName();
				if(comppnentCellName.contains("_")){
					comppnentCellName = comppnentCellName.substring(comppnentCellName.lastIndexOf("_")+1);
					if(log.isDebugEnabled()) {
						log.debug("comppnentCellName :"+comppnentCellName);
					}
					componentCustomId = Integer.parseInt(comppnentCellName)+ 2;
				}
			} catch (Exception e) {
				log.error("Exception :"+e.getMessage());
				log.debug(e.getMessage(), e);
			}
		}
		return componentCustomId;
	}
	
	public static long getParsysNumber(Resource resource){

		Node componentCellNode = resource.adaptTo(Node.class);
		long childCount = 0;
		long parsysCount = 0;
		NodeIterator childnode = null;
		if(componentCellNode!=null){
			try {
				//childCount  = componentCellNode.getNodes().getSize();
				if(componentCellNode.getNodes() != null){
					childCount  = componentCellNode.getNodes().getSize();
			    if(childCount == 1){
			    	childnode  = componentCellNode.getNodes();
				
			    if(childnode.hasNext()){
			    	Node tempNode = childnode.nextNode();
			    	if(tempNode.getNodes() != null){
			    	parsysCount = tempNode.getNodes().getSize();
			    	}
			    }
				}
				}
				
			} catch (RepositoryException e) {
				log.error("RepositoryException :"+e.getMessage());
				log.debug(e.getMessage(), e);
			}
		}
		return parsysCount;
	}

	public static String[] getIntenalUrl(String paths[], ResourceResolver resolver){
        String reqUrl[] = new String[paths.length];
         for (int i = 0; i < paths.length; i++) {
              if (paths[i].toString().startsWith("/content")) {
                 reqUrl[i] = resolver.map(paths[i].toString()).concat(".html");
              }else{
            	reqUrl[i] = paths[i].toString();
            }
            
       }
         if(log.isDebugEnabled()) {
 			log.debug("reqUrl for internal :"+reqUrl);
         }
		return reqUrl;
	}
	
	public static Object[] getDisplayUrl(Object paths[], ResourceResolver resolver){
        Object reqUrl[] = new Object[paths.length];
         for (int i = 0; i < paths.length; i++) {
              if (paths[i].toString().startsWith("/content")) {
                 reqUrl[i] = resolver.map(paths[i].toString()).concat(".html");
              }else{
            	reqUrl[i] = paths[i].toString();
            }
            
       }
         if(log.isDebugEnabled()) {
 			log.debug("reqUrl for Display :"+reqUrl);
         }
		return reqUrl;
	}
	
	public static String getLinkUrl(String path, ResourceResolver resolver){
		String reqUrl = "";
		if (path.startsWith("/content")) {
			reqUrl = resolver.map(path).concat(".html");
         }else{
       	reqUrl = path;
       }
     return reqUrl;
	}
	

	public static IntelConfigurationService getIntelConfigService(){
		BundleContext bundleContext = FrameworkUtil.getBundle(IntelConfigurationService.class).getBundleContext();  	
		return (IntelConfigurationService) bundleContext.getService(bundleContext.getServiceReference(IntelConfigurationService.class.getName()));
	}
	
	public static String getDisclaimerForShop(Page currentPage, String disclaimerNumber){
		
		String disclaimerText = null;
		String country = currentPage.getAbsoluteParent(2).getName();
		String language = currentPage.getAbsoluteParent(3).getName();
		
		//http://www.intel.com/content/data/disclaimers/us-en/disclaimer-1199/_jcr_content/disclaimerpar/disclaimerentry.json
		StringBuffer discalimerURL = new StringBuffer();
		discalimerURL.append(IntelMobileConstants.INTEL_DISCLAIMER_ROOT);
		discalimerURL.append("/").append(country).append("-").append(language).append("/");
		discalimerURL.append("disclaimer-").append(disclaimerNumber);
		discalimerURL.append("/_jcr_content/disclaimerpar/disclaimerentry.json");
		if(log.isDebugEnabled()) {
			log.debug("discalimerURL :"+discalimerURL.toString());
		}
		try {
			URL intelDisclaimerUrl = new URL(discalimerURL.toString());
			InputStream disclaimerStream =  intelDisclaimerUrl.openStream();
			String jsonTxt = IOUtils.toString(disclaimerStream);
			JSONObject json = new JSONObject(jsonTxt); 
			disclaimerText = (String)json.get("text");
			if(log.isDebugEnabled()) {
				log.debug("disclaimerText :"+disclaimerText);
			}
		} catch (Exception e) {
			String exceptionMsg = e.getMessage();
			if(exceptionMsg != null && exceptionMsg.length() > 50)
			{
				exceptionMsg = exceptionMsg.substring(0, 50);
			}
			log.error("Exception :"+exceptionMsg);
		}
		return disclaimerText;
	}
	
	public static String getGoogleSiteVerificationCode(Page currentPage){
				
		String gsv = null;
		try {
			Session session = currentPage.getContentResource().getResourceResolver().adaptTo(Session.class);
			Node localeNode = session.getNode(getRootPath(currentPage));
			if(log.isDebugEnabled()) {
				log.debug("localeNode :"+localeNode.getPath());
			}
			if(localeNode.hasNode(JcrConstants.JCR_CONTENT)){
				Node jcrContent = localeNode.getNode(JcrConstants.JCR_CONTENT);
				if(jcrContent.hasNode("locale")){
					Node localeConfigNode = jcrContent.getNode("locale");
					if(localeConfigNode.hasProperty("gsv")){
						gsv = localeConfigNode.getProperty("gsv").getString();
					}
				}
			}
		} catch (PathNotFoundException e) {
			log.error("PathNotFoundException :"+e.getMessage());
			log.debug(e.getMessage(), e);
		} catch (RepositoryException e) {
			log.error("RepositoryException :"+e.getMessage());
			log.debug(e.getMessage(), e);
		}
		return gsv;
	}
	
	public static String getConfigValue(Page currentPage,String nodeName, String property, String defaultValue) {
		String value = defaultValue;
		Node configNode = null;  
		try {	
			String localePath = getRootPath(currentPage) + "/jcr:content";
			Session session = currentPage.getContentResource().getResourceResolver().adaptTo(Session.class);
			Node localeNode = session.getNode(localePath);
			//log.info("path:"+localePath);
		
			if(localeNode.hasNode(nodeName)){
				configNode = localeNode.getNode(nodeName);
			}
			if(configNode != null) {
				if(configNode.hasProperty(property)) {
					value = configNode.getProperty(property).getString();
					if(value == null || value.length() ==0) {
						value = defaultValue;
					}
				}
			}
		} catch(Exception e) {
			log.error("Exception in getConfigValue:",e);
		}
		return value;
	}
	public static String[] getConfigValues(Page currentPage,String nodeName, String property) {
		String[] stringValues = null;
		Node configNode = null;
		try {
			String localePath = getRootPath(currentPage) + "/jcr:content";
			Session session = currentPage.getContentResource().getResourceResolver().adaptTo(Session.class);
			Node localeNode = session.getNode(localePath);
			
			if(localeNode.hasNode(nodeName)){
				configNode = localeNode.getNode(nodeName);
			}
			if(configNode != null) {
				if(configNode.hasProperty(property)) {
					if(configNode.getProperty(property).isMultiple()) {
						Value[] values = configNode.getProperty(property).getValues();
						stringValues = new String[values.length];
						for(int i=0;i<values.length;i++) {
							stringValues[i] = values[i].getString();
						}						
					} else {
						stringValues = new String[1];
						stringValues[0] = configNode.getProperty(property).getString();
					}
				}
			}
		} catch(Exception e) {
			log.error("Exception in getconfig values:",e);
		}
		return stringValues;
	}
	
	public static Status sendMail(String to, String from, String subject, String body, String copyMe,String emailPageUrl,String fromFirstName,String fromLastName) {
		
		log.info("to :"+to);
		log.info("from :"+from);
		log.info("subject :"+subject);
		log.info("body :"+body);
		log.info("copyMe :"+copyMe);
		log.info("emailPageUrl :"+emailPageUrl);
		log.info("fromFirstName :"+fromFirstName);
		log.info("fromLastName :"+fromLastName);
		
		Status status = Status.EMAILSENDSUCCESS;
		HtmlEmail email = new HtmlEmail();

		try {   
			Bundle bndl = FrameworkUtil.getBundle(com.day.cq.mailer.MailService.class);
			BundleContext bundleContext =bndl.getBundleContext();  
			ServiceReference ref = bundleContext.getServiceReference(MailService.class.getName());
			MailService mailService = (MailService) bundleContext.getService(ref);
			
		    log.info("mailService:::" + mailService);
			
			//Set the body of the email
			MimeBodyPart messageBodyPart =  new MimeBodyPart();
			MimeMultipart multipart = new MimeMultipart();
			
			// If To Present
			if (to!=null && to.length()>0 && !(to.equals(""))) {
				
				log.info ("Inside To::"+to);
				
				InternetAddress[] internetAddressTo = InternetAddress.parse(to, true);
				email.setTo(Arrays.asList(internetAddressTo));
			}	

			// If CC is present
			if(copyMe!=null && copyMe.length()>0 && copyMe.equals("Y")) {
				if( log.isDebugEnabled()){
					log.debug ("Inside CC:"+from);
				}
				InternetAddress[] internetAddresCc = InternetAddress.parse(from, true);
				email.setCc(Arrays.asList(internetAddresCc));
			}   

			email.setFrom(from); 
			email.setSubject(subject); 
			email.addPart(multipart);
			//email.setTextMsg(body);
			email.setContent(body,"text/html");
			mailService.send(email);

		} catch(MessagingException e) {
			if( log.isDebugEnabled()){
				log.debug("Status :"+Status.MESSAGINGEXCEPTION.getStatusMessage());
			}
			status = Status.MESSAGINGEXCEPTION;

			log.error("MessagingException :", e);

		} catch (EmailException e) {
			if( log.isDebugEnabled()){
				log.debug("Status :"+Status.EMAILEXCEPTION.getStatusMessage());
			}
			status = Status.EMAILEXCEPTION;

			log.error("EmailException :", e);

		}catch (MailingException e) {
			if( log.isDebugEnabled()){
				log.debug("Status :"+Status.MAILINGEXCEPTION.getStatusMessage());
			}
			status = Status.MAILINGEXCEPTION;

			log.error("MailingException :", e);

		}catch (NullPointerException e) {
			if( log.isDebugEnabled()){
				log.debug("Status :"+Status.NULLPOINTEREXCEPTION.getStatusMessage());
			}
			status = Status.NULLPOINTEREXCEPTION;

			log.error("NullPointerException :", e);

		}
		return status;
	}
	public static String tweetName(String orgName){
	    //log.info("----inside tweetname---");
		if(orgName != null) {
			String pName = orgName.replace("\u00AE","");
			       pName = pName.replace("\u2122","");
			
			return pName;
		}
		return null;
	}
}
