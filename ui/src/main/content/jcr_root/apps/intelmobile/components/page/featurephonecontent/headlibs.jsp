<%--
  Copyright 1997-2010 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Includes the scripts and css to be included in the head tag

  ==============================================================================

--%><%@ page session="false" %>
<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="/libs/foundation/global.jsp" %>
<%if(WCMMode.fromRequest(request) == WCMMode.EDIT || WCMMode.fromRequest(request) == WCMMode.DESIGN){%>
    <cq:includeClientLib categories="intel.widgets"/>
<%}%>
<%-- <cq:includeClientLib categories="intel.appclientlib"/> --%>