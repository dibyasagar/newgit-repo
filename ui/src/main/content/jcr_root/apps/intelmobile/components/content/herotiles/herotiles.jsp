<%--

Hero Tiles component.

--%><%@page import="java.util.logging.Logger"%>
<%@page
	import="com.intel.mobile.search.ProductDetails,com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%
	
%><%@page session="false"%>
<%
	if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
		out.println("Double Click to Edit HeroTiles Component");
	}
 String defaultimage = "";
	String layout = "";
	String truncatevalue = "";
	int truncVal = 0;
	String internalLink[] = null;
	String imageLink[] = null;
	String copyText[] = null;
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName());
	
	if (properties.get("truncatechar") != null) {
		truncatevalue = properties.get("truncatechar").toString();
		truncVal = Integer.parseInt(truncatevalue);
	}
	if (properties.get("layouttype") != null) {
		layout = properties.get("layouttype").toString();
	}
	if (properties.get("defaultimage") != null) {
		defaultimage = properties.get("defaultimage").toString();
	}
	internalLink = (String[]) properties.get("internalUrl",
			new String[0]);
	imageLink = (String[]) properties.get("image", new String[0]);
	copyText = (String[]) properties.get("copytext", new String[0]);

	for (int i = 0; i < copyText.length; i++) {
		if (copyText[i].toString().length() > truncVal) {
			copyText[i] = copyText[i].substring(0, truncVal).concat(
					"...");
		}

	}
%>
<c:set var="layout1class" value="span" />
<c:set var="layout2class" value="span2" />
<c:set var="layout3class" value="span4" />
<c:set var="defaultimage"
	value="<%= defaultimage%>" />
<c:set var="layouttype" value="<%=layout %>" />
<c:set var="internalLink" value="<%=internalLink %>" />
<c:set var="imageLink" value="<%=imageLink %>" />
<c:set var="copyText" value="<%=copyText %>" />

<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<nav>
<ul class="tiles clearfix">
	<c:if test="${fn:length(internalLink) gt 0}">
		<c:forEach items="${internalLink}" var="link" varStatus="status">
			<c:choose>
				<c:when test="${status.count > 1}">
					<li><a href="${link}${'.html'}"> <c:choose>
								<c:when test="${imageLink[status.index] ne ''}">
									<img src="${imageLink[status.index]}"
										alt="${copyText[status.index]}" />
								</c:when>
								<c:otherwise>
									<img src="${defaultimage}" alt="${copyText[status.index]}" />
								</c:otherwise>
							</c:choose>
							<div class="tile-info">
								<span><c:out value="${copyText[status.index]}" escapeXml="false"/></span>
							</div> </a></li>
				</c:when>
				<c:otherwise>
					<c:if test="${status.count == 1}">
						<c:choose>
							<c:when test="${layouttype == 'layout2'}">
								<li class="${layout2class}"><a href="${link}${'.html'}">
										<c:choose>
											<c:when test="${imageLink[status.index] ne ''}">

												<img src="${imageLink[status.index] }"
													alt="${copyText[status.index]}" />
											</c:when>
											<c:otherwise>
												<img src="${defaultimage}" alt="${copyText[status.index]}" />
											</c:otherwise>
										</c:choose>
										<div class="tile-info">
											<span><c:out value="${copyText[status.index]}" escapeXml="false"/></span>
										</div> </a></li>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${layouttype == 'layout3'}">
										<li class="${layout3class}"><a href="${link}${'.html'}">
												<c:choose>
													<c:when test="${imageLink[status.index] ne ''}">
														<img src="${imageLink[status.index] }"
															alt="${copyText[status.index]}" />
													</c:when>
													<c:otherwise>
														<img src="${defaultimage}" alt="${copyText[status.index]}" />
													</c:otherwise>
												</c:choose>
												<div class="tile-info">
													<span><c:out value="${copyText[status.index]}" escapeXml="false"/></span>
												</div> </a></li>
									</c:when>
									<c:otherwise>

										<c:choose>
											<c:when test="${layouttype == 'layout1'}">
												<li class="${layout1class}"><a href="${link}${'.html'}">
														<c:choose>
															<c:when test="${imageLink[status.index] ne ''}">
																<img src="${imageLink[status.index] }"
																	alt="${copyText[status.index]}" />
															</c:when>
															<c:otherwise>
																<img src="${defaultimage}"
																	alt="${copyText[status.index]}" />
															</c:otherwise>
														</c:choose>
														<div class="tile-info">
															<span><c:out value="${copyText[status.index]}" escapeXml="false"/></span>
														</div> </a></li>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:otherwise>
			</c:choose>

		</c:forEach>
		<c:if
			test="${(fn:length(internalLink) % 2 == 0 && layouttype == 'layout2')||(fn:length(internalLink) % 2 == 0 && layouttype == 'layout3')}">
			<li><img src="${defaultimage}" alt="" /></li>
		</c:if>
	</c:if>
</ul>
</nav>
</div>





