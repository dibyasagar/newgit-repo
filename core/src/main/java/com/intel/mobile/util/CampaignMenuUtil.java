/**
 * 
 */
package com.intel.mobile.util;

import java.util.ArrayList;
import java.util.List;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.PathNotFoundException;
import javax.jcr.RepositoryException;

import org.apache.sling.api.resource.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.intel.mobile.vo.UltrabookMenuItemVO;

/**
 * @author skarm1
 *
 */
public class CampaignMenuUtil {

	private static final Logger log = LoggerFactory.getLogger(IntelUtil.class);

	public static List<UltrabookMenuItemVO> getLeftMenuItems(Resource resource, Page currentPage){

		List<UltrabookMenuItemVO> leftMenuItems = new ArrayList<UltrabookMenuItemVO>();
		Node jcrContent  = currentPage.getContentResource().adaptTo(Node.class);
		int noOfCellingPointsComponents = 0;
		int noOfLeftMenuItems=0;
		try {
			if(jcrContent.hasNode("contentPar")){

				Node contentPar = jcrContent.getNode("contentPar");
				NodeIterator nodeIterator = contentPar.getNodes();
				while(nodeIterator.hasNext()){
					Node currentNode = nodeIterator.nextNode();
					if(currentNode.getName().startsWith("sellingpoint")){

						UltrabookMenuItemVO ultrabookMenuItemVO = new UltrabookMenuItemVO();
						ultrabookMenuItemVO.setCellId(currentNode.getName());
						if(currentNode.hasProperty("thumbnailReference")){
							ultrabookMenuItemVO.setImagePath(currentNode.getProperty("thumbnailReference").getString());
						}
						if(currentNode.hasProperty("title")){
							ultrabookMenuItemVO.setName((currentNode.getProperty("title").getString()));
						}
						leftMenuItems.add(ultrabookMenuItemVO);	
						noOfCellingPointsComponents ++;
					}
				}

				noOfLeftMenuItems = noOfCellingPointsComponents - (noOfCellingPointsComponents/2);
				log.info("noOfCellingPointsComponents :"+noOfCellingPointsComponents);
				log.info("noOfLeftMenuItems :"+noOfLeftMenuItems);

				for(int i=0;i<noOfCellingPointsComponents/2;i++){
					leftMenuItems.remove(noOfLeftMenuItems);
				}
			}
		} catch (PathNotFoundException e1) {
			log.error("PathNotFoundException :"+e1.getMessage());
			e1.printStackTrace();
		} catch (RepositoryException e1) {
			log.error("RepositoryException :"+e1.getMessage());
			e1.printStackTrace();
		}

		log.info("leftMenuItems :"+leftMenuItems);
		return leftMenuItems;
	}


	public static List<UltrabookMenuItemVO> getRightMenuItems(Resource resource, Page currentPage){

		List<UltrabookMenuItemVO> rightMenuItems = new ArrayList<UltrabookMenuItemVO>();
		Node jcrContent  = currentPage.getContentResource().adaptTo(Node.class);
		int noOfCellingPointsComponents = 0;
		int noOfRightMenuItems=0;
		int noOfLeftMenuItems=0;
		try {
			if(jcrContent.hasNode("contentPar")){

				Node contentPar = jcrContent.getNode("contentPar");
				NodeIterator nodeIterator = contentPar.getNodes();
				while(nodeIterator.hasNext()){
					Node currentNode = nodeIterator.nextNode();
					if(currentNode.getName().startsWith("sellingpoint")){

						UltrabookMenuItemVO ultrabookMenuItemVO = new UltrabookMenuItemVO();
						ultrabookMenuItemVO.setCellId(currentNode.getName());
						if(currentNode.hasProperty("thumbnailReference")){
							ultrabookMenuItemVO.setImagePath(currentNode.getProperty("thumbnailReference").getString());
						}
						if(currentNode.hasProperty("title")){
							ultrabookMenuItemVO.setName((currentNode.getProperty("title").getString()));
						}
						rightMenuItems.add(ultrabookMenuItemVO);	
						noOfCellingPointsComponents ++;
					}
				}

				noOfRightMenuItems = (noOfCellingPointsComponents/2);
				noOfLeftMenuItems = noOfCellingPointsComponents - (noOfCellingPointsComponents/2);
				log.info("noOfCellingPointsComponents ::"+noOfCellingPointsComponents);
				log.info("noOfRightMenuItems ::"+noOfRightMenuItems);
				log.info("noOfLeftMenuItems ::"+noOfLeftMenuItems);

				for(int i=0;i<noOfLeftMenuItems;i++){
					rightMenuItems.remove(0);
				}
			}
		} catch (PathNotFoundException e1) {
			log.error("PathNotFoundException :"+e1.getMessage());
			e1.printStackTrace();
		} catch (RepositoryException e1) {
			log.error("RepositoryException :"+e1.getMessage());
			e1.printStackTrace();
		}

		log.info("rightMenuItems :"+rightMenuItems);
		return rightMenuItems;
	}


	public static String getComponentCellId(Resource resource){

		Node componentCellNode = resource.adaptTo(Node.class);
		String comppnentCellName = null;

		if(componentCellNode!=null){
			try {
				comppnentCellName = componentCellNode.getName();

			} catch (RepositoryException e) {
				log.error("RepositoryException :"+e.getMessage());
				log.debug(e.getMessage(), e);
			}
		}
		log.info("comppnentCellName : "+comppnentCellName);
		return comppnentCellName;
	}

}
