<%@page session="false"%>
<%@page import="java.util.Iterator,
        com.intel.mobile.constants.IntelMobileConstants,
        com.intel.mobile.util.ComponentsUtil,
        com.intel.mobile.util.IntelUtil" %>
<%@include file="/libs/foundation/global.jsp"%>
<cq:setContentBundle />
<%
  ComponentsUtil.processProductListing(resourceResolver,pageContext, currentPage, properties);
  pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
  pageContext.setAttribute("componentName",component.getName() );
%>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
    <div id="main" role="main">
      <div class="products">
                   <h1><c:out value="${prodListTitle} ${currentPageTitle}" escapeXml="false"/></h1>          
               <div class="bd">
                    <cq:include path="sortfilter" resourceType="intelmobile/components/content/sortfilter" />
                
                      
    <ul class="compare accordion" style="display:block" id="comparebox">
                 <li>
                     <h5 class="closed"><a href="javascript:void(0);"><fmt:message key='productcompare.label.title'/> <span id="compare-widget-count"></span></a></h5>
                     <div class="content">
                         <ul id="compareitemlist">
                         </ul>
                     </div>
                  </li>
                 </ul>  
                       
                    <ul id="prodList" class="items clearfix" style="display:block">
                        <c:forEach var="result" items="${results.results}">
                            <li id="li_${result.productId}" class="newclass">
                                <a href="${result.productUrl}" class="copy">
                                    <div class="tile-compare-text">
                                        <span>Item Added to Compare</span>
                                    </div>
                                    <img id="li_picture_${result.productId}" src="${result.pictureUrl}" alt="${result.productName}">
                                    <div class="tile-info">
                                        <span id="li_name_${result.productId}"><c:out value="${result.productName}" escapeXml="false"/></span>
                                        <c:if test="${result.tagLine ne ''}">
                                            <span><c:out value="${result.tagLine}" escapeXml="false"/></span>
                                        </c:if>
                                        <c:if test="${result.price ne null and result.price ne ''}">
                                            <span id="li_price_${result.productId}"><fmt:message key='productdetails.label.price' /> <fmt:message key='generic.label.currency_symbol'/><c:out value="${result.price}" /></span>
                                        </c:if>
                                    </div>
                                </a>
                                <label id="label_name_${result.productId}" style="display:none"><c:out value="${result.productName}" escapeXml="false"/></label>
                                <label id="label_price_${result.productId}" style="display:none"><c:out value="${result.price}" /></label>
                                <label id="label_picture_${result.productId}" style="display:none"><c:out value="${result.pictureUrl}" /></label>
                                <span style="display:none"><c:out value="${result.productId}" /></span>
                                <span style="display:none"><c:out value="${result.productPath}" /></span>
                                <a href="javascript:void(0)" class="add-compare cta-tile-add" title="compare"> </a>
                            </li>                                                   
                        </c:forEach>
                        <c:if test="${cmsTileText ne '' and results.totalCount>0}">
                            <li id="cmstile" class="cms_pro">
                                <a href="${cmsTileUrl}.html">
                                    <img src="${cmsTileImage}" alt="${cmsTileText}">
                                    <div class="tile-info">
                                        <span><c:out value="${cmsTileText}" escapeXml="false"/></span>
                                    </div>
                                </a>
                            </li>   
                        </c:if>                     
                    </ul>
                    
                    <ul id="prodGrid" class="items tiles clearfix" style="display:none">
                        <c:forEach var="result" items="${results.results}">
                            <li id="li_${result.productId}" class="newclass">
                                <a href="${result.productUrl}" class="copy">
                                    <div class="tile-compare-text">
                                        <span>Item Added to Compare</span>
                                    </div>
                                    <img id="li_picture_${result.productId}" src="${result.pictureUrl}" alt="${result.productName}">
                                    <div class="tile-info">
                                        <span id="li_name_${result.productId}"><c:out value="${result.productName}" escapeXml="false"/></span>
                                        <c:if test="${result.tagLine ne ''}">
                                            <span><c:out value="${result.tagLine}" escapeXml="false"/></span>
                                        </c:if>
                                        <c:if test="${result.price ne null and result.price ne ''}">
                                            <span id="li_price_${result.productId}"><fmt:message key='productdetails.label.price' /> <fmt:message key='generic.label.currency_symbol'/><c:out value="${result.price}" /></span>
                                        </c:if>
                                    </div>
                                </a>
                                <label id="label_name_${result.productId}" style="display:none"><c:out value="${result.productName}" escapeXml="false"/></label>
                                <label id="label_price_${result.productId}" style="display:none"><c:out value="${result.price}" /></label>
                                <label id="label_picture_${result.productId}" style="display:none"><c:out value="${result.pictureUrl}" /></label>
                                <span style="display:none"><c:out value="${result.productId}" /></span>
                                <span style="display:none"><c:out value="${result.productPath}" /></span>
                                <a href="javascript:void(0)" class="add-compare cta-tile-add" title="compare"> </a>
                            </li>                                                   
                        </c:forEach>     
                        <c:if test="${cmsTileText ne '' and results.totalCount>0}">
                            <li id="cmstile" class="cms_pro">
                                <a href="${cmsTileUrl}.html">
                                    <img src="${cmsTileImage}" alt="${cmsTileText}">
                                    <div class="tile-info">
                                        <span><c:out value="${cmsTileText}" escapeXml="false"/></span>
                                    </div>
                                </a>
                            </li>                                                                                   
                        </c:if>                     
                    </ul>
                    
        <div class="ft">
                                <span id="totalResult">
                                    <c:if test="${results.totalCount == 0}"> 
                                        <fmt:message key='productlisting.message.nullresult' />                             
                                    </c:if>
                                    <c:if test="${results.totalCount > 0}">                                     
                                        <c:if test="${results.totalCount < noOfProducts}"> 
                                            <c:out value="${results.totalCount}" />
                                        </c:if>
                                        <c:if test="${results.totalCount >= noOfProducts}"> 
                                            <c:out value="${noOfProducts}" />
                                        </c:if>                                 
                                        <fmt:message key='productlisting.label.resultsof'/> 
                                        <c:out value="${results.totalCount}" />
                                    </c:if>
                                </span>
                                <c:if test="${results.totalCount > noOfProducts}"> 
                                    <a id="fetch-more" href="#" title="<fmt:message key='productlisting.label.loadmoreproducts'/>" ><fmt:message key='productlisting.label.loadmoreproducts'/></a>
                                </c:if>
                                </div>
                    
                    </div>

            </div>

        </div>
            <div id="sortedBlock"></div>
        </div>   
            
