<%--

  Article Landing Hero component.



--%><%@page import="java.util.logging.Logger,com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>

<%@include file="/libs/foundation/global.jsp"%>
<%
%><%@page session="false"%>

<%
int heroCount = Integer.parseInt(properties.get("articlelandinghero","0"));
String  heroImage[] = new String[heroCount];
String  title[] = new String[heroCount];
String  linkCopy[] = new String[heroCount];
String  linkUrl[] = new String[heroCount];
linkUrl = (String[]) properties.get("linkurl", new String[0]);

pageContext.setAttribute("heroImageArray",properties.get("heroimage",heroImage));
pageContext.setAttribute("titleArray",properties.get("title",title));
pageContext.setAttribute("linkCopyArray",properties.get("linkcopy",linkCopy));
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );

  for (int i = 0; i < linkUrl.length; i++) {
        if (linkUrl[i].toString().startsWith("/content")) {
        	linkUrl[i] = linkUrl[i].toString().concat(
                    ".html");
        }
   }
  pageContext.setAttribute("linkUrlArray",linkUrl);
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div class="hero">
	<c:choose>
		<c:when	test="${properties.articlelandinghero ne '' && not empty properties.articlelandinghero }">
		
			<div data-count="1" class="carousel">
				
				<ul class="carousel-content">

					<c:forEach var="element" items="${heroImageArray}" varStatus="row">
						<li style="width: 1264px;">
						<img
							src="<c:out value="${element}" />"
							alt="<c:out value="${titleArray[row.index]}" escapeXml="false"/>"/>
					 
							<div class="pagination-container">
								<div class="pagination">
									<span class="active"></span><span class=""></span>
								</div>
							</div>
							<div class="content">
								<h3>
									<c:out value="${titleArray[row.index]}" escapeXml="false"/>
								</h3>
								<a href="<c:out value="${linkUrlArray[row.index]}" />"><c:out
										value="${linkCopyArray[row.index]}" escapeXml="false"/> </a>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<div style="color:#FFFFFF">Double Click to Edit Article Landing Hero Component</div>
		</c:otherwise>
	</c:choose>
</div>
</div>
