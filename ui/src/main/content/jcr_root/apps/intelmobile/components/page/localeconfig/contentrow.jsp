<%--

Content Row.

  This file contains the Main Content of the template

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false"%>


     locale config component 
 <div class="page-layout">
          
            <cq:include path="locale" resourceType="intelmobile/components/content/localeconfig"/>
        <h1><font color="black">Header config </font></h1>
            <cq:include path="siteheader" resourceType="intelmobile/components/content/globalheader/config/headerconfig"/>
        <h1><font color="black">Footer Config </font></h1>
            <cq:include path="footer" resourceType="intelmobile/components/content/globalfooter/config/footerconfig"/>
        <h1><font color="black">Search Component Config </font></h1>
            <cq:include path="searchcomp" resourceType="intelmobile/components/content/searchcomponent/config/searchcomponentconfig"/> 
         <h1><font color="black">Processor Specs Config </font></h1>
            <cq:include path="processorspecs" resourceType="intelmobile/components/content/processorspectab/config/processorspecconfig"/>  
         <h1><font color="black">Shop Disclaimer Config </font></h1>
            <cq:include path="shopdisclaimer" resourceType="intelmobile/components/content/shopdisclaimer/config/shopdisclaimerconfig"/>         
         <h1><font color="black">Feature Phone Header Config </font></h1>
            <cq:include path="featureheader" resourceType="intelmobile/components/content/featurephoneheader/config/featureheaderconfig"/>
         <h1><font color="black">Feature Phone Footer Config </font></h1>
            <cq:include path="featurefooter" resourceType="intelmobile/components/content/featurephonefooter/config/featurefooterconfig"/>
            
 </div>