<script type="text/javascript">
var COOKIE_NAME_CATEGORY = "intelmobile_pc_category";
var COOKIE_NAME_CATEGORY_TITLE = "intelmobile_pc_category_title";
var COOKIE_NAME_CATEGORY_PATH = "intelmobile_pc_category_path";
var COOKIE_NAME_PRODUCT_PATHS = "intelmobile_productcomparepaths";
var COOKIE_PREFIX_PRODUCT_DETAILS = "intelmobile_pd_";

var  productnameMeta = "${productnameMeta}";
var  priceMeta = "${priceMeta}";
var  pictureurlMeta = "${pictureurlMeta}";
var  taglineMeta = "${taglineMeta}";
var  productpathMeta = "${productpathMeta}";
var  productidMeta = "${productidMeta}";

var alert_product_exists = "<fmt:message key='productcompare.alert.productexists'/>"
var alert_diff_category = "<fmt:message key='productcompare.alert.diffcategory'/>"
var alert_limit_reached = "<fmt:message key='productcompare.alert.limitreached'/>"

var compareButtonLabel = "<fmt:message key='productcompare.button.compare' />";
var removeLabel = "<fmt:message key='productcompare.label.remove' />";
var resetLabel = "<fmt:message key='productcompare.label.reset' />";
var moreItemsLabel = "<fmt:message key='productcompare.label.moreitems' />";
var adduptoLabel = "<fmt:message key='productcompare.label.addupto' />";
var fromLabel = "<fmt:message key='productdetails.label.price' />";
var categoryLabel = "<fmt:message key='sitesearch.label.category' />";
var label_currency = "<fmt:message key='generic.label.currency_symbol'/>";
var label_resultsof = "<fmt:message key='productlisting.label.resultsof'/>"
var label_nullresult = "<fmt:message key='productlisting.message.nullresult' />"

var productCategory = "${currentPageName}"
var productCategoryTitle = "${currentPageTitle}"
var productCategoryPath = "${currentPagePath}"

var productComparePagePath = "${rootPath}/compare.html";
var searchOffset = ${noOfProducts};
var totalOnPage = ${noOfProducts};
var noOfProducts = ${noOfProducts};

