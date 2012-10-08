<%--

  SHOP Disclaimer component.

--%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );

String disclaimerType = currentStyle.get("disclaimerType", "");
if(disclaimerType!=null && !disclaimerType.isEmpty() && disclaimerType.equals("datadriven")){
	pageContext.setAttribute("disclaimerText",IntelUtil.getDisclaimerForShop(currentPage,currentStyle.get("disclaimerNumber", "")));	
}else{
	pageContext.setAttribute("disclaimerText",currentStyle.get("authoredDisclaimer", ""));
}

pageContext.setAttribute("expand",currentStyle.get("expand", "open"));
%>
<cq:setContentBundle />

<c:choose>
	<c:when	test="${expand eq 'no'}">
		<c:set var="class" value="" />
	</c:when>
	<c:otherwise>
		<c:set var="class" value="open" />
	</c:otherwise>
</c:choose>

<c:if test="${disclaimerText ne '' && not empty disclaimerText }">
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="disclaimers" class="clearfix">
		<a class="expand <c:out value="${class}" default="open"  />" href="#disclaimer-content"><fmt:message key="productdetails.label.disclaimer_heading"/></a>
	    <div id="disclaimer-content" class="<c:out value="${class}" default="open"  />">
           <p><c:out value="${pageScope.disclaimerText}" default="[Disclaimer]" escapeXml="false" /></p>
    </div>
</div>
</div>
</c:if>