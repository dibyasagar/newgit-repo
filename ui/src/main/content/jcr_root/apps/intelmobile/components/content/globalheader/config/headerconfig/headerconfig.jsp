<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%
String title[] = null;
String url[] = null;
String showsubpage[] = null;
title = (String[]) properties.get("headerTitle", new String[0]);
url =(String[]) properties.get("headerUrl", new String[0]);
showsubpage = (String[]) properties.get("showsubpage", new String[0]);
pageContext.setAttribute("headertitle",title);
pageContext.setAttribute("headerurl",url);
pageContext.setAttribute("showsubpage",showsubpage);
%>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Global Header component</font></h1>
<table border=0>
<tr>
<td><b>Attribute Name</b></td> <td><b>Attribute Value</b></td>
</tr>
<c:if test="${not empty properties.logolink}">
<tr>
	<td>Logo Link</td> <td><cq:text property="logolink" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.logoimage}">
<tr>
	<td>Logo Image</td> <td><cq:text property="logoimage" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.menulabel}">
<tr>
	<td>Menu Label</td> <td><cq:text property="menulabel"/></td>
</tr>	
</c:if>
<c:if test="${not empty properties.searchicon}">
<tr>
	<td>Search Icon</td> <td><cq:text property="searchicon"/></td>
</tr>	
</c:if>
<c:if test="${fn:length(headertitle) gt 0}">  
  <c:forEach items="${headertitle}" var="name" varStatus="status"> 
  <tr><td>Link Display Text</td><td><c:out value="${name}" escapeXml="false"/></td></tr>
  <tr><td>Link url</td><td><c:out value="${headerurl[status.index]}"/></td></tr>
  <tr><td>Show Subpage</td><td><c:out value="${showsubpage[status.index]}"/></td></tr>
  <tr><td></td><td></td></tr>
  </c:forEach>
</c:if>
</table>
</div>