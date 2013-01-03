<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%@page import="com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode"%>
<%
String rootPath = IntelUtil.getRootPath(currentPage);
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
%>

<c:choose>
<c:when test="${ not empty properties.contenttitle &&  not empty properties.contenttext && not empty properties.videopath }">
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
	<li>
	    <div class="videoplayer content">
               <div class="video-a" >
                             <a href="<%=rootPath%>/video.v.html#v=${properties.videoid}"> 
                                <img
                                    src="${properties.heroimage}"
                                    alt="${properties.contenttitle}"></img></a>
           
                          </div>
	            <h3><c:out value="${properties.contenttitle}" escapeXml="false"/></h3>
	            <p>
	              <div class="rte_text">
	                 <c:out value="${properties.contenttext}" escapeXml="false"/>
	              </div>
	            </p>
	            <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>	
	    </div>
	</li>
</div>
</c:when>
<c:otherwise>
<c:if test="${editmode eq 'true'}">
<div>Double Click to Edit Articledetails Podcast Component</div>
</c:if>
</c:otherwise>
</c:choose>