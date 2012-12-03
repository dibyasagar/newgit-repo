<%--

  Article Detail Slideshare Component component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>
<%
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		pageContext.setAttribute("editmode", "true");
	}

pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
  <li>
	<c:if test="${editmode eq 'true'}">
		<center><h4>Right Click -> Edit to edit the Slide component </h4></center>
	</c:if>
	<c:if test="${properties.slideId ne null and properties.slideId ne ''}">
		<div class="slideshare" data-slide="${properties.slideId}"></div>	
	</c:if>
	<cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>                   
 </li>
 </div>