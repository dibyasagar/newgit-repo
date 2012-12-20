package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;

import javax.jcr.NodeIterator;
import javax.jcr.PathNotFoundException;
import javax.jcr.Property;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.Value;
import javax.jcr.ValueFormatException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.felix.scr.annotations.Reference;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.jcr.api.SlingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.replication.ReplicationActionType;
import com.day.cq.wcm.api.Page;
import com.intel.mobile.constants.IntelMobileConstants;
import com.intel.mobile.vo.SmillarProductsVO;

public class SimillarProductUtil {

	@Reference
	private static final Logger LOG = LoggerFactory
			.getLogger(SimillarProductUtil.class);

	public static List getShopSimilarInfo(Page currentPage,
			ResourceResolver resolver) {

		String name = "";
		String picture = "";
		String bestPrice = "";
		String url = "";
		String id = "";
		String categoryPath = "";
		String prodName = "";
        Boolean activationstatus= false;
		Page categoryPage = currentPage.getParent();
		// LOG.info("-----categoryPage ----"+categoryPage.getPath());
		List<SmillarProductsVO> similarResultList = new ArrayList<SmillarProductsVO>();

		try {
			Node detailNode = currentPage.getContentResource()
					.getChild("details").adaptTo(Node.class);
			if (LOG.isDebugEnabled()) {
				LOG.debug("---detailNode-----" + detailNode.getName());
			}
			if (detailNode.hasNode("shopsimilarproducts")) {
				Node similarProductnode = detailNode
						.getNode("shopsimilarproducts");
				NodeIterator similarNode = similarProductnode.getNodes();
				// long Count = similarNode.getSize();

				while (similarNode.hasNext()) {
					try {
					Node tmpNode = similarNode.nextNode();
					if (tmpNode.hasProperty("name")
							&& tmpNode.getProperty("name") != null) {
						name = tmpNode.getProperty("name").getString();
						prodName = IntelUtil.normalizeName(name);
						// url = categoryPage.getPath()+"/"+prodName;
						//url = getProductUrl(categoryPage, prodName, resolver);
						activationstatus=getActivationStatus(similarProductnode,prodName,resolver);
					}
					if (activationstatus==true) {
						if (tmpNode.hasProperty("picture")
								&& tmpNode.getProperty("picture") != null) {
							picture = tmpNode.getProperty("picture")
									.getString();
						}
						if (tmpNode.hasProperty("bestPrice")
								&& tmpNode.getProperty("bestPrice") != null) {
							bestPrice = tmpNode.getProperty("bestPrice")
									.getString();
						}

						SmillarProductsVO productsInfo = new SmillarProductsVO(
								name, picture, bestPrice, url);
						if (!similarResultList.contains(productsInfo)) {
							similarResultList.add(productsInfo);
						}
					}
					// LOG.info("---similarResultList-----"+similarResultList);

					if (LOG.isDebugEnabled()) {
						LOG.debug("---similarResultList-----"
								+ similarResultList);
					} 
					} catch (Exception e) {
						LOG.error("Error getting similar product URL "+e.getMessage());
						LOG.debug(e.getMessage(), e);
					}
					

				}
			}

		} catch (Exception e) {
			LOG.error("Exception in getShopSimilarInfo :" + e.getMessage());
			LOG.debug(e.getMessage(), e);
		}

		return similarResultList;
	}

	public static String getProductUrl(Page categoryPage, String prodName,
			ResourceResolver resolver) {
		String productUrl = "";
		try {
			// String queryStatement = "";
			// String pageStats = "";
			String tempUrl = categoryPage.getPath() + "/" + prodName;
			
			Page reqPage = resolver.resolve(tempUrl).adaptTo(Page.class);
			
			if(reqPage != null){
				ValueMap vm = reqPage.getProperties();
				if(vm != null){
					Object activateStatusObj = vm.get("cq:lastReplicationAction");
					if(activateStatusObj != null && activateStatusObj instanceof String) {
						String activationStatus = (String) activateStatusObj;
						if("Activate".equals(activationStatus)){
							productUrl = tempUrl;
						} else {
							LOG.debug("Product is deactivated "+prodName);
						}
					} else {
						LOG.debug("activateStatusObj is null :"+prodName);
					}
				} else {
					LOG.debug("Properties are null "+prodName);
				}
			} else {
				LOG.debug("Req Page is null for product:"+prodName);
			}
		} catch (Exception e) {
			LOG.error("Exception getting product URL" + e.getMessage());
			LOG.debug(e.getMessage(), e);
		}
		return productUrl;

	}
public static boolean getActivationStatus(Node productCategoryListingNode,String prodName, ResourceResolver resolver){
	Node jcrContent = null;
	//Node product=null;
	//String prodName=null;
	Boolean activationstatus = null;
	//Node productCategoryListingNode=null;
	Node productNode=null;
	try {
		if(productCategoryListingNode.hasNode(prodName)){
			productNode = productCategoryListingNode.getNode(prodName);
			jcrContent = productNode.getNode(IntelMobileConstants.NODE_JCR_CONTENT);
			if(jcrContent != null)
			{
				if(jcrContent.hasProperty("cq:lastReplicationAction")) {
					Property prop  = jcrContent.getProperty("cq:lastReplicationAction");
					if(prop != null)
					{
						String activated = prop.getString();
						if(activated != null && activated.equals(ReplicationActionType.ACTIVATE))
						{
							activationstatus =true;
						}
					}
				
				
}
			}
		}
	} catch (PathNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ValueFormatException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (RepositoryException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
return activationstatus;
}	
	
	public static List getCmsSimilarProducts(String reqPages[],
			ResourceResolver resolver) {

		String pagePath = null;
		String name = "";
		String picture = "";
		String bestPrice = "";
		String url = "";
		List<SmillarProductsVO> cmsSimilarList = new ArrayList<SmillarProductsVO>();

		if (reqPages != null && reqPages.length > 0) {
			for (int i = 0; i < reqPages.length; i++) {
				url = reqPages[i].toString();
				if (LOG.isDebugEnabled()) {
					LOG.debug("---url -----" + url.toString());
				}
				Resource root = resolver.getResource(url
						+ "/jcr:content/details");
				if (root != null) {
					if (LOG.isDebugEnabled()) {
						LOG.debug("---root -----" + root.getName());
					}
					ValueMap map = root.adaptTo(ValueMap.class);
					if (LOG.isDebugEnabled()) {
						LOG.debug("---Map-----" + map);
					}
					if (map.get("name") != null) {
						name = map.get("name").toString();
					}
					if (map.get("picture") != null) {
						picture = map.get("picture").toString();
					}
					if (map.get("bestPrice") != null) {
						bestPrice = map.get("bestPrice").toString();
					}

					SmillarProductsVO productsInfo = new SmillarProductsVO(
							name, picture, bestPrice, url);
					cmsSimilarList.add(productsInfo);
				}
				if (LOG.isDebugEnabled()) {
					LOG.debug("---cmsSimilarList-----" + cmsSimilarList);
				}
			}

		}
		return cmsSimilarList;
	}

}
