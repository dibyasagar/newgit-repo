<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%><%
%><%@page session="false" %>
<% String displaynames[] = null;
   String links[] = null;
   String newwindow[] = null;
   String validLink[] = null;
   String buttoncolor[] = null;
   
   displaynames = (String[]) properties.get("displaycopy", new String[0]);
   links =(String[]) properties.get("link", new String[0]);
   newwindow = (String[]) properties.get("newwindow", new String[0]);
   buttoncolor = (String[]) properties.get("buttonColor", new String[0]);
   if (links != null){ validLink = IntelUtil.getIntenalUrl(links,resourceResolver);}
 
   pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
   pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
   pageContext.setAttribute("componentName",component.getName());
   pageContext.setAttribute("displaynames",displaynames);
   pageContext.setAttribute("links",validLink);
   pageContext.setAttribute("newwindow",newwindow);
   pageContext.setAttribute("buttoncolor",buttoncolor);
%>
     <c:choose>
          <c:when test="${fn:length(displaynames) gt 0}">  
              <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">   
             <c:forEach items="${displaynames}" var="name" varStatus="status"> 
                <c:set var="window" value="" />
                <c:if test="${newwindow[status.index] eq 'yes'}">
                          <c:set var="window" value="_blank" />
                </c:if> 
                
                <c:choose>
         			 <c:when test="${buttoncolor[status.index] eq 'grey'}">
                        <c:set var="buttontype" value="button secondary" />
                	</c:when>
                	<c:otherwise>
                		<c:set var="buttontype" value="button primary" />
                	</c:otherwise>
                </c:choose>	
              <a class="<c:out value="${buttontype}"/>" href="${links[status.index]}#shopthirdparty" target="${window}"><c:out value="${name}" escapeXml="false"/></a>
             </c:forEach>
              </div>
          </c:when>
          <c:otherwise>
               <c:if test="${editmode eq 'true'}">
		           <div>Double Click to Edit Externallink Component</div>
	           </c:if>
           </c:otherwise>
      </c:choose>  
           


