<%@include file="/libs/foundation/global.jsp"%><%
%><%@page import="com.intel.mobile.util.IntelUtil"%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
%>
<c:choose>
<c:when test="${not empty properties.imageFileReference && not empty properties.displayCopy}">
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
 <div class="table-list">
    <img class="table-cell"  src="${properties.imageFileReference}" />
         <div class="table-cell">
    	 <span><cq:text property="displayCopy" escapeXml="false"/></span>
    	 </div>	
</div>
</div>
</c:when>
<c:otherwise>
<div>Double Click to Edit Showcase Feature Spotlight Component</div>
</c:otherwise>
</c:choose>