function getCookie(cookieName) {
    var allCookies = document.cookie.split('; ');
    for (var i=0;i<allCookies.length;i++) {             
        var cookiePair = allCookies[i];
        var c_name = cookiePair.substring(0,cookiePair.search("="));
        var c_value = cookiePair.substring(cookiePair.search("=")+1); 
        if(c_name==cookieName) {
            return decodeURIComponent(c_value);
        }
    }   
    return "";
}

function setCookie(cookieName, cookieValue) {
    if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){
        document.cookie = cookieName 
        + "=" + cookieValue + ";expires=24*60*60*1000; path=/";
    } else  {
        document.cookie = cookieName 
        + "=" + cookieValue + ";expires=; path=/";
    }
}

function removeCookie(cookieName) {
    document.cookie = cookieName 
    + "=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
}

function getUrlParts(url) {
    var a = document.createElement('a');
    a.href = url;

    return {
        href: a.href,
        host: a.host,
        hostname: a.hostname,
        port: a.port,
        pathname: a.pathname,
        protocol: a.protocol,
        hash: a.hash,
        search: a.search
    };
}

function addProductToCookie(productPath,
        productTitle,
        productImage,
        productPrice,
        productId) {     
    
    var cki_category = getCookie(COOKIE_NAME_CATEGORY);
    if(cki_category != "" && cki_category != productCategory) {
        removeAllProducts();
        cki_category = "";
    }
    
    var cki_productPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);
    var cki_productDetail = "";
    
    productImage = productImage.replace(/&amp;/g,"&");

    var arr_productPaths = cki_productPaths.split("|");
    var arr_length = 0;
    if(arr_productPaths[0]!="") {
        arr_length = arr_productPaths.length;
    }
    if(arr_productPaths == null || arr_length <6) {
        if(cki_category == "" || cki_category == productCategory) {
            if(cki_category == "") {
                
                setCookie(COOKIE_NAME_CATEGORY, productCategory);
                setCookie(COOKIE_NAME_CATEGORY_TITLE, encodeURIComponent(productCategoryTitle));
                setCookie(COOKIE_NAME_CATEGORY_PATH, productCategoryPath);
            }
            if(cki_productPaths.search(productPath) == -1) {
                if(cki_productPaths == "") {
                    cki_productPaths = productPath;
                } else {
                    cki_productPaths = cki_productPaths + "|" + productPath;    
                }
                productTitle = encodeURIComponent(productTitle);
                productImage = encodeURIComponent(productImage);
                productPrice = encodeURIComponent(productPrice);
                productId = encodeURIComponent(productId);
                cki_productDetail = productTitle + "~" + productImage + "~" + productPrice + "~" + productId;
                
                setCookie(COOKIE_NAME_PRODUCT_PATHS, cki_productPaths);
                setCookie(COOKIE_PREFIX_PRODUCT_DETAILS + productPath, cki_productDetail);

            } else {
                alert(alert_product_exists);
                return false;
            }
        } else {
            alert(alert_diff_category);
            return false;
        }                   
    } else {
        alert(alert_limit_reached);
        return false;
    }
    
     $('#li_'+productId+' .tile-compare-text').fadeTo('slow', 0.8, function() {
      // Animation complete.
      setTimeout('fadeAdded("'+productId+'")',700);
      
    });
    repaintCompareBox();
    return true;
}
function fadeAdded(productId)
{
    $('#li_'+productId+' .tile-compare-text').fadeTo('slow', 0);
}

function removeProductFromCookie(productPath) {
    var cki_productPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);
    if(cki_productPaths != "") {
        var productPaths = cki_productPaths.split("|");
        cki_productPaths = "";
        for(i=0;i<productPaths.length;i++) {
            var path = productPaths[i];
            if(productPaths[i] != productPath) {
                if(cki_productPaths == "") {
                    cki_productPaths = productPaths[i];
                } else {
                    cki_productPaths = cki_productPaths + "|" + productPaths[i];
                }                   
            }               
        }
        setCookie(COOKIE_NAME_PRODUCT_PATHS,cki_productPaths);
        removeCookie(COOKIE_PREFIX_PRODUCT_DETAILS +  productPath);
        
        if(cki_productPaths == "") {
            removeCookie(COOKIE_NAME_PRODUCT_PATHS);
            removeCookie(COOKIE_NAME_CATEGORY);
            removeCookie(COOKIE_NAME_CATEGORY_TITLE);
            removeCookie(COOKIE_NAME_CATEGORY_PATH);
        }           
    }   
    repaintCompareBox();    
}

