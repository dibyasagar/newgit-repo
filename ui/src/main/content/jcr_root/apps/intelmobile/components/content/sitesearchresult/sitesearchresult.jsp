<%@page import="com.intel.mobile.constants.IntelMobileConstants,
		com.intel.mobile.util.IntelUtil, 
		com.intel.mobile.services.IntelConfigurationService,
		com.intel.mobile.util.ComponentsUtil" %>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<cq:setContentBundle/>
<%
	ComponentsUtil.processSiteSearch(pageContext,
		currentPage,slingRequest.getRequestPathInfo(),
		properties);
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName());
%>
<div class="component" data-component="<c:out value='${pageScope.componentName}'/>" data-component-id="<c:out value='${pageScope.componentId}'/>">
<div id="main" role="main">
<div class="search-results" id="search-results" style="display:none">
<h1><span id="totalResultsFound"></span> <fmt:message key="searchresultspage.label.resultsfound" /></h1>
<div class="bd">
<c:choose>
                <c:when test="${searchScope eq 'intel'}">
                </c:when>
                <c:otherwise>
                    <cq:include path="sortfilter" resourceType="intelmobile/components/content/sortfilter" />
                </c:otherwise>
</c:choose>
        
<div id="resultsList" class="results">
</div>
<div id="nextTen1"></div>
<div id="searchfooter" class="ft">
    <span id="result_fond"><label id="totalShowing"></label> <fmt:message key="sitesearch.label.pagination_copy"/> <label id="totalResults"></label> <fmt:message key="sitesearch.label.results_found"/></span>
    <a href="#" title="<fmt:message key='sitesearch.label.loadmoreresults'/>" onclick="populateResults(event)" id="load_count"><fmt:message key="sitesearch.label.loadmoreresults"/></a>
</div>



<!-- Related Search Start -->
        <ul id="relatedsearches" class="accordion">
            <li>
                <h5>
                    <a href="javascript:void(0)"><fmt:message key='sitesearch.label.relatedsearches'/></a>
                </h5>
                <div class="content" style="overflow: hidden; display: block;">
                    <ul id="relatedsearch">
                        
                    </ul>
                </div>
            </li>
        </ul>
<!-- Related Search End -->

<!-- Scope Search Link Start -->
<div class="intel_search">
            <c:choose>
                <c:when test="${searchScope eq 'intel'}">
                    <a href="${rootPath}/search-result.${searchtext}.intelmobile.html">
                        <fmt:message key='sitesearch.label.search'/> m.intel.com > </a>
                </c:when>
                <c:otherwise>
                    <a href="${rootPath}/search-result.${searchtext}.intel.html">
                        <fmt:message key='sitesearch.label.search'/> Intel.com > </a>
                </c:otherwise>
            </c:choose>
</div>
<!-- Scope Search Link End -->

</div>
</div>
</div>
</div>

<script type="text/javascript">
var currentpageName = "${currentPageName}";
var localecode = "${localecode}"
var searchtext = "${searchtext}"
var searchtype = "${searchtype}"
var relateditemsno = "${relateditemsno}"
var searchscope = "${searchScope}"
var gStart= 0 ;

var searchOffset = 0;
var totalOnPage = 0;
var hits = 12;

var label_bestMatch = "<fmt:message key='sitesearch.label.best_match'/>";
var label_category = "<fmt:message key='sitesearch.label.category'/>";
var label_matchingResult = "<fmt:message key='sitesearch.label.matching_result'/>"
var label_price = "<fmt:message key='productdetails.label.price'/>";
var label_currency = "<fmt:message key='generic.label.currency_symbol'/>";

var  productnameMeta = "${productnameMeta}";
var  priceMeta = "${priceMeta}";
var  pictureurlMeta = "${pictureurlMeta}";
var  taglineMeta = "${taglineMeta}";
var  productpathMeta = "${productpathMeta}";
var  categoryMeta = "${categoryMeta}";
var  mobilecontentMeta = "mobilecontent";

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

