<%--

  Page Header component.

  Global Page Header Component
  We can add Disclosure text also Print, Go and Email button images can be added

--%><%@page import="com.intel.mobile.search.ProductDetails,com.intel.mobile.util.PurchaseUtil,com.intel.mobile.util.SimillarProductUtil, java.util.Map, com.intel.mobile.util.ConfigUtil,org.apache.sling.api.resource.Resource, javax.jcr.Node, com.intel.mobile.util.ProductUtil, java.util.List, java.util.Map"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
  String rootPath = resourceResolver.map(IntelUtil.getRootPath(currentPage));
%>
<%@page session="false"%>
<cq:setContentBundle />
<%
     Session session = slingRequest.getResourceResolver().adaptTo(Session.class);
	 String pagepath = currentPage.getPath();
	 Map labels = ConfigUtil.getConfigDetailsValues(resourceResolver,pagepath);
	 List retailerValues = PurchaseUtil.getRetailerInfo(currentPage);
	 List similarProd = SimillarProductUtil.getShopSimilarInfo(currentPage,session);
    log.info("---------similarProd------"+similarProd.size()); 
    log.info("---------retailerValues------"+retailerValues.size());
	String pageTitle = currentPage.getTitle();
	String pageURL = request.getRequestURL().toString();
	
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName() );
	pageContext.setAttribute("retailerValues",retailerValues);
	pageContext.setAttribute("similarProd",similarProd);
	pageContext.setAttribute("labels",labels);
	pageContext.setAttribute("wapData",ProductUtil.getWapData(currentPage)); 
	try {
		Resource res = currentPage.getParent().getContentResource();				
		Node node = res.adaptTo(Node.class);
		pageContext.setAttribute("productCategory", node.getProperty("jcr:title").getString());
		//Map<String, String> features = ProductUtil.getFeatures(resourceResolver, currentPage);
		//pageContext.setAttribute("features", features);
	} catch(Exception e) {
	}
%>
 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">	
<div id="main" role="main">
<c:if test="${properties.addtocompare eq 'show'}">
	<ul class="compare accordion" style="display:block" id="comparebox">
                 <li>
                     <h5 class="closed"><a href="javascript:void(0);"><fmt:message key='productcompare.label.title'/> <span id="compare-widget-count"></span></a></h5>
                     <div class="content">
                         <ul id="compareitemlist">
                         </ul>
                     </div>
                  </li>
                 </ul>	
