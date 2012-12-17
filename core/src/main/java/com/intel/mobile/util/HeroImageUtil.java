package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;

public class HeroImageUtil {
	
	private static final Logger LOG = LoggerFactory.getLogger(HeroImageUtil.class);
	
	public static List getArticleImage(Page currentPage) {
	    
		String image = "";
		String image2 = "";
		String image3 = "";
		String image4 = "";
		String image5 = "";
		String image6 = "";
		Node heroNode = null ;
		List<String> articleImageList  = new ArrayList<String>();
		 try {
			 Node articleNode = currentPage.getContentResource().getChild("articleHead").adaptTo(Node.class);
			 LOG.info("detailNode ---"+articleNode);
			 if(articleNode != null){
				 if(articleNode.hasNode("articledetailshero")){
					 heroNode = articleNode.getNode("articledetailshero");
			 LOG.info("heroNode ---"+heroNode);	
			 }
				
				 if(heroNode.hasProperty("imagePath")&& heroNode.getProperty("imagePath") != null){
					 image = heroNode.getProperty("imagePath").getString();
					 articleImageList.add(image);
				 }
				 if(heroNode.hasProperty("imagePath2")&& heroNode.getProperty("imagePath2") != null){
					 image2 = heroNode.getProperty("imagePath2").getString();
					 articleImageList.add(image2);
				 }
				 if(heroNode.hasProperty("imagePath3")&& heroNode.getProperty("imagePath3") != null){
					 image3 = heroNode.getProperty("imagePath3").getString();
					 articleImageList.add(image3);
				 }
				 if(heroNode.hasProperty("imagePath4")&& heroNode.getProperty("imagePath4") != null){
					 image4 = heroNode.getProperty("imagePath4").getString();
					 articleImageList.add(image4);
				 }
				 if(heroNode.hasProperty("imagePath5")&& heroNode.getProperty("imagePath5") != null){
					 image5 = heroNode.getProperty("imagePath5").getString();
					 articleImageList.add(image5);
				 }
				 if(heroNode.hasProperty("imagePath6")&& heroNode.getProperty("imagePath6") != null){
					 image6 = heroNode.getProperty("imagePath6").getString();
					 articleImageList.add(image6);
				 }
			 }
			 LOG.info("---articleImageList ---"+articleImageList);	
			 }
			 catch(Exception e){
				 LOG.error("Error getArticleImage method " + e.getMessage());
			 }
		
	
		return articleImageList;
	}

}
