<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Processor Spec component</font></h1>
<table border=0>
<tr>
<td>
	<b>Attribute Name</b>
</td>
<td>
	<b>Attribute Value</b>
</td>
</tr>
<c:if test="${not empty properties.heading}">
<tr>
	<td>Heading Text</td> <td><cq:text property="heading" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.comparePath}">
<tr>
	<td>Processor Comparison Page</td> <td><cq:text property="comparePath" /></td>
</tr>	
</c:if>
</table>
</div>