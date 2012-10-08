<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil" %>
<%
String viewmoreafternum = (String) properties.get("viewmorenum");
long viewmoreafter = 0;
if(viewmoreafternum != null){
 viewmoreafter = Long.parseLong(viewmoreafternum);
 pageContext.setAttribute("viewmoreafter",viewmoreafter);
}
pageContext.setAttribute("wcmMode",WCMMode.fromRequest(request));
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName());
pageContext.setAttribute("parsysCount",IntelUtil.getParsysNumber(resource));
%>

<c:set var="contentstyle" value="${properties.contentstyle}" />
<c:if test="${contentstyle eq '' or contentstyle eq null}">
	<c:set var="contentstyle" value="genericcontentpshowcase" />
</c:if>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<c:if test="${contentstyle eq 'genericcontentpshowcase'}">
<!-- Generic Content Component Product Showcase -->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" /></a>
		</h5>
		<div class="border-list content">
		     <c:if test="${properties.header ne '' && not empty properties.header }">
             <c:out value="${properties.header}" escapeXml="false"/>
	         </c:if>
			<div class="items">
				<cq:include path="drawerpshowcase" resourceType="foundation/components/parsys" />
			</div>	
		    <c:set var="url" value="${properties.footerurl}" />
		    <c:if test="${fn:startsWith(url,'/content')}">
        		 <c:set var="url" value="${url}.html" />
        	</c:if>
        	<c:if test="${properties.footerurl ne '' && not empty properties.footerurl }">
                 <a class='grad' href="${url}"><c:out value="${properties.footertext}"/></a>
		    </c:if>		
		</div>
	</li>
<!-- Generic Content Component Product Showcase -->
</c:if>

<c:if test="${contentstyle eq 'genericcontentpshowcaseshowmore'}">
<!-- Generic Content Component Product Showcase Showmore -->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" escapeXml="false"/></a>
		</h5>
		<div class="features content" style="overflow: hidden; display: block; ">
			<div class="items">
				<cq:include path="drawerpshowcase" resourceType="foundation/components/parsys" />
				<c:if test="${viewmoreafter == parsysCount}">
				<div class="view-more">
					<c:if test="${wcmMode eq 'EDIT'}">
						Drop view more items below.
					</c:if>				
					<cq:include path="drawerpshowcaseviewmore" resourceType="foundation/components/parsys" />
				</div>
				<a class="view-more-control grad" href="#"><cq:text property="footertext" escapeXml="false"/></a>
				</c:if>
			</div>		
		</div>
	</li>
<!-- Generic Content Component Product Showcase -->
</c:if>

<c:if test="${contentstyle eq 'genericcontentpdetail'}">
<!-- Generic Content Component Product Detail -->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" /></a>
		</h5>
		<cq:include path="drawer" resourceType="foundation/components/parsys" />
	</li>
<!-- Generic Content Component Product Detail -->
</c:if>


<c:if test="${contentstyle eq 'imageandvideo'}">
<!--  Image & Video -->
<li>
	<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
		<a href="#"><cq:text property="title" default="Images &amp; Videos" /></a>
	</h5>
	<div id="product-images" class="videoplayer content">
		<ul>
			<cq:include path="drawer" resourceType="foundation/components/parsys" />
		</ul>
	</div>
</li>
<!--  Image & Video -->
</c:if>		    			

<c:if test="${contentstyle eq 'showcasefeaturespotlight'}">
<!--  Showcase Feature Spotlight -->
<li>
	<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
		<a href="#"><cq:text property="title" default="Drawer" escapeXml="false"/></a>
	</h5>
	<div class="uses content">
		<cq:include path="drawershowcasefeature" resourceType="foundation/components/parsys" />
	</div>
</li>
<!--  Showcase Feature Spotlight -->
</c:if>

<c:if test="${contentstyle eq 'cmslink1'}">
<!--  CMS Link 1  -->
<li>
	<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
		<a href="#"><cq:text property="title" default="Drawer" escapeXml="false"/></a>
	</h5>
	<div class="content">
		
			<cq:include path="drawercmslink1" resourceType="foundation/components/parsys" />
		
	</div>
</li>
<!--  CMS Link 1  -->
</c:if>


<c:if test="${contentstyle eq 'articlelanding'}">
<!-- Article Landing  Content-->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" escapeXml="false"/>
			</a>
		</h5>
				<div class="content">
				<cq:include path="articleLandingMainDrawerParsys"
					resourceType="foundation/components/parsys" />
				<c:if test="${viewmoreafter == parsysCount}">	
				<div class="view-more">
					<c:if test="${wcmMode eq 'EDIT'}">
						Drop view more items below.
					</c:if>
					<cq:include path="articleLandinViewMoreParsys"
						resourceType="foundation/components/parsys" />
				</div>
				<a class="view-more-control grad" href="javascript:void(0)" data-closedcopy="<cq:text property="footertext" escapeXml="false"/>" data-opencopy="<cq:text property="viewlesstext" escapeXml="false"/>"><cq:text
						property="footertext" escapeXml="false"/>
				</a>
				</c:if>	
				<cq:include path="articleLandingSubDrawerParsys"
						resourceType="foundation/components/parsys" />
				</div>
		</li>
<!--  Article Landing Content-->
</c:if>


<c:if test="${contentstyle eq 'articlelandingvideo'}">
<!-- Article Landing  Video-->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" escapeXml="false"/>
			</a>
		</h5>
				<div class="videoplayer content">
				 <!-- Article Landing Video Componet Include Start -->
				 <cq:include path="articleLandingVideo" resourceType="intelmobile/components/content/articlelandingvideo"/>
				 <!-- Article Landing Video Componet Include End -->
				</div>
		</li>
<!--  Article Landing Video-->
</c:if>


<c:if test="${contentstyle eq 'articledetailcontent'}">
<!--  Article Detail Content-->
	<li>
		<div class="border-list content">
			<div class="items">
			<c:if test="${wcmMode eq 'EDIT'}">
						<div>Double Click to Edit the Component</div>
					</c:if>
			
				<cq:include path="articledetailContent" resourceType="foundation/components/parsys"/>
			</div>
		</div></li>
<!--  Article Detail Content-->
</c:if>
<c:if test="${contentstyle eq 'genericcontentfeatures'}">
<!-- Generic Content Component Features -->
	<li>
		<h5 class = "<c:out value="${pageScope.properties.drawerState}" default="closed" escapeXml="false" />">
			<a href="#"><cq:text property="title" default="Drawer" /></a>
		</h5>
		<ul class="specs content"> 
		<cq:include path="drawer" resourceType="foundation/components/parsys" />
		</ul>
	</li>
<!-- Generic Content Component Features -->
</c:if>
</div>
