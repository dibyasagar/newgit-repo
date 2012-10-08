<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<div id="main" role="main">
<h1><font color="black">Right Click->Edit to edit the Search component</font></h1>
<table border=0>
<tr>
<td><b>Attribute Name</b></td> &nbsp;<td><b>Attribute Value</b></td>
</tr>
<c:if test="${not empty properties.searchbtnimg}">
<tr>
	<td>Search Button Image</td> <td><cq:text property="searchbtnimg" /></td>
</tr>	
</c:if>
</table>
</div>