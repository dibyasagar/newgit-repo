<%@include file="/libs/foundation/global.jsp"%>
<%@page import="java.util.Map, java.util.LinkedHashMap, com.day.cq.wcm.api.WCMMode, com.intel.mobile.util.IntelUtil" %>
<%@page session="false" %>
<% 
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
	    out.println("<h2>Right Click -> Edit to edit Links</h2>");
	}
   String linkscopy[] = null;
   String linkspath[] = null;
   Map<String, String> links = new LinkedHashMap<String, String>();
   
   linkscopy = (String[]) properties.get("linkcopy", new String[0]);
   linkspath =(String[]) properties.get("linkpath", new String[0]);
   if (linkscopy != null && linkspath != null && linkscopy.length > 0 && linkspath.length > 0) {
           for (int j = 0; j < linkscopy.length; j++) {
   				if(linkscopy[j] != null && linkspath[j]!=null && linkscopy[j].length()>0 && linkspath[j].length() > 0) {
   					links.put(linkscopy[j], linkspath[j]);
   				}
           }
   }
   pageContext.setAttribute("links", links);
   pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
   pageContext.setAttribute("componentName",component.getName() );
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<img src="${properties.heroImageReference}" alt="">
<div class="menu">
	<c:forEach var="entry" items="${links}">
		<p><a href="${entry.value}.html"><c:out value="${entry.key}" escapeXml="false"/></a></p>
	</c:forEach>
</div>
</div>