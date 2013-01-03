<%@include file="/libs/foundation/global.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.intel.mobile.util.IntelUtil,com.intel.mobile.util.HeroImageUtil"%>
<%@page import="com.day.cq.wcm.api.WCMMode,java.util.List,com.intel.mobile.util.IntelUtil"%><%
%><%@page session="false" %>
<cq:setContentBundle />
<% 
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
    
    out.println("Double Click to Edit Product Showcase Heading Component");
}
String internalLink = "";
String validLink = "";
List productImageList = HeroImageUtil.getShowcaseImage(currentPage);
log.info("list of images :"+productImageList);
if (properties.get("linkUrl") != null) {
    internalLink = properties.get("linkUrl").toString();
    validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);}
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("validLink",validLink);
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
pageContext.setAttribute("prodImages",productImageList);
if (properties.get("newwindow") != null) {
pageContext.setAttribute("openinnewwindow",properties.get("newwindow").toString());
}
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
       <div id="main" role="main">
                   <div id="product-showcase" class="products family">
               
<c:if test="${properties.heroimageReference ne '' && properties.picture2 ne '' && properties.picture3 ne '' && properties.picture4 ne '' && properties.picture5 ne '' && properties.picture1 ne '' &&  properties.linkUrl ne '' && properties.linkCopy ne '' && properties.headingcopy ne ''}">
                    <c:set var="window" value="_blank" />
                    <c:if test="${openinnewwindow eq 'no'}">
                      <c:set var="window" value="" />
                    </c:if> 
                    <c:if test="${openinnewwindow eq null}">
                      <c:set var="window" value="" />
                    </c:if>
                    <h1><cq:text property="title" default="" escapeXml="false"/></h1>    
                       <div class="hero">
                       <c:choose>
                             <c:when test="${not empty prodImages }">
                               <div id="prod_2" class="hero">
           <div data-count="1" class="carousel">
                <ul class="carousel-content">
                  <c:forEach var="prodImage" items="${prodImages}" > 
                   <li>
                       <img src="<c:out value="${prodImage}"/>" alt="${properties.alttext}"/>
                       <div class="pagination-container"><div class="pagination"></div></div>
                        <div class="" style="height:20px">
                        </div>
                   </li>
                </c:forEach>
             </ul>
           </div>
           </div>
                                <div class="content" >
                                
                                    <h3><c:out value="${properties.headingcopy}" escapeXml="false"/></h3>
                                    <cq:text property="bodytext" default="" />
                                 
                                  <c:if test="${properties.linkCopy ne '' && not empty properties.linkCopy }">
                                    <a class='grad' href="${validLink}" target="${window}">
                                        <c:out value="${properties.linkCopy}" escapeXml="false" />
                                     </a>
                                   </c:if>
                                   <c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
                                         <c:if test="${properties.displaysocial eq 'yes'}">
                                            <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
                                         </c:if>             
                                    </c:if> 
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="content" style="margin: 0px 10px 5px">
                                
                                    <h3><c:out value="${properties.headingcopy}" escapeXml="false"/></h3>
                                    <cq:text property="bodytext" default="" />
                               
                                  <c:if test="${properties.linkCopy ne '' && not empty properties.linkCopy }">
                                    <a class='grad' href="${validLink}" target="${window}">
                                        <c:out value="${properties.linkCopy}" escapeXml="false" />
                                     </a>
                                    </c:if>
                                    <c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
                                         <c:if test="${properties.displaysocial eq 'yes'}">
                                            <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
                                         </c:if>             
                                    </c:if> 
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>  
        
</c:if>

       <div class="sections">
            <div class="section">
                <ul class="accordion">
                    <cq:include path="contentParsys" resourceType="foundation/components/parsys"/>
                </ul>
           </div>
        </div> 
  </div>

  <cq:include path="disclaimer" resourceType="intelmobile/components/content/disclaimer"/>

</div>
</div>
</script>     

<%
        if (WCMMode.fromRequest(request) == WCMMode.EDIT || WCMMode.fromRequest(request) == WCMMode.PREVIEW) {
%>
        <script> 
            //alert("called");
            
            $(document).ready(function(){
                setTimeout('heroCaroAlign()',100);
                
            }); 
            function heroCaroAlign()
            {
                //alert($(".hero .carousel .carousel-content li").html());
                $(".hero .carousel .carousel-content li").attr("style","width:304px");
            }
        </script>
  <%
}
%>