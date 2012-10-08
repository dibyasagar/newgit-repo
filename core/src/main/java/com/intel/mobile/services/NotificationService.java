package com.intel.mobile.services;

import java.util.List;

/**
 * 
 * @author ujverm
 *
 */
public interface NotificationService {
	public void notifyErrorMessages(List<String> messages, String service) ;
	
	public void notifySuccessMessages(List<String> messages, String service) ;
}
