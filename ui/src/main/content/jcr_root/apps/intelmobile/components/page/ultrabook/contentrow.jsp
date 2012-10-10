<%@page import="com.intel.mobile.util.CampaignMenuUtil"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="com.intel.mobile.vo.UltrabookMenuItemVO"%>
<%@page import="org.apache.sling.api.resource.ResourceResolver"%>
<%@page import="javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%

pageContext.setAttribute("leftMenuItems",CampaignMenuUtil.getLeftMenuItems(resource,currentPage));
pageContext.setAttribute("rightMenuItems",CampaignMenuUtil.getRightMenuItems(resource,currentPage));

String validLink = "";
Resource campaignHeaderResource = resourceResolver.getResource(currentPage.getPath() + "/jcr:content/contentPar/campaignheader");
Resource campaignFooterResource = resourceResolver.getResource(currentPage.getPath() + "/jcr:content/contentPar/campaignfooter");
if(campaignHeaderResource!=null && campaignFooterResource!=null ){
Node campaignHeaderNode = campaignHeaderResource.adaptTo(Node.class);
Node campaignFooterNode = campaignFooterResource.adaptTo(Node.class);
if(campaignHeaderNode.hasProperty("sectiontitle")&& campaignFooterNode.hasProperty("buttontext")){
  String sectiontitle=campaignHeaderNode.getProperty("sectiontitle").getString();
  String buttontext=campaignFooterNode.getProperty("buttontext").getString();
  String newwindow=campaignFooterNode.getProperty("newwindow").getString();
  String linkUrl=campaignFooterNode.getProperty("linkUrl").getString();
  if (linkUrl != null) {
	  validLink = IntelUtil.getLinkUrl(linkUrl,resourceResolver);
  }    
  pageContext.setAttribute("title",sectiontitle);
  pageContext.setAttribute("buttontext",buttontext);
  pageContext.setAttribute("validLink",validLink); 
  pageContext.setAttribute("newwindow",newwindow);
}

  
}


%>
<!-- Menus -->

		<div class="ultrabook menus">

			<nav class="menus-a clear">

				<div class="head">
				<h1><c:out value="${title}" escapeXml="false"/></h1>
				</div>

				<div class="close"></div>

				<div class="clear"></div>

				<div class="column left">
                     
                     <c:forEach  items="${leftMenuItems}" var="item">  
                     
                     <div class="item menus-2">
                     	<img src="${item.imagePath}"/> 
						<a class="inside ui-link" href="#slide-${item.cellId}" title="${item.name}">${item.name}</a>
					 </div>
                     
                     </c:forEach>

				</div>

				<div class="column right">

					<c:forEach  items="${rightMenuItems}" var="item">  
					<div class="item menus-4">
					<img src="${item.imagePath}"/> 
					<a class="inside ui-link" href="#slide-${item.cellId}" title="${item.name}">${item.name}</a>
					</div>
					</c:forEach>
					
					<c:if test="${validLink ne '' && not empty validLink}">
        	            <c:set var="window" value="" />
				        <c:if test="${newwindow eq 'yes'}">
                           <c:set var="window" value="_blank" />
                        </c:if>
        		    <div class="shop">
        		        <a class="ui-link" href="${validLink}" title="Shop Ultrabook™" target="${window}">
                        <span><c:out value="${buttontext}" escapeXml="false"/></span></a>
        		    </div>
				
        	      </c:if>
				
				</div>

			</nav>

		</div>



<div class="ultrabook content" id="ultrabook_content">
			
			<!-- Nav -->
			<div style="top: 70px; " role="banner" class="sticky ui-header ui-bar-a" data-role="header"></div>

 	
 			<!-- Parsys Component Start -->
			<cq:include path="contentPar" resourceType="foundation/components/parsys"/>
			<!-- Parys Component End-->
<cq:include path="disclaimer" resourceType="intelmobile/components/content/disclaimer"/>
</div>
