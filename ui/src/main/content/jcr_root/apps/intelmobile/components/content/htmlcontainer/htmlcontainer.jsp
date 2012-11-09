<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="javax.jcr.Node,com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
 pageContext.setAttribute("html",properties.get("plaintext", ""));
 pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>

<c:choose>
<c:when test="${not empty properties.plaintext}">
<c:out value="${pageScope.html}" default="[HTML]" escapeXml="false" />
</c:when>
<c:otherwise>
<c:if test="${editmode eq 'true'}">
<div>Double Click to Edit HTML Container Component</div>
</c:if>
</c:otherwise>
</c:choose>