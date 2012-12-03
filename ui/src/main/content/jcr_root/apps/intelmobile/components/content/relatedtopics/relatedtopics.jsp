<%--

  Related Topics component.



--%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>

<%
int suggestionCount = Integer.parseInt(properties.get("relatedtopics","0"));
String  linkCopy[] = new String[suggestionCount];
String  linkUrl[] = new String[suggestionCount];

pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("linkCopyArray",properties.get("linkcopy",linkCopy));
pageContext.setAttribute("linkUrlArray",properties.get("linkurl",linkUrl));

%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<h3 class="grad"><c:out value="${pageScope.properties.title}" default="[Title]" escapeXml="false" /></h3>
<div class="suggest table-list">
<c:forEach var="element" items="${linkCopyArray}" varStatus="row">
	<span><a href="${linkUrlArray[row.index]}"><c:out value="${element}" escapeXml="false"/></a></span> 
	</c:forEach>
</div>
</div>
