<%--
   Social media component
--%>

<%@page import="com.day.cq.wcm.api.Page,com.intel.mobile.util.IntelUtil,org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="com.day.cq.wcm.api.WCMMode, com.intel.mobile.util.IntelUtil"%>

<%@include file="/libs/foundation/global.jsp"%>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<%@page session="false"%>
<cq:setContentBundle />
<%  
   String default_language = "en";
   String pageTitle = currentPage.getTitle();
   if(currentPage.getContentResource().adaptTo(Node.class).hasProperty("pageTitle")){
       pageTitle = currentPage.getContentResource().adaptTo(Node.class).getProperty("pageTitle").getString();
   } 
   String pageDesc = currentPage.getDescription() != null ? currentPage.getDescription(): "";
   String pageURL = request.getRequestURL().toString();
   log.info("pageURL===="+pageURL);
   //Logic to find the current language
   String currentLanguage = default_language;
   String pageURI = request.getRequestURI();
   String pathList[] = pageURI.split("/");
   String language_Node = IntelUtil.getLocale(currentPage);
  /*
       String language_Node = "en_US";
       if(pageURI.indexOf(rootPath)!= -1){
           language_Node = pathList[3];
       }
       else{
           language_Node = pathList[0];
       } 
   */
   currentLanguage = language_Node.substring(0,2);
   String rootPath = IntelUtil.getRootPath(currentPage);
   String localeConfigNodePath = rootPath + "/jcr:content/locale";
   Resource localConfigResource = resourceResolver.getResource(localeConfigNodePath);
   properties = localConfigResource.adaptTo(ValueMap.class); 
   String showShare = properties.get("showshare","no"); 
   String showFacebook = properties.get("showfacebook","no"); 
   String showTweeter = properties.get("showtweeter","no");
   request.setAttribute("fb_language",language_Node);
   
   //commenting out to fix the defect #1741392
  /*  pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
   pageContext.setAttribute("componentName",component.getName() ); */
%>
   <script type="text/javascript">
      var fb_language = "<%=language_Node %>";
   </script>
   <%
   if(showFacebook.equalsIgnoreCase("yes") || showTweeter.equalsIgnoreCase("yes") ||
            showShare.equalsIgnoreCase("yes")){
       %>  
       
      <!-- Commenting out to fix the defect #1741392. As it's not a proper component and is included as a script into other components.     -->    
        <!-- <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>"> -->     
       <div id="social-share" class="grad">
                <div class="social-share-align">
                <% if(showShare.equalsIgnoreCase("yes")){   %>

                     <!-- AddThis Button BEGIN -->
                                <span class='st_sharethis_custom' displayText='Share'></span>
                                <!-- AddThis Button END -->
                 <% } %>
                <%  if(showFacebook.equalsIgnoreCase("yes")){%>
                     <span class='st_facebook_hcount' displayText='Facebook'></span>
                <% } 
                 
                String tweetOrg="";    
                           
                if(showTweeter.equalsIgnoreCase("yes")){%>
                    <span class='st_twitter_hcount' 
                          displayText='Tweet' 
                          <%
                          
                          if(pageDesc==null || pageDesc.isEmpty()){
                              tweetOrg = currentPage.getTitle()==null ? StringEscapeUtils.escapeHtml4(currentPage.getName()) : StringEscapeUtils.escapeHtml4(currentPage.getTitle());
                          }
                          else{
                              tweetOrg = pageDesc;
                          }
                          
                          if(tweetOrg!=null && tweetOrg.length()>105 ){
                              tweetOrg=tweetOrg.substring(0,105)+"..";
                          }
                          %>
                          st_title="<%= tweetOrg %>" 
                          st_via="Intel">
                    </span>

                <% }%>
            </div>
            <div style="clear:both"></div>    
                
       </div>
      <!--  </div> -->
   <%
     }
     if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
        //  out.println("Double Click to Edit Social connect Component");
     }

    %>
    

                    