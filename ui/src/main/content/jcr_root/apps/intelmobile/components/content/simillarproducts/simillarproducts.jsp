<%--

  Simillar Products component.

--%><%@page import="java.util.logging.Logger,com.day.cq.wcm.api.WCMMode,java.util.List,com.intel.mobile.util.ConfigUtil,com.intel.mobile.util.IntelUtil,com.intel.mobile.util.SimillarProductUtil"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<cq:setContentBundle />
 <% 
String requiredPages[] = null;
String name = "";
String price = "";
String imageUrl = "";
String pagePath = "";

String heading = properties.get("heading","");
String reqpath = currentPage.getPath();

requiredPages = (String[]) properties.get("pages", new String[0]);
log.info("---------requiredPages------"+requiredPages.toString()); 
List similarProdList = SimillarProductUtil.getCmsSimilarProducts(requiredPages,resourceResolver);
log.info("---------similarProdList------"+similarProdList.size()); 
pageContext.setAttribute("similarProd",similarProdList);
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("locale",IntelUtil.getLocale(currentPage));
%>
<c:choose>
<c:when test="${fn:length(similarProd)>0}">
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
   <div class="carousel" data-count="2">
    <h3><%=heading %></h3>
    <ul class="carousel-content">
            
<c:forEach var="similarProds" items="${similarProd}" >       
   <li>
         <a href="<c:out value="${similarProds.url}"/>.html">  
           <img src="<c:out value="${similarProds.picture}"/>" />
              <div class="tile-info">
                <span><c:out value="${similarProds.name}" escapeXml="false"/></span>
                <c:if test="${similarProds.bestPrice ne '' && not empty similarProds.bestPrice}">
                <c:choose>
                 <c:when test="${locale eq 'ru_RU'}">
                       <c:set var="bestPrice" value="${fn:replace(similarProds.bestPrice,',',' ')}" />
                       <c:set var="bestPrice" value="${fn:replace(bestPrice,'.',',')}" />
                      
				         <span><c:out value="${bestPrice}"/><fmt:message key="generic.label.currency_symbol"/></span>
					  
                  </c:when>
                  <c:otherwise>
					   <span><fmt:message key="generic.label.currency_symbol"/><c:out value="${similarProds.bestPrice}"/></span>
				 </c:otherwise>
                  </c:choose>
                </c:if>
               </div>
           </a> 
   </li>
</c:forEach>
   </ul>
     <div class="pagination">
				</div>

    </div>
  </div>
 </c:when>
<c:otherwise>
     <c:if test="${editmode eq 'true'}">
	<div style="color:#FFFFFF">Double Click to Edit Similar Product Component </div>
	</c:if>
</c:otherwise>                     
</c:choose>

