<%--
  Content Row.

  This file contains the Main Content of the template.

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false"%>
<%@page import="com.intel.mobile.util.ProductUtil, 
				com.intel.mobile.util.IntelUtil,
                java.util.Map, 
                java.util.HashMap,
                java.util.Map.Entry,
                java.util.List, 
                java.util.ArrayList,
                javax.jcr.Node" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
  String rootPath = resourceResolver.map(IntelUtil.getRootPath(currentPage));
  pageContext.setAttribute("locale", IntelUtil.getLocaleWithoutChangingUK(currentPage));
  pageContext.setAttribute("rootpath", rootPath);
%>
                
<cq:setContentBundle />

<div id="main" role="main">
            <div id="compare">
            </div>
        </div>
         <cq:include path="disclaimer" resourceType="intelmobile/components/content/disclaimer"/>


            <!-- Product compare End -->
           
<script type="text/javascript">
var COOKIE_NAME_PRODUCT_PATHS = "intelmobile_productcomparepaths";
var COOKIE_NAME_CATEGORY = "intelmobile_pc_category";
var COOKIE_NAME_CATEGORY_TITLE = "intelmobile_pc_category_title";
var COOKIE_NAME_CATEGORY_PATH = "intelmobile_pc_category_path";
var COOKIE_NAME_LAST_CATEGORY = "intelmobile_pc_last_category";
var COOKIE_NAME_LAST_CATEGORY_TITLE = "intelmobile_pc_last_category_title";
var COOKIE_NAME_LAST_CATEGORY_PATH = "intelmobile_pc_last_category_path";
var COOKIE_PREFIX_PRODUCT_DETAILS = "intelmobile_pd_";
var NA_VALUE = "N/A";

var localeValue = "${locale}";
var rootpath = "${rootpath}"

var label_currency = "<fmt:message key='generic.label.currency_symbol'/>";
var labelCompareTitle = "<fmt:message key='productcompare.label.title' />";

var categoryValue = "";
var categoryTitle = "";
var categoryPath = "";

var lastCategoryValue = "";
var lastCategoryTitle = "";
var lastCategoryPath = "";

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
	} else	{
		document.cookie = cookieName 
		+ "=" + cookieValue + ";expires=; path=/";
	}
}

function removeCookie(cookieName) {
	document.cookie = cookieName 
	+ "=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
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
		setCookie(COOKIE_NAME_PRODUCT_PATHS, cki_productPaths);
		removeCookie(COOKIE_PREFIX_PRODUCT_DETAILS + productPath);
        
        if(cki_productPaths == "") {
			var c_value = getCookie(COOKIE_NAME_CATEGORY);
			var c_title = getCookie(COOKIE_NAME_CATEGORY_TITLE);
			var c_path = getCookie(COOKIE_NAME_CATEGORY_PATH);
			
			removeCookie(COOKIE_NAME_CATEGORY);
			removeCookie(COOKIE_NAME_CATEGORY_TITLE);
			removeCookie(COOKIE_NAME_CATEGORY_PATH);
			removeCookie(COOKIE_NAME_PRODUCT_PATHS);
			
			setCookie(COOKIE_NAME_LAST_CATEGORY, c_value);
			setCookie(COOKIE_NAME_LAST_CATEGORY_TITLE, encodeURIComponent(c_title));
			setCookie(COOKIE_NAME_LAST_CATEGORY_PATH, c_path);
        }           
    }   
    //refreshComparison();
    window.location.reload();
}



