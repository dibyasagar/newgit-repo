<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="javax.jcr.Node,com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
String internalLink = "";
String validLink = "";
if (properties.get("linkUrl") != null) {
internalLink = properties.get("linkUrl").toString();
validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);}
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("validLink",validLink);
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>
<c:choose>
<c:when test="${not empty properties.imgFileReference && not empty properties.linkUrl && not empty properties.linkdisplayCopy}">
        <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
        <div class="table-list">
        <div class="table-cell"><img src="${properties.imgFileReference}" alt=""></div>

	     <c:if test="${validLink ne '' && not empty validLink}">
        	   <c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
        		<div class="table-cell"><a class="arrow" href="${validLink}" target="${window}"><c:out value="${properties.linkdisplayCopy}" escapeXml="false"/></a></div>
				
        	</c:if>
       </div>
       </div>
</c:when>
<c:otherwise>
<c:if test="${editmode eq 'true'}">
<div>Double Click to Edit CMS Link One Component</div>
</c:if>
</c:otherwise>
</c:choose>