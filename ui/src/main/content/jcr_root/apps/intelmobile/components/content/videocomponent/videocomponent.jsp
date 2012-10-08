<!-- 
   Video Component
 -->
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil" %>
<% 
    pageContext.setAttribute("wcmMode",WCMMode.fromRequest(request));
%>
<%
   if(WCMMode.fromRequest(request) == WCMMode.EDIT) {
    %>       
        <br/><p> Right click to edit the Video Component </p>                  
   <%    
   }
    String rootPath = IntelUtil.getRootPath(currentPage);

%> 
               <li>                 
                    
                        <div class="video-container">
							<div class="video-aa" id="${properties.videoid}" ></div>
                       
						</div> 
                
                     <div class="video-desc">
                            <h3><c:out value="${properties.title}" escapeXml="false"/></h3>
                            <p>
                                <c:out value="${properties.subheading}" escapeXml="false"/>
                            </p>
                    </div>  
                </li>

