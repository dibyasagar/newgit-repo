<%--

  Article Detail Terms component.


--%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>
<%@page session="false" %>
<%
	pageContext.setAttribute("expandLabelLink",properties.get("expandlinklabel", ""));
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		pageContext.setAttribute("editmode", "true");
	}
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName());
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div class="hero border-list">
	<div class="content items terms-page">
		<cq:include path="defaultText" resourceType="foundation/components/parsys" />
 
        <div class="view-more" style="overflow: hidden; display: none; ">					
			<c:if test="${editmode eq 'true'}">
				<center><h4>Add Expandable Rich Text Items below</h4></center>
			</c:if>

			<cq:include path="expandedText" resourceType="foundation/components/parsys" />					
        </div>
       	<a href="" data-opencopy="${expandLabelLink}" class="view-more-control grad">
			<c:out value="${expandLabelLink}" escapeXml="false"/>
		</a>	              
    </div>
</div>
</div>