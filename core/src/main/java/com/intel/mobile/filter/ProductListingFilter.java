/**
 * 
 */
package com.intel.mobile.filter;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.ResourceResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.tagging.Tag;
import com.day.cq.tagging.TagManager;
import com.day.cq.wcm.api.Page;

import com.intel.mobile.vo.ProductFilterVO ;
import com.intel.mobile.vo.ProductSubFilterVO;


public class ProductListingFilter {

	private static final Logger LOG = LoggerFactory.getLogger(ProductListingFilter.class);

	public void getFilters(HttpServletRequest request, Page currentPage , String filterTags){
		
		LOG.info("Filter Tags Passed from filter page" + filterTags);
		
		List<ProductFilterVO> productFilterVOList = new ArrayList<ProductFilterVO>();
		
		SlingHttpServletRequest slingRequest = (SlingHttpServletRequest)request;
		ResourceResolver resourceResolver = slingRequest.getResourceResolver();
		TagManager tagManager = resourceResolver.adaptTo(TagManager.class);

		try {
			
			String productCategoryTagPath = "" ;
			
			if(!filterTags.equals("") && filterTags != null){
				
				productCategoryTagPath = filterTags ;
				
				
			}
			else{
				productCategoryTagPath = currentPage.getPath().replace("/content", "/etc/tags").concat("/filters");
			}
			
			Tag productCategoryTag = tagManager.resolve(productCategoryTagPath);
			LOG.info("productCategoryTagPath :"+productCategoryTagPath);
			LOG.info("productCategoryTag.getName() :"+productCategoryTag.getName());
	
			Iterator<Tag> filterIterator = productCategoryTag.listChildren();
			while(filterIterator.hasNext()){
				ProductFilterVO productFilterVO = new ProductFilterVO();
				Tag filter = filterIterator.next();
				LOG.info("filter.getName() :"+filter.getName());
				productFilterVO.setFilterName(filter.getName());
				Iterator<Tag> subFilterIterator = filter.listChildren();
				List<ProductSubFilterVO> subFilters = new ArrayList<ProductSubFilterVO>();
				while(subFilterIterator.hasNext()){
					ProductSubFilterVO productSubFilterVO = new ProductSubFilterVO();
					Tag subFilter = subFilterIterator.next();
					productSubFilterVO.setSubFilterName(subFilter.getTitle());
					productSubFilterVO.setSubFilterValue(subFilter.getName());
					subFilters.add(productSubFilterVO);
					LOG.info("subFilter.getName() :"+subFilter.getName());
					LOG.info("subFilter.getTitle() :"+subFilter.getTitle());
				}
				productFilterVO.setSubFilters(subFilters);
				
				LOG.info("productFilterVO :: " + productFilterVO);
				productFilterVOList.add(productFilterVO);
			}
	
			LOG.info("productFilterVOList : " + productFilterVOList);
			request.setAttribute("productFilterVOList", productFilterVOList);
			}
		catch (Exception e){
			
			LOG.info("Exception : " + e);
			
		}

	}

}
