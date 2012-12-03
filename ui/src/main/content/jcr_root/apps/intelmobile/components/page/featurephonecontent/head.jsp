
<%--
  Copyright 1997-2008 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Default head script.

  Draws the HTML head with some default content:
  - initialization of the WCM
  - initialization of the WCM Mobile Emulator and Device Group CSS
  - includes the current design CSS
  - sets the HTML title

  ==============================================================================

--%><%@page import="com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp" %><%
%><%@ page import="com.day.cq.commons.Doctype,
                   com.day.cq.wcm.mobile.api.device.DeviceGroup,
                   org.apache.commons.lang3.StringEscapeUtils,
                    com.day.cq.commons.Externalizer,
                   com.day.cq.wcm.api.WCMMode" %><%
    String xs = Doctype.isXHTML(request) ? "/" : "";
    String favIcon = currentDesign.getPath() + "/favicon.ico";
    if (resourceResolver.getResource(favIcon) == null) {
        favIcon = null;
    }
    String webclipIcon = currentDesign.getPath() + "/webclip.png";
    if (resourceResolver.getResource(webclipIcon) == null) {
        webclipIcon = null;
    }
    String webclipIconPre = currentDesign.getPath() + "/webclip-precomposed.png";
    if (resourceResolver.getResource(webclipIconPre) == null) {
        webclipIconPre = null;
    }
    
    final Externalizer externalizer = resourceResolver.adaptTo(Externalizer.class);
    final String canonicalURL  = externalizer.absoluteLink(slingRequest, "http", currentPage.getPath()) + ".html";
%><head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"<%=xs%>>
    <meta http-equiv="keywords" content="<%= StringEscapeUtils.escapeHtml4(WCMUtils.getKeywords(currentPage)) %>"<%=xs%>>
    <!--<meta name="viewport" content="width=device-width"<%=xs%>>-->
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">    
    <link rel="canonical" href="<%= xssAPI.getValidHref(canonicalURL) %>" />
    <cq:include script="/libs/wcm/core/components/init/init.jsp"/>
     <% 
             if(WCMMode.fromRequest(request) != WCMMode.DISABLED) {
                /*
                Retrieve the current mobile device group from the request in the following order:
                1) group defined by <path>.<groupname-selector>.html
                2) if not found and in author mode, get default device group as defined in the page properties
                   (the first of the mapped groups in the mobile tab)
        
                If a device group is found, use the group's drawHead method to include the device group's associated
                emulator init component (only in author mode) and the device group's rendering CSS.
                */
                final DeviceGroup deviceGroup = slingRequest.adaptTo(DeviceGroup.class);
                if (null != deviceGroup) {
                    deviceGroup.drawHead(pageContext); 
                }
           } 
        %>
    
    <!-- Additional Script Inclusion Start -->
            <!-- Carousel CSS -->
     <cq:include script="headlibs.jsp"/>       
    
        <!-- WAP Integration Start -->
        <script>window.jQuery || document.write('<script src="/etc/designs/intelmobile/appclientlibs/js/libs/jquery/jquery-1.7.2.min.js"><\/script>')</script>
        <script type="text/javascript">
            // Custom WAP -------------------------------------------------------------------------------
            s={}; //init s object
            var wapTrackingEnv = "<%= IntelUtil.getIntelConfigService().getWapTrackingEnv()%>"; //prod = production,  test = all other instances.
            s['cqUrl'] = "<%=currentPage.getPath() %>";
            s['pageType'] = "<%=IntelUtil.getTemplateName(currentPage) %>";
            // END ---------------------------------------------------------------------------------------
        </script>
        <script type="text/javascript" src="http://www.intel.com/content/dam/www/global/wap/wap-mobile.js "></script>
        <!-- WAP Integration End -->
    
     <!-- Additional Script Inclusion End-->
    
    <% if (favIcon != null) { %>
    <link rel="icon" type="image/vnd.microsoft.icon" href="<%= favIcon %>"<%=xs%>>
    <link rel="shortcut icon" type="image/vnd.microsoft.icon" href="<%= favIcon %>"<%=xs%>>
    <% } %>
    <% if (webclipIcon != null) { %>
    <link rel="apple-touch-icon" href="<%= webclipIcon %>"<%=xs%>>
    <% } %>
    <% if (webclipIconPre != null) { %>
    <link rel="apple-touch-icon-precomposed" href="<%= webclipIconPre %>"<%=xs%>>
    <% } %>
<%--    <% currentDesign.writeCssIncludes(pageContext); %> --%>
    <link rel="stylesheet" type="text/css" href="/etc/designs/intelmobile/feature-phone.css" />
    <title><%= currentPage.getTitle() == null ? StringEscapeUtils.escapeHtml4(currentPage.getName()) : StringEscapeUtils.escapeHtml4(currentPage.getTitle()) %></title>
</head>