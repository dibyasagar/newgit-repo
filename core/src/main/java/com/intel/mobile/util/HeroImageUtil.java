package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;


import org.apache.sling.api.resource.Resource;
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
		Node articleNode=null;
		List<String> articleImageList  = new ArrayList<String>();
		 try {
			// if(currentPage.getContentResource().getChild("articleHead")!=null)
			 //Resource articleresource=currentPage.getContentResource().getChild("articleHead");
			
			 Node articleresource=currentPage.getContentResource().adaptTo(Node.class);
			 LOG.info("ArticleResource ---"+articleresource);
			 if(articleresource.hasNode("articleHead"))
			 articleNode=articleresource.getNode("articleHead");
			
				 //if(articleresource!=null)
			// Node articleNode = articleresource.adaptTo(Node.class);
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
				 LOG.error("Error getArticleImage method :",e );
			 }
		
	
		return articleImageList;
	}

	public static List getShowcaseImage(Page currentPage) {
		 
		String image = "";
		String image1 = "";
		String image2 = "";
		String image3 = "";
		String image4 = "";
		String image5 = "";
		Node detailNode=null;
		List<String> showcaseImageList  = new ArrayList<String>();
		 try {
		// Node detailNode = currentPage.getContentResource().getChild("showcase").adaptTo(Node.class);
		 Node showcase=currentPage.getContentResource().adaptTo(Node.class);
		 if(showcase.hasNode("showcase"))	 
			 detailNode=showcase.getNode("showcase");
			
		if(detailNode.hasProperty("heroimageReference")&& detailNode.getProperty("heroimageReference") != null){
			 image = detailNode.getProperty("heroimageReference").getString();
			 showcaseImageList.add(image);
		 }
		 if(detailNode.hasProperty("picture1")&& detailNode.getProperty("picture1") != null){
			 image1 = detailNode.getProperty("picture1").getString();
			 showcaseImageList.add(image1);
		 }
		 if(detailNode.hasProperty("picture2")&& detailNode.getProperty("picture2") != null){
			 image2 = detailNode.getProperty("picture2").getString();
			 showcaseImageList.add(image2);
		 }
		 if(detailNode.hasProperty("picture3")&& detailNode.getProperty("picture3") != null){
			 image3 = detailNode.getProperty("picture3").getString();
			 showcaseImageList.add(image3);
		 }
		 if(detailNode.hasProperty("picture4")&& detailNode.getProperty("picture4") != null){
			 image4 = detailNode.getProperty("picture4").getString();
			 showcaseImageList.add(image4);
		 }
		 if(detailNode.hasProperty("picture5")&& detailNode.getProperty("picture5") != null){
			 image5 = detailNode.getProperty("picture5").getString();
			 showcaseImageList.add(image5);
		 }
		}
		 catch(Exception e){
			 LOG.error("Error getShowcaseImage method " + e.toString());
		 }
		 
		
		 return showcaseImageList;
	}
}
