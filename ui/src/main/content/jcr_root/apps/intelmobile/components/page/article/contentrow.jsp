<%--
Content Row.This file contains the Main Content of the template

--%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		pageContext.setAttribute("editmode", "true");
	}
%>

<div id="main" role="main">
	<div id="article-landing" class="article-detail">
		<cq:include path="header" resourceType="intelmobile/components/content/articletitle" />
		<cq:include path="articleHead" resourceType="foundation/components/parsys"/>            
		
		<c:if test="${editmode eq 'true'}">
			<center><h4>Add Additional Components Below </h4></center>
		</c:if>
		
		<div class="sections">
			<ul class="accordion">
				<cq:include path="articleBody" resourceType="foundation/components/parsys"/>
			</ul>
		</div>				
	</div>	
</div>
<cq:include path="disclaimer" resourceType="intelmobile/components/content/disclaimer"/>