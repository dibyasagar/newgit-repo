<%--

  Page Footer component.

  Global Page Footer Component

--%>
<%
    
%><%@include file="/libs/foundation/global.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode"%>
<%-- footer --%>
<%
    Object footerlinkTitle[] = null;
    Object footerlinkUrl[] = null;
    Object newWindow[] = null;
    Object validLink[] = null;
    String trademarkText = "";
    String fullsiteText = "";
    String fullsiteLink = "";
    String hideSitelink = null;
    String footerurl = "";
    String region = "";
    String regionUrl = "";
   
    String fullLink = "";
    String strCurrentPage = currentPage.getProperties().get("cq:template", "");
    String strCurrentPagePath = currentPage.getPath();
 
    footerlinkTitle = IntelUtil.getConfigValues(currentPage,"footer", "footerTitle");
    footerlinkUrl = IntelUtil.getConfigValues(currentPage,"footer", "footerUrl");
    newWindow =  IntelUtil.getConfigValues(currentPage,"footer", "newwindow");
    if (footerlinkUrl != null){ validLink = IntelUtil.getDisplayUrl(footerlinkUrl,resourceResolver);}
    if (IntelUtil.getConfigValue(currentPage,"footer", "fullsitelink","")!= null) {
        fullsiteLink = IntelUtil.getConfigValue(currentPage,"footer", "fullsitelink","");
        fullLink = IntelUtil.getLinkUrl(fullsiteLink,resourceResolver);}
    
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName());
    pageContext.setAttribute("footerlinkUrl",validLink);
    pageContext.setAttribute("fullsiteLink",fullLink);
    pageContext.setAttribute("newWindow",newWindow);
         
%>

<c:set var="trademarkText"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "trademarktext","") %>" />
<c:set var="fullsiteText"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "fullsitelinktext","") %>" />

<c:set var="region"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "region","") %>" />
<c:set var="regionUrl"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "regionurl","") %>" />
      <c:if test="${fn:startsWith(regionUrl,'/content')}">
       <c:set var="regionUrl" value="${regionUrl}.html" />
      </c:if>
<c:set var="hideSitelink"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "hidefullsitelink","") %>" />
<c:set var="hideregionurl"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer", "hideregionurl","false") %>" /> 
    <c:set var="openFullSiteInNewWindow"
    value="<%= IntelUtil.getConfigValue(currentPage,"footer","fullsiteinnewwindow", "yes") %>" /> 

<c:set var="footerlinkTitle" value="<%=footerlinkTitle %>" />
<%-- updated html code below --%>

<footer>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
   
    <c:if test="${hideregionurl !='true'}">
    <div id="language">
        <a href="${regionUrl}"><c:out value="${region}" escapeXml="false"/></a>
    </div>
    </c:if>
    <nav>
        <ul>
            <c:set var="fullSiteInNewWindow" value="_blank" />
            
            <c:if test="${openFullSiteInNewWindow eq 'no'}">
                      <c:set var="fullSiteInNewWindow" value="" />
            </c:if> 
        
            <c:if test="${hideSitelink !='true'}">
                <li><a href="${fullsiteLink}" target="${fullSiteInNewWindow}"><c:out value="${fullsiteText}" escapeXml="false"/></a>
                </li>
            </c:if>
        
         
            <c:if test="${ (fn:length(footerlinkTitle) gt 0) }">
                <c:forEach items="${footerlinkTitle}" var="title" varStatus="status">
                <c:set var="window" value="" />
                <c:if test="${newWindow[status.index] eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if> 
                <li><a href="${footerlinkUrl[status.index]}" target="${window}"><c:out value="${title}" escapeXml="false"/></a>
                    </li>
                </c:forEach>
            </c:if>

        </ul>
        <small><c:out value="${trademarkText}" escapeXml="false"/></small> 
    </nav> 
   </div> 
</footer>
<script text="text/javascript">
//alert(document.getElementById("hiddenField").value );
$(document).ready(function(){
var val = "<%=strCurrentPage %>";
val = val  + "|";
val = val + "<%=strCurrentPagePath %>";
var expiration_date = new Date();
expiration_date.setTime(expiration_date.getTime()+(90*24*60*60*1000));
expiration_date = expiration_date.toGMTString();
//alert("cookie value is"+val);
document.cookie = "intelmobile_last_visited_page="+val +";expires="+expiration_date+";path=/";

});
</script>


 <script src="/etc/designs/intelmobile/appclientlibs/js/intel.mobile.js"></script> 
 <script src="http://platform.twitter.com/widgets.js"></script> 
<%-- intel specific scripts --%>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/decision/app_wrapper.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/decision/core_metaphors.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/decision/spec_shuffle.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/decision/meet_ultrabook.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/decision/iscroll.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/helper.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/articlelanding.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/sitesearch.js"></script>
    <%-- WAP Integration Start --%>
    <script type="text/javascript">
        // Custom WAP -------------------------------------------------------------------------------
        s={}; //init s object
        var wapTrackingEnv = "<%= IntelUtil.getIntelConfigService().getWapTrackingEnv()%>"; //prod = production,  test = all other instances.
        s['cqUrl'] = "<%=currentPage.getPath() %>";
        s['pageType'] = "<%=IntelUtil.getTemplateName(currentPage) %>";
        // END ---------------------------------------------------------------------------------------
    </script>
    <script type="text/javascript" src="http://www.intel.com/content/dam/www/global/wap/wap-mobile.js "></script>
    <%-- WAP Integration End --%>
    
     <%-- Additional Script Inclusion End --%>

<%-- Add this --%>
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "ur-661b55e5-341-5a95-e973-c4ac96945400",shorten:false}); </script>
<%-- end scripts --%>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/plugins.js"></script>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/example-controller.js"></script>


<%
        if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/alignfix.js"></script>
<%
}
%>

<%
        if (WCMMode.fromRequest(request) == WCMMode.EDIT||WCMMode.fromRequest(request) == WCMMode.PREVIEW) {
%>
<script>
	$(document).ready(function(){
    
    setTimeout('resizeUB()',100);
    
});

function resizeUB()
{
	$(".space-2.vertical").attr("style","display: block !important");
	$(".space-2.imgland").attr("style","display: none !important");
}
</script>
<%
}
%>