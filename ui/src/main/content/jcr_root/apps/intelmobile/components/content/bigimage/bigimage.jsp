<%--
  Big Image Component.
--%>

<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
 if(WCMMode.fromRequest(request) == WCMMode.EDIT) {
    %>       
        <br/><div style="color:#FFFFFF"> Right click to edit the Big Image Component </div>                  
   <%    
 }
%>
<li>
    <div class="items content">
        <div class="item">
          <c:if test="${properties.imagePath ne '' && not empty properties.imagePath }">
             <img src="<c:out value="${properties.imagePath}"/>" alt="<c:out value="${properties.alttext}"/>">
          </c:if>
          <c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
              <c:if test="${properties.displaysocial eq 'yes'}">
                 <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
              </c:if>             
          </c:if> 
          </div>
     </div>
</li>