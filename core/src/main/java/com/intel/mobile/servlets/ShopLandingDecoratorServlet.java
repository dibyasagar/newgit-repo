package com.intel.mobile.servlets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.query.InvalidQueryException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.jcr.api.SlingRepository;


import java.awt.List;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.apache.sling.api.servlets.SlingAllMethodsServlet;

import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.util.RepoUtil;


@Component(immediate = true, metatype = false, label = "PDF Merge Servlet")
@Service(value = javax.servlet.Servlet.class)
@Properties({ @Property(name = "sling.servlet.paths", value = "/bin/PerformSearch") })


public class ShopLandingDecoratorServlet extends SlingAllMethodsServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(ShopLandingDecoratorServlet.class);

	@Reference
	private SlingRepository repository;

	private Session jcrSession;

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


	}


	@SuppressWarnings("deprecation")
	private void doProductsSearch(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
		try{
			String queryStatement = "";
			queryStatement = "select * from sling:Folder where jcr:path like '"+IntelMobileConstants.PRODUCT_TYPES_PATH+"'" ;
			LOGGER.info("querystatment***11  "+ queryStatement);

			jcrSession = RepoUtil.login(repository);
			QueryManager queryManager = jcrSession.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qr = query.execute();
			NodeIterator itr = qr.getNodes();
			LOGGER.info("prodtjsonlenght:"+itr.getSize());
			JSONArray listArray = new JSONArray();
			while (itr.hasNext()) {
				JSONObject object = new JSONObject();
				Node node = itr.nextNode();
				if (node.hasProperty("name")&& node.hasProperty("value")) {
					if(node.getProperty("name").getString()!= null && node.getProperty("name").getString().length()>0 && 
							node.getProperty("value").getString()!= null && node.getProperty("value").getString().length()>0)
					{
						object.put("name",node.getProperty("name").getString());
						object.put("value",node.getProperty("value").getString());
						listArray.put(object);
					}
					
				}
			}
			response.setContentType("application/json;charset=utf-8");
			//response.setContentType("application/json");
			response.getWriter().write(listArray.toString());
			LOGGER.info("jsonResponse*** : "+listArray.toString());

		}
		catch (JSONException e) {
			LOGGER.error("JSONException :"+e.getMessage());
			e.printStackTrace();
		} catch (InvalidQueryException e) {
			LOGGER.error("InvalidQueryException :"+e.getMessage());
			e.printStackTrace();
		} catch (RepositoryException e) {
			LOGGER.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		} 

	}

	protected void doGet(SlingHttpServletRequest request,SlingHttpServletResponse response) throws IOException {
		if(request.getParameter("searchtype").equals("products")){
			LOGGER.info("searchtype***"+request.getParameter("searchtype"));
			doProductsSearch(request, response);
		}
		else if(request.getParameter("searchtype").equals("processors")){
			doProcessorsSearch(request, response);
		}
		else if(request.getParameter("searchtype").equals("brands")){
			doBrandsSearch(request, response);
		}

	}
	@SuppressWarnings("deprecation")
	private void doBrandsSearch(SlingHttpServletRequest request,
			SlingHttpServletResponse response)throws IOException {
		// TODO Auto-generated method stub
		LOGGER.info("in dobrandsSearch**"+request.getParameter("searchtype"));

		try{
			String queryStatement = "";
			queryStatement = "select * from nt:unstructured where jcr:path like '"+IntelMobileConstants.PRODUCT_PATH+"' AND categoryId='"+ request.getParameter("categorytype")+"' AND processorId='"+request.getParameter("processortype")+"'";
			LOGGER.info("querystatmentBBBBB  "+ queryStatement);

			jcrSession = RepoUtil.login(repository);
			QueryManager queryManager = jcrSession.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qr = query.execute();
			NodeIterator itr = qr.getNodes();
			LOGGER.info("BRANDjsonlenght:"+itr.getSize());
			Set tempset = new HashSet();
			JSONArray listArray = new JSONArray();
			int counter=0;
			int finalcounter=0;
			while (itr.hasNext()) {
				counter++;
				LOGGER.info("in BRAND while");
				JSONObject object = new JSONObject();
				Node node = itr.nextNode();
				if(!object.has(node.getProperty("manufacturer").getString())){

					LOGGER.info("*****BBB****");
					if (node.hasProperty("manufacturer")) {
						if(node.getProperty("manufacturer").getString()!= null && node.getProperty("manufacturer").getString().length()>0 )
						{
							if(tempset.add(node.getProperty("manufacturer").getString()))
							{
								finalcounter++;
								object.put("name",node.getProperty("manufacturer").getString());
								object.put("value",node.getProperty("manufacturer").getString());
								//proclist.add(object);
								listArray.put(object);
							}
						}
						
					}
				}
			}
			LOGGER.info("counterBB"+counter);
			LOGGER.info("finalcounterBB"+finalcounter);
			//listArray.put(removeDuplicates(proclist));
			response.setContentType("application/json;charset=utf-8");
			//response.setContentType("application/json");
			response.getWriter().write(listArray.toString());
			//LOGGER.info("proclist"+proclist.size());
			LOGGER.info("procjsonResponse*BB** : "+listArray.toString());

		}
		catch (JSONException e) {
			LOGGER.error("JSONException :"+e.getMessage());
			e.printStackTrace();
		} catch (InvalidQueryException e) {
			LOGGER.error("InvalidQueryException :"+e.getMessage());
			e.printStackTrace();
		} catch (RepositoryException e) {
			LOGGER.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		} 


	}

	/*public static ArrayList<JSONObject> removeDuplicates(ArrayList<JSONObject> arlList) {
		//LOGGER.info("b4 removeduplicates"+list.size());
        HashSet set = new HashSet(list);
        list.clear();
        list.addAll(set);
        LOGGER.info("after removeduplicates"+list.size());
		LOGGER.info("b4 removeduplicates"+arlList.size());
        Set set = new HashSet();
        ArrayList newList = new ArrayList();
        for (Iterator iter = arlList.iterator(); iter.hasNext(); ) {
        Object element = iter.next();
        if (set.add(element))
        newList.add(element);
        }
        arlList.clear();
        arlList.addAll(newList);
        LOGGER.info("after removeduplicates"+arlList.size());
		return arlList;
}*/
	@SuppressWarnings("deprecation")
	private void doProcessorsSearch(SlingHttpServletRequest request,
			SlingHttpServletResponse response)throws IOException {
		// TODO Auto-generated method stub
		LOGGER.info("in doProcessorsSearch**"+request.getParameter("searchtype"));

		try{
			String queryStatement = "";

			queryStatement = "select * from nt:unstructured where jcr:path like '"+IntelMobileConstants.PRODUCT_PATH+"' AND categoryId='"+ request.getParameter("categorytype")+"'"  ;
			LOGGER.info("querystatment$$$$  "+ queryStatement);

			jcrSession = RepoUtil.login(repository);
			QueryManager queryManager = jcrSession.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qr = query.execute();
			NodeIterator itr = qr.getNodes();
			LOGGER.info("procjsonlenght:"+itr.getSize());
			Set tempset = new HashSet();
			JSONArray listArray = new JSONArray();
			int counter=0;
			int finalcounter=0;
			while (itr.hasNext()) {
				counter++;
				LOGGER.info("in proc while");
				JSONObject object = new JSONObject();
				Node node = itr.nextNode();
				if(!object.has(node.getProperty("processor").getString())){

					LOGGER.info("*********");
					if (node.hasProperty("processor")&& node.hasProperty("processorId")) {
						if(node.getProperty("processor").getString()!= null && node.getProperty("processor").getString().length()>0 && 
								node.getProperty("processorId").getString()!= null && node.getProperty("processorId").getString().length()>0)
						{
							if(tempset.add(node.getProperty("processor").getString()))
							{
								finalcounter++;
								object.put("name",node.getProperty("processor").getString());
								object.put("value",node.getProperty("processorId").getString());
								//proclist.add(object);
								listArray.put(object);
							}
						}
						
					}
				}
			}
			LOGGER.info("counter"+counter);
			LOGGER.info("finalcounter"+finalcounter);
			//listArray.put(removeDuplicates(proclist));
			response.setContentType("application/json;charset=utf-8");
			//response.setContentType("application/json");
			response.getWriter().write(listArray.toString());
			//LOGGER.info("proclist"+proclist.size());
			LOGGER.info("procjsonResponse*** : "+listArray.toString());

		}
		catch (JSONException e) {
			LOGGER.error("JSONException :"+e.getMessage());
			e.printStackTrace();
		} catch (InvalidQueryException e) {
			LOGGER.error("InvalidQueryException :"+e.getMessage());
			e.printStackTrace();
		} catch (RepositoryException e) {
			LOGGER.error("RepositoryException :"+e.getMessage());
			e.printStackTrace();
		} 

	}
}

