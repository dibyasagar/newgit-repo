<!--  Language Selector Component -->

<!-- 
   This components is place holder for country/language selector component.
   contain parsys container to drag n drop country/language selector component.
   In non-edit mode, this component reads the multiple country/language selector component node 
   and displays the language selector based on the logic.
 -->

<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="com.day.cq.wcm.api.WCMMode,
                 org.apache.sling.api.resource.Resource,
                 com.intel.mobile.util.IntelUtil, 
                 javax.jcr.Node,
                 javax.jcr.NodeIterator, 
                 java.util.*,
                 java.net.URLDecoder,
                 javax.jcr.Value,
                 com.intel.mobile.util.IntelUtil"%>
<%
   String regionHolderPath = currentNode.getPath().toString().trim()+ "/regionHolder";
   String language_Node = "en_US";
   language_Node = IntelUtil.getLocaleWithoutChangingUK(currentPage); 
   request.setAttribute("language_Node",language_Node);
   if(WCMMode.fromRequest(request) != WCMMode.EDIT) {
   Node regionHolderNode = null;
   List<Node> topNodeList =  new ArrayList<Node>();
   List<Node> restOfNodesList = new ArrayList<Node>();
   NodeIterator regionNodeIteraor = null;
   
   pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
   pageContext.setAttribute("componentName",component.getName() );
   Node regionNode = null;
   String countryHomeURL = "";
   String countrydisplaynames[] = null;
   String countryhomepageurls[] = null;
   String locales[] = null;
   Page homePage = null;
   int countryCount=0;
   String localeLanguage="";
   Resource languageSelectorResource;
   String languageURL = "";
  
   /* Logic to check the country / language selector nodes and find the node corresponding 
      to the current languge in process. create to Node list, one with top region and second
      with the rest nodes.
     */
   if(currentNode.hasNodes()){
       languageSelectorResource = resourceResolver.getResource(regionHolderPath);
       regionHolderNode = languageSelectorResource.adaptTo(Node.class);
       regionNodeIteraor = regionHolderNode.getNodes();
       while(regionNodeIteraor.hasNext()){
           regionNode = regionNodeIteraor.nextNode();
           languageSelectorResource = resourceResolver.getResource(regionNode.getPath());
           properties = languageSelectorResource.adaptTo(ValueMap.class); 
           if(regionNode.hasProperty("countries")){
           countryCount = Integer.parseInt(properties.get("countries","0"));
           
           // If only one country under region.
           if (countryCount == 1) {
                 localeLanguage = properties.get("locale").toString().trim();
                 if(localeLanguage.trim().equals(language_Node)){
                       topNodeList.add(regionNode);
                   }
                   else{
                       restOfNodesList.add(regionNode);
                }
            }
            // If only more than one country under region.
            else {
                   locales = new String[countryCount];
                   locales = properties.get("locale",locales);
                   boolean topNode = false;
                   for(String locale : locales ){
                          if(locale.trim().equals(language_Node)){
                           topNodeList.add(regionNode);
                           topNode = true;
                           break;
                       }
                   }
                   if(!topNode) {
                       restOfNodesList.add(regionNode);
                   }
               }  
           }
       }
   }   
  %>
  <% 
  /*
    Proceed if Any region is present.
  */
  //log.info("Topnode list :"+topNodeList);
  //log.info("Rest of nodes :"+restOfNodesList);
   if(topNodeList != null || restOfNodesList!= null){
       String CountryNameParts[];
       String CountryName = "";
    %>
    <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
       <div id="main" role="main">
           <div id="language-selector" class="lang">
                <h1>Select a Country</h1>
                <div class="hd"></div>
                     <div class="bd">
                        <ul>
                        <%
                           // If top node list is not empty                       
                            if(topNodeList!= null){
                              %>
                                <ul>
                              <%    
                               // Process the individual country/language nodes for the top regions.
                                for(Node nodeName : topNodeList){
                                    languageSelectorResource = resourceResolver.getResource(nodeName.getPath());
                                    properties = languageSelectorResource.adaptTo(ValueMap.class); 
                                    countryCount = Integer.parseInt(properties.get("countries", "0"));
                                    countrydisplaynames = new String[countryCount];
                                    countryhomepageurls = new String[countryCount];
                                    locales = new String[countryCount];

                                    if (countryCount == 1) {
                                        countrydisplaynames[0] = properties.get("countrydisplayname", "");
                                        countryhomepageurls[0] = properties.get("countryhomepageurl", "");
                                        locales[0] = properties.get("locale", "");
                                    } else {
                                        countrydisplaynames = properties.get("countrydisplayname", countrydisplaynames);
                                        countryhomepageurls = properties.get("countryhomepageurl",countryhomepageurls);
                                        locales = properties.get("locale",locales);
                                    }

                                     %>
                                    <li class="header"><%=properties.get("regionname")%>: </li>
                                      <%
                                       // logic to display the selected country as first under top region.
                                        for (int j = 0; j < countrydisplaynames.length; j++){ 
                                            CountryNameParts = countrydisplaynames[j].split("\\(");
                                            CountryName = CountryNameParts[0];
                                            CountryName = CountryName.replaceAll("\\s","").toLowerCase();
                                            homePage = pageManager.getPage(countryhomepageurls[j].toString());
                                            localeLanguage = locales[j].toString();
                                           
                                            if(localeLanguage.trim().equals(language_Node)){
                                                if(countryhomepageurls[j].toString().startsWith("/content")){
                                                    languageURL = countryhomepageurls[j].toString() + ".html";
                                                }
                                                else{
                                                    languageURL =countryhomepageurls[j].toString();
                                                }
                                               %> 
                                                  <li class="default1"> <a href="<%=languageURL%>" data-loc=<%=CountryName%> onclick="setLocaleCookies('<%=countrydisplaynames[j].toString()%>','<%=properties.get("regionname")%>','<%=language_Node%>')"><%=countrydisplaynames[j].toString()%></a></li>
                                                <%
                                            }
                                         }
                                       // logic to display the remainaing country list.
                                         for (int j = 0; j < countrydisplaynames.length; j++){ 
                                              CountryNameParts = countrydisplaynames[j].split("\\(");
                                              CountryName = CountryNameParts[0];
                                              CountryName = CountryName.replaceAll("\\s","").toLowerCase();
                                              homePage = pageManager.getPage(countryhomepageurls[j].toString());
                                              localeLanguage = locales[j].toString();
                                              
                                              if(!(localeLanguage.trim().equals(language_Node))){
                                                  if(countryhomepageurls[j].toString().startsWith("/content")){
                                                      languageURL = countryhomepageurls[j].toString() + ".html";
                                                  }
                                                  else{
                                                      languageURL =countryhomepageurls[j].toString();
                                                  }
                                                  %> 
                                                    <li> <a href="<%=languageURL%>" data-loc="<%=CountryName%>" onclick="setLocaleCookies('<%=countrydisplaynames[j].toString()%>','<%=properties.get("regionname")%>','<%=language_Node%>')"><%=countrydisplaynames[j].toString()%></a></li>
                                                  <%
                                              }
                                          }
                                   }
                                  %>
                                  </ul>                                                                                             
                                <%
                              }
                           // Process the remaining region node list.
                            if(restOfNodesList!= null){
                                %>
                                  <ul>
                                <%    
                                  for(Node nodeName : restOfNodesList){
                                      languageSelectorResource = resourceResolver.getResource(nodeName.getPath());
                                      properties = languageSelectorResource.adaptTo(ValueMap.class); 
                                      countryCount = Integer.parseInt(properties.get("countries", "0"));
                                      countrydisplaynames = new String[countryCount];
                                      countryhomepageurls = new String[countryCount];
    
                                      if (countryCount == 1) {
                                          countrydisplaynames[0] = properties.get("countrydisplayname", "");
                                          countryhomepageurls[0] = properties.get("countryhomepageurl", "");
                                      } else {
                                          countrydisplaynames = properties.get("countrydisplayname", countrydisplaynames);
                                          countryhomepageurls = properties.get("countryhomepageurl",countryhomepageurls);
                                      }
    
                                       %>
                                      <li class="header"><%=properties.get("regionname")%>: </li>
                                        <%
                                          for (int j = 0; j < countrydisplaynames.length; j++){ 
                                              CountryNameParts = countrydisplaynames[j].split("\\(");
                                              CountryName = CountryNameParts[0];
                                              CountryName = CountryName.replaceAll("\\s","").toLowerCase();
                                              if(countryhomepageurls[j].toString().startsWith("/content")){
                                                  languageURL = countryhomepageurls[j].toString() + ".html";
                                              }
                                              else{
                                                  languageURL =countryhomepageurls[j].toString();
                                              }
                                          %> 
                                                <li> <a href="<%=languageURL%>" data-loc="<%=CountryName%>" onclick="setLocaleCookies('<%=countrydisplaynames[j].toString()%>',<%=properties.get("regionname")%>),'<%=language_Node%>'"><%=countrydisplaynames[j].toString()%></a></li>
                                              <%
                                          }
                                     }
                                    %>
                                </ul>                                                                                             
                              <%
                            }
                        %>                       
                       </ul>
                    </div>
                <div class="ft"></div>
            </div>
       </div>
       </div>
     <%    
   }

%>


<script type="text/javascript">
   // function to set the cookie.
   // sets country, region and locale cookies.
   function setLocaleCookies(countrySelected,regionSelected,localeCode){
            cookie_country = "country_selected";
            cookie_region = "region_selected" ;
            cookie_locale = "locale_selected";

            document.cookie=cookie_country+"="+ escape(countrySelected)+"; expires=Monday, 04-Apr-2020 05:00:00 GMT";
            document.cookie=cookie_region+"="+escape(regionSelected)+"; expires=Monday, 04-Apr-2020 05:00:00 GMT";
            document.cookie=cookie_locale+"="+escape(localeCode)+"; expires=Monday, 04-Apr-2020 05:00:00 GMT";  
            return true;  
    }

</script>
<%
  // Display the message only in Edit mode and if no county/language compnent is present
  if(WCMMode.fromRequest(request) == WCMMode.EDIT ) {
    %>       
     
   <%       
    }
}
%>
<%
 /*
   Parsys in displayed in Edit mode and the content in edit mode in renderd from
   country/language slector. This is to provide proper edit option to the author
   for individual country/language selector in Edit mode.
 */
  if(WCMMode.fromRequest(request) == WCMMode.EDIT) {
    %>       
        <div id="main" role="main">
           <div id="language-selector" class="lang">
                <h2>Select a Country</h2>
                <div class="hd"></div>
                     <div class="bd">
                          
                            <cq:include path="regionHolder" resourceType="foundation/components/parsys"/> 

                     </div>
           </div>
        </div>                      
   <%       
    }
%>
 