<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Feature Phone Header component</font></h1>
<table border=0>
<tr>
<td>
	<b>Attribute Name</b>
</td>
<td>
	<b>Attribute Value</b>
</td>
</tr>
<c:if test="${not empty properties.logoImageReference}">
<tr>
	<td>Logo Image</td> <td><cq:text property="logoImageReference" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.linkpath}">
<tr>
	<td>Link Path</td> <td><cq:text property="linkpath" /></td>
</tr>	
</c:if>
</table>
</div>