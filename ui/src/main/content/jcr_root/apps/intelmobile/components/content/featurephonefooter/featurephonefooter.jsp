<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
    String link1copy = currentStyle.get("link1copy", "");
    String link1url = currentStyle.get("link1url", "");
    
    String link2copy = currentStyle.get("link2copy", "");
    String link2url = currentStyle.get("link2url", "");

    String link3copy = currentStyle.get("link3copy", "");
    String link3url = currentStyle.get("link3url", "");

    pageContext.setAttribute("link1copy", link1copy);
    pageContext.setAttribute("link1url", link1url);

    pageContext.setAttribute("link2copy", link2copy);
    pageContext.setAttribute("link2url", link2url);

    pageContext.setAttribute("link3copy", link3copy);
    pageContext.setAttribute("link3url", link3url); 
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName() );
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
    <div id="footer">
	    <div>   
	         <c:if test="${fn:startsWith(link1url,'/content')}">
	                 <c:set var="link1url" value="${link1url}.html" />
	         </c:if>
	         <c:if test="${fn:startsWith(link2url,'/content')}">
	                 <c:set var="link2url" value="${link2url}.html" />
	         </c:if>
	         <c:if test="${fn:startsWith(link3url,'/content')}">
	                 <c:set var="link3url" value="${link3url}.html" />
	         </c:if>
	        <span><a href="${link1url}"><c:out value="${link1copy}" escapeXml="false"/></a></span>
	        <c:if test="${link2copy ne '' and link2url ne ''}">
	            <span>/</span>
	            <span><a href="${link2url}"><c:out value="${link2copy}" escapeXml="false"/></a></span>               
	        </c:if>
	        <c:if test="${link3copy ne '' and link3url ne ''}">
	            <span>/</span>
	            <span><a href="${link3url}"><c:out value="${link3copy}" escapeXml="false"/></a></span>               
	        </c:if>
	    </div>
</div>
</div>