</c:if>                 

	<div id="product-details">
		<h1><c:out value="${properties.name}" /></h1>
		<div id="prod_2" class="hero">
		<div class="hero-img">
		<img src="${properties.picture}" alt="${properties.name}">
		</div>
		<div class="content">
					<div class="price">
						<fmt:message key="productdetails.label.price"/> <fmt:message key="generic.label.currency_symbol"/> <c:out value="${properties.bestPrice}" /> 
					</div>
					
					<c:if test="${not empty properties.tagline}">
						<h3><c:out value="${properties.tagline}" escapeXml="false"/></h3>
					</c:if>
					
					<p>
						<c:if test="${properties.description ne 'null'}">
							<c:out value="${properties.description}" escapeXml="false"/>
						</c:if>
					</p>
									

				<cq:include path="features" resourceType="intelmobile/components/content/productdetails/productdetailsfeatures" />           
               <div class="grad">
		        <c:choose>
		<c:when	test="${fn:length(retailerValues) gt 0  }">
	<div class="purchase-options">
	                      <c:set var="window" value="_blank" />
						  <c:if test="${properties.newwindow eq 'no'}">
                          <c:set var="window" value="" />
                          </c:if>
		<h4>
			<fmt:message key="productdetailsCMS.label.purchasing_options" />
		</h4>
		<ul class="items">
		<c:choose>
				<c:when test="${fn:length(retailerValues) gt 0 && fn:length(retailerValues) <= 2}">
					<c:forEach items="${retailerValues}" var="retailer" varStatus="rowCounter">
						 <li><img src="<c:out value="${retailer.logo}"/>">
						<span class="price"><c:out value="${labels['currencysymbol']}" /><c:out value="${retailer.price}" /></span>
						
						<a href="<c:out value="${retailer.url}"/>" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${retailer.name}","model":"${wapData.name}","price":"${retailer.price}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${retailer.name}" escapeXml="false"/></a>
						
					    </li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:if test="${fn:length(retailerValues) gt 2}">
					<c:forEach var="retailer" items="${retailerValues}" varStatus="rowCounter">
				<c:choose>
					<c:when test="${rowCounter.count <= 2}">
					     <li>
						   <img src="<c:out value="${retailer.logo}"/>">
						   <span class="price"><c:out value="${labels['currencysymbol']}" /><c:out value="${retailer.price}" /></span>
						   <a href="<c:out value="${retailer.url}"/>" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${retailer.name}","model":"${wapData.name}","price":"${retailer.price}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${retailer.name}" escapeXml="false"/></a>
					     </li>
					</c:when>
					<c:otherwise>
					   <c:choose>
				          <c:when test="${rowCounter.count == 3}">
		                    </ul>
		                       <div class="view-more">
			                     <ul class="items">
			                       <li>
							        <img src="<c:out value="${retailer.logo}"/>">
							        <span class="price"><c:out value="${labels['currencysymbol']}" /><c:out value="${retailer.price}" /></span>
							        <a href="<c:out value="${retailer.url}" />" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${retailer.name}","model":"${wapData.name}","price":"${retailer.price}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${retailer.name}" escapeXml="false"/></a>
						           </li>
				            </c:when>

				    <c:otherwise>
					   <c:choose>
						 <c:when test="${rowCounter.count > 2}">
					       <li>
							<img src="<c:out value="${retailer.logo}"/>">
							<span class="price"><c:out value="${labels['currencysymbol']}" /><c:out value="${retailer.price}" /></span>
							<a href="<c:out value="${retailer.url}" />" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${retailer.name}","model":"${wapData.name}","price":"${retailer.price}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${retailer.name}" escapeXml="false"/></a>
						   </li>	
						  </c:when>
						<c:otherwise>
						</c:otherwise>
					  </c:choose>
				   </c:otherwise>
				</c:choose>

				</c:otherwise>
				</c:choose>

				</c:forEach>
				</c:if>
				</c:otherwise>

				</c:choose>

			</ul>
		</div>
		<c:if test="${fn:length(retailerValues) gt 2}">
			<a class="view-more-control" data-opencopy="See less purchasing options" data-closedcopy="See more purchasing options" href="javascript:void(0)">See more purchasing options</a>
		</c:if>
		</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
		</c:choose>

         <div class="top-border-grad">
						
						<cq:include path="description" resourceType="intelmobile/components/content/externallink"/>
					</div>
					
						<cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>	
					    <c:if test="${properties.addtocompare eq 'show'}">						
							<a class="button primary add-compare grad" href="javascript:void(0)"><fmt:message key="productdetails.label.addtocompare"/></a>
						</c:if>
				</div>
			</div>
		<div class="sections">
		
			<div class="section">
				<ul class="accordion">
					<cq:include path="processorspecs" resourceType="intelmobile/components/content/processorspectab" />
					<cq:include path="comps" resourceType="foundation/components/parsys" />
				</ul>
			</div>
			
			<br />
			<c:if test="${fn:length(similarProd)>0}">
			<div id="similar_products" class="carousel" data-count="2">
			
			      <h3><fmt:message key="productdetails.label.similar_products"/></h3>
                 <ul class="carousel-content">
                        
           <c:forEach var="similarProds" items="${similarProd}" >       
               <li>
               
                      <a href="<c:out value="${similarProds.url}"/>.html">  
                       <img src="<c:out value="${similarProds.picture}"/>" />
                          <div class="tile-info">
		                    <span><c:out value="${similarProds.name}" escapeXml="false"/></span>
		                    <span><c:out value="${labels['currencysymbol']}" /><c:out value="${similarProds.bestPrice}" escapeXml="false"/></span>
		                   </div>
		               </a> 
               </li>
           </c:forEach>
               </ul>
                 <div class="pagination">
    						</div>
     
              </div>
             </c:if>
		</div>
	</div>
	</div>
	<cq:include path="shopdisclaimer" resourceType="intelmobile/components/content/shopdisclaimer"/>
