/**
 * 
 */
package com.intel.mobile.util;

/**
 * @author skarm1
 *
 */
public enum Status {

	MESSAGINGEXCEPTION("Messaging Exception occured."), 
	MALFORMEDURLEXCEPTION("MalformedURL Exception occured."), 
	EMAILEXCEPTION("Email Exception occured."), 
	EMAILSENDSUCCESS("Thank you.Your email has been sent.") , 
	MAILINGEXCEPTION("Connection to the mail server failed."),
	NULLPOINTEREXCEPTION("Please configure the mail Server.");

	private String status;
	
	Status(String st) {
		status = st;
	  }

	public String getStatusMessage() {
		return status;
	}
}
