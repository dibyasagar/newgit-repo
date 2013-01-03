
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

--%><%@page import="com.intel.mobile.util.IntelUtil,com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp" %><%
%><%@ page import="com.day.cq.commons.Doctype,
                   com.day.cq.wcm.mobile.api.device.DeviceGroup,
                   com.day.cq.commons.Externalizer,
                   org.apache.commons.lang3.StringEscapeUtils" %><%
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
        <meta name="HandheldFriendly" content="True">
        <%--PHONE --%>

        <meta name="mobileoptimized" content="320">
        <meta name="handheldfriendly" content="true">

        <meta name="viewport" content="
                    width=device-width,
                    minimum-scale=1.0,
                    maximum-scale=1.0,
                    initial-scale=1.0,
                    user-scalable=no">
         <%-- APPLE --%>

        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <meta name="format-detection" content="telephone=yes">
        <%-- MSIES --%>

        <meta http-equiv="cleartype" content="on">
         <%-- SHEET --%>
    	<meta name="url" content="<%= xssAPI.getValidHref(canonicalURL) %>" />
	
    <link rel="canonical" href="<%= xssAPI.getValidHref(canonicalURL) %>" />
    <cq:include script="/libs/wcm/core/components/init/init.jsp"/>
    <%
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
    %>
    <%-- Additional Script Inclusion Start --%>
    
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/intel.mobile.css" media="all">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/density.css" media="all">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.v.css" media="all">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.360v.css" media="all and (min-width:321px) and (max-width:360px) and (orientation:portrait)">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.480v.css" media="all and (min-width:361px) and (orientation:portrait)">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.480h.css" media="all and (min-width:360px) and (max-width:480px) and (orientation:landscape)">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.533h.css?v0.850a" media="all and (min-width:481px) and (max-width:533px) and (orientation:landscape)" />
     <%
        if (WCMMode.fromRequest(request) == WCMMode.EDIT||WCMMode.fromRequest(request) == WCMMode.PREVIEW||WCMMode.fromRequest(request) == WCMMode.DESIGN) 
        {
    %>
       <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.h.css" media="all and (max-width:360px) and (orientation:landscape)"> 
    <%
        }
        else
        {
    %>
        <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.h.css" media="all and (min-width:360px) and (orientation:landscape)"> 
    <%
    }
    %>   
    
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.640h.css" media="all and (min-width:481px) and (max-width:640px) and (orientation:landscape)">
    <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/styles.800h.css" media="all and (min-width:641px) and (orientation:landscape)">
      
    <%-- <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/intel.mobile.css" type="text/css" media="screen"> --%>
    <%-- <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/reset.css" type="text/css" media="screen"> --%>
    
    <script src="/etc/designs/intelmobile/appclientlibs/js/ultrabook/vendor/jquery-1.7.2.min.js"></script>
    <script src="/etc/designs/intelmobile/appclientlibs/js/ultrabook/vendor/modernizr-2.5.3.min.js"></script>
    <script src="/etc/designs/intelmobile/appclientlibs/js/ultrabook/jquery/index.js"></script>
        
    
    
   
   <%-- <script src="/etc/designs/intelmobile/appclientlibs/js/ultrabook/vendor/jquery.mobile-1.1.1.min.js"></script> --%>
   
    <%-- Additional Script Inclusion End --%>
    <% currentDesign.writeCssIncludes(pageContext); %>
    <title><%= currentPage.getTitle() == null ? StringEscapeUtils.escapeHtml4(currentPage.getName()) : StringEscapeUtils.escapeHtml4(currentPage.getTitle()) %></title>
    <cq:include script="/apps/intelmobile/components/page/mobilecontentpage/headmeta.jsp"/>
</head>
