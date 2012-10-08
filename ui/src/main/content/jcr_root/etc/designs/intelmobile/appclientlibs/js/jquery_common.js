//Date Utility methods
var util_date = {
	/* returns returns integer- days until a specified date
	 * if less than 1 full day (24 hours, or 86400000 miliseconds) will return 0
	 * @param date - the date to compare to
	 * usage: daysUntil("Nov 15, 2006")
	 */
	daysUntil: function(date)
	{
		// check for servertime variable (a var set by server-side code
		// if it doesn't exist use client time
		var now = (typeof servertime != "undefined") ? new Date(servertime) : new Date();
		//var now = new Date(); // use for testing
		var enddate = new Date(date);
		var count = Math.floor((enddate.getTime() - now.getTime()) / 86400000);
		return count;
	},

	/* returns true if current day is btween 2 dates; else false
	 * @param startdate
	 * @param enddate
	 * usage: isBetween("Nov 1, 2006", "Nov 15, 2006")
	 */
	isBetween: function(startdate, enddate)
	{
		var now = (typeof servertime != "undefined") ? new Date(servertime) : new Date();
		//var now = new Date(); // use for testing
		var startdate = new Date(startdate);
		var enddate = new Date(enddate);
		var before = Math.floor((enddate.getTime() - now.getTime()) / 86400000);
		var after = Math.floor((startdate.getTime() - now.getTime()) / 86400000);
		var ret = (after < 0 && before >= 0) ? true : false;
		return ret;
	}
}

//Calls 'func' on 'eventName' in 'obj'
function addEvent(obj, eventName, func){
	if(obj.addEventListener)
		return obj.addEventListener(eventName, func, true);
	else if(obj.attachEvent)
	{
		obj.attachEvent("on" + eventName, func);
		return true;
	}
	return false;
}

function fixIeBackgroundImageCache() {
	var agt = navigator.userAgent.toLowerCase();
	var appVer = navigator.appVersion.toLowerCase();
	// *** BROWSER VERSION ***
	var is_konq = false;
	var kqPos = agt.indexOf('konqueror');
	if (kqPos != -1) {is_konq = true;}
	var is_safari = ((agt.indexOf('safari') != -1) && (agt.indexOf('mac') != -1));
	var is_khtml = (is_safari || is_konq);
	var is_opera = (agt.indexOf("opera") != -1);
	var iePos = appVer.indexOf('msie');
	var is_ie = ((iePos != -1) && (!is_opera) && (!is_khtml));
	if (is_ie)
	{
		try {document.execCommand('BackgroundImageCache', false, true);} 
		catch(e){	
			// this will fail for IE 6 prior to SP1.
		}
	}
}

function loadJavascriptFile(jsPath) {
	document.write('<script type="text/javascript" src="' + jsPath + '"></scr' + 'ipt>');
}

function loadStyleSheet(cssPath, title, rel) {
	var fileref=document.createElement("link");
	fileref.setAttribute("rel", rel);
	fileref.setAttribute("type", "text/css");
	fileref.setAttribute("href", cssPath);
	if (title!=null)
	{
		fileref.setAttribute("title", title);
	}
	document.getElementsByTagName("head")[0].appendChild(fileref);
}

function writeImageTag(siteId, location, params) {
	var imageLocation = PTIncluder.imageServerURL + '..' + location;
	eval("document.write('<img src=\"' + imageLo"+"cation + '\" '+ params +' >')");
}

var commonSiteId = null;
function setSiteId(site) {
  commonSiteId = site;
}

function writeTextForSite(site, text){
	if (site == null || commonSiteId == null)
	{
			return;
	}
	if (commonSiteId.toLowerCase()==site.toLowerCase())
	{
			document.write(text);
	}
}

var externalLinkMap = {};
function externalLink(link, linkText, linkId, linkClass) {
   	this.link=link;
   	this.linkText=linkText;
   	this.linkId=linkId;
		this.linkClass=linkClass;
}

