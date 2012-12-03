<%@include file="/libs/foundation/global.jsp"%><%@page import="com.intel.mobile.util.IntelUtil"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
%>
<c:choose>
<c:when test="${ not empty properties.title}">
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
 <h3><c:out value="${properties.title}" escapeXml="false"/></h3>
 </div>
</c:when>
<c:otherwise>
<div>Double Click to Edit Content Title Component</div>
</c:otherwise>
</c:choose>