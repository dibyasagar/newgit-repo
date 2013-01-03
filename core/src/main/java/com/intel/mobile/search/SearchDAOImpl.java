package com.intel.mobile.search;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intel.mobile.services.SchedulerService;


public class SearchDAOImpl implements ISearchDAO {
	private static final Logger LOG = LoggerFactory.getLogger(SearchDAOImpl.class);
	
    public SearchBeanList getResults (String url, String q1, String q2, String q3, String q4, String q10, String q11, String q23, String q24, String q26, String q40) {

          HttpURLConnection connection = null;
          BufferedReader rd  = null;
          StringBuilder sb = null;
          String line = null;
          URL serverAddress = null;
          
          int hits = Constants.MEDIUM_HITS;
          try {
              hits = Integer.parseInt(q3);
              if (hits >= Constants.HIGH_HITS)
                  hits = Constants.HIGH_HITS;
              else if (hits >= Constants.MEDIUM_HITS)
                        hits = Constants.MEDIUM_HITS;
                    else if (hits >= Constants.LOW_HITS)
                        hits = Constants.LOW_HITS;
          }
          catch (Exception e) {
              hits = Constants.MEDIUM_HITS;
          }  
          q3 = Integer.toString(hits);
          LOG.info("hits :"+q3 );
          String searchReq = url + "?" + "q1=" + q1 + "&q2=" + q2 + "&q3=" + q3 + "&q4=" + q4 + "&q10=" + q10 + "&q11=" + q11 + "&q23=" + q23 + "&q24=" + q24 +"&q26="+ q26 + "&q40=" + q40;
        
          LOG.info("searchReq :"+searchReq );
          
          try {
              serverAddress = new URL(searchReq);
              //set up communications
              connection = null;
            
              //Set up the initial connection
              connection = (HttpURLConnection)serverAddress.openConnection();
              connection.setRequestMethod("GET");
              connection.setDoOutput(true);
              connection.setReadTimeout(10000);
                   
              connection.connect();
              LOG.info("After connection ::***"+connection);  
              LOG.info("After connection :::"+connection.getInputStream());  
              //read the result from the server
              //rd  = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
              rd  = new BufferedReader(new InputStreamReader(connection.getInputStream(),Charset.forName("UTF-8")));
              LOG.info("After rd ::::"+rd);   
              sb = new StringBuilder();
              
              while ((line = rd.readLine()) != null)
              {
                  sb.append(line + '\n');
              }
              LOG.info("searchstring :"+sb.toString());                     
          } catch (MalformedURLException e) {
        	  LOG.error("MalformedURLException :"+e.getMessage());
              e.printStackTrace();
          } catch (ProtocolException e) {
        	  LOG.error("ProtocolException :"+e.getMessage());
              e.printStackTrace();
          } catch (IOException e) {
        	  LOG.error("IOException :"+e.getMessage());
              e.printStackTrace();
          }
          finally
          {
              //close the connection, set all objects to null
              connection.disconnect();
              rd = null;
              connection = null;
          }       
         
        SearchBeanList searchBeanList = SearchUtil.convertJSONtoList(sb.toString());
        LOG.info("searchBeanList :"+searchBeanList);
        return searchBeanList;
    }
    public ArrayList getQuickResults (String url, String m, String languageCode, String searchRealm, String includeBestMatch, String searchPhrase, String limit, String callback) {
    	
    	 HttpURLConnection connection = null;
         BufferedReader rd  = null;
         StringBuilder sb = null;
         String line = null;
         URL serverAddress = null;
         ArrayList<String> resultList = new ArrayList<String>();
         searchPhrase = searchPhrase.replace(" ","+");
         String searchQuery = url + "?" + "m=" + m + "&languageCode=" + languageCode + "&searchRealm=" + searchRealm + "&includeBestMatch=" + includeBestMatch + "&searchPhrase=" + searchPhrase + "&limit=" + limit + "&callback=" + callback;

        try {
            serverAddress = new URL(searchQuery);
            //set up communications
            connection = null;
          
            //Set up the initial connection
            connection = (HttpURLConnection)serverAddress.openConnection();
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);
            connection.setReadTimeout(10000);
                 
            connection.connect();
                      
            //read the result from the server
            LOG.info("searchQuery:"+searchQuery);
            LOG.info("connection.getResponseCode() :"+connection.getResponseCode());
            if (connection.getResponseCode() == 200){
            	rd  = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
            } else {
            	rd  = new BufferedReader(new InputStreamReader(connection.getErrorStream(),"UTF-8"));
            }
            //rd  = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
            sb = new StringBuilder();
          
            while ((line = rd.readLine()) != null)
            {
                sb.append(line + '\n');
            }
            String searchResult =  sb.toString();
            LOG.info("searchResult :"+searchResult);
            if(searchResult!=null && searchResult.contains("[") && searchResult.contains("]")){       
                   searchResult = searchResult.substring(searchResult.indexOf("[")+1, searchResult.indexOf("]"));
                   searchResult = searchResult.replace("\"","");
                   LOG.debug("searchResult without quotes :"+searchResult);
                  
                   StringTokenizer st1 = new StringTokenizer(searchResult,",");
                   while(st1.hasMoreTokens()){
       		        
                	   resultList.add(st1.nextToken());
       		    }
            }
                   LOG.info("searchResult final :"+resultList);
                   
        } 
        catch (MalformedURLException e) {
        	LOG.error("MalformedURLException :",e);
        } catch (ProtocolException e) {
        	LOG.error("ProtocolException :",e);
        } catch (IOException e) {
        	LOG.error("IOException :",e);
        }
        finally
        {
            //close the connection, set all objects to null
            connection.disconnect();
            rd = null;
            connection = null;
        }
        if(sb!=null){
        	LOG.debug("searchResult :"+sb.toString());
        }
        return resultList;
    }
}
