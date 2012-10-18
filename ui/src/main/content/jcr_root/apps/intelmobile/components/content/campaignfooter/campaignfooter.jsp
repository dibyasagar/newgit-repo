<%--

  Campaign Header component.

  NA

--%><%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
String internalLink = "";
String validLink = "";
if (properties.get("linkUrl") != null) {
internalLink = properties.get("linkUrl").toString();
validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);}
pageContext.setAttribute("validLink",validLink);

%>

		<section class="slide">
				<div class="slide-z">
				<div class="item">
				<article class="inside clear">

					<div class="ultra"></div>

					<div class="head">
						<h2><c:out value="${properties.sectiontitle}" escapeXml="false"/></h2>
					</div>

					<div class="laptop">
						<img src="<c:out value="${properties.imagePath}"/>" alt="${properties.alttext}" title="${properties.alttext}" class="laptop"/>
					</div>
					
					 <c:if test="${validLink ne '' && not empty validLink}">
        	            <c:set var="window" value="" />
				        <c:if test="${properties.newwindow eq 'yes'}">
                           <c:set var="window" value="_blank" />
                        </c:if>
        		    <div class="shop">
        		        <a class="ui-link" href="${validLink}" title="<c:out value="${properties.buttontext}" escapeXml="false"/>" target="${window}">
                        <span><c:out value="${properties.buttontext}" escapeXml="false"/></span></a>
        		    </div>
				
        	      </c:if> 

					<div class="spacer"></div>
					<div class="spacer"></div>

					<div class="legal">
						<c:out value="${properties.legal}" escapeXml="false"/>
					</div>

				</article>
				</div>
				</div>
			</section>