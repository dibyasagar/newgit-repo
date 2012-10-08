<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%  String footerdisplaytext[] = null;
    String footerlinks[] = null;
    String newwindow[] = null;
    footerdisplaytext = (String[]) properties.get("footerTitle", new String[0]);
    footerlinks =(String[]) properties.get("footerUrl", new String[0]);
    newwindow = (String[]) properties.get("newwindow", new String[0]);
    pageContext.setAttribute("footerdisplaytext",footerdisplaytext);
    pageContext.setAttribute("footerlinks",footerlinks);
    pageContext.setAttribute("newwindow",newwindow);
   %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Global Footer component</font></h1>
<table border=0>
<tr>
<td><b>Attribute Name</b></td><td><b>Attribute Value</b></td>
</tr>

<c:if test="${not empty properties.fullsitelinktext}">
<tr>
	<td>Full Site Link Text</td> <td><cq:text property="fullsitelinktext" escapeXml="false"/></td>
</tr>	
</c:if>
<c:if test="${not empty properties.fullsitelink}">
<tr>
	<td>Full Site Link</td><td><cq:text property="fullsitelink" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.fullsitenewwindow}">
<tr>
	<td>Open full site in new window</td><td><cq:text property="fullsitenewwindow" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.hidefullsitelink}">
<tr>
	<td>Hide Fullsite View Link</td><td><cq:text property="hidefullsitelink" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.trademarktext}">
<tr>
	<td>Trademark Text</td><td><cq:text property="trademarktext" escapeXml="false"/></td>
</tr>	
</c:if>
<c:if test="${not empty properties.region}">
<tr>
	<td>Enter Region</td><td><cq:text property="region" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.regionurl}">
<tr>
	<td>Region Url</td><td><cq:text property="regionurl" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.hideregionurl}">
<tr>
	<td>Hide Region URL</td><td><cq:text property="hideregionurl" /></td>
</tr>	
</c:if>

<c:if test="${fn:length(footerdisplaytext) gt 0}">  
  <c:forEach items="${footerdisplaytext}" var="name" varStatus="status"> 
  <tr><td>Global Footer Display Text</td><td><c:out value="${name}" escapeXml="false"/></td></tr>
  <tr><td>Global Footer URL</td><td><c:out value="${footerlinks[status.index]}"/></td></tr>
  <tr><td>Open in new window</td><td><c:out value="${newwindow[status.index]}"/></td></tr>
  <tr><td></td><td></td></tr>
  </c:forEach>
</c:if>
</table>
</div>