function writeExternalAnchorLink(linkMap) {
	var urlProtocolPattern = new RegExp('(http|https)(:\/\/)');
	jQuery.each(linkMap, function(key){
		var link = linkMap[key].link;
		if (typeof link != 'undefined' && link != null && link.length > 0) {	
			if (!urlProtocolPattern.test(link)){
				link = "http://" + link;
			}
			var temp = '<a target="_blank" href="' + link + '" ';
			if (linkMap[key].linkId) {temp += 'id="' + linkMap[key].linkId + '" ';}
			if (linkMap[key].linkClass) {temp += 'class="' + linkMap[key].linkClass + '" ';}
			temp += '>' + linkMap[key].linkText + '</a>';
			jQuery('#'+key).replaceWith(temp);
		}		
	});	
}

function writeExternalLink(link, linkText, linkId, linkClass) {
	var urlProtocolPattern = new RegExp('(http|https)(:\/\/)');
	if (typeof link != 'undefined' && link != null && link.length > 0) {
		if (!urlProtocolPattern.test(link)){
			link = "http://" + link;
		}
		var temp = '<a target="_blank" href="' + link + '" ';
		if (linkId) {temp += 'id="' + linkId + '" ';}
		if (linkClass) {temp += 'class="' + linkClass + '" ';}
		temp += '>' + linkText + '</a>';
		document.write(temp);
	}
}

function writeExternalImageLink(imageSrc, imageAlt, imageTitle, link, linkId, linkClass) {
	var urlProtocolPattern = new RegExp('(http|https)(:\/\/)');
	if (typeof link != 'undefined' && link != null && link.length > 0) {
		if (!urlProtocolPattern.test(link)){
			link = "http://" + link;
		}
		var temp = '<a target="_blank" href="' + link + '" ';
		if (linkId) {temp += 'id="' + linkId + '" ';}
		if (linkClass) {temp += 'class="' + linkClass + '" ';}
		if (imageTitle) {temp += 'title="' + imageTitle + '" ';}
		temp += '>';
		temp += '<img src="' + imageSrc + '" ';
		if (imageAlt) {temp += 'alt="' + imageAlt + '" ';}
		if (imageTitle) {temp += 'title="' + imageTitle + '" ';}
		temp += '/>';
		temp += '</a>';
		document.write(temp);
	}
}

function getQueryStringParameter(queryString, parameterName) {
	// Add "=" to the parameter name (i.e. parameterName=value)
	var parameterName = parameterName + "=";
	if (queryString.length > 0)
	{
		// Find the beginning of the string
		begin = queryString.indexOf(parameterName);
		// If the parameter name is not found, skip it, otherwise return the value
		if (begin != -1)
		{
			// Add the length (integer) to the beginning
			begin += parameterName.length;
			// Multiple parameters are separated by the "&" sign
			end = queryString.indexOf("&", begin);
			if (end == -1)
			{
					end = queryString.length
			}
			// Return the string
			return unescape(queryString.substring(begin, end));
		}
		// Return "null" if no parameter has been found
		return null;
	}
}

//function to reset a portlet flow
function resetPortlet(portletName) {
	//alert('resetPortlet : '+portletName);
	if(typeof PTPortlet != 'undefined'){
		PTPortlet.setSessionPref('ComUhgOvationsPortalResetPortlet', portletName);
	}
}

// onclick function injection step 1 -- this function is needed to inject itself in existing links on the page
function refreshPortlet(portletName) {
	return function() {
		resetPortlet(portletName);
	}
}

// prevent the plumtree generated login code from attempting to focus on an object when it is in display:hidden state (for IE)
function focusUserTextbox() {
  // do nothing
}

function focusPasswordField() {
  // do nothing
}

//submitGoogleSearch
function submitGoogleSearch(query) {
	if (query.length < 1) {
			alert('Your search box was empty. Please enter some text in the search box.');
	} else {
			resetPortlet('google_search');
			document.googleSearchForm.q.value = query;
			document.googleSearchForm.submit();
			return false;
	}
}

//Default enter key submit functionality
//add the following to your form tag:
//onkeypress="javascript:return processEnterKeySubmit(event, <submit button id>, <true/false>)"
function processEnterKeySubmit(e, submitButtonId, allBrowsers) {
	if (allBrowsers || navigator.appName == "Microsoft Internet Explorer")
	{
		if (null == e)
			e = window.event;

		if (e.keyCode == 13)
		{
			var subButton = document.getElementById(submitButtonId);

			if (subButton != null)
			{
				subButton.click();
				return false;
			} else {
				return true;
			}
		} else {
			return true;
		}
	} else {
		return true;
	}
}

