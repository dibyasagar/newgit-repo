<%--

  Selling Point component.

  NA

--%><%@page import="com.intel.mobile.util.CampaignMenuUtil"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="com.day.cq.wcm.api.WCMMode,javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
String title = properties.get("title","");
String description = properties.get("description", "");
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
                            <img src="<%=properties.get("imagePath","")%>" class="icon"/>
                        </div>

                        <div class="head">
                            <h1><%=properties.get("title","")%></h1>
                        </div>

                    </div>

                    <div class="asset clear">

                        <div class="video">
                            <div class="video-container">
                                <div class="video-aa" id="<%=properties.get("videoid","")%>" ></div>
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
                        <%=properties.get("sub-heading","")%>
                        </p>

                        <div class="more">

                            <h4>
                            <%=properties.get("section-heading","")%>
                            </h4>

                            <hr>

                            <p>
                            <%=properties.get("section-description","")%>
                            </p><p>

                        </p></div>

                        <span class="learn" data-more="Learn More" data-less="Close">
                        <%=properties.get("learn-more","")%>
                        </span>

                    </div>

                    <div class="spacer"></div>

                    <div class="shop portrait">
                        <a class="ui-link" href="${validLink}" title="Shop Ultrabook™" target="_blank">
                        <span><c:out value="${properties.text}" escapeXml="false"/></span></a>
                    </div>

                </article>
                </div>
                </div>
            </section>

            <section class="space">
                <div class="space-2">
                    <img src="<%=properties.get("heroImageFileReference","")%>" class="space space-2"/>
                </div>
            </section>