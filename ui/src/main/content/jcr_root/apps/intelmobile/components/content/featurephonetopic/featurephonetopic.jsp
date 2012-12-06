<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<img src="${properties.heroImageReference}" alt="${properties.heading}">
<h2><cq:text property="heading" default="" escapeXml="false"/></h2>
<div class="section">
<div class="rte_text"><cq:text property="bodycopy" default="" escapeXml="false"/></div>
</div>
</div>