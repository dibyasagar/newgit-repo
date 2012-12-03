/**
 * 
 */
package com.intel.mobile.search;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.servlet.http.HttpServletRequest;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;

/**
 * @author vshind
 * 
 */
public class ProductCompare {

	/**
	 * 
	 */
	public ProductCompare() {
		// TODO Auto-generated constructor stub
	}

	private static final Logger LOG = LoggerFactory
			.getLogger(ProductDetails.class);

	public void getProudctDetails(HttpServletRequest request, Page currentPage) {

		String categoryName = request.getParameter("productCategoryName");

		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest) request;
		ResourceResolver resourceResolver = slingRequest.getResourceResolver();
		TagManager tagManager = resourceResolver.adaptTo(TagManager.class);
		Iterator<Tag> tagIterator = null;

		try {

			String productCategoryTagPath = "";
			productCategoryTagPath = currentPage.getPath()
					.replace("/content", "/etc/tags/").concat(categoryName);

			Tag productCategoryTag = tagManager.resolve(productCategoryTagPath);

			tagIterator = productCategoryTag.listChildren();

		} catch (Exception e) {

			LOG.info("Exception : " + e);

		}

		List<Map<String, String>> featureList = new ArrayList<Map<String, String>>();

		Map<String, String> featureMap = new HashMap<String, String>();
		String id = request.getParameter("id");
		Session session = slingRequest.getResourceResolver().adaptTo(
				Session.class);

		String queryStatement = "";
		queryStatement = "select * from nt:unstructured where jcr:path like '"
				+ IntelMobileConstants.PRODUCT_PATH + "' AND id ='" + id + "'";
		LOG.info("queryStatement: " + queryStatement);
		QueryManager queryManager;
		try {
			queryManager = session.getWorkspace().getQueryManager();
			String stmt = queryStatement;
			Query query = queryManager.createQuery(stmt, Query.SQL);
			QueryResult qResult = query.execute();

			NodeIterator itr = qResult.getNodes();
			if (itr.hasNext()) {

				Node tmpNode = itr.nextNode();
				while (tagIterator.hasNext()) {

					Tag tag = tagIterator.next();
					LOG.info("tag.getName() :" + tag.getName());
					LOG.info("tag.getName() :" + tag.getTitle());
					if (tmpNode.hasProperty(tag.getTitle())) {
						featureMap
								.put(tag.getName(),
										tmpNode.getProperty(tag.getTitle())
												.getString());

					}

					featureList.add(featureMap);
				}

			}
		} catch (RepositoryException e) {
			LOG.error("RepositoryException :" + e.getMessage());
			e.printStackTrace();
		}
	}
}
