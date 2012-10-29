<%--

  Page Header component.

  Global Page Header Component
  We can add Disclosure text also Print, Go and Email button images can be added

--%>
<%
	
%><%@include file="/libs/foundation/global.jsp"%>
<%
	
%><%@page session="false"%><%@page
	import="com.day.cq.wcm.foundation.Image,java.util.Map,com.day.cq.wcm.api.PageFilter,com.day.cq.wcm.api.Page,java.util.Iterator,java.util.List,
           com.intel.mobile.constants.IntelMobileConstants,com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.HeaderUtil"%>
<cq:setContentBundle />
<%
    String label = "";
	String logoUrl = "";
	String logoImage = "";
	String headUrl = "";
	String homePagePath = "";
	String rootPagePath = "";
	String SearchIconImage = "";
	logoUrl = IntelUtil.getConfigValue(currentPage,"siteheader","logolink", ""); 

	List menulist = HeaderUtil.getHeaderInfo(currentPage,
			resourceResolver);
	Map alterPage = HeaderUtil.getDefaultPage(currentPage);
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName", component.getName());
	pageContext.setAttribute("menulist", menulist);
	pageContext.setAttribute("alterpage", alterPage);
	pageContext.setAttribute("logoUrl", IntelUtil.getLinkUrl(logoUrl,resourceResolver));
%>
<c:set var="label"
	value="<%= IntelUtil.getConfigValue(currentPage,"siteheader","menulabel", "") %>" />
<c:set var="logoImage"
	value="<%= IntelUtil.getConfigValue(currentPage,"siteheader","logoimage", "") %>" />
<c:set var="SearchIconImage"
	value="<%= IntelUtil.getConfigValue(currentPage,"siteheader","searchicon", "") %>" />

<header>
<div class="component"
	data-component="<c:out value="${pageScope.componentName}"/>"
	data-component-id="<c:out value="${pageScope.componentId}"/>">
	<div id="header-bar" class="clearfix">
		<div id="logo">
			<a href="${logoUrl}"><img src="${logoImage}" alt="">
			</a>
		</div>
		<ul>
			<li id="search-item"><div class="nub"></div>
				<a href="#search-menu" class="dropdown-trigger"></a>
				
			</li>
			<li id="menu-item"><div class="nub"></div>
				<a class="dropdown-trigger" href="#category-menu">${label}</a>
			</li>
		</ul>
	</div>

	<div id="category-menu" class="dropdown-menu">
		<ul>
				<c:choose>
					<c:when test="${fn:length(menulist) gt 0}">
						<c:forEach items="${menulist}" var="titles" varStatus="count">
							<c:forEach items="${titles}" var="title" varStatus="status">
								<c:if test="${status.index == 0 && title.value ne null}">
										<li>
										<a href="${title.value}" id="${title.key}">${title.key}</a>
										</li>
								</c:if>
								<c:choose>
									<c:when test="${status.index == 0 && title.value eq null}">
									<li>
										<span class="select-title">${title.key}</span>
										<select id="${title.key}">
											<option value=""><fmt:message key="subpage.label.select"/> ${title.key}</option>
									</c:when>
									<c:otherwise>
										<c:if test="${status.index gt 0}">
											<option value="${title.value}">${title.key}</option>
										</c:if>
																		
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
							</select>
								</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<c:forEach items="${alterpage}" var="name" varStatus="status">
					 <li>
                         <a href="${name.value}" id="${name.key}">${name.key}</a>
                     </li>
					</c:forEach>
					</c:otherwise>
				
				</c:choose>
			</ul>
    </div>
	<%
		if (WCMMode.fromRequest(request) == WCMMode.DESIGN) {
	%>
	<br /> <br /> <br />

	<%
		}
	%>
	<!-- Search Menu -->
	<div id="search-menu" class="dropdown-menu">
		<cq:include path="searchcomponent"
			resourceType="intelmobile/components/content/searchcomponent" />
	</div>
</div>
</header>
