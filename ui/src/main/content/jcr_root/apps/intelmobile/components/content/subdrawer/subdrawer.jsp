<%--

  Sub Drawer component.

--%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.day.cq.wcm.api.WCMMode, com.intel.mobile.util.IntelUtil" %>

<%
	String viewmoreafternum = (String) properties.get("viewmorenum");
	long viewmoreafter = 0;
	if (viewmoreafternum != null) {
		viewmoreafter = Long.parseLong(viewmoreafternum);
		pageContext.setAttribute("viewmoreafter", viewmoreafter);
	}
	pageContext.setAttribute("wcmMode", WCMMode.fromRequest(request));
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName", component.getName());
	pageContext.setAttribute("parsysCount",IntelUtil.getParsysNumber(resource));
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">

<!-- Article Landing Sub Drawer -->
	
		<h3 class = "grad">
			<cq:text property="title" default="SubDrawer" escapeXml="false"/>
		</h3>
				<cq:include path="subDrawerParsys"
					resourceType="foundation/components/parsys" />
					
		   <c:if test="${viewmoreafter == parsysCount}">			
				<div class="view-more">
					<c:if test="${wcmMode eq 'EDIT'}">
						Drop view more items below.
					</c:if>
					<cq:include path="subDrawerMoreParsys"
						resourceType="foundation/components/parsys" />
				</div>
			
				<a class="view-more-control grad" href="javascript:void(0)" data-closedcopy="<cq:text property="footertext" />" data-opencopy="<cq:text property="viewlesstext" />"><cq:text
						property="footertext" escapeXml="false"/>
				</a>
		  </c:if>	
	</div>	
<!--  Article Landing Sub Drawer-->