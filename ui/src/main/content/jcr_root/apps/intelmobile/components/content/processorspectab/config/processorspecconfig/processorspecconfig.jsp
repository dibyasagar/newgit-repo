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
<c:if test="${not empty properties.seefullspecslabel}">
<tr>
	<td>See Full Processor Specification Label</td> <td><cq:text property="seefullspecslabel" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.compspecslabel}">
<tr>
	<td>Compare Processor Specification Label</td> <td><cq:text property="compspecslabel" /></td>
</tr>	
</c:if>
<c:if test="${not empty properties.arklinkprefix}">
<tr>
	<td>ARK Link Prefix</td> <td><cq:text property="arklinkprefix" /></td>
</tr>	
</c:if>
</table>
</div>