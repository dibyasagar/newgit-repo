<%--

  Decision Shop Spot component.



--%>

<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName());

%>

<c:set var="suffleboardUrl" value="${properties.suffleboardUrl}" />
<c:if test="${fn:startsWith(suffleboardUrl,'/content')}">
	<c:set var="suffleboardUrl" value="${suffleboardUrl}.html" />
</c:if>

<c:set var="metaphoresUrl" value="${properties.metaphoresUrl}" />
<c:if test="${fn:startsWith(metaphoresUrl,'/content')}">
	<c:set var="metaphoresUrl" value="${metaphoresUrl}.html" />
</c:if>

<c:set var="ultrabookUrl" value="${properties.ultrabookUrl}" />
<c:if test="${fn:startsWith(ultrabookUrl,'/content')}">
	<c:set var="ultrabookUrl" value="${ultrabookUrl}.html" />
</c:if>

<link rel="stylesheet"
	href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot.css" />
<link rel="stylesheet"
	href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot_widget.css" />
<div class="page-layout">
	<div id="shopper-app" class="shop-spot-landing">

		<div class="shop-spot-header">
			<h2></h2>
		</div>
		<div class="shop-spot-shelf">
			<div class="shop-spot-products">
				<div class="shop-spot-content-container">
					<!-- NOTE: this href value needs to be the final of the spec shuffleboard page in prod -->
					<a href="<c:out value="${suffleboardUrl}" />" data=""
						class="shop-spot-product"> <img
						src="/etc/designs/intelmobile/img/decision/shuffleboard_large.png" />
					</a>
					<!-- NOTE: this href value needs to be the final of the core metaphors page in prod -->
					<a href="<c:out value="${metaphoresUrl}" />" data=""
						class="shop-spot-product"> <img
						src="/etc/designs/intelmobile/img/decision/core_metaphors_large.png" />
					</a>
					<!-- NOTE: this href value needs to be the final of the meet ultrabook page in prod -->
					<a href="<c:out value="${ultrabookUrl}" />" data=""
						class="shop-spot-product"> <img
						src="/etc/designs/intelmobile/img/decision/ultrabook_large.png" />
					</a>
				</div>
			</div>

		</div>

	</div>
	<!-- end spec  app -->
</div>