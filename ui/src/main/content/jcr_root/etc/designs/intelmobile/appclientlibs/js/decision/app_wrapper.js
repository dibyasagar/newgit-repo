/**
 * Provides requestAnimationFrame in a cross browser way.
 * http://paulirish.com/2011/requestanimationframe-for-smart-animating/
 */
 
if ( !window.requestAnimationFrame ) {

	window.requestAnimationFrame = (function(){
	  return  window.requestAnimationFrame       || 
	          window.webkitRequestAnimationFrame || 
	          window.mozRequestAnimationFrame    || 
	          window.oRequestAnimationFrame      || 
	          window.msRequestAnimationFrame     || 
	          function(/* function */ callback, /* DOMElement */ element) {
	            window.setTimeout(callback, 1000 / 60);
	          };
	})();
}



window.onload = function(){

	var initMS = 10,
		dt = getDeviceType();

	init();

	function init() {

		if ( dt == 'android' || dt == 'iphone' ) { hideAddressBar(); initMS = 50; }

		window.shopper_app = (function () {

			var shopper_app_globals = {
				device: {
					height: 640,//getDeviceHeight(),//Math.max( window.screen.height, window.innerHeight, window.outerHeight),
					width: window.innerWidth
				},
				app: $('#shopper-app'),
				useragent: getDeviceType(),
				scrollTimer: 0,
				autoScroll: false,
				heightSet: false
			};

			function setheight( h, cb ) {
				shopper_app_globals.device.height = ( typeof h !== 'undefined' ) ? h : getDeviceHeight();
				var appHeight = ( shopper_app_globals.device.height < 416 ) ? 416 : shopper_app_globals.device.height;
				//appHeight = ( appHeight > 800 ) ? 800 : appHeight;
				shopper_app_globals.app.css({'height': appHeight + 'px'});//, 1000, (cb || function(){}) );/*(cb || function(){})*/
				shopper_app_globals.heightSet = true;
				if ( typeof cb !== 'undefined' ) { cb(); }
			}

			function scrolltoapp( cb ) {
				//console.log( shopper_app_globals.heightSet );
				if (shopper_app_globals.scrollTimer != null) window.clearTimeout( shopper_app_globals.scrollTimer );
				if( !shopper_app_globals.heightSet ) {
					$('html,body').animate({'scrollTop': shopper_app_globals.app.offset().top + 'px'}, 500, setheight );
					shopper_app_globals.heightSet = true;
				} else {
					$('html,body').animate({'scrollTop': shopper_app_globals.app.offset().top + 'px'}, 500);
				}
			}

			function getDeviceHeight() {
				var h;
				if (getDeviceType() === 'iphone') {
					h = window.innerHeight;
				} else {
					window.scrollTo(0, 1);
					var d = document.createElement('div');
					d.setAttribute('id','getHeight'); d.style.position = 'absolute'; d.style.width = '100%'; d.style.height = '100%'; d.style.top = '0'; d.style.left = '0';
					document.getElementsByTagName('body')[0].appendChild(d);
					h = Math.max($(d).height(), window.innerHeight);
					document.getElementsByTagName('body')[0].removeChild(d);
					//alert('availHeight: ' + screen.availHeight + ', screen height: ' + screen.height + ', window innerHeight: ' + window.innerHeight );
				}

				if ( h < 416 ) { h = 416; }
				else if ( h > 640 ) { h = 640; }

				return h;
			}

			function documentExceedsWindowHeight(){
				return document.height > window.outerHeight;
			}

			var vendor = (function() {
				var vendors = ['webkit','Moz','o','ms',''];
				//alert("vendors: "+vendors);
				var d = document.createElement("div");
				for ( var i = 0; i < vendors.length; i++ ) {
					//alert("alert: "+typeof d.style[ vendors[i] + 'Transform']);
					if ( typeof d.style[ vendors[i] + 'Transform'] !== 'undefined' ) {
						return { 'css': '-' + vendors[i] + '-', 'event': vendors[i] };
						break;
					} 
				}
			})();
			//alert("called: "+vendor);
			if(vendor!==undefined)
			{
				var cssVendorPrefix = vendor.css;
				var vendorEventPrefix = vendor.event;
			}
			


			if ( getDeviceType() !== undefined ) {
				var orientationBlocker = document.createElement('div');
				orientationBlocker.setAttribute('class','orientation-blocker');
				shopper_app_globals.app[0].appendChild( orientationBlocker );
			} else {
				var nonMobileBlocker = document.createElement('div');
				nonMobileBlocker.setAttribute('class','non-mobile-blocker');
				//shopper_app_globals.app[0].appendChild( nonMobileBlocker );
			}

			//window.setTimeout( function(){ setheight( getDeviceHeight()/*, scrolltoapp */); }, initMS);

			$(window).bind('scroll', function() {
				if ( !shopper_app_globals.autoScroll ) { return; }
				window.clearTimeout( shopper_app_globals.scrollTimer );
				shopper_app_globals.scrollTimer = window.setTimeout(scrolltoapp, 2000);
			});
			if(window.addEventListener) {
			window.addEventListener("orientationchange", function() {
				if ( window.orientation % 90 == 0 ) {
					scrolltoapp();
				}
			}, false);
			}

			return {
				setHeight: setheight,
				scrollToApp: scrolltoapp,
				getHeight: function() {
					return getDeviceHeight();
				},
				getWidth: function(){
					return shopper_app_globals.device.width;
				},
				touchClick: 'createTouch' in document ? 'touchstart' : 'click',
				setAutoScroll: function( val ) {
					shopper_app_globals.autoScroll = ( typeof val === 'boolean' ) ? val : true;
				},
				cssPrefix: cssVendorPrefix,
				eventPrefix: vendorEventPrefix,
				unsetAppHeight: function() {
					shopper_app_globals.app.css('height','auto');
				}
			}

		})();

	}
}


