<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@page import="com.intel.mobile.util.IntelUtil,
                com.intel.mobile.constants.IntelMobileConstants, 
				com.intel.mobile.util.ComponentsUtil,
                java.util.Map, java.util.List, 
                com.intel.mobile.util.FilterSortUtil, 
                org.apache.sling.api.resource.ValueMap,
                com.intel.mobile.services.IntelConfigurationService,
                com.day.cq.wcm.api.WCMMode"%>
<cq:setContentBundle />
<%
	ComponentsUtil.processSortFilter(resourceResolver, pageContext, currentPage, properties);
	pageContext.setAttribute("editmode",(WCMMode.fromRequest(request) == WCMMode.EDIT));

%>

    <c:set var="filtertext" value="" />

    <c:forEach var="filter" items="${filters}">
        <c:set var="filtername" value="${filter.key}" />
        <c:set var="filtertext" value="${filtertext}^${filtername}" />
        <c:forEach var="subfilter" items="${filter.value}">
            <c:set var="filtertext" value="${filtertext}~${subfilter.key}" />
        </c:forEach>
    </c:forEach>
<style>
    .hiddenlevel
    {
        display: none;
    }
</style>
<script text="text/javascript">

    var filterLabel = "<fmt:message key='generic.button.filter' />";
    var continueLabel = "<fmt:message key='filterpage.button.continue' />";
    var cancelLabel = "<fmt:message key='filterpage.button.cancel' />";
    var refineLabel = "<fmt:message key='filterpage.button.refine' />";
    var backLabel = "<fmt:message key='filterpage.button.back' />";
    
    var section = "${section}"; 
    var category = "${category}";
    var categoryMeta = "${categoryMeta}";
    var pagetypeMeta = "${pagetypeMeta}";
    var localecode = "${localecode}";
    var localecodeMeta = "${localecodeMeta}";
    
    if(section == "products") {
        var filterCookiePrefix = "intelmobile_filter_" + section + "_" + category + "_";
        var sortCookiePrefix ="intelmobile_sort_" + section + "_" + category + "_";     
    } else {
        var filterCookiePrefix = "intelmobile_filter_" + section + "_";
        var sortCookiePrefix ="intelmobile_sort_" + section + "_" ;     
    }
    
    var totalFiltersCookie = "intelmobile_" + category+ "_total_filter";
    
    var items = "${fn:substringAfter(filtertext,'^')}"; 
    var items = items.split("^");
    
    var filterItems = new Array(items.length);
    for(i=0;i<filterItems.length;i++) {
        var subfilterItems = items[i];
        subfilterItems = subfilterItems.split("~");
        filterItems[i] = new Array();
        filterItems[i][0] = subfilterItems[0];
        for(j=0;j<subfilterItems.length;j++) {
            filterItems[i][j] = subfilterItems[j];
        }
    }

    function getCookie(cookieName) {
        var allCookies = document.cookie.split('; ');
        for (var i=0;i<allCookies.length;i++) {
            var cookiePair = allCookies[i].split('=');
            if(cookiePair[0]==cookieName) {
                return cookiePair[1];
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
    
    function getFilterNameTitle(text,field) {
        if(field == "name") {
            return text.substring(0,text.indexOf("`"));
        } else {
            return text.substring(text.indexOf("`")+1,text.length);
        }
    }
    
    function resetFilters() {
        for(i=0;i<filterItems.length;i++) {
            var mainFilter = getFilterNameTitle(filterItems[i][0],"name");
            var cookieName = filterCookiePrefix + mainFilter;
            removeCookie(cookieName);
        }   
        if(section == "products") {
            removeCookie(totalFiltersCookie);
        }
        updateFilters();
        executeFilter();
        $(".filter").hide(); // hide the filter menu
        $('.results, .ft, .sort-filter' ).show();
    }
    
    function getTotalFilters() {
        var totalFilters = getCookie(totalFiltersCookie);
        if(totalFilters == "") {
            totalFilters = "0";     
        } 
        return totalFilters;
    }
    
    function updateFilters() {
        var totalCategories = 0;
        if(filterItems != undefined && filterItems.length > 0 && filterItems[0][0] != "") {     
            for(i=0;i<filterItems.length;i++) {
                var mainFilter = getFilterNameTitle(filterItems[i][0],"name");
                var cookieName = filterCookiePrefix + mainFilter; 
                var cookieValue = getCookie(cookieName);
                var cookieArray = cookieValue.split("~");
                var totalSelText = "";
                for(j=1;j<filterItems[i].length;j++) {
                    var item = filterItems[i][j];
                    var chk = "chk_" + mainFilter + "_" + item;
                    if(cookieValue == item 
                    		|| cookieValue.search("~" + item + "~") > -1 
                    		|| ((cookieValue.search("~") > -1) && (cookieValue.lastIndexOf("~") == cookieValue.search("~" + item)))
                    		|| (cookieValue.search(item + "~") == 0)) {
                    	document.getElementById(chk).checked=true;
                    } else {
                    	document.getElementById(chk).checked=false;
                    }
                }
                if(cookieValue!="") {
                    totalSelText = "(" + cookieArray.length + ")" ;
                    totalCategories++;
                }
                document.getElementById("count_" + mainFilter).textContent = totalSelText;
            }
    /*      if(totalCategories > 0) {
                document.getElementById("filterbutton").value = filterLabel +" (" + totalCategories + ")";
            } else {
                document.getElementById("filterbutton").value = filterLabel;
            }    */
            document.getElementById("filterCount").textContent = totalCategories;       
        }
    }
    
    function updateCookies() {
        var totalFilter = 0;
        if(filterItems != undefined && filterItems.length > 0 && filterItems[0][0] != "") {
            for(i=0;i<filterItems.length;i++) {
                var mainFilter = getFilterNameTitle(filterItems[i][0],"name");
                var cookieName = filterCookiePrefix + mainFilter; 
                var cookieValue = "";
                for(j=1;j<filterItems[i].length;j++) {
                    var subFilter = filterItems[i][j];
                    var item = "chk_" + mainFilter + "_" + subFilter;
                    if(document.getElementById(item).checked) {
                        cookieValue = cookieValue + "~" + subFilter; 
                    }
                }
                cookieValue = cookieValue.substring(1);
                if(cookieValue != "") {
                    setCookie(cookieName, cookieValue);
                    totalFilter++;
                } else {
                    removeCookie(cookieName);
                }
            }
            if(section == "products") {
                setCookie(totalFiltersCookie,totalFilter);
            }
            
            updateFilters();
        }
    }
    
    function generateFilterURL(keyword,offset,hits,sortoption) {

        if(keyword == undefined) keyword="";
        if(offset == undefined) offset=0;
        if(hits == undefined) hits = 11;
        if(sortoption == undefined) sortoption = "";
        
        
        var URL = "${fastSearchUrl}"
        var q1 = "${fastSearchAppId}"; // Application Id
        //var q2 = "en"; //Language
        var q2 = "<%=IntelUtil.getLocaleLanguage(currentPage)%>"; //Language
        //alert("q2 :"+q2);
        var q3 = hits; //Numbers of Records to Fetch
        var q4 = keyword;
        var q6 = offset ; //Result Offset
        var q23 = ":" //Fielded Search Separator
        var q24 = "~" //Multifield Separator
        var q32 = "and" //Multifield Operator
        var q9 = sortoption;
        var q19 = ":";
        
        var numericPattern=new RegExp("^(?:[0-9]\\d*|0)?(?:\\.\\d+)?$");
        

        if(section == "products") { //For Products Filter
            var q11 = "reimaginesublevelcategory,url"   
        } else { //For Site Search Filter
            var q11 = "reimaginesublevelcategory,title,teaser,body,url" 
        }

        var q10=""; //Fielded Search
        
        q10  = localecodeMeta + q23 + localecode + q23 + "exactphrase";
        
        if(section == "products") { 
            q10 += q24 + "reimaginesublevelcategory" + q23 + "Mobile^" + pagetypeMeta + "^product" + q23 + "anyword";
            q10 += q24 + "reimaginesublevelcategory" + q23 + "Mobile^" + categoryMeta + "^" + category + q23 + "anyword";
        }
        
        var q14=""  //Range Search
        
        var allCookies = document.cookie.split('; ');
        for (var i=0;i<allCookies.length;i++) {
            var cookiePair = allCookies[i].split('=');
            if(cookiePair[0].search(filterCookiePrefix) == 0) {
                var cookieName = cookiePair[0].replace(filterCookiePrefix,"");
                var cookieVal = cookiePair[1];
                if(cookieVal != "") {
                    var cookieArray = cookieVal.split("~");
                    var filter = "";
                    var range = false;
                    for(j=0;j<cookieArray.length;j++) {
                        var value = cookieArray[j];                        
                        if(value.indexOf("-") > 0 
                                && value.indexOf("-") == value.lastIndexOf("-") 
                                && value.indexOf("-") != value.length-1) {
                                   var temp = value;
                                   var fromValue = "";
                                   var toValue = "";
                                   fromValue = temp.substr(0,temp.indexOf("-"));
                                   toValue = temp.substr(temp.indexOf("-")+1,temp.length);  
                                   if(numericPattern.test(fromValue) && numericPattern.test(toValue)) {                      
                                       range = true;
                                       if(filter != "") {
                                         filter = filter + " OR ";
                                     }
                                     filter = filter + cookieName + ":range(" + fromValue + "," + toValue + ")";
                                   } else {
                                     if(filter != "") {
                                         filter = filter + " ";
                                     }
                                     if(cookieName == 'category' || cookieName == 'mobilecontent') {
                                    	 filter = filter + "\"" + "Mobile^" + cookieName + "^" + value + "\"";
                                     } else {
                                    	 filter = filter + "\"" + "Mobile^" + cookieName + "^" + $("#label_" + cookieName+"_"+value).text() + "\"";	 
                                     }
                                      
                                   }
                        } else {
                             if(filter != "") {
                                 filter = filter + " ";
                             }
                             if(cookieName == 'category' || cookieName == 'mobilecontent') {
                            	 filter = filter + "\"" + "Mobile^" + cookieName + "^" + value + "\"";
                             } else {                             
                             	filter = filter + "\"" + "Mobile^" + cookieName + "^" + $("#label_" + cookieName+"_"+value).text() + "\"";
                             }
                             console.log("Check Box value - " + $("#label_" + cookieName+"_"+value).text())
                        }               
                    }
                    if(range == false) {
                        if(q10 != "") {
                            q10 = q10 + q24;
                        }
                        q10=q10 + "reimaginesublevelcategory" + q23 + filter + q23 + "anyword";
                    } else {
                        if(q14 != "") {
                            q14 = q14 + " AND ";
                        }
                        q14 = q14 + "(" + filter + ")";
                    }                   
                }

            }
        }   
        var finalURL = URL + "?"
                + "q1=" + q1 + "&"
                + "q2=" + q2 + "&"
                + "q3=" + q3 + "&"
                + "q4=" + q4 + "&"
                + "q6=" + q6 + "&"
                + "q10=" + q10 + "&"
                + "q14=" + q14 + "&"
                + "q11=" + q11 + "&"
                + "q23=" + q23 + "&"
                + "q24=" + q24 + "&"
                + "q32=" + q32 + "&"
                + "q9=" + q9 + "&"
                + "q19=" + q19;
        
        return finalURL;
    }   
    
</script>
<c:if test="${editmode eq true }">
<h3>Right Click -> Edit to edit Configurations</h3>
</c:if>
<c:if test="${showhide eq 'showboth' || showhide eq 'showfilter'}">            
<div class="filter">

    <div class="level1 cta">
        <a href="#" class="cancel" onclick="updateFilters()"><fmt:message key='filterpage.button.cancel' /></a>
        <a href="#" class="continue active" onclick="updateCookies()"><fmt:message key='filterpage.button.refine' /></a>
    </div>
    <div class="level2 cta">
        <a href="#" class="cancel" onclick="updateFilters()" style="display:none;"><fmt:message key='filterpage.button.cancel' /></a>
        <a href="#" class="continue active" onclick="updateCookies()"><fmt:message key='filterpage.button.continue' /></a>
    </div>
    <ul class="level1" id="level1" style="display:block">
        <li><fmt:message key='generic.button.filter' />: <a href="javascript:void(0)" onclick="resetFilters();">(<fmt:message key='filterpage.label.reset' />)</a> </li> 
        <c:forEach var="entry" items="${filters}">
            <c:set var="n" value="${fn:substringBefore(entry.key,'`')}" />  
            <c:set var="t" value="${fn:substringAfter(entry.key,'`')}" />
            <li onclick="javascript:showSubFilter('filterl2_${n}')"><a href="javascript:void(0)"><c:out value="${t}" /> <span id="count_${n}" ></span></a></li>
        </c:forEach>
    </ul>
    <div id="search_level2" style="display:none">
        <c:forEach var="entry" items="${filters}">
            <c:set var="n" value="${fn:substringBefore(entry.key,'`')}" />  
            <c:set var="t" value="${fn:substringAfter(entry.key,'`')}" />
            <ul class="level2 hiddenlevel" id="filterl2_${n}">              
                <li><c:out value="${t}" />: <a href="javascript:void(0)" onclick="document.getElementById('form_${n}').reset();">(<fmt:message key='filterpage.label.reset' />)</a></li>            
                <form id="form_${n}">
                <c:forEach var="subfilter" items = "${entry.value}">
                    <li><input type="checkbox" value="${subfilter.key}" id="chk_${n}_${subfilter.key}"><label id="label_${n}_${subfilter.key}" for="chk_${n}_${subfilter.key}"><c:out value="${subfilter.value}" /></label></li>
                </c:forEach>
                </form>
            </ul>
            
        </c:forEach>
    </div>
    <div class="level1 cta">
        <a href="#" class="cancel" onclick="updateFilters()"><fmt:message key='filterpage.button.cancel' /></a>
        <a href="#" class="continue active" onclick="updateCookies()"><fmt:message key='filterpage.button.refine' /></a>
    </div>
    <div class="level2 cta">
        <a href="#" class="cancel" onclick="updateFilters()"  style="display:none;"><fmt:message key='filterpage.button.cancel' /></a>
        <a href="#" class="continue active" onclick="updateCookies()"><fmt:message key='filterpage.button.continue' /></a>
    </div>  
</div>
</c:if>
  
<div class='clearfix'>
<div class="sort-filter">
    <div>
        <c:if test="${showhide eq 'showboth' || showhide eq 'showsort'}">
	        <div class="selectbox">
	            <form id="sort">
	                <select id="sortoptions" name="sort" onchange="executeFilter()">
	                    <option value=""><fmt:message key='generic.button.sort' /></option>
	                    <c:if test="${section eq 'search'}">
	                        <option value=""><fmt:message key='filterpage.label.relevancy' /></option>
	                    </c:if>                 
	                    <c:forEach var="entry" items="${sortoptions}">
	                        <option value="${entry.key}"><c:out value="${entry.value}"/></option>
	                    </c:forEach>
	                </select>
	            </form>
	        </div>
        </c:if>
        <c:if test="${showhide eq 'showboth' || showhide eq 'showfilter'}">        
        <div class="criteria-filter">
            <form id="filter">
                <input id="filterbutton" type="button" name="filter" value="<fmt:message key='generic.button.filter' />">
                <span id="filterCount">0</span>
            </form>
        </div>
        </c:if>
        <c:if test="${section eq 'products'}">
            <div class="view-pref">
                <form id="view-toggle" action="">
                    <input type="button" id="btn_toggle" />
                </form>
            </div>          
        </c:if>
    </div>
</div>
</div>
<script>
var showhide = "${showhide}";
function showSubFilter(id)
{
    //$("#"+id).removeClass('hiddenlevel');
    $("#level1").hide();
    $(".level2").addClass('hiddenlevel');
    //$("#search_level2").style.display="block";
    $('div.level2').removeClass('hiddenlevel');
    $('div.level2').show();
    $('div.level1').hide();
    $('div.level2 .cancel').show();
    $('div.level2 .continue').show();
    
    document.getElementById('search_level2').style.display="block";
    $("#"+id).show();
}
	if(showhide == 'showboth' || showhide == 'showfilter') {
		updateFilters();	
	}    
</script>
