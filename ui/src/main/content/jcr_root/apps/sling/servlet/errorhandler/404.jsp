<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%@ page import="
    java.net.URLEncoder,
    org.apache.sling.api.scripting.SlingBindings,
    org.apache.sling.engine.auth.Authenticator,
    org.apache.sling.engine.auth.NoAuthenticationHandlerException,
    com.day.cq.wcm.api.WCMMode" %>
    
    
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
    
    if(url.contains("/us/")){
    response.sendRedirect("/content/intelmobile/us/en/error-pages/404.html");
    }else if(url.contains("/uk/")){       
     response.sendRedirect("/content/intelmobile/uk/en/error-pages/404.html");
    }else  if(url.contains("/de/")){       
     response.sendRedirect("/content/intelmobile/de/de/error-pages/404.html");
    }else  if(url.contains("/ng/")){       
     response.sendRedirect("/content/intelmobile/ng/en/error-pages/404.html");
    }else  if(url.contains("/au/")){       
     response.sendRedirect("/content/intelmobile/au/en/error-pages/404.html");
    }else  if(url.contains("/my/")){       
     response.sendRedirect("/content/intelmobile/my/en/error-pages/404.html");
    }else  if(url.contains("/ph/")){       
     response.sendRedirect("/content/intelmobile/ph/en/error-pages/404.html");
    }else  if(url.contains("/in/")){       
     response.sendRedirect("/content/intelmobile/in/en/error-pages/404.html");
    }else  if(url.contains("/br/")){       
     response.sendRedirect("/content/intelmobile/br/pt/error-pages/404.html");
    }else  if(url.contains("/ru/")){       
     response.sendRedirect("/content/intelmobile/ru/ru/error-pages/404.html");
    }else {       
     response.sendRedirect("/content/intelmobile/us/en/error-pages/404.html");
    }
   
   
   %>