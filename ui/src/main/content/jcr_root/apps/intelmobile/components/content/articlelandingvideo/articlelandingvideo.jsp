<%--
  Article landing video component - Carousel
--%>

<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
  String rootPath = IntelUtil.getRootPath(currentPage);
%>  
<%
    int videoCount = Integer.parseInt(properties.get(
            "articlelandingvideo", "0"));
    String heroImage[] = new String[videoCount];
    String title[] = new String[videoCount];
    String subHeading[] = new String[videoCount];
    String videoId[] = new String[videoCount];

    pageContext.setAttribute("videoIdArray",
            properties.get("videoid", videoId));
    pageContext.setAttribute("heroImageArray",
            properties.get("heroimage", heroImage));
    pageContext.setAttribute("titleArray",
            properties.get("title", title));
    pageContext.setAttribute("subHeadingArray",
            properties.get("subheading", subHeading));
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName() );
    pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>

<c:choose>
    <c:when
        test="${properties.articlelandingvideo ne '' && not empty properties.articlelandingvideo }">
        <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
        <div data-count="1" class="carousel">
            <ul class="carousel-content">
            <c:forEach var="element" items="${heroImageArray}" varStatus="row">
                <li style="width: 1244px;">  

                        <div class="video-container">
                        <div class="video-aa" id="<c:out value="${videoIdArray[row.index]}" />" ></div>
                                            

                     </div> 
               

                     <div class="video-desc">
                            <h3><c:out value="${titleArray[row.index]}" escapeXml="false"/></h3>
                            <p>
                                <c:out value="${subHeadingArray[row.index]}" escapeXml="false"/>
                            </p>
                    </div>  

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
        <br/><br/><div>Double Click to Edit Article Video Component</div>
        </c:if>
    </c:otherwise>
</c:choose>