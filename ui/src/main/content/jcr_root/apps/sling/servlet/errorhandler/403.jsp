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
    <%
   
   String url=request.getRequestURL().toString();
    String uri= request.getRequestURI();
    
    if(url.contains("/us/en/")){        
    %><jsp:include page="/content/intelmobile/us/en/error-pages/403.html"/> <%
    }else if(url.contains("/uk/en")){       
     %><jsp:include page="/content/intelmobile/uk/en/error-pages/403.html"/> <%
    }else  if(url.contains("/de/de")){       
     %><jsp:include page="/content/intelmobile/de/de/error-pages/403.html"/> <%
    }else  if(url.contains("/ng/en")){       
     %><jsp:include page="/content/intelmobile/ng/en/error-pages/403.html"/> <%
    }else  if(url.contains("/au/en")){       
     %><jsp:include page="/content/intelmobile/au/en/error-pages/403.html"/> <%
    }else  if(url.contains("/my/en")){       
     %><jsp:include page="/content/intelmobile/my/en/error-pages/403.html"/> <%
    }else  if(url.contains("/ph/en")){       
     %><jsp:include page="/content/intelmobile/ph/en/error-pages/403.html"/> <%
    }else  if(url.contains("/in/en")){       
     %><jsp:include page="/content/intelmobile/in/en/error-pages/403.html"/> <%
    }else  if(url.contains("/br/pt")){       
     %><jsp:include page="/content/intelmobile/br/pt/error-pages/403.html"/> <%
    }else  if(url.contains("/ru/ru")){       
     %><jsp:include page="/content/intelmobile/ru/ru/error-pages/403.html"/> <%
    }else {       
     %><jsp:include page="/content/intelmobile/us/en/error-pages/403.html"/> <%
    }
   
   
   %>
