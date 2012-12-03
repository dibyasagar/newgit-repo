<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Shop Disclaimer Component</font></h1>
<table border=0>
<tr>
<td>
	<b>Attribute Name</b>
</td>
<td>
	<b>Attribute Value</b>
</td>
</tr>
<c:if test="${not empty properties.disclaimerType}">
<tr>
	<td>Disclaimer Type</td> <td><cq:text property="disclaimerType" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.disclaimerNumber}">
<tr>
	<td>Disclaimer Number</td> <td><cq:text property="disclaimerNumber" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.authoredDisclaimer}">
<tr>
	<td>Disclaimer Text</td> <td><cq:text property="authoredDisclaimer" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.expand}">
<tr>
	<td>Expand By Default ?</td> <td><cq:text property="expand" /></td>
</tr>	
</c:if>
</table>
</div>