<%--

  Decision Shop Spot component.



--%>

<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@page import="javax.jcr.Node"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
    pageContext.setAttribute("componentName",component.getName());

%>

<c:set var="suffleboardUrl" value="${properties.suffleboardUrl}" />
<c:if test="${fn:startsWith(suffleboardUrl,'/content')}">
    <c:set var="suffleboardUrl" value="${suffleboardUrl}.html" />
</c:if>

<c:set var="metaphoresUrl" value="${properties.metaphoresUrl}" />
<c:if test="${fn:startsWith(metaphoresUrl,'/content')}">
    <c:set var="metaphoresUrl" value="${metaphoresUrl}.html" />
</c:if>

<c:set var="ultrabookUrl" value="${properties.ultrabookUrl}" />
<c:if test="${fn:startsWith(ultrabookUrl,'/content')}">
    <c:set var="ultrabookUrl" value="${ultrabookUrl}.html" />
</c:if>

<link rel="stylesheet"
    href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot.css" />
<link rel="stylesheet"
    href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot_widget.css" />
<div class="page-layout">
    <div id="shopper-app" class="shop-spot-landing">

        <div class="shop-spot-header">
            <h2></h2>
        </div>
        <div class="shop-spot-shelf">
            <div class="shop-spot-products">
                <div class="shop-spot-content-container">
                    <!-- NOTE: this href value needs to be the final of the spec shuffleboard page in prod -->
                    <a href="<c:out value="${suffleboardUrl}" />" data=""
                        class="shop-spot-product">
                        
                        <img
                        src="/etc/designs/intelmobile/img/decision/shuffleboard_small.png" />
                        <div class="img-box">
                            <div class="img-txt"><c:if test="${properties.shuffleboardtitle ne '' && not empty properties.shuffleboardtitle }">
                    <c:out value="${properties.shuffleboardtitle}" escapeXml="false"/> 
              
                </c:if></div>
                            
                        </div>
                        <div class="img-desc">
                               <c:if test="${properties.shuffleboardtext ne '' && not empty properties.shuffleboardtext}">
                    <c:out value="${properties.shuffleboardtext}" escapeXml="false"/> 
              
                </c:if>
                            </div>
                        
                        <!--
                        <div style="width:110px;height:20px;border:1px solid red;background:#ccc;margin-left:-14px;padding:4px;text-align:center;">
                            Shuffle Board
                        </div>
                        -->
                        
                    </a>
                    <!-- NOTE: this href value needs to be the final of the core metaphors page in prod -->
                    <a href="<c:out value="${metaphoresUrl}" />" data=""
                        class="shop-spot-product"> 
                        
                        <img
                        src="/etc/designs/intelmobile/img/decision/core_metaphors_small.png" />
                        <div class="img-box">
                            <div class="img-txt"><c:if test="${properties.metaphoretitle ne '' && not empty properties.metaphoretitle }">
                    <c:out value="${properties.metaphoretitle}" escapeXml="false"/>
              
                </c:if></div>

                        </div>
                            <div class="img-desc">
                               <c:if test="${properties.metaphoretext ne '' && not empty properties.metaphoretext }">
                    <c:out value="${properties.metaphoretext}" escapeXml="false"/>
              
                </c:if>
                            </div>
                        
                        
                    </a>
                    <!-- NOTE: this href value needs to be the final of the meet ultrabook page in prod -->
                    <a href="<c:out value="${ultrabookUrl}" />" data=""
                        class="shop-spot-product"> 
                        
                        <img
                        src="/etc/designs/intelmobile/img/decision/ultrabook_small.png" />
                        <div class="img-box">
                            
                            <div class="img-txt"><c:if test="${properties.ultrabooktitle ne '' && not empty properties.ultrabooktitle }">
                    <c:out value="${properties.ultrabooktitle}" escapeXml="false"/>
              
                </c:if></div>
                            
                        </div>
                        <div class="img-desc">
                                <c:if test="${properties.ultrabooktext ne '' && not empty properties.ultrabooktext }">
                    <c:out value="${properties.ultrabooktext}" escapeXml="false"/> 
              
                </c:if>
                        </div>
                        
                    </a>
                </div>
            </div>

        </div>

    </div>
    <!-- end spec  app -->
</div>

<script>
    
    $(document).ready(function(){
    
    $(".img-txt").each(function(index) {
        //alert(index + ': ' + $(this).height());
        
        var ch=$(this).height();
        var ph = $(this).parent().height();
        
    
        var mh = (ph - ch) / 2;
        $(this).css('padding-top', mh);
        
    });
    /*
    var ph=$(".img-box").height();
    
    alert("ph: "+ph);
    var ch=$(".img-txt").height();
    alert("ch: "+ch);
    */
    
});
</script> 