<!--  
T   This will render the content in Edit mode only. This for the proper alignment
    of each country / language selector component.
 -->
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@ page import="com.day.cq.wcm.api.WCMMode,
                 org.apache.sling.api.resource.Resource,
                 javax.jcr.Node, 
                 com.intel.mobile.util.IntelUtil"%>
<%
 if(WCMMode.fromRequest(request) == WCMMode.EDIT ) {
        String CountryNameParts[];
        String CountryName = "";
        String languageURL = "";
	  %>       
	     <br/><p>Right click to edit the country/language selector component</p><br/> 
	  <%       
	      String countrydisplaynames[] = null;
	      String countryhomepageurls[] = null;  
	      int countryCount = Integer.parseInt(properties.get("countries", "0"));
	      countrydisplaynames = new String[countryCount];
	      countryhomepageurls = new String[countryCount];
	      String language_Node = IntelUtil.getLocale(currentPage);
	      pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	      pageContext.setAttribute("componentName",component.getName() );
	      
	      if (countryCount == 1) {
	          countrydisplaynames[0] = properties.get("countrydisplayname", "");
	          countryhomepageurls[0] = properties.get("countryhomepageurl", "");
	      } else {
	          countrydisplaynames = properties.get("countrydisplayname", countrydisplaynames);
	          countryhomepageurls = properties.get("countryhomepageurl",countryhomepageurls);
	      }
          if (countrydisplaynames != null && countrydisplaynames.length > 0){ 
	             %>
	              <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
	             <ul>   
	                <ul>
	                  <li class="header"><%=properties.get("regionname")%>: </li>
	                    <%
	                        for (int j = 0; j < countrydisplaynames.length; j++)
	                         {
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
	                           <li> <a href="<%=languageURL%>" data-loc="<%=CountryName%>" onclick="setLocaleCookies('<%=countrydisplaynames[j].toString()%>','<%=properties.get("regionname")%>','<%=language_Node%>')"><%=countrydisplaynames[j].toString()%></a></li>
	                          <%
	                           }
	                    %>
	                    </ul>
	                </ul>
	                </div>
	                <%
	         }
	    }
  %>
  <script type="text/javascript">
   // function to set the cookie.
   // sets country, region and locale cokkies.
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