function removeAllProducts() {
    var cki_productPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);
    var arr_productPaths = cki_productPaths.split("|");
    var arr_length = 0;
    if(arr_productPaths[0]!="") {
        arr_length = arr_productPaths.length;
    }   
    for(i=0;i<arr_length;i++) {
        var cki_pd = COOKIE_PREFIX_PRODUCT_DETAILS + arr_productPaths[i];
        var cki_pd_value = getCookie(cki_pd);
        var pdetails = cki_pd_value.split("~");
        var productId = pdetails[3];
        if($("li#li_" + productId).length>0) {
            $("li#li_" + productId).find('a:last').removeClass('cta-tile-remove');  
            $("li#li_" + productId).find('a:last').addClass('cta-tile-add');            
        }       
        removeCookie(cki_pd);
    }
    removeCookie(COOKIE_NAME_PRODUCT_PATHS);
    removeCookie(COOKIE_NAME_CATEGORY);
    removeCookie(COOKIE_NAME_CATEGORY_TITLE);
    removeCookie(COOKIE_NAME_CATEGORY_PATH);
    repaintCompareBox();
}

function repaintCompareBox() {
    var cki_productPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);
    var cki_productCategoryTitle = getCookie(COOKIE_NAME_CATEGORY_TITLE);
    var arr_productPaths = cki_productPaths.split("|");
    var arr_length = 0;
    if(arr_productPaths[0]!="") {
        arr_length = arr_productPaths.length;
    }   
    if(arr_length > 0) {
        var compareBoxHtml = "<li>"+adduptoLabel+ " " + (6-arr_length) + " " + moreItemsLabel + " <a class='reset' href='javascript:removeAllProducts();'>("+resetLabel+")</a></li>";
        
        for(i=0;i<arr_length;i++) {
            var cki_pd_name = COOKIE_PREFIX_PRODUCT_DETAILS + arr_productPaths[i];
            var cki_pd_value = getCookie(cki_pd_name);
            var pdetails = cki_pd_value.split("~");
            compareBoxHtml = compareBoxHtml + "<li>";
            compareBoxHtml = compareBoxHtml + "<img src='"+ pdetails[1] +"' alt='"+ pdetails[0] +"' />";
            compareBoxHtml = compareBoxHtml + "<div>";
            compareBoxHtml = compareBoxHtml + "<h3>" + pdetails[0] + "</h3> " + (pdetails[2]!=""?fromLabel+" "+label_currency+"<span class='price'>" + pdetails[2] + "</span>":"");            
            compareBoxHtml = compareBoxHtml + "<span class='category'>"+categoryLabel+ " "+ cki_productCategoryTitle + "</span>";
            compareBoxHtml = compareBoxHtml + "</div>";
            compareBoxHtml = compareBoxHtml + "<span style='display:none'>"+pdetails[3]+"</span>";
            compareBoxHtml = compareBoxHtml + "<span style='display:none'>"+arr_productPaths[i]+"</span>";
            compareBoxHtml = compareBoxHtml + "<a href='javascript:void(0);' class='cta-tile-remove' title='"+removeLabel+"'></a>";            
        }   
        compareBoxHtml = compareBoxHtml + "<li class='compare-btn'><a class='button primary' href='" + productComparePagePath + "'>"+compareButtonLabel +"</a></li>"; 
        $("#comparebox").show();
        $("#compareitemlist").empty();
        $("#compareitemlist").append(compareBoxHtml);
        $("#compare-widget-count").text(arr_length);    
        $(".cta-tile-remove").bind("click",function () {
            var $self = $(this);
            var pathToRemove = $self.prev().text();
            var productId = $self.prev().prev().text();
            removeProductFromCookie(pathToRemove);
            if($("li#li_" + productId).length>0) {
                $("li#li_" + productId).find('a:last').removeClass('cta-tile-remove');  
                $("li#li_" + productId).find('a:last').addClass('cta-tile-add');    
            }       
        }); 
        $(".reset").bind("click",function () {
            removeAllProducts();
        });                     
    } else {
        $("#comparebox").hide();        
    }
}

function executeFilter() {  
    searchOffset = 0;
    totalOnPage = 0;
    populateResults();
}

function parseFieldFromResponse(response,field) {
    var value = ""; 
    field = "Mobile^" + field;
    var start = response.indexOf(field);    
    if(start != -1) {
        var end = response.indexOf(";",start);
        if(end == -1) {
            response = response.substring(start);
            } else {
            response = response.substring(start,end);
        }
        value = response.substring(response.lastIndexOf("^")+1,response.length);
    }
    return value;
}

