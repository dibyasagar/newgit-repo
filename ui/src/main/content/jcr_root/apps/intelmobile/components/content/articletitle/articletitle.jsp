<%@include file="/libs/foundation/global.jsp"%><%@page import="com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>
<c:choose>
<c:when test="${ not empty properties.articletitle}">
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
 <h1><c:out value="${properties.articletitle}" escapeXml="false"/></h1>
 </div>
</c:when>
<c:otherwise>
<c:if test="${editmode eq 'true'}">
<div>Double Click to Edit Content Article Title Component</div>
</c:if>
</c:otherwise>
</c:choose>