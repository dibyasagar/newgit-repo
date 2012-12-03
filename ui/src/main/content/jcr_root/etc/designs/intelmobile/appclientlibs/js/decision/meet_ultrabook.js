intel.initMeetUltrabook = function(){
	
	var setSizes = function () {
		var h  = window.innerHeight;
		var w  = window.innerWidth;			
		
		if (h <= 416){			
			$("#shopper-app").addClass('apple');
		};   

		if (h >= 530){
			$("#shopper-app").addClass('lg');
			var mar = window.innerHeight - $("ul").height();	
			// $("#logo").css("top",mar);	
			// $(".ultraBook.lg #primary ul").css("margin-bottom",mar * -1);
			$(".ultraBook.lg li:last-child").width(w);
		};   

        // this helps detect minor versions such as 5_0_1
        if(/(iPhone|iPod|iPad)/i.test(navigator.userAgent)) { 
		    if(/OS [2-4]_\d(_\d)? like Mac OS X/i.test(navigator.userAgent)) {  
		        // iOS 2-4
		        return;
		    } else if(/CPU like Mac OS X/i.test(navigator.userAgent)) {
		        // iOS 1 so Do Something 
		        return;
		    } else {
		      $(".apple ul").css("background-image","url(/etc/designs/intelmobile/img/decision/meet-ultrabook-full_highres.png) left top no-repeat transparent");
		    }
		}

		$(".fb-like").css("margin-left",  ( $(w) / 2 )  - ( $(".fb-like").width() / 2) );

	};	
	setSizes();
	
	function loaded() {
		if ( typeof window.shopper_app === 'undefined' ) {
			window.setTimeout(loaded, 500);
			return;
		}
		ultraBook();
	}
	
	loaded();
	
	var ultraBook = function (){
 		trackPage('meet-ultrabook');
 		var yTouch, isDragging = false;
 		var touchCapable = ( shopper_app.touchClick == 'touchstart' ) ? true : false;
		//events
		window.shopper_app.setHeight();		
		$(".touchArea").bind( window.shopper_app.touchClick, function( event ) {			

					window.shopper_app.scrollToApp();
					trackEvent('meet_ultrabook','start', 'meet_ultrabook' );
					// var mar = (window.innerHeight - $("ul").height() ) / 2;		
					// $(".ultraBook.lg #primary").css({"margin-top":mar,"margin-bottom":mar* -1});					

		});		

		$(".hotSpot").click(function(e) {
			if ( !$("#support").hasClass("show") ) {			 	
			 	updateContent($(this));
			 	showCallout($(this),mouseCords(e));	
			 	shopper_app.scrollToApp(); //centers app when user selects a callout 	
			}		
		});


		$("#blocker,#close").click(function() { 		
				 hideCallout();
				 shopper_app.scrollToApp(); //centers app when user selects a callout 	
	 	});

		$('.touchAreaTop,.touchAreaBottom').bind( ( touchCapable ) ? 'touchstart' : 'mousedown', function( e ){
			var evnt = getMousePosition( e );
			yTouch = evnt.y;
			isDragging = true;
		});

		$('.touchAreaTop,.touchAreaBottom').bind( ( touchCapable ) ? 'touchmove' : 'mousemove', function( e ){
			if ( !isDragging ) { return; }
			shopper_app.setAutoScroll( false );
			var evnt = getMousePosition( e );
			var yTouch2 = evnt.y;			
			var diff = yTouch - yTouch2;			
			if ( Math.abs( diff ) > 3 ) {
				var windowScrollTop = $(window).scrollTop() + diff;
				$('html,body').scrollTop( windowScrollTop );
			}

		});

		$('.touchAreaTop,.touchAreaBottom').bind( ( touchCapable ) ? 'touchend' : 'mouseup', function( e ){
			isDragging = false;			
		});

		var getMousePosition = function( evnt ) {
			if (evnt.type == 'touchstart' || evnt.type == 'touchmove' || evnt.type == 'touchend' ) {
				var e = (typeof evnt.touches === 'undefined') ? evnt.originalEvent : evnt;
				touchClick = { x: e.touches[0].pageX, y: e.touches[0].pageY };
			} else {
				touchClick = { x: evnt.pageX, y: evnt.pageY };
			}
			return touchClick;
		}	

		var showCallout = function(o,rels) {
			var pos = getCords(o);	
			var tp = pos.top;		

			if(tp <= 100){			
				tp = 250;
			};
			if(( rels.X + $("#callout").width()) >= $("#primary").width()){
				$("#callout").css({
				opacity: 1.0,
				'z-index':1,
				left: ( $("#primary").width() - $("#callout").width() ) -20 ,
				top: tp - 70
			});

			}else{
				$("#callout").css({
					opacity: 1.0,
					'z-index':1,
					left: 20,
					top: tp -70
				});
			}
		}

		var getCords = function(o){ 		
	 		var cords = { 
	 			top : Math.floor($(o).position().top),
	 			left : Math.floor($(o).position().left)
	 			} 		 
	 		 return(cords); 
		};	

		var mouseCords = function (evt) {		
			  var offset = $("#primary").offset();		  
			  var rels = {
			  	X : Math.floor((evt.pageX - offset.left)),
			  	Y : Math.floor((evt.pageY - offset.top))
			  }
			 return (rels);
		}

		var updateContent = function (o) {
		 	$('#callout p').replaceWith('<p>'+callOutContent[$(o).index()-3]+'</p>');
		 	$('#support p').replaceWith('<p>'+spotContent[$(o).index()-3]+'</p>');
		 	$('#support,#blocker').addClass('show');		
			$("#callout p ").css('margin-top',Math.floor(($("#callout").height()- $("#callout p ").height() ) / 2)); 	
		};

		// content
		var callOutContent = [
		"Less than an inch thick for exceptional mobility.",
		"Built-in security for extra peace of mind.",
		"Watch HD movies in stunning visual clarity.",			

		"Sleek profile always stands out from the crowd.",
		"Stay connected anywhere and everywhere.",		
		"Blazing fast to keep up with your creativity.",

		"Create & edit photos on the fly.",
		"Access your social networks in a flash.",
		"Bring a library of music wherever you go."
		];

		var spotContent = [
		"With its thin profile and lightweight design, Ultrabook<sup>&trade;</sup> is the optimal choice for taking your creativity to new places.",		
		"Intel<sup>&reg;</sup> Anti-Theft Technology protects your data by disabling your lost or stolen Ultrabook<sup>&trade;</sup> from anywhere in the world.<sup>2</sup>",
		"Enjoy smoother, sharper and richer cinematic experiences with built-in HD visuals.<sup>1</sup>",

		"Make a statement the minute you walk out the door with Ultrabook’s<sup>&trade;</sup> thin yet powerful design.",
		"Features Intel<sup>&reg;</sup> Smart Connect Technology to automatically update apps, social networks &amp; more — even when the system is asleep.<sup>3</sup>",		
		"Intel<sup>&reg;</sup> Turbo Boost Technology provides an automatic burst of speed whenever you need it for performance that adapts to you.<sup>4</sup>",


		"Powered by Intel<sup>&reg;</sup> Core<sup>&trade;</sup> processors, Ultrabook<sup>&trade;</sup> packs plenty of computing muscle to handle complex creative tasks with ease.",
		"Intel<sup>&reg;</sup> Rapid Start Technology returns your Ultrabook<sup>&trade;</sup> to full operational power within seconds after startup.<sup>5</sup>",
		"From its ultra-light design to extra long battery life, Ultrabook<sup>&trade;</sup> is the ultimate package of style and entertainment."
		];

		// tracking 


		$('#shopSpot a').bind( shopper_app.touchClick, function( e ) {
				e.preventDefault();
				var optLabel = $(this).attr('data'),
					pageTarget = $(this).attr('href');
				//tracking
				trackEvent('meet_ultrabook','main_menu', optLabel );
				//delay(function{}, 50);
				window.setTimeout( function(){ window.location.href = pageTarget; }, 50);
			});

		$(".spot").bind( shopper_app.touchClick , function( e ) {			
			var evtLabel = $(this).attr('data'),
				pageTarget = $(this).attr('href');
				//tracking
				trackEvent('meet_ultrabook','select_node', evtLabel );

			});

		$("a.outbound").bind( shopper_app.touchClick , function( e ) {			
			var pageTarget = $(this).attr('href');
				trackEvent('meet_ultrabook','outbound_link', 'deep_ultrabook_info' );
				window.setTimeout( function(){ window.location.href = pageTarget; }, 50);
			});

};

 // globals

	var hideCallout = function() {

		$('#support, #blocker').removeClass('show');
		$("#callout").css({
			'z-index':0,
			"opacity": "0"
		});
	};	

	
	 var slidePos = function(){	
	 	//snapTofirstSlide();
		var theWidth = $("ul li:first-child").width() + $("ul li:nth-child(2)").width();
		var xPos= this.myScroll.x * -1;

			if(xPos >= theWidth ){		      
		       trackEvent('meet_ultrabook','end', 'end_meet_ultrabook' );
		    }else{

		    };

		    if(xPos >= 160 ){
		        $("#ubLogo").css("opacity","1.0");
		    }else{
		     	$("#ubLogo").css("opacity","0.0");	
		  		//var mar = (window.innerHeight - $("ul").height() ) / 2;	
				// $("#logo").css("top",mar);	


		    };


		};

	return {
		hideCallout: hideCallout,
		slidePos: slidePos
	}
		
		
}

		

		