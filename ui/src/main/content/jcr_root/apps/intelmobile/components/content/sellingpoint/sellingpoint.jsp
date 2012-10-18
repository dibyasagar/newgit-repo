<%--

  Selling Point component.

  NA

--%><%@page import="com.intel.mobile.util.CampaignMenuUtil"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="com.day.cq.wcm.api.WCMMode,javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("subheading",properties.get("sub-heading"));
pageContext.setAttribute("sectionheading",properties.get("section-heading"));
pageContext.setAttribute("sectiondescription",properties.get("section-description"));
pageContext.setAttribute("learnmore",properties.get("learn-more"));

String internalLink = "";
String validLink = "";
if (properties.get("linkUrl") != null) {
internalLink = properties.get("linkUrl").toString();
validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);}
pageContext.setAttribute("validLink",validLink);
%>

<a class="ui-link" name="slide-<%=CampaignMenuUtil.getComponentCellId(resource)%>"></a>

            <section class="slide">
                <div class="slide-2">
                <div class="item">
                <article class="inside clear">

                    <div class="title clear">

                        <div class="icon">
                            <img src="<c:out value="${properties.imagePath}"/>" class="icon"/>
                        </div>

                        <div class="head">
                            <h1><c:out value="${properties.title}" escapeXml="false"/></h1>
                        </div>

                    </div>

                    <div class="asset clear">

                        <div class="video">
                            <div class="video-container">
                                <div class="video-aa" id="<c:out value="${properties.videoid}"/>" ></div>
                            </div> 
                        </div>

                        <div class="shop landscape">
                            <a class="ui-link" href="${validLink}" title="Shop Ultrabook™" target="_blank">
                            <span><c:out value="${properties.text}" escapeXml="false"/></span></a>
                        </div>

                    </div>

                    <div class="body">

                        <h3>
                             <c:out value="${properties.heading}" escapeXml="false"/>
                        </h3>
                        <p>
                        <c:out value="${subheading}" escapeXml="false"/>
                        </p>

                        <div class="more">

                            <h4>
                            <c:out value="${sectionheading}" escapeXml="false"/>
                            </h4>

                            <hr>

                            <p>
                            <c:out value="${sectiondescription}" escapeXml="false"/>
                            </p><p>

                        </p></div>

                        <span class="learn" data-more="<c:out value="${learnmore}" escapeXml="false"/>" data-less="<c:out value="${properties.close}" escapeXml="false"/>">
                        <c:out value="${learnmore}" escapeXml="false"/>
                        </span>

                    </div>

                    <div class="spacer"></div>

                  <c:if test="${validLink ne '' && not empty validLink}">
        	            <c:set var="window" value="" />
				        <c:if test="${properties.newwindow eq 'yes'}">
                           <c:set var="window" value="_blank" />
                        </c:if>
        		    <div class="shop portrait">
        		        <a class="ui-link" href="${validLink}" title="Shop Ultrabook™" target="${window}">
                        <span><c:out value="${properties.text}" escapeXml="false"/></span></a>
        		    </div>
				
        	      </c:if>
                        

                </article>
                </div>
                </div>
            </section>

            <section class="space">
                <div class="space-2 vertical">
                    <img src="<c:out value="${properties.heroImageFileReferencePotrait}" />"  alt="${properties.alttext}" title="${properties.alttext}" class="space space-2"/>
                </div>
				 <div class="space-2 imgland" style="display:none">
                    <img src="<c:out value="${properties.heroImageFileReferenceLandscape}"/>"  alt="${properties.alttext}" title="${properties.alttext}" class="space space-2"/>
                </div>
            </section>