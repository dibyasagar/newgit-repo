<%--

  Disclaimer component.

--%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="javax.jcr.Node"%>
<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("wcmMode",WCMMode.fromRequest(request));
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
String disclaimerType = properties.get("disclaimerType", "");
if(disclaimerType!=null && !disclaimerType.isEmpty() && disclaimerType.equals("datadriven")){
	pageContext.setAttribute("disclaimerText",IntelUtil.getDisclaimerForShop(currentPage,properties.get("disclaimerNumber", "")));	
}else{
	pageContext.setAttribute("disclaimerText",properties.get("authoredDisclaimer", ""));
}

String hideComponent = properties.get("hide", "no");
pageContext.setAttribute("hide",hideComponent);
%>
<cq:setContentBundle />


<c:choose>
	<c:when	test="${properties.expand eq 'no'}">
		<c:set var="class" value="" />
	</c:when>
	<c:otherwise>
		<c:set var="class" value="open" />
	</c:otherwise>
</c:choose>

<c:if test="${hide eq 'no'}">
<c:if test="${(disclaimerText ne '' && not empty disclaimerText ) || 'EDIT' eq wcmMode}">
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="disclaimers" class="clearfix">
		<a class="expand <c:out value="${class}" default="open"  />" href="#disclaimer-content"><fmt:message key="productdetails.label.disclaimer_heading"/></a>
	    <div id="disclaimer-content" class="<c:out value="${class}" default="open"  />">
           <p><c:out value="${pageScope.disclaimerText}" default="[Disclaimer]" escapeXml="false" /></p>
    </div>
</div>
</div>
</c:if>
</c:if>

<c:if test="${hide eq 'yes' and wcmMode eq 'EDIT'}">
<div id="disclaimers" class="clearfix">
Disclaimer is hidden. Configure to show.
</div>
</c:if>