//Generic cookie reader function
function getCookie(name) {
	var start = document.cookie.indexOf( name + "=" );
	var len = start + name.length + 1;
	if ( ( !start ) && ( name != document.cookie.substring( 0, name.length ) ) ) {
		return null;
	}
	if ( start == -1 ) return null;
	var end = document.cookie.indexOf( ";", len );
	if ( end == -1 ) end = document.cookie.length;
	return unescape( document.cookie.substring( len, end ) );
}
function readCookie(name){
 	return getCookie(name);
}

//Generic cookie creator function
function setCookie(name, value, expires, path, domain, secure) {
	var today = new Date();
	today.setTime(today.getTime());
	if (expires) 
	{expires = expires * 1000 * 60 * 60 * 24;}
	var expires_date = new Date( today.getTime() + (expires) );
	if (path==null || '/portal/'==path) 
	{path='/';}
	document.cookie = name+"="+escape( value ) +
		( ( expires ) ? ";expires="+expires_date.toGMTString() : "" ) + //expires.toGMTString()
		( ( path ) ? ";path=" + path : "" ) +
		( ( domain ) ? ";domain=" + domain : "" ) + 
		( ( secure ) ? ";secure" : "" );
}
function createCookie(name, value, expires){
	setCookie(name, value, expires);
}

//Generic cookie eraser function
function deleteCookie( name, path, domain ) {
	if ( getCookie( name ) ) document.cookie = name + "=" +
			( ( path ) ? ";path=" + path : "") +
			( ( domain ) ? ";domain=" + domain : "" ) +
			";expires=Thu, 01-Jan-1970 00:00:01 GMT";
}
function eraseCookie(name) {
  setCookie(name,"",-1);
}

//These function are used to remove/add text in text box on focus.
function checkOnBlur(obj, txtVal) {
	if (obj.value == '') {obj.value = txtVal;}
}

function checkOnFocus(obj, txtVal) {
	if (obj.value == txtVal) {obj.value = '';}
}

/*
	nStr: The number to be formatted, as a string or number. No validation is done, so don't input a formatted number. If inD is something other than a period, then nStr must be passed in as a string.
	inD: The decimal character for the input, such as '.' for the number 100.2
	outD: The decimal character for the output, such as ',' for the number 100,2
	sep: The separator character for the output, such as ',' for the number 1,000.2 
	symbol: The currency symbol to be used such as $
*/
function formatNumber(nStr, inD, outD, sep, symbol) {
	nStr += '';
	var dpos = nStr.indexOf(inD);
	var nStrEnd = '';
	if (dpos != -1) {
		nStrEnd = outD + nStr.substring(dpos + 1, nStr.length);
		nStr = nStr.substring(0, dpos);
	}
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(nStr)) {
		nStr = nStr.replace(rgx, '$1' + sep + '$2');
	}
	return symbol + nStr + nStrEnd;
}

// CSS Browser Selector   v0.2.5
// 06.28.07 JS
var css_browser_selector = function() {
    var ua = navigator.userAgent.toLowerCase(),
        is = function(t) {
          return ua.indexOf(t) != -1;
        },
        h = document.getElementsByTagName('html')[0],
        b = (!(/opera|webtv/i.test(ua)) && /msie (\d)/.test(ua)) ? ('ie ie' + RegExp.$1) : is('gecko/1.7.5') ? 'gecko' : is('opera/9') ? 'opera opera9' : /opera (\d)/.test(ua) ? 'opera opera' + RegExp.$1 : is('konqueror') ? 'konqueror' : is('applewebkit/') ? 'webkit safari' : is('mozilla/') ? 'gecko' : '',
        os = (is('x11') || is('linux')) ? ' linux' : is('mac') ? ' mac' : is('win') ? ' win' : '';
    var c = b + os + ' js';
    h.className += h.className ? ' ' + c : c;
}();