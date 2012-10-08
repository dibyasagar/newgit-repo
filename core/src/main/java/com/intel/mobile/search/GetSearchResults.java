package com.intel.mobile.search;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;


public class GetSearchResults {
	
	
	@SuppressWarnings("deprecation")
	public static QueryResult doSearch(Session session,String type) throws RepositoryException
	{
		String queryStatement = "";
		if(type.equals("product")){
			
			queryStatement = "select * from nt:unstructured where jcr:path like '/content/intel/product/%'" ;
		}
        if(type.equals("processor")){
			
			queryStatement = "select * from nt:unstructured where jcr:path like '/content/intel/processor/%'" ;
		}  
       if(type.equals("brand")){
			
			queryStatement = "select * from nt:unstructured where jcr:path like '/content/intel/brand/%'" ;
		}  
	
		QueryManager queryManager = session.getWorkspace().getQueryManager();
	    String stmt = queryStatement;
	    Query query = queryManager.createQuery(stmt, Query.SQL);
        QueryResult qResult = query.execute();
	    return qResult;
		
	}
}
