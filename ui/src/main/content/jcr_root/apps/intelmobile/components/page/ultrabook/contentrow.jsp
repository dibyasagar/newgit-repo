<%@page import="com.intel.mobile.util.CampaignMenuUtil"%>
<%@page import="com.intel.mobile.vo.UltrabookMenuItemVO"%>
<%@page import="org.apache.sling.api.resource.ResourceResolver"%>
<%@page import="javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%

pageContext.setAttribute("leftMenuItems",CampaignMenuUtil.getLeftMenuItems(resource,currentPage));
pageContext.setAttribute("rightMenuItems",CampaignMenuUtil.getRightMenuItems(resource,currentPage));

Resource campaignHeaderResource = resourceResolver.getResource(currentPage.getPath() + "/jcr:content/contentPar/campaignheader");
Resource campaignFooterResource = resourceResolver.getResource(currentPage.getPath() + "/jcr:content/contentPar/campaignfooter");
if(campaignHeaderResource!=null && campaignFooterResource!=null ){
Node campaignHeaderNode = campaignHeaderResource.adaptTo(Node.class);
Node campaignFooterNode = campaignFooterResource.adaptTo(Node.class);
if(campaignHeaderNode.hasProperty("sectiontitle")&& campaignFooterNode.hasProperty("buttontext")){
  String sectiontitle=campaignHeaderNode.getProperty("sectiontitle").getString();
  String buttontext=campaignFooterNode.getProperty("buttontext").getString();
  pageContext.setAttribute("title",sectiontitle);
  pageContext.setAttribute("buttontext",buttontext);
}
}
  
%>
<!-- Menus -->

		<div class="ultrabook menus">

			<nav class="menus-a clear">

				<div class="head">
				<h1>${title}</h1>
				</div>

				<div class="close"></div>

				<div class="clear"></div>

				<div class="column left">
                     
                     <c:forEach  items="${leftMenuItems}" var="item">  
                     
                     <div class="item menus-2">
						<a class="inside ui-link" href="#slide-${item.cellId}" title="${item.name}">${item.name}</a>
					 </div>
                     
                     </c:forEach>

				</div>

				<div class="column right">

					<c:forEach  items="${rightMenuItems}" var="item">  
					<div class="item menus-4">
					<a class="inside ui-link" href="#slide-${item.cellId}" title="${item.name}">${item.name}</a>
					</div>
					</c:forEach>
					
					<div class="shop">
						<a class="ui-link" href="#" title="Shop Ultrabook™" target="_blank">
						<span>${buttontext}</span></a>
					</div>

				</div>

			</nav>

		</div>



<div class="ultrabook content">
			
			<!-- Nav -->

			<div style="top: 70px; " role="banner" class="sticky ui-header ui-bar-a" data-role="header"></div>

			<!-- 0 -->
			
			<!-- <cq:include path="campaignheader" resourceType="intelmobile/components/content/campaignheader"/> -->
			<!--<cq:include path="contentPar" resourceType="foundation/components/parsys"/>
			--><!-- Include Campaign Header Component -->

			<!-- 2 -->
 			<!-- <cq:include path="sellingpoint" resourceType="intelmobile/components/content/sellingpoint"/> -->
			<cq:include path="contentPar" resourceType="foundation/components/parsys"/>
			<!-- Include Selling Point Component -->

			<!-- 1 -->



			<!-- 3 -->

		
			<!-- 4 -->

		
			<!-- 5 -->

			
			<!-- Z -->

			

		</div>