function populateResults(event) {
    if(event!=undefined)
   {
  
       event.preventDefault();
   }
    var searchURL = ""; 
    var sortoption = "";
    var totalCount = 0;
    if(document.getElementById("sortoptions") != undefined) {
        sortoption = document.getElementById("sortoptions").value;
    }
        
    if(searchOffset == 0) {
        searchURL = generateFilterURL("",searchOffset,noOfProducts,sortoption);
            } else {
        searchURL = generateFilterURL("",searchOffset,12,sortoption);
    }
    console.log(searchURL);
    
    var cookieProductPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);

     var cmsURL = "${cmsTileUrl}";
     var cmsImage = "${cmsTileImage}";
     var cmsLinkText = "${cmsTileText}";
     
    var populate = function (data) {
        alert(data);
       };
     
    
    /* Initial Div paint with product list */
    $.ajax( {


        url : searchURL,
        type : 'GET',
        dataType : 'jsonp',
        error : function() {
        },

        success : function(data) {
            totalCount = data.TotalCount ;
            var count = 0 ;
            

            var counter=true;
            if(searchOffset == 0) {
               $("#prodList").empty();
               $("#prodGrid").empty();
            } else {
                $(".cms_pro").remove();
                $(".add-compare").unbind();
            }
               
            if(totalCount > 0) {
               $.each(data.ResultSet, function(index){

               count++;
                 
                 var value = this.FieldList[0].FieldValue;
                 var productname = parseFieldFromResponse(value,productnameMeta);                    
                 var price = parseFieldFromResponse(value,priceMeta);
                 var tagLine = parseFieldFromResponse(value,taglineMeta);
                 var productpath = parseFieldFromResponse(value,productpathMeta);
                 var pictureurl = parseFieldFromResponse(value,pictureurlMeta);
                 var productid = productpath.substring(productpath.lastIndexOf("/")+1)               
                 var producturl = getUrlParts(this.FieldList[1].FieldValue).pathname;
                 
                 if(producturl.charAt(0) != "/") {
                     producturl = "/" + producturl;
                 }
                 
                 var compareClass = "";
                 if(cookieProductPaths.search(productpath) > -1) {
                     compareClass="cta-tile-remove";
                 } else {
                     compareClass="cta-tile-add";
                 }

                 var liTag = "<li id='li_"+productid+"' class='newclass'>";
                 
                 var prodList =
                  liTag +
                  '<a href="'+ producturl + '" class="copy">' +
                  "<div class='tile-compare-text'><span>Item Added to Compare</span></div>" + 

                         '<img id="li_picture_'+productid+'" src="'+ pictureurl +'" alt="'+
                         productname + '" />'+
                         '<div class="tile-info">' +
                             '<span id="li_name_'+productid+'">' + productname + '</span>' + 

                             (tagLine!=''?'<span>' + tagLine + '</span>':'') +   
                             
                             (price!=''?'<span id="li_price_'+productid+'">' + fromLabel + " " + label_currency + price + '</span>':'') +
                         '</div>' +
                     '</a>' +
                     '<label id="label_name_'+productid+'" style="display:none">' + productname + '</label>' +
                     '<label id="label_price_'+productid+'" style="display:none">' + price + '</label>' +
                     '<label id="label_picture_'+productid+'" style="display:none">' + pictureurl + '</label>' +
                     '<span style="display:none">' + productid + '</span>' +
                     '<span style="display:none">' + productpath + '</span>' +
                     '<a href="javascript:void(0)" class="add-compare '+compareClass+'" title="compare"> '+
                     '</a>' +
                 '</li>' ;
           

                 $("#prodList").append(prodList);

                 $("#prodGrid").append(prodList);       
                 totalOnPage++;
           });          
           searchOffset = totalOnPage;
           $('#totalResult').html( totalOnPage + " " + label_resultsof + " " + totalCount);   
           $(".add-compare").bind("click",function (evt) {

               var $self = $(this);
                var productPath = $self.prev().text();
            var productId = $self.prev().prev().text();
/*              var productTitle = $("#li_name_" + productId).html();
            var productPrice = $("#li_price_" + productId).html();
            var productImage = $("#li_picture_" + productId).attr('src');
 */
            var productTitle = $("#label_name_" + productId).html();
            var productPrice = $("#label_price_" + productId).html();
            var productImage = $("#label_picture_" + productId).html();

            
               if(getCookie(COOKIE_NAME_PRODUCT_PATHS).indexOf(productPath) == -1) { // add is clicked
                      if(addProductToCookie(productPath, productTitle, productImage, productPrice, productId)) {
                        $("li#li_" + productId).find('a:last').removeClass();   
                        $("li#li_" + productId).find('a:last').addClass('cta-tile-remove');         
                      }
                  } else { // minus is clicked 
                      removeProductFromCookie(productPath);
                        $("li#li_" + productId).find('a:last').removeClass();   
                        $("li#li_" + productId).find('a:last').addClass('cta-tile-add');            
              }
                evt.stopImmediatePropagation();
           });                                             
        } else {
            $('#totalResult').html(label_nullresult);
        }
            if(totalOnPage == totalCount) {
               $('#fetch-more').hide();
            } else {
               $('#fetch-more').show();
            }
            
            if(cmsLinkText != "" && totalCount >0) {
                cmsList =
                    '<li id="cmstile" class="cms_pro">' +
                       '<a href="' + cmsURL + '.html"><img src="' + cmsImage + '" alt="' + cmsLinkText + '" />'+
                       '<div class="tile-info">'+
                       '<span>' + cmsLinkText + '</span>'+
                       '</div>'+
                       '</a>' +
                    '</li>' ;

                    $("#prodList").append(cmsList);
                    $("#prodGrid").append(cmsList);                                                     
            }  
        }
    });     
}



