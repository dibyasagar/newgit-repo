<%@ page import="org.apache.jackrabbit.util.Text,
				com.intel.mobile.util.IntelSitemap,
				java.util.List,
				java.util.Arrays,
				com.intel.mobile.util.IntelUtil,
				com.day.cq.wcm.api.Page,
				com.day.cq.wcm.api.PageFilter,
				com.day.cq.wcm.api.PageManager,
				com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<h1>Sitemap</h1>
<%
log.info("System mapped  path is - "  + resourceResolver.map(currentPage.getPath()));
if (WCMMode.fromRequest(request) == WCMMode.EDIT || WCMMode.fromRequest(request) == WCMMode.DESIGN) {
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		out.println("Right Click -> Edit to edit Sitemap component.");		
	}
} else {
	String rootPath = "";
	String pages[] = properties.get("pages", String[].class);
	List exceptionPaths = null;
	if(pages != null) {
		exceptionPaths = Arrays.asList(pages);
	}	
	if(currentPage.getParent() != null) {
		rootPath = currentPage.getParent().getPath();
	}
	out.println("<div class='text'>");
	Page rootPage = slingRequest.getResourceResolver().adaptTo(PageManager.class).getPage(rootPath);
    IntelSitemap stm = new IntelSitemap(rootPage, exceptionPaths);
    stm.draw(out);
    out.println("</div>");
}
%>
</div>