(function refreshComparison() {

    var productPaths = getCookie(COOKIE_NAME_PRODUCT_PATHS);
    productPaths = productPaths.replace(/\|/g,",");

    categoryValue = getCookie(COOKIE_NAME_CATEGORY);
    categoryTitle = getCookie(COOKIE_NAME_CATEGORY_TITLE);
	categoryPath = getCookie(COOKIE_NAME_CATEGORY_PATH);

	if(categoryValue == "" ) {
		lastCategoryValue = getCookie(COOKIE_NAME_LAST_CATEGORY);
		lastCategoryTitle = getCookie(COOKIE_NAME_LAST_CATEGORY_TITLE);
		lastCategoryPath = getCookie(COOKIE_NAME_LAST_CATEGORY_PATH);
	}

    $.ajax({
        type: "GET",
        url: "/bin/ProductDetails",
        dataType : "json",
        data: {products:productPaths, locale:localeValue, category:categoryValue},     
        error : function(e) {
            alert('error occurred ' + e);
         },
        success: function(msg) {
            //repaintCompareDiv(msg);
            var featuresList = msg.features;
    var productList = msg.products; 
    var titleText = categoryTitle;
       
    var htmlText = "";
			if(categoryValue != "") {
				htmlText+="<h1>"+labelCompareTitle + " " + categoryTitle + " (" + productList.length + ")</h1>";
			} else {
				htmlText+="<h1>"+labelCompareTitle + " " + lastCategoryTitle + " (" + productList.length + ")</h1>";
			}
            
    
			htmlText+="<div class='bd caro-parent'>";
            
            htmlText+="<div class='container'>";
            for(i=0;i<productList.length;i+=2) {
                htmlText+="<div class='sections'>";
                
                htmlText+="<ul class='tiles'>";
                var loopEnd = ((i+1)== productList.length)?i:i+1;
                for(j=i;j<=loopEnd;j++) {
                        htmlText+="<li class='compare-item'>";
                        htmlText+="<a href='" + productList[j].path + ".html'>";
                        htmlText+="<img src='" + productList[j].picture + "' alt='" + productList[j].name + "' />";
                        htmlText+="<div class='tile-info'>";
                        htmlText+="<span>" + productList[j].name + "</span>";
						if(productList[j].bestPrice != "") {
							htmlText+="<span>" + label_currency + productList[j].bestPrice + "</span>";
						}
						htmlText+="</div>";
                        htmlText+="</a>";
                        htmlText+="<span style='display:none'>"+productList[j].path+"</span>";
                        htmlText+="<a href='javascript:void(0)' class='cta-tile-remove' title='Remove'></a>";   
                        htmlText+="</li>";
                }
                if(j==productList.length && j%2==1) {
                	var comparepath = "";
                	if(categoryValue != "") {
                		comparepath = categoryPath + ".html"
                	} else {
						if(lastCategoryValue != "") {
							comparepath = lastCategoryPath + ".html"
						} else {
							comparepath = rootpath + ".html";
						}
                		
                	}
                    htmlText+="<li class='compare-item'>";
                    //htmlText+="<a href='"+comparepath+"' class='compareImg'><span class='Comparetxt'>Add a Product to Compare</span></a>";
                    //htmlText+="<img src='/etc/designs/intelmobile/img/img_COMPARE-add-item.jpg' alt='' />";
					
                    //htmlText+="</a>";   
					htmlText+="<a href='"+comparepath+"'>";
					htmlText+="<img src='/etc/designs/intelmobile/img/img_COMPARE-add-item.jpg' alt='' />";
					htmlText+="<span class='Comparetxt'><fmt:message key='productcompare.label.add' /></span></a>";  
                    htmlText+="</li>";
                }
                htmlText+="</ul>";
				htmlText+="<div class='pagination'>";
				//htmlText+="<span></span>";
				//htmlText+="<span></span>";
				htmlText+="</div>"
                htmlText+="<table>";
                for(var key in featuresList) {
                    htmlText+="<tr>";
                    htmlText+="<th colspan='2'>" + featuresList[key] + "</th>";
                    htmlText+="</tr>";
                    htmlText+="<tr>";
                    for(j=i;j<=loopEnd;j++) {
                        var featureValue = NA_VALUE;
                        if(productList[j][key] != undefined) {
                            featureValue = productList[j][key];
                        }
                        htmlText+="<td>" + featureValue + "</td>";                          
                    }
                    htmlText+="</tr>";
                }
                htmlText+="</table>";
                htmlText+="</div>";                     
            }
            if(productList.length<6 && productList.length%2==0) {
				var comparepath = "";
				if(categoryValue != "") {
					comparepath = categoryPath + ".html"
				} else {
					if(lastCategoryValue != "") {
						comparepath = lastCategoryPath + ".html"
					} else {
						comparepath = rootpath + ".html";
					}
					
				}
                htmlText+="<div class='sections'>";
                htmlText+="<ul class='tiles'>";
                htmlText+="<li class='compare-item'>";
                //htmlText+="<a href='"+comparepath+"'>";
                //htmlText+="<img src='/etc/designs/intelmobile/img/img_COMPARE-add-item.jpg' alt='' />";
               // htmlText+="</a>";   
				htmlText+="<a href='"+comparepath+"'>";
				htmlText+="<img src='/etc/designs/intelmobile/img/img_COMPARE-add-item.jpg' alt='' />";
				htmlText+="<span class='Comparetxt'><fmt:message key='productcompare.label.add' /></span></a>"; 
                htmlText+="</li>";
                htmlText+="</ul>"; 
				htmlText+="<div class='pagination'>";
				//htmlText+="<span></span>";
				//htmlText+="<span></span>";
				htmlText+="</div>";
                htmlText+="</div>";                 
            }
            htmlText+="</div>"; 
            htmlText+="</div>";  
            $('#compare').empty();
            $('#compare').append(htmlText); 
            $(".cta-tile-remove").bind("click",function () {
                var $self = $(this);
                var pathToRemove = $self.prev().text();
                removeProductFromCookie(pathToRemove);
            }); 
        },
        async:   false
    }); 
})();


</script> 

