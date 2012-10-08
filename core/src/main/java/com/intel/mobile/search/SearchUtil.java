package com.intel.mobile.search;

import java.util.ArrayList;
import org.apache.sling.commons.json.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SearchUtil {
	private static final Logger LOG = LoggerFactory.getLogger(SearchUtil.class);
	public static SearchBeanList convertJSONtoList (String results) {
		SearchBeanList searchBeanList = new SearchBeanList ();
		String errorResponse = "null";// The string "null" is returned from the search if the request completes normally.
		// Parse JSON string
		String didYouMeanResponse = "";
		try {
            JSONObject jsonObject = new JSONObject(results);
            // Get error response
            errorResponse = jsonObject.getString("ErrorResponse");
            if(!jsonObject.isNull("DidYouMean")){
            	didYouMeanResponse = jsonObject.getString("DidYouMean");
                }
             
            
            LOG.info("Did You mean ::"+didYouMeanResponse);
            // Get total count - seems to be NOT a counter of results. Not used currently.
            // String totalCount = jsonObject.getString("TotalCount");

            // Get results
            JSONArray jResultSet = null;
            if(!jsonObject.isNull("ResultSet")){
            jResultSet = jsonObject.getJSONArray("ResultSet");
            }
            ArrayList<SearchBean> resultList = new ArrayList<SearchBean>();
            int counter = 0;
            if(jResultSet != null){
            for (int i=0; i<jResultSet.length(); i++) {
            	SearchBean searchBean = new SearchBean();
                JSONObject jFieldList = (JSONObject)jResultSet.get(i);
                JSONArray jFieldArray = jFieldList.getJSONArray("FieldList");
                //System.out.println("jFieldArray: "+jFieldArray);

                JSONObject jTitle = (JSONObject)jFieldArray.get(0);
                String title = jTitle.getString("FieldValue");
                LOG.info("Title ::"+title);  
                searchBean.setTitle(title);
                JSONObject jBody = (JSONObject)jFieldArray.get(2);
                String body = jBody.getString("FieldValue");
                LOG.info("Body ::"+body); 
                searchBean.setBody(body);
                JSONObject jTeaser = (JSONObject)jFieldArray.get(1);
                String teaser = jTeaser.getString("FieldValue");
                LOG.info("Teaser ::"+teaser); 
                searchBean.setTeaser(teaser);
                JSONObject jURL = (JSONObject)jFieldArray.get(3);
                String url = jURL.getString("FieldValue");
                LOG.info("url::"+url); 
                searchBean.setUrl(url);
                resultList.add(searchBean);
                counter++;

                //System.out.println("title: " + title);
               // System.out.println("body: " + body);
                //System.out.println("url: " + url);
            }}
            searchBeanList.setErrorMessage(errorResponse);
            searchBeanList.setTotalCount(counter);
            searchBeanList.setSearchBeans(resultList);
            searchBeanList.setDidYouMessage(didYouMeanResponse);
            //System.out.println ("ErrorResponse: "+ errorResponse);
            //System.out.println ("TotalCount: "+ totalCount);									
		} catch (JSONException e) {
			if (errorResponse.equals("null")) {
				errorResponse = "JSONException in SearchUtil.java";
				searchBeanList.setErrorMessage(errorResponse);
			}
			e.printStackTrace();
			LOG.error("JSONException :"+e.getMessage());
		}
		return searchBeanList;
	}
}
