package com.intel.mobile.vo;

import java.util.ArrayList;
import java.util.List;

public class SyncMessageVO {
	List<String> successList;
	List<String> failureList;
	
	public SyncMessageVO() {
		successList = new ArrayList<String>();
		failureList = new ArrayList<String>();
	}
	
	public void addSuccessMessage(String message) {
		successList.add(message);
	}
	
	public void addFailureMessage(String message) {
		failureList.add(message);
	}
	
	public List<String> getSuccessList() {
		return successList;
	}
	
	public List<String> getFailureList() {
		return failureList;
	}	
}
