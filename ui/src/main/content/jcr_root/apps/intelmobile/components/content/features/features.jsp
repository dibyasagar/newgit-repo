<%@include file="/libs/foundation/global.jsp"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils,com.intel.mobile.util.IntelUtil"%>
<%
%><%@page session="false" %>


<% String featuretitle[] = null;
   String featuredescription[] = null;
   pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
   pageContext.setAttribute("componentName",component.getName() );

   featuretitle = (String[]) properties.get("title", new String[0]);

   featuredescription =(String[]) properties.get("description", new String[0]);%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<li>
   <h5><a href="#"><cq:text property="contenttitle" /></a></h5>
                          
	<ul class="specs content">    
<% if (featuretitle != null && featuretitle.length > 0) {
           for (int j = 0; j < featuretitle.length; j++) {
                         %>
                       
	            <li>         
	              <strong><%= featuretitle[j].toString()%></strong>
	                  <%= StringEscapeUtils.unescapeHtml(featuredescription[j].toString())%>
	            </li>
	            <%
	                       }
	                    }
	             %>
    </ul>
</li>
</div>