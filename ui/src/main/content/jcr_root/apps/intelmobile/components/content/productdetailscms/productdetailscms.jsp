<%--
ProductDetail cms component


--%><%@page import="com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.ConfigUtil,java.util.Map, com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
  String rootPath = resourceResolver.map(IntelUtil.getRootPath(currentPage));
%><%@page session="false"%>
<cq:setContentBundle />
<%
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
    out.println("Double Click to Edit product detials Component");
}

String propertynames[] = null;
String propertyvalues[] = null;
String pagepath = currentPage.getPath();
String pageTitle = currentPage.getTitle();
String pageURL = request.getRequestURL().toString();
Map labels = ConfigUtil.getConfigDetailsValues(resourceResolver,pagepath);
String displayLabels = ConfigUtil.getFeatureLabels(resourceResolver,pagepath,"cms");
propertynames = (String[]) properties.get("propertylabel", new String[0]);
propertyvalues =(String[]) properties.get("propertyvalue", new String[0]);

pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("labels",labels);
pageContext.setAttribute("propertynames",propertynames);
pageContext.setAttribute("propertyvalues",propertyvalues);
pageContext.setAttribute("displayLabels",displayLabels);

pageContext.setAttribute("boardfamily",currentNode!=null && currentNode.hasProperty("734")?currentNode.getProperty("734").getString():"");
pageContext.setAttribute("boardformfactor",currentNode!=null && currentNode.hasProperty("735")?currentNode.getProperty("735").getString():"");
pageContext.setAttribute("boardseries",currentNode!=null && currentNode.hasProperty("733")?currentNode.getProperty("733").getString():"");
pageContext.setAttribute("chipset",currentNode!=null && currentNode.hasProperty("736")?currentNode.getProperty("736").getString():"");
pageContext.setAttribute("integratedgraphics",currentNode!=null && currentNode.hasProperty("731")?currentNode.getProperty("731").getString():"");
pageContext.setAttribute("memory",currentNode!=null && currentNode.hasProperty("737")?currentNode.getProperty("737").getString():"");
pageContext.setAttribute("socket",currentNode!=null && currentNode.hasProperty("706")?currentNode.getProperty("706").getString():"");
pageContext.setAttribute("capacity",currentNode!=null && currentNode.hasProperty("3")?currentNode.getProperty("3").getString():"");
pageContext.setAttribute("formfactor",currentNode!=null && currentNode.hasProperty("740")?currentNode.getProperty("740").getString():"");
pageContext.setAttribute("interface",currentNode!=null && currentNode.hasProperty("741")?currentNode.getProperty("741").getString():"");


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
           <h1><c:out value="${properties.name}" escapeXml="false"/></h1>
		   <div id="prod_2" class="hero">
		   <div class="hero-img">
           <img src="${properties.picture}" alt="${properties.name}">
		   </div>
		   <div class="content">
		            <c:if test="${not empty properties.bestPrice && (properties.bestPrice ne 'null')}">
            		<div class="price">
						<fmt:message key="productdetails.label.price"/> <fmt:message key="generic.label.currency_symbol"/><c:out value="${properties.bestPrice}" /> 
					</div>
					</c:if>
            			<c:if test="${not empty properties.productdescription && (properties.productdescription ne 'null')}">
  							<c:out value="${properties.productdescription}" escapeXml="false"/>
						</c:if>	
						<!-- <cq:include path="featurelist" resourceType="intelmobile/components/content/featurelist"/> -->
	<c:if test="${not empty properties.contenttitle && (properties.contenttitle ne 'null')}">
          <div class="features productdetailsfeatures">
              <h4 class="grad"><cq:text property="contenttitle" escapeXml="false"/></h4>
	<ul class="features">
   <c:if test="${not empty properties.carriervalue && (properties.carriervalue ne 'null') }">
    <li><c:if test="${fn:contains(displayLabels,'carrier')}">
			<b> <fmt:message key="productdetailsCMS.label.feature_carrier"/>:</b>
	   </c:if>
	   <cq:text property="carriervalue" escapeXml="false"/>
	 </li>  	
  </c:if>
   <c:if test="${not empty properties.countryvalue && (properties.countryvalue ne 'null')}">
    <li><c:if test="${fn:contains(displayLabels,'country')}">
          <b> <fmt:message key="productdetailsCMS.label.feature_country"/>:</b>
        </c:if>
        <cq:text property="countryvalue" escapeXml="false"/> 
    </li>
   </c:if>
   <c:if test="${not empty properties.processorvalue && (properties.processorvalue ne 'null')}">
    <li>
     <c:if test="${fn:contains(displayLabels,'processorfamily')}">
     <b> <fmt:message key="productdetailsCMS.label.feature_processorfamily"/>:</b>
     </c:if>
     <cq:text property="processorvalue" escapeXml="false"/> 
    </li>
   </c:if>
   <c:if test="${not empty properties.convertvalue && (properties.convertvalue ne 'null')}">
    <li>
    <c:if test="${fn:contains(displayLabels,'convertability')}">
     <b> <fmt:message key="productdetailsCMS.label.feature_convertability"/>:</b>
     </c:if>
     <cq:text property="convertvalue" escapeXml="false"/>
     </li>
   </c:if>
   <c:if test="${not empty properties.screenvalue && (properties.screenvalue ne 'null')}">
    <li>
    <c:if test="${fn:contains(displayLabels,'screensize')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_screensize"/>:</b>
    </c:if>
    <cq:text property="screenvalue" escapeXml="false"/> 
    </li>
   </c:if>
   <c:if test="${not empty properties.ramvalue && (properties.ramvalue ne 'null')}">
    <li>
    <c:if test="${fn:contains(displayLabels,'ram')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_ram"/>:</b>
    </c:if>
    <cq:text property="ramvalue" escapeXml="false"/> 
    </li>
   </c:if>
   <c:if test="${not empty properties.wifivalue && (properties.wifivalue ne 'null')}">
    <li>
     <c:if test="${fn:contains(displayLabels,'wifi')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_wifi"/>:</b>
    </c:if>
    <cq:text property="wifivalue" escapeXml="false"/>
    </li>
   </c:if>
   <c:if test="${not empty properties.threegvalue && (properties.threegvalue ne 'null')}">
    <li> 
    <c:if test="${fn:contains(displayLabels,'3g')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_3g"/>:</b>
    </c:if>
    <cq:text property="threegvalue" escapeXml="false"/>
    </li>
   </c:if>
   <c:if test="${not empty properties.thicknessvalue && (properties.thicknessvalue ne 'null')}">
    <li> 
    <c:if test="${fn:contains(displayLabels,'thickness')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_thickness"/>:</b>
    </c:if>
    <cq:text property="thicknessvalue" escapeXml="false"/>
    </li>
   </c:if>
   <c:if test="${not empty properties.weightvalue && (properties.weightvalue ne 'null')}">
    <li>
    <c:if test="${fn:contains(displayLabels,'weight')}">
    <b> <fmt:message key="productdetailsCMS.label.feature_weight"/>:</b>
    </c:if>
    <cq:text property="weightvalue" escapeXml="false"/> 
    </li>
   </c:if>

	<!-- Features List for Ultrabooks -->
   <c:if test="${properties.processor ne null && not empty properties.processor}">
    <li><b> <fmt:message key="productdetails.label.feature_processor"/>:</b>
    <cq:text property="processor" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${properties.speed ne null && not empty properties.speed}">
    <li>
    <b> <fmt:message key="productdetails.label.feature_speed"/>:</b>
    <cq:text property="speed" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${properties.ram ne null && not empty properties.ram}">
    <li><b> <fmt:message key="productdetails.label.feature_ram"/>:</b>
    <cq:text property="ram" escapeXml="false"/> 
   
    </li>
   </c:if>

   <c:if test="${properties.screen ne null && not empty properties.screen}">
    <li><b> <fmt:message key="productdetails.label.feature_screen"/>:</b>
    <cq:text property="screen" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${properties.hardDrive ne null && not empty properties.hardDrive}">
    <li>
     <b> <fmt:message key="productdetails.label.feature_harddrive"/>:</b>
    <cq:text property="hardDrive" escapeXml="false"/> 

    </li>
   </c:if>

   <c:if test="${properties.os ne null && not empty properties.os}">
    <li>
    <b> <fmt:message key="productdetails.label.feature_os"/>:</b>
    <cq:text property="os" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${properties.weight ne null && not empty properties.weight}">
    <li><b> <fmt:message key="productdetails.label.feature_weight"/>:</b>
    <cq:text property="weight" escapeXml="false"/> 
    </li>
   </c:if>
   	<!-- Features List for Ultrabooks -->

	<!-- Features List for Motherboards -->
   <c:if test="${boardfamily ne null && not empty boardfamily}">
    <li>
    <b> <fmt:message key="productdetails.label.feature_boardfamily"/>:</b>
    <c:out value="${boardfamily}" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${boardformfactor ne null && not empty boardformfactor}">
    <li>
     <b> <fmt:message key="productdetails.label.feature_boardformfactor"/>:</b>
    <c:out value="${boardformfactor}" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${boardseries ne null && not empty boardseries}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_boardseries"/>:</b>
    <c:out value="${boardseries}" escapeXml="false"/>
    </li>
   </c:if>

   <c:if test="${chipset ne null && not empty chipset}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_chipset"/>:</b>
    <c:out value="${chipset}" escapeXml="false"/>
    </li>
   </c:if>

   <c:if test="${integratedgraphics ne null && not empty integratedgraphics}">
    <c:if test= "${fn:toUpperCase(integratedgraphics) eq 'YES' or  fn:toUpperCase(integratedgraphics) eq 'TRUE'}">
    	<li><b> <fmt:message key="productdetails.label.feature_integratedgraphics"/>:</b>
    	<c:out value="${integratedgraphics}" />
    	</li>
    </c:if>
   </c:if>

   <c:if test="${memory ne null && not empty memory}">
    <li><b> <fmt:message key="productdetails.label.feature_memory"/>:</b>
    <c:out value="${memory}" escapeXml="false"/> 
   </li>
   </c:if>
  
   <c:if test="${socket ne null && not empty socket}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_socket"/>:</b>
    <c:out value="${socket}" escapeXml="false"/>
    </li>
   </c:if>
	<!-- Features List for Motherboards -->
	<!-- Features List for Solid State Devices -->
	 <c:if test="${capacity ne null && not empty capacity}">
    <li>
    <b> <fmt:message key="productdetails.label.feature_capacity"/>:</b>
    <c:out value="${capacity}" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${formfactor ne null && not empty formfactor}">
    <li>
     <b> <fmt:message key="productdetails.label.feature_formfactor"/>:</b>
    <c:out value="${formfactor}" escapeXml="false"/> 
    </li>
   </c:if>

   <c:if test="${interface ne null && not empty interface}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_interface"/>:</b>
    <c:out value="${interface}" escapeXml="false"/>
    </li>
   </c:if>

   <c:if test="${properties.seqreadwrite ne null && not empty properties.seqreadwrite}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_seqreadwrite"/>:</b>
    <cq:text property="seqreadwrite" escapeXml="false"/> 
    </li>
   </c:if>
   <c:if test="${properties.ranreadwrite ne null && not empty properties.ranreadwrite}">
    <li> 
    <b> <fmt:message key="productdetails.label.feature_ranreadwrite"/>:</b>
    <cq:text property="ranreadwrite" escapeXml="false"/> 
    </li>
   </c:if>
	<!-- Features List for Solid State Devices -->
   
   <c:if test="${(fn:length(propertynames) gt 0)}">
				<c:forEach items="${propertynames}" var="name" varStatus="status">
                     <li><b> ${name}:</b> ${propertyvalues[status.index]} 
                     </li>
				</c:forEach>
		    </c:if>
	  
	 </ul>
	 </div>
	 </c:if> 
						
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
            <cq:include path="parsyscomp" resourceType="foundation/components/parsys"/>
            </ul>
            </div>
            </div>
      </div>
      </div>
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

		compareBoxHtml = compareBoxHtml + "<li class='compare-btn'><a class='button primary' href='" + productComparePagePath + "'>"+compareButtonLabel +"</a></li>"		
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