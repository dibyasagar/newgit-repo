<%@include file="/libs/foundation/global.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.day.cq.wcm.api.WCMMode, com.intel.mobile.util.IntelUtil"%><%
%><%@page session="false" %>
<cq:setContentBundle />
<% 
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
	
    out.println("Double Click to Edit Product Showcase Heading Component");
}
String internalLink = "";
String validLink = "";
if (properties.get("linkUrl") != null) {
	internalLink = properties.get("linkUrl").toString();
	validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);}
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("validLink",validLink);
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
if (properties.get("newwindow") != null) {
pageContext.setAttribute("openinnewwindow",properties.get("newwindow").toString());
}
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
       <div id="main" role="main">
                   <div id="product-showcase" class="products family">
               
<c:if test="${properties.heroimageReference ne '' &&  properties.linkUrl ne '' && properties.linkCopy ne '' && properties.headingcopy ne ''}">
                
		            <c:set var="window" value="_blank" />
                    <c:if test="${openinnewwindow eq 'no'}">
                      <c:set var="window" value="" />
                    </c:if> 
		            <c:if test="${openinnewwindow eq null}">
                      <c:set var="window" value="" />
                    </c:if>
					<h1><cq:text property="title" default="" escapeXml="false"/></h1>    
                       <div class="hero">
                       <c:choose>
							<c:when	test="${properties.heroimageReference ne '' && not empty properties.heroimageReference}">
							
								<img src="${properties.heroimageReference}" alt ="${properties.alttext}"/>
								<div class="content" >
					    		
		                        	<h3><c:out value="${properties.headingcopy}" escapeXml="false"/></h3>
		                            <cq:text property="bodytext" default="" />
		                         
		        	              <c:if test="${properties.linkCopy ne '' && not empty properties.linkCopy }">
						        	<a class='grad' href="${validLink}" target="${window}">
						        		<c:out value="${properties.linkCopy}" escapeXml="false" />
						             </a>
		 						   </c:if>
		 						   <c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
					                     <c:if test="${properties.displaysocial eq 'yes'}">
					                        <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
					                     </c:if>             
					                </c:if> 
								</div>
                       		</c:when>
							<c:otherwise>
								<div class="content" style="margin: 0px 10px 5px">
					    		
		                        	<h3><c:out value="${properties.headingcopy}" escapeXml="false"/></h3>
		                            <cq:text property="bodytext" default="" />
		                       
		        	              <c:if test="${properties.linkCopy ne '' && not empty properties.linkCopy }">
						        	<a class='grad' href="${validLink}" target="${window}">
						        		<c:out value="${properties.linkCopy}" escapeXml="false" />
						             </a>
		  							</c:if>
		  							<c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
					                     <c:if test="${properties.displaysocial eq 'yes'}">
					                        <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
					                     </c:if>             
					                </c:if> 
								</div>
							</c:otherwise>
						</c:choose>
					</div>  
		
</c:if>

       <div class="sections">
			<div class="section">
            	<ul class="accordion">
            		<cq:include path="contentParsys" resourceType="foundation/components/parsys"/>
            	</ul>
           </div>
		</div> 
  </div>

  <cq:include path="disclaimer" resourceType="intelmobile/components/content/disclaimer"/>

</div>
</div>
  