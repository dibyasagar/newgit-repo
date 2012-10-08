<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Feature Phone Footer component</font></h1>
<table border=0>
<tr>
<td>
	<b>Attribute Name</b>
</td>
<td>
	<b>Attribute Value</b>
</td>
</tr>
<c:if test="${not empty properties.link1copy}">
<tr>
	<td>Link 1 Copy</td> <td><cq:text property="link1copy" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.link1url}">
<tr>
	<td>Link 1 URL</td> <td><cq:text property="link1url" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.link2copy}">
<tr>
	<td>Link 2 Copy</td> <td><cq:text property="link2copy" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.link2url}">
<tr>
	<td>Link 2 URL</td> <td><cq:text property="link2url" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.link3copy}">
<tr>
	<td>Link 3 Copy</td> <td><cq:text property="link3copy" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.link3url}">
<tr>
	<td>Link 3 URL</td> <td><cq:text property="link3url" /></td>
</tr>	
</c:if>
</table>
</div>