function getRelatedKeys() {

      //var searchParams={"keyword":"desktop""}
       //alert("searchParams :");
      
       $.ajax( {

            url : "http://search.intel.com/SearchLookup/DataProvider.ashx" ,
            type : 'GET',
            dataType : "jsonp",
            data:{"m":"GetTypeAheadSuggestions","searchRealm":"Mobile","languageCode":localecode,"searchPhrase":searchtext},
            error : function() {
            },

            success : function(data) {
               strbrnd = data.toString().split(",")
               var sugg_html = "";
               if(strbrnd.length>0 && strbrnd[0]!="") {
                   if(relateditemsno > 0 && strbrnd.length > relateditemsno){
                       for (i=0;i<relateditemsno;i++){
                           sugg_html += "<li><a data-wap='{"linktype":"related"}' href='"+currentpageName+"."+strbrnd[i]+"."+searchscope+".html'>"+strbrnd[i]+"</a></li>";          
                       } 
                       }
                       else{
                           for (i=0;i<strbrnd.length;i++){
                           sugg_html += "<li><a data-wap='{"linktype":"related"}' href='"+currentpageName+"."+strbrnd[i]+"."+searchscope+".html'>"+strbrnd[i]+"</a></li>"; 
                           }
                       }               
                       $("#relatedsearch").append(sugg_html);                          	   
               } else {
            	   //$('#relatedsearches').hide();
				   document.getElementById("relatedsearches").style.display="none";
               }
            }
        });
    }    

function executeFilter() {
	searchOffset = 0;
	totalOnPage = 0;
	populateResults();
}

