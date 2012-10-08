<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
   Integer scObject = (Integer) request.getAttribute("javax.servlet.error.status_code");
   int statusCode = (scObject != null)
            ? scObject.intValue()
            : HttpServletResponse.SC_INTERNAL_SERVER_ERROR;

    response.setStatus(statusCode);
    response.setContentType("text/html"); 
    response.setCharacterEncoding("utf-8"); 
 %>
   <jsp:include page="/content/intelmobile/us/en/error-pages/500.html"/> 
