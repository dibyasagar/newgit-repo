<%--

  Search component.

--%>
<%@page import="com.intel.mobile.search.ProductDetails,com.intel.mobile.util.IntelUtil,com.intel.mobile.search.*,org.apache.commons.lang.StringEscapeUtils,org.apache.commons.lang.StringUtils,com.day.cq.wcm.mobile.api.device.DeviceGroup"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>

<% 

String searchbuttonImage = "";
String rootPath = IntelUtil.getRootPath(currentPage);
String resultPath = rootPath+"/search-result.html";
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
String pageName = currentPage.getName() ;
String searchValue = "";
if(pageName.equalsIgnoreCase("search-result")){
	String selectors[] = slingRequest.getRequestPathInfo().getSelectors();
	if (selectors.length > 0) {
      searchValue = selectors[0];
}
}
if (currentStyle.get("searchbtnimg") != null) {
    searchbuttonImage = currentStyle.get("searchbtnimg").toString();
}


%>
<c:set var="searchbuttonImage"
	value="<%= searchbuttonImage %>" />
<c:set var="searchresultpath"
	value="<%= resultPath %>" />
<c:set var="searchValue"
	value="<%= searchValue %>" />		
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div id="modal-search" class="tipped-modal">
    <form action="${searchresultpath}" method="get" id="form-search" name="form-search" onsubmit="return submitSearchForm();">

             <div class="text-input">
                 <input id="search-term" name="search-term" type="text" class="text" onkeyup="getKeys()" value="${searchValue}">
                 <a id="clear-search" title="Clear" href="#">Clear</a>
                 <c:if test="${ searchbuttonImage ne '' && not empty searchbuttonImage }">
                 <input type="image" src="${searchbuttonImage}">
                  </c:if>
                 <c:if test="${ empty searchbuttonImage }">
                  <input type="image" src="/etc/designs/intelmobile/img/btn-search.png">
                  </c:if>
             </div>                                 
            <div id= "suggestions" style="background-color:#FFF;">
            </div>                            
    </form>
</div>
</div>