$(document).ready(function(){
    var totalFilters = getTotalFilters();
    
    var cki_category = getCookie(COOKIE_NAME_CATEGORY);
    if(cki_category != "" && cki_category != productCategory) {
        removeAllProducts();        
    }
    
    if(totalFilters != "0") {
        $("#prodGrid").empty();
        $("#prodList").empty();     
        executeFilter();
    } else {
        {
            $("#prodList li").each(function() {
                if(getCookie(COOKIE_NAME_PRODUCT_PATHS).indexOf($(this).find('span:last').html()) != -1){
                    $(this).find('a:last').removeClass('cta-tile-add'); 
                    $(this).find('a:last').addClass('cta-tile-remove'); 
                }         
            });     
        }
        {
            $("#prodGrid li").each(function() {
                if(getCookie(COOKIE_NAME_PRODUCT_PATHS).indexOf($(this).find('span:last').html()) != -1){
                    $(this).find('a:last').removeClass('cta-tile-add'); 
                    $(this).find('a:last').addClass('cta-tile-remove'); 
                }       
            });     
        }
        if(document.getElementById("sortoptions") != undefined) {
            document.getElementById("sortoptions").selectedIndex = 0;
        }
    }
    $('#fetch-more').bind('click',function (event){
        populateResults(event);
    });
    
    $("#btn_toggle").bind("click", function (){
        $("#prodGrid").toggle();
        $("#prodList").toggle();
        changeImage();
    });    

    function changeImage()
    {
        
        if(document.getElementById('prodList').style.display=="none")
        {

            $("#btn_toggle").attr("style","background: url(/etc/designs/intelmobile/img/spr-view-pref-grid.png) no-repeat scroll 4px 0 transparent");
        }
        else if(document.getElementById('prodGrid').style.display=="none")
        {

            $("#btn_toggle").attr("style","background: url(/etc/designs/intelmobile/img/spr-view-pref-list.png) no-repeat scroll 4px 0 transparent");
        }
    }
    $(".add-compare").bind("click",function (evt) {
       var $self = $(this);
        var productPath = $self.prev().text();
    var productId = $self.prev().prev().text();
    var productTitle = $("#label_name_" + productId).html();
    var productPrice = $("#label_price_" + productId).html();
    var productImage = $("#label_picture_" + productId).html();

    
       if(getCookie(COOKIE_NAME_PRODUCT_PATHS).indexOf(productPath) == -1) { // add is clicked
              if(addProductToCookie(productPath, productTitle, productImage, productPrice, productId)) {
              //$(target).removeClass('cta-tile-add').addClass('cta-tile-remove');
                //$("li#li_"+productId+" .add-compare").removeClass('cta-tile-add').addClass('cta-tile-remove');
                $("li#li_" + productId).find('a:last').removeClass('cta-tile-add'); 
                $("li#li_" + productId).find('a:last').addClass('cta-tile-remove');         
              }
          } else { // minus is clicked 
              removeProductFromCookie(productPath);
            
            $("li#li_" + productId).find('a:last').removeClass('cta-tile-remove');  
            $("li#li_" + productId).find('a:last').addClass('cta-tile-add');            
      }
       // evt.stopImmediatePropagation();
        
   });                                             
    
});

repaintCompareBox();
</script>