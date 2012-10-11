<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
	String logoImage = IntelUtil.getConfigValue(currentPage,"featureheader", "logoImageReference","");
    String logoLink = IntelUtil.getConfigValue(currentPage, "featureheader" ,"linkpath","");
    String internalLink = "";
    String validLink = "";
    if (logoLink != null) {
    	//internalLink = properties.get("logoLink").toString();
    	validLink = IntelUtil.getLinkUrl(logoLink,resourceResolver);}
    //pageContext.setAttribute("logoLink", logoLink);
    pageContext.setAttribute("logoImage", logoImage);
    pageContext.setAttribute("validLink",validLink);
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="header">
       
            <h1><a href="validLink" title="Home"><img src="${logoImage}" alt="Intel"></a></h1>
</div>
</div>