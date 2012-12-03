<%@include file="/libs/foundation/global.jsp"%>
<%@page import="java.util.Map, com.intel.mobile.util.ProductUtil,com.intel.mobile.util.ConfigUtil, java.util.List, java.util.ArrayList, java.util.Arrays" %>
<%@page session="false" %>
<cq:setContentBundle />
<%
	Map<String, String> features = ProductUtil.getFeatures(resourceResolver, currentPage);
String pagepath = currentPage.getPath();
    String displayLabels = ConfigUtil.getFeatureLabels(resourceResolver,pagepath,"shop");
	pageContext.setAttribute("features", features);
	pageContext.setAttribute("displayLabels",displayLabels);
	
	
	String prop[] = properties.get("customfeatures", String[].class);
	List<String> customFeatures = null;
	if(prop != null) {
		customFeatures = Arrays.asList(prop);
	} else {
		customFeatures = new ArrayList();
	}
	pageContext.setAttribute("customfeatures", customFeatures);
%>
<c:if test="${fn:length(features)>0 or fn:length(customfeatures)>0}">
		<h4 class="grad"><fmt:message key="productdetails.label.feature" /></h4>
		<ul class="features">						
		<c:forEach var="entry" items="${features}">
				<li>
					<c:out value="${entry.value}" /> 
					<c:set var="attributeName" value="${fn:replace(entry.key,'productdetails.label.feature_','')}" />
				   
				    <c:if test="${fn:contains(displayLabels,attributeName)}">
						<fmt:message key="${entry.key}"/>
					</c:if>	
								
				</li>
		</c:forEach>
		<c:forEach var="entry" items="${customfeatures}">
			<li>
				<c:out value="${entry}" />
			</li>
		</c:forEach>
		</ul>
</c:if>