function parseFieldFromResponse(response,field) {
    var value = ""; 
    field = "Mobile^" + field;
    if(response != undefined && response != "") {
        var start = response.indexOf(field);        
        if(start!= undefined && start != -1) {
            var end = response.indexOf(";",start);
            if(end == -1) {
                response = response.substring(start);
                } else {
                response = response.substring(start,end);
            }
            value = response.substring(response.lastIndexOf("^")+1,response.length);
        }    	
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
    
    if(searchscope == "intelmobile") {
        if(document.getElementById("sortoptions") != undefined) {
        	sortoption = document.getElementById("sortoptions").value;	
        }
        searchURL = generateFilterURL(searchtext,searchOffset,hits,sortoption);
		searchURL += "&q17=" + searchtype;
    } else if (searchscope == "intel") {
        searchURL = "${fastSearchUrl}"
        searchURL+= "?q1=reimagine&q2=<%=IntelUtil.getLocaleLanguage(currentPage)%>";
        searchURL+= "&q4=" + searchtext;
        searchURL+= "&q10=localecode:" + localecode + ":allword";
        searchURL+= "&q23=:";
		searchURL+= "&q17=" + searchtype;
        searchURL+= "&q3=12&q6=" + searchOffset;
        searchURL+= "&q11=title,teaser,body,url";       
    }

    
    /* Initial Div paint with product list */
    $.ajax( {


        url : searchURL,
        type : 'GET',
        dataType : "jsonp",
        error : function() {
        //alert('failed')
        },

        success : function(data) {
			$("#search-results").hide();		
			totalCount = data.TotalCount ;
            var count = 0 ;
            

            var counter=true;
            if(searchOffset == 0) {
               $("#resultsList").empty();
            }
               
            var htmlText = "";
            if(totalCount > 0) {            
            $.each(data.ResultSet, function(index){
               
                   
               var v_url = "";
               var v_img = "/etc/designs/intelmobile/img/search/fpo_SEARCH-support.jpg";
               var v_title = "";
               var v_category = "";
               var v_teaser = "";
               var v_body = "";
               var v_price = "";
               var v_articletype = "";
               
               if(searchscope == "intelmobile") {
                    var value = this.FieldList[0].FieldValue;
                    v_url = getUrlParts(this.FieldList[4].FieldValue).pathname;
                    if(v_url.charAt(0)!="/") {
                    	v_url = "/" + v_url;
                    }
                    v_category = parseFieldFromResponse(value,"pagetype");
                    if(v_category == "Product") {                       
                        v_title = parseFieldFromResponse(value,productnameMeta);
                        v_price = parseFieldFromResponse(value,priceMeta);
                        v_teaser = parseFieldFromResponse(value,taglineMeta);
                        v_img = parseFieldFromResponse(value,pictureurlMeta);
                    } else {
                        v_title = (this.FieldList[1].FieldValue!= null && this.FieldList[1].FieldValue != "null")?this.FieldList[1].FieldValue:"";
                        v_teaser = (this.FieldList[2].FieldValue!= null && this.FieldList[2].FieldValue != "null")?this.FieldList[2].FieldValue:"";
                        v_body = (this.FieldList[3].FieldValue!= null && this.FieldList[3].FieldValue!="null")?this.FieldList[3].FieldValue:"";
                        if(v_category == "Article")  {
                        	v_articletype = parseFieldFromResponse(value,mobilecontentMeta);	
                        }                        
                    }
               } else {
                    v_title = (this.FieldList[0].FieldValue!= null && this.FieldList[0].FieldValue != "null")?this.FieldList[0].FieldValue:"";
                    v_teaser = (this.FieldList[1].FieldValue!= null && this.FieldList[1].FieldValue != "null")?this.FieldList[1].FieldValue:"";
                    v_body = (this.FieldList[2].FieldValue!= null && this.FieldList[2].FieldValue != "null")?this.FieldList[2].FieldValue:"";
                    v_url = this.FieldList[3].FieldValue;
               }
               
               count++;
                
                if(count==1 && searchOffset==0) { //Best Match

                   htmlText += '<h2>'+label_bestMatch+'</h2>'
                   htmlText += '<ul class="best-match">'
                   htmlText += '<li>'
                   if(searchscope == "intelmobile") {
                        htmlText += '<div class="thumb">'
                        htmlText += '<a data-wap=\'{"linktype":"bestmatch"}\' href="'+v_url+'">'                 
                        htmlText += '<img src="'+ v_img +'" alt="'+v_title+'">'
                        htmlText += '</a>'
                        htmlText += '</div>'
                    }
                   htmlText += '<div>'
                   htmlText += '<h3><a data-wap=\'{"linktype":"bestmatch"}\' href="'+v_url+'">'+v_title+'</a></h3>'
                   htmlText += v_teaser;
                   if(searchscope == "intelmobile") {
                        if(v_category == "Product") {
                        	if(v_price != "") {
                        		htmlText += label_price + ' ' + label_currency + '<span class="price">'+v_price+'</span>';	
                        	}
                            htmlText += '<span class="category">' + label_category + ': ' + v_category  +'</span>'
                        } else if(v_category == "Article") {
                        	var labelName = "label#label_" + mobilecontentMeta + "_" + v_articletype;
                        	if($(labelName).length > 0) {
                        		v_articletype = $(labelName).html();
                        	} else {
                        		v_articletype = v_category;
                        	}
                    		htmlText += '<span class="category">' + label_category + ': ' + v_articletype  +'</span>'                        	
                        }
                   }                                      
                   htmlText += '</div>'
                   htmlText += '</li>'
                   htmlText += '</ul>'
                                        
                } else { //First item from Matching Results
                    if(count == 2 && searchOffset==0) {
                        htmlText+= '<h2>'+label_matchingResult+'</h2>';
                        htmlText+= '<ul id="nextTen">';                     
                    }
                   htmlText += '<li>'
                   if(searchscope == "intelmobile") {
                        htmlText += '<div class="thumb">'
                        htmlText += '<a data-wap=\'{"linktype":"matching-results"}\' href="'+v_url+'">'                 
                        htmlText += '<img src="'+ v_img +'" alt="'+v_title+'">'
                        htmlText += '</a>'
                        htmlText += '</div>'                        
                   }
                   htmlText += '<div>'
                   htmlText += '<h3><a data-wap=\'{"linktype":"matching-results"}\' href="'+v_url+'">'+v_title+'</a></h3>'
                   htmlText += v_teaser;
                   if(searchscope == "intelmobile") {
                        if(v_category == "Product") {
                        	if(v_price != "") {
                        		htmlText += label_price + ' ' + label_currency + '<span class="price">'+v_price+'</span>';	
                        	}                            
                            htmlText += '<span class="category">' + label_category + ': ' + v_category  +'</span>'
                        } else if(v_category == "Article") {
                        	var labelName = "label#label_" + mobilecontentMeta + "_" + v_articletype;
                        	if($(labelName).length > 0) {
                        		v_articletype = $(labelName).html();
                        	} else {
                        		v_articletype = v_category;
                        	}
                    		htmlText += '<span class="category">' + label_category + ': ' + v_articletype  +'</span>'                        	
                        }
                   }                                      
				   
                   htmlText += '</div>'
                   htmlText += '</li>'
                }
               totalOnPage++;
           });
            if(count > 1 && searchOffset==0) {
                    htmlText+= '</ul>';                     
            }
            if(searchOffset == 0) {
                $("#resultsList").append(htmlText);
                $("#totalResultsFound").html(totalCount)
            } else {
                $("#nextTen").append(htmlText);
            }
            
            
            searchOffset = totalOnPage;            
           $('#totalShowing').html(totalOnPage);  
           $('#totalResults').html(totalCount);
           $('#searchfooter').show();
		   //$('#relatedsearches').show();
          } else {
        	  $('#searchfooter').hide();
			  $('#relatedsearches').hide();
        	  $("#totalResultsFound").html("No");
          }
          if(totalOnPage == totalCount) {
        	   $('#load_count').hide();
           } else {
        	   $('#load_count').show();
           }       
			$("#search-results").show();
        },
		async:   false
    });     
}

$(document).ready(function() {
  // Handler for .ready() called.
  populateResults();  
  getRelatedKeys();
});
</script>