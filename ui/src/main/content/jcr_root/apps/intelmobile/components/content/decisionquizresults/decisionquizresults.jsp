<%@include file="/libs/foundation/global.jsp"%><%@page import="com.intel.mobile.util.IntelUtil"%><%
%><%@page session="false" %>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName());
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
 <h1><c:out value="${properties.heading}" escapeXml="false"/></h1>
            <div class="hero">
                <img src = "${properties.heroImageFileReference}" />
                <div class="content">
                  <h3><c:out value="${properties.subHeading}" escapeXml="false"/></h3>
                    <div class="table-list">	
                        <img class="table-cell" src = "${properties.processorImageFileReference}" />
                        <div class="table-cell">
                        	<p><div class="rte_text"><c:out value="${properties.recommendation}" escapeXml="false"/></div></p>
                        </div>
                    </div>                  
                    <a href="${properties.linkPath}.html" class="grad"><c:out value="${properties.linkCopy}" escapeXml="false"/></a> 
                </div>
            </div>
      </div>