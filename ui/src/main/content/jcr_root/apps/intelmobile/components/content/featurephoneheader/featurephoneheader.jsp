<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
    String logoImage = currentStyle.get("logoImageReference", "");
    String logoLink = currentStyle.get("linkpath", "#");
    
    pageContext.setAttribute("logoLink", logoLink);
    pageContext.setAttribute("logoImage", logoImage);
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="header">
         <c:if test="${fn:startsWith(logoLink,'/content')}">
                 <c:set var="logoLink" value="${logoLink}.html" />
         </c:if>
            <h1><a href="${logoLink}.html" title="Home"><img src="${logoImage}" alt="Intel"></a></h1>
</div>
</div>