</div>
<script type="text/javascript">
/*
                 var addthis_share_config =
                 {
                     url: "<%=pageURL%>",
                     title: "<%=pageTitle %>",                     
                     //swfurl: "http://www.youtube.com/v/1F7DKyFt5pY&hl=en&fs=1",
                     width: "560",
                     height: "340",
                     screenshot: ""
                 }
                 var addthis_config = {
                	      ui_offset_top: 40,
                	      ui_offset_left: 60
                	} 

                 addthis.button("#btn", addthis_config, addthis_share_config);
*/				 
                 </script>

<script type="text/javascript">
var COOKIE_NAME_CATEGORY = "intelmobile_pc_category";
var COOKIE_NAME_CATEGORY_TITLE = "intelmobile_pc_category_title";
var COOKIE_NAME_CATEGORY_PATH = "intelmobile_pc_category_path";
var COOKIE_NAME_PRODUCT_PATHS = "intelmobile_productcomparepaths";
var COOKIE_PREFIX_PRODUCT_DETAILS = "intelmobile_pd_";

var productCategory = "<%= currentPage.getParent().getName() %>"
var productCategoryTitle = "<%= currentPage.getParent().getTitle() %>"
var productCategoryPath = "<%= resourceResolver.map(currentPage.getParent().getPath()) %>"
var currentProductPath = "<%= currentPage.getPath() %>";
var currentProductTitle = "${properties.name}";
var currentProductImage = "${properties.picture}";
var currentProductPrice = "${properties.bestPrice}";
var currentProductId = "${properties.id}";
var productComparePagePath = "<%=rootPath%>/compare.html";

var compareButtonLabel = "<fmt:message key='productcompare.button.compare' />";
var removeLabel = "<fmt:message key='productcompare.label.remove' />";
var resetLabel = "<fmt:message key='productcompare.label.reset' />";
var moreItemsLabel = "<fmt:message key='productcompare.label.moreitems' />";
var adduptoLabel = "<fmt:message key='productcompare.label.addupto' />";
var fromLabel = "<fmt:message key='productdetails.label.price' />";
var categoryLabel = "<fmt:message key='sitesearch.label.category' />";
var label_currency = "<fmt:message key='generic.label.currency_symbol'/>";

var alert_product_exists = "<fmt:message key='productcompare.alert.productexists'/>"
var alert_diff_category = "<fmt:message key='productcompare.alert.diffcategory'/>"
var alert_limit_reached = "<fmt:message key='productcompare.alert.limitreached'/>"




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
				setCookie(COOKIE_NAME_CATEGORY,productCategory);
				setCookie(COOKIE_NAME_CATEGORY_TITLE,encodeURIComponent(productCategoryTitle));
				setCookie(COOKIE_NAME_CATEGORY_PATH,productCategoryPath);
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
    repaintCompareBox();
    return true;
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
		removeCookie(COOKIE_PREFIX_PRODUCT_DETAILS+productPath); 
		
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
		$("#li_" + productId).toggleClass('compare-item');
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
        var compareBoxHtml = "<li>"+adduptoLabel+ " " + (6-arr_length) + " " + moreItemsLabel + " <a class='reset' href='javascript:void(0);'>("+resetLabel+")</a></li>";
        
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
			removeProductFromCookie(pathToRemove);
		});	
		$(".reset").bind("click",function () {
			removeAllProducts();
		});			 			
	} else {
		$("#comparebox").hide();		
	}
}

repaintCompareBox();


$(document).ready(function(){
	$(".add-compare").bind("click",function () {
		var $self = $(this);
		var result = addProductToCookie(currentProductPath,
				currentProductTitle,
				currentProductImage,
				currentProductPrice,
				currentProductId);
	});
 });
</script>
