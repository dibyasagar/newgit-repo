<%@include file="/libs/foundation/global.jsp"%><%@page import="com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName());
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>
<c:choose>
<c:when test="${not empty properties.cmsImageFileReference && not empty properties.linkUrl && not empty properties.linkdisplayCopy}">
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div class="item">
        <ul>
        <li>
         <img src="${properties.cmsImageFileReference}" />
           <c:set var="url" value="${properties.linkUrl}" />
        	<c:if test="${fn:startsWith(url,'/content')}">
        		<c:set var="url" value="${url}.html" />
        	</c:if>
        	<c:if test="${properties.linkUrl ne '' && not empty properties.linkUrl }">
        	<c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
        	<a href="${url}" target="${window}">
        	<c:out value="${properties.linkdisplayCopy}" escapeXml="false"/>
                &nbsp;&#62;
        	
        		</a>
        	</c:if>
        </li>
       </ul>

</div>
</div>
</c:when>
<c:otherwise>
<c:if test="${editmode eq 'true'}">
<div>Double Click to Edit CMS Link Two Component</div>
</c:if>
</c:otherwise>
</c:choose>