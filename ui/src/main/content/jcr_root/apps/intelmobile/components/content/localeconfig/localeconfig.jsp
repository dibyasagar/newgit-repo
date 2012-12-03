<%--

  Locale Config component.

--%><%@page import="com.intel.mobile.search.ProductDetails,java.util.*,com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.ConfigUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>

<%
    if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
        out.println("Double Click to Edit ");
    }

    String localeid = "";
    String currencyCode = "";
    String jcrLanguage = "";

    if (properties.get("localeid") != null) {
        localeid = properties.get("localeid").toString();
    }
    if (properties.get("currencycode") != null) {
        currencyCode = properties.get("currencycode").toString();
    }
    if (properties.get("language") != null) {
        jcrLanguage = properties.get("language").toString();
    }
    ConfigUtil.setConfigLang(currentPage,jcrLanguage);
%> 

<h2><font color="black">Right Click->Edit to edit the Locale config component</font></h2>
</br> 
<h3><font color="black">Locale ID, used for SHOP API: </font> <%=localeid %></h3>
</br>
<h3><font color="black">Currency code: </font> <%=currencyCode %></h3>
</br>
<h3><font color="black">JCR Language, used for resource bundle lookup: </font> <%=jcrLanguage %></h3>