/*---------------------- global function library ----------------------*/

//hides address bar on mobile
function hideAddressBar() {

	if(document.height < Math.max(window.outerHeight, window.innerHeight, window.screen.height) + 50 ) {
		var app = document.getElementById('shopper-app');
		app.style.height = Math.max(window.outerHeight, window.innerHeight,  window.screen.height) + 50 + 'px';
	}
	setTimeout( function(){ window.scrollTo(0, 1); }, 50 );
}

//returns platform in string
function getDeviceType(){
	var ua = navigator.userAgent.toLowerCase(),
		deviceType = undefined;

	if ( ua.match(/iphone/) !== null ) { deviceType = 'iphone'; }
	else if ( ua.match(/ipad/) !== null ) { deviceType = 'ipad'; }
	else if ( ua.match(/android/) !== null) { deviceType = 'android'; }

	return deviceType;
}

var bindCallBackFunction = function(scope, fn) {
	return function () {
		fn.apply(scope, arguments);
	};
}

function applyVendorPrefixes( cssObject ) {
	var returnObj = {};
	var obj = cssObject;
	for ( var p in obj ) {
		if ( p == 'transition' || p =='transform' ) {
			returnObj[ shopper_app.cssPrefix + p ] = obj[ p ];
		} else {
			returnObj[ p ] = obj[ p ];
		}
	}
	return returnObj;
}

var delay = function( f, t ) {
	var dur = t || 100;
	if ( typeof f === 'function') { return window.setTimeout(f,t); }
}

function trackPage(pageTitle) {
	if (typeof _gaq === 'undefined' ) { return; }
	if (pageTitle && typeof pageTitle == 'string') {
		_gaq.push(['_trackPageview', pageTitle]);
    }
}

function trackEvent(category, action, optlabel, optValue) {
	if (typeof _gaq === 'undefined' ) { return; }
	if (category && action && optlabel && optValue) {
		_gaq.push(['_trackEvent', category, action, optlabel, optValue]);
	} else if (category && action && optlabel) {
		_gaq.push(['_trackEvent', category, action, optlabel]);
	} else if (category && action) {
		_gaq.push(['_trackEvent', category, action]);
    }
}

function parseURL() {
	var paramObject = undefined; //{ access_token: false, expires_in: false };
	var params = window.location.hash.substring(1).split('&');
	if (params.length >= 1 && params[0] != "") {
		paramObject = {};
		for (var i = 0; i < params.length; i++) {
			var pair = params[i].split("=");
			paramObject[pair[0]] = pair[1];
		}
	}
	return paramObject;
}
