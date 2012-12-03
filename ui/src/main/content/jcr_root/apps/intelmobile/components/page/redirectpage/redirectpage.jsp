<%--

  Redirect Page component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%@page import="com.day.cq.wcm.api.WCMMode" %>
<cq:include script="/libs/wcm/core/components/init/init.jsp"/>
<%
    if(WCMMode.fromRequest(request) != WCMMode.EDIT) {
        String url = properties.get("redirecturl","");
        if(url.length() > 0) {
            response.sendRedirect(url);
        }        
    } else {
        out.println("<h3>Use Page Properties dialog to configure the Redirect URL</h3>");
    }
%>