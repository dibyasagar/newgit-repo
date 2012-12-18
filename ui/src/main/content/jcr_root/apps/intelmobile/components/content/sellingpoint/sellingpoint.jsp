<%--

  Selling Point component.

  NA

--%><%@page import="com.intel.mobile.util.CampaignMenuUtil"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="com.day.cq.wcm.api.WCMMode,javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%>
<%
    
%><%@page session="false"%>
<%
    pageContext.setAttribute("wcmMode", WCMMode.fromRequest(request));
    if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
%>
<br />
<p>Right click to edit the Selling Point Component</p>
<%
    }
    pageContext.setAttribute("subheading",
            properties.get("sub-heading"));
    pageContext.setAttribute("sectionheading",
            properties.get("section-heading"));
    pageContext.setAttribute("sectiondescription",
            properties.get("section-description"));
    pageContext.setAttribute("learnmore", properties.get("learn-more"));
    pageContext
            .setAttribute("locale", IntelUtil.getLocale(currentPage));

    String internalLink = "";
    String validLink = "";
    if (properties.get("linkUrl") != null) {
        internalLink = properties.get("linkUrl").toString();
        validLink = IntelUtil
                .getLinkUrl(internalLink, resourceResolver);
    }
    pageContext.setAttribute("validLink", validLink);
%>

<a class="ui-link"
    name="slide-<%=CampaignMenuUtil.getComponentCellId(resource)%>"></a>

<section class="slide">
    <div class="slide-2">
        <div class="item">
            <article class="inside clear">

                <div class="title clear">
                    
                                <div class="icon">
                        <img src="<c:out value="${properties.imagePath}"/>" class="icon" />
                    </div>
                    <c:choose>
                        <c:when test="${locale eq 'ru_RU'}">
                           <div class="head hed_ru_style">
                                <h1>
                                    <c:out value="${properties.title}" escapeXml="false" />
                                </h1>
                            </div>
                        </c:when>
                        <c:otherwise>
                           <div class="head">
                                <h1>
                                    <c:out value="${properties.title}" escapeXml="false" />
                                </h1>
						    </div>

                        </c:otherwise>
                    </c:choose>
                        
                               
            
                </div>

                <div class="asset clear">

                    <div class="video">
                        <div class="video-container">
                            <div class="video-aa" id="<c:out value="${properties.videoid}"/>"></div>
                        </div>
                    </div>
                    <c:if test="${validLink ne '' && not empty validLink}">
                        <c:set var="window" value="" />
                        <c:if test="${properties.newwindow eq 'yes'}">
                            <c:set var="window" value="_blank" />
                        </c:if>
                        <div class="shop landscape">
                            <a class="ui-link" href="${validLink}"
                                title="<c:out value="${properties.text}" escapeXml="false"/>"
                                target="${window}"
                                data-wap="{&quot;linktype&quot;:&quot;shop&quot;}"> <span><c:out
                                        value="${properties.text}" escapeXml="false" /></span></a>
                        </div>
                    </c:if>

                </div>

                <div class="body">

                    <c:choose>
                        <c:when test="${locale eq 'ru_RU'}">
                            <h3 class="ru_style">
                                
                                    <c:out value="${properties.heading}" escapeXml="false" />
                            </h3>
                            <div class="ru_style">
                                <c:out value="${subheading}" escapeXml="false" />
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3>
                                <c:out value="${properties.heading}" escapeXml="false" />
                            </h3>
                            <p>
                                <c:out value="${subheading}" escapeXml="false" />
                            </p>

                        </c:otherwise>
                    </c:choose>

                    <div class="more">

                        <c:choose>
                            <c:when test="${locale eq 'ru_RU'}">
                                <h4 class="ru_style">
                                    <c:out value="${sectionheading}" escapeXml="false" />
                                </h4>
                                <hr>
                                <div class="ru_style">                                    
                                    <c:out value="${sectiondescription}" escapeXml="false" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <h4>
                                    <c:out value="${sectionheading}" escapeXml="false" />
                                </h4>
                                <hr>

                                <p>
                                    <c:out value="${sectiondescription}" escapeXml="false" />
                                </p>
                            </c:otherwise>
                        </c:choose>
                        <p></p>
                    </div>
                    
                     <c:choose>
                            <c:when test="${locale eq 'ru_RU'}">
                                 <span class="learn learn_ru"
                                    data-more="<c:out value="${learnmore}" escapeXml="false"/>"
                                    data-wap='{"linktype":"learn"}' 
									data-less="<c:out value="${properties.close}" escapeXml="false"/>">
                                    <c:out value="${learnmore}" escapeXml="false" />
                                </span>
                             </c:when>
                            <c:otherwise>
                                 <span class="learn"
                                    data-more="<c:out value="${learnmore}" escapeXml="false"/>"
                                    data-wap='{"linktype":"learn"}' 
									data-less="<c:out value="${properties.close}" escapeXml="false"/>">
                                    <c:out value="${learnmore}" escapeXml="false" />
                                </span>
                            </c:otherwise>
                        </c:choose>
                    
                   
                </div>

                <div class="spacer"></div>

                <c:if test="${validLink ne '' && not empty validLink}">
                    <c:set var="window" value="" />
                    <c:if test="${properties.newwindow eq 'yes'}">
                        <c:set var="window" value="_blank" />
                    </c:if>
                    <div class="shop portrait">
                        <a class="ui-link" href="${validLink}"
                            title="<c:out value="${properties.text}" escapeXml="false"/>"
                            target="${window}"
                            data-wap="{&quot;linktype&quot;:&quot;shop&quot;}"> <span><c:out
                                    value="${properties.text}" escapeXml="false" /></span></a>
                    </div>

                </c:if>


            </article>
        </div>
    </div>
</section>

<section class="space">
    <div class="space-2 vertical">
        <img
            src="<c:out value="${properties.heroImageFileReferencePotrait}" />"
            alt="${properties.alttext}" title="${properties.alttext}"
            class="space space-2" />
    </div>
    <div class="space-2 imgland" style="display: none">
        <img
            src="<c:out value="${properties.heroImageFileReferenceLandscape}"/>"
            alt="${properties.alttext}" title="${properties.alttext}"
            class="space space-2" />
    </div>
</section>