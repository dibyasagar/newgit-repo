<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
    String logoImage = currentStyle.get("logoImageReference", "");
    String logoLink = currentStyle.get("linkpath", "#");
   
    String validLink = "";
    if (logoLink != null) {
    	validLink = IntelUtil.getLinkUrl(logoLink,resourceResolver);}
    
    pageContext.setAttribute("validLink", validLink);
    pageContext.setAttribute("logoImage", logoImage);
    pageContext.setAttribute("validLink",validLink);
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="header">
        
            <h1><a href="${validLink}" title="Home"><img src="${logoImage}" alt="Intel"></a></h1>
</div>
</div>