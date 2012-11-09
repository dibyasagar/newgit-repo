package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;


public class ProductcmsUtil {
	
private static final Logger LOG = LoggerFactory.getLogger(SimillarProductUtil.class);
	
	public static List getProductImage(Page currentPage) {
		 
		String image = "";
		String image2 = "";
		String image3 = "";
		String image4 = "";
		String image5 = "";
		String image6 = "";
		 List<String> cmsImageList  = new ArrayList<String>();
		 try {
		 Node detailNode = currentPage.getContentResource().getChild("details").adaptTo(Node.class);
		 
		 if(detailNode.hasProperty("picture")&& detailNode.getProperty("picture") != null){
			 image = detailNode.getProperty("picture").getString();
			 cmsImageList.add(image);
		 }
		 if(detailNode.hasProperty("picture2")&& detailNode.getProperty("picture2") != null){
			 image2 = detailNode.getProperty("picture2").getString();
			 cmsImageList.add(image2);
		 }
		 if(detailNode.hasProperty("picture3")&& detailNode.getProperty("picture3") != null){
			 image3 = detailNode.getProperty("picture3").getString();
			 cmsImageList.add(image3);
		 }
		 if(detailNode.hasProperty("picture4")&& detailNode.getProperty("picture4") != null){
			 image4 = detailNode.getProperty("picture4").getString();
			 cmsImageList.add(image4);
		 }
		 if(detailNode.hasProperty("picture5")&& detailNode.getProperty("picture5") != null){
			 image5 = detailNode.getProperty("picture5").getString();
			 cmsImageList.add(image5);
		 }
		 if(detailNode.hasProperty("picture6")&& detailNode.getProperty("picture6") != null){
			 image6 = detailNode.getProperty("picture6").getString();
			 cmsImageList.add(image6);
		 }
		 }
		 catch(Exception e){
			 LOG.error("Error getProductImage method " + e.toString());
		 }
		 
		
		 return cmsImageList;
	}

}
