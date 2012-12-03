intel.initCoreMetaphores = function(){
	function loaded() {
		if ( typeof window.shopper_app === 'undefined' ) {
			window.setTimeout(loaded, 1000);
			return;
		}
		core_metaphors();
	};

	loaded();
}	

	

	var Arm = function( el ) {
		this.self = el;
		this.rotation = 30;
		this.currentRotation = 30;
		this.startRotation = 30;
		this.maxRotation = -30;
		this.rotationRange = 60;
		this.draggable = true;
		this.hasTransition = false;
		this.callbackFunction = undefined;
		this.onfirstpull = undefined;
		this.onfirstpullcancel = undefined;
		this.firstPull = true;
		this.activeThreshold = 0;
	}

	Arm.prototype = {
		calculateRotation: function( delta ) {
			this.rotation = this.startRotation + (-this.rotationRange * delta);
		},
		pull: function( delta ) {
			if ( this.draggable ) {
				
				this.calculateRotation( delta );
				this.track();
				if ( this.currentRotation <= this.activeThreshold ) {
					if ( this.firstPull && this.onfirstpull !== undefined ) { delay( bindCallBackFunction(this, this.onfirstpull), 200 );  }
				} else {
					if ( this.firstPull && this.onfirstpullcancel !== undefined ) { delay( bindCallBackFunction(this, this.onfirstpullcancel), 200 );  }
				}
			}
		},
		removeTransition: function() {
			this.self.css( applyVendorPrefixes({'transition': 'none'}) );
		},
		swingBack: function() {
			if ( this.callbackFunction !== undefined && this.currentRotation <= this.activeThreshold ) {
				this.callbackFunction();
			}
			if (  this.firstPull && this.currentRotation <= this.activeThreshold ) {  
				this.firstPull = false;
				//tracking
				trackEvent('core_metaphors','start','start_core_metaphors');
			}

			this.self.css( applyVendorPrefixes({'transition': 'all .8s cubic-bezier(0.2,1,0,1)'}) );
			this.rotation = this.startRotation;
			this.draggable = false;
			delay( bindCallBackFunction( this, this.track ), 50 );
			delay( bindCallBackFunction( this, function(){
				this.removeTransition();//self.css( applyVendorPrefixes( {'transition': 'none'} ) );
				this.draggable = true;
			}), 1000);
		},
		track: function() {
			this.currentRotation = this.rotation;
			if (this.currentRotation < this.maxRotation ) { this.currentRotation = this.maxRotation; }
			this.self.css( applyVendorPrefixes({'transform': 'rotate(' + this.currentRotation.toFixed(2) +'deg)'}) );
		},
		anim: function() {
			this.self.css( applyVendorPrefixes({'transition': 'all 1.5s cubic-bezier(.5,1,0,1)'}) );
			this.currentRotation = this.rotation;
			delay( bindCallBackFunction( this, this.track ), 500 );
		},
		hide: function() {
			this.self.css( applyVendorPrefixes({'transition': 'all .5s cubic-bezier(.5,1,0,1)'}) );
			delay( bindCallBackFunction( this, function(){ this.self.css( applyVendorPrefixes({'transform': 'translate3d(100px,0,0) rotate(' + this.currentRotation + 'deg)'}) ); } ), 100 );
		},
		show: function() {
			this.self.css( applyVendorPrefixes( {'transform': 'translate3d(0,0,0) rotate(' + this.currentRotation + 'deg)'} ) );
			delay( bindCallBackFunction( this, function(){
				this.removeTransition();
				this.draggable = true;
			}), 1500);
			
		},
		init: function() {

		},
		onAfterPull: function( func ) {
			if (typeof func === 'function') {
				this.callbackFunction = func;
			}
		},
		onFirstPull: function( func ) {
			if (typeof func === 'function') {
				this.onfirstpull = func;
			}
		},
		onFirstPullCancel: function( func ) {
			if (typeof func === 'function') {
				this.onfirstpullcancel = func;
			}
		}
	}

	function Game() {
		this.metaphors = [{
			name: 'dance moves',
			nameImage: 15,
			images: [0, -112, -221],
			copy: [	'It might look simple but the twist is a knee-knobbing bucket of good times. Same goes for the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3. Its built-in graphics always keep eyes dancing — whether you\'re watching movies, editing photos or surfing the web.',
					'Ready to step up your swagger? Get in sync with the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5. Featuring Intel<sup>&reg;</sup> Hyper-Threading Technology, this versatile processor can handle multiple tasks without missing a beat. Heeeyyyyyyy Macarena!',
					'The tango is a highly technical dance…and the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7 is a highly technical processor. Our top-of-the-line engine deftly handles stunning HD visuals, complex design creations and demanding programs with style to spare. In two words: muy bien!']
		}, {
			name: 'Legends',
			nameImage: -30,
			images: [-328, -432, -545],
			copy: [	'Maestros of money, these imps know value when they see it. And the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3 doesn’t disappoint. From syncing up to your TV to chatting with your former college roommates online, it delivers impressive performance at an incredible price.',
					'Half man, half horse, the centaur is all about balancing smarts with speed — much like the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5. Its visibly smart performance makes quick work of creating, editing and sharing videos. Want more? It swashbuckles through web pages and business programs with noble savagery.',
					'Want to make PC magic? The unicorn of processors, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7, is made of digital pixie dust. HD. 3D. Multitasking. Multimedia. And more. This unbelievably fast engine can keep up with anything and everything you throw its way.']
		}, {
			name: 'Singers',
			nameImage: -76,
			images: [-648, -756, -863],
			copy: [	'Down to earth in price but stunning in performance, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3 is like a folk tune that strums to a beautiful rhythm. Its power chords are rich visuals, life-like audio and multitasking without missing a note. Encore! Encore!',
					'The Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5 has plenty of moves to pump up any party. Wirelessly stream content to your HDTV. Face off with rivals via the latest games. Share your latest photos and videos. No matter what you’re into, this engine always scores high on the “what’s hot” charts.',
					'Opera is the ultimate stage for a singer’s potential. Likewise, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7 is the ultimate centerpiece for your creativity. Whether you’re editing a cinematic masterpiece or mixing music that will shake the world, prepare to push your creativity to decibel-shattering levels.']
		}, {
			name: 'Soccer move',
			nameImage: -121,
			images: [-972, -1078, -1187],
			copy: [	'Just like the pullback turn, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3 is all about helping you carve out space for your next big move. And with 4-way multiprocessing, you’ll easily sidestep all obstacles as you simultaneously share videos, listen to music and lob messages across your social networks.',
					'The stepover is essential to any serious player’s arsenal. Likewise, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5 is a key component to serious computing. Featuring Intel<sup>&reg;</sup> Turbo Boost Technology, this engine delivers an extra shot of power whenever you’re ready to make your signature strike.',
					'With its dynamic delivery, the bicycle kick completely changes the game. Same goes for the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7. Boasting Intel<sup>&reg;</sup> HD Graphics and Intel<sup>&reg;</sup> Clear Video HD Technology, you’ll have a front row seat to in-your-face action like never before.']
		}, {
			name: 'Dogs',
			nameImage: -167,
			images: [-1294, -1400, -1508],
			copy: [	'Despite it\'s cute looks, the Pomeranian is a brave and loyal companion. So is the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3. Capable of four-way multitasking, the Core i3 can easily accommodate simultaneous web browsing, movie watching and photo editing. It’s the real deal in a feisty package.',
					'Make no mistake: bulldogs are friendly but also tenacious. And when it comes to processors, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5 is their equal. Packed with smart performance, this engine has plenty of power to astound you with HD visuals and stunning productivity.',
					'Dignity. Elegance. And raw strength. These are the qualities of both a Great Dane and Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7 processor. (Trust us, the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7 is totally dignified.) With visually smarter performance, this engine handles Herculean tasks like cutting-edge web design with the utmost ease.']
		}, {
			name: 'Yoga Moves',
			nameImage: -213,
			images: [-1616, -1724, -1830],
			copy: [	'Sure, it sounds like it\'s ready to punch a hole through the planet. But the warrior pose is all about inner harmony. Same goes for the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3. Powered by dual-core processors, it has the power and speed to help you get things done and enjoy doing them.',
					'The tree is all about striking a balance between poise, strength and…well, balance. That’s why it’s the perfect analogy for the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5. Responsive, efficient and able to handle complex tasks with ease, it’s the ideal processor for gearing up or winding down.',
					'Execute this pose and it’s obvious this ain’t your first time on a yoga mat. If you’re looking for similar flexibility on a computer, count on the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7. With our richest set of features, it delivers visually smart performance that’s built to stretch your limits.']
		}, {
			name: 'future',
			nameImage: -258,
			images: [-1942, -2050, -2158],
			copy: [	'The Jet Pack is essential tech for tomorrow. And so is the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i3. Capable of four-way multitasking, you’re equipped to soar into the latest movies, hop onto the Internet or put the finishing touches on your memoirs. It’s a tiny piece of tomorrow packed into the PC of today.',
					'Why drive when you can fly? The same thinking applies to the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i5 processor. Able to handle lifelike graphics without shifting gears, this engine can breeze through movie editing, HD movies and online searches with top gear performance.',
					'A to B to Z? Done, done and done. Teleporters and the Intel<sup>&reg;</sup> Core<sup>&trade;</sup> i7 are the way of the future. Why? This engine can be everywhere at once. From complex tasks like movie editing to invading an online gaming galaxy, its capabilities know no bounds.']
		}

		];
		this.selectIndex = 0;
	}

	Game.prototype = {
		selectNextMetaphor: function() {
			this.selectIndex = (this.selectIndex + 1) % this.metaphors.length;
			return this.metaphors[ this.selectIndex ];
		},
		shuffle: function() {
			for(var j, x, i = this.metaphors.length; i; j = parseInt(Math.random() * i), x = this.metaphors[--i], this.metaphors[i] = this.metaphors[j], this.metaphors[j] = x);
		}
	}

function core_metaphors() {
	
	_globals = {
		wrapper: $('.core-metaphors'),
		appHeight: shopper_app.getHeight(),
		appWidth: $('.core-metaphors').width(),
		swipeZone: $('.swipe-zone'),
		swipeZoneOffset: $('.swipe-zone').offset().top,
		swipeZoneActive: true,
		cores: $('.core'),
		swipeZoneLimit: 280,
		swipeStart: 0,
		currentSwipeY: 0,
		arm: new Arm( $('.metaphore-arm') ),
		touchCapable: (shopper_app.touchClick == 'touchstart') ? true : false,
		appOffsetY: $('.core-metaphors').offset().top,
		isDraggingArm: false,
		gameStarted: false,
		uiElements: {
			splashRibbon: $('.ribbon'),
			gameSections: $('.app-container'),
			swipeRibbon: $('.swipe-ribbon'),
			spinAgain: $('.spin-again'),
			gameInstructions: $('.game-instructions'),
			ghostArms: $('.ghost-arms '),
			processorCarousel: $('.processor-carousel'),
			processorCarouselContainer: $('.processor-carousel-container'),
			processorTable: $('.processor-desc'),
			compareProcessorsBtn: $('.compare-processors'),
			backToMetaphors: $('.back-to-metaphors'),
			motionBlur: $('.motion-blur'),
			theMetaphor: $('.the-metaphor span'),
			textBlur: $('.the-metaphor b')
		},
		slides: $('.slide'),
		slideSelector: $('.processor-selector a'),
		metaphorGraphics: $('.metaphor-graphic'),
		game: new Game(),
		appTransitioning: false,
		screens: [ $('.splash .section-content'), $('.game .section-content'), $('.metaphor-desc .section-content') ],
		firstMetaphor: true,
		currentMetaphor: '',
		isSpinning: false
	};

	var getMousePosition = function( evnt ) {
		if (evnt.type == 'touchstart' || evnt.type == 'touchmove' || evnt.type == 'touchend' ) {
			var e = (typeof evnt.touches === 'undefined') ? evnt.originalEvent : evnt;
			touchClick = { x: e.touches[0].pageX, y: e.touches[0].pageY };
		} else {
			touchClick = { x: evnt.pageX, y: evnt.pageY };
		}
		return touchClick;
	}

	var changeSlide = function( index ) {
		var slides = _globals.slides,
			len = slides.length;

		while ( len-- ) {
			if ( len == index ) {
				$( slides[ len ] ).addClass('slide-active').css( applyVendorPrefixes({ 'transform': 'translate3d(0,0,0)', 'opacity': 1 }));
			} else if ( len > index ) {
				$( slides[ len ] ).removeClass('slide-active').css( applyVendorPrefixes({ 'transform': 'translate3d(' + _globals.appWidth + 'px,0,0)', 'opacity': 0}) );
			} else {
				$( slides[ len ] ).removeClass('slide-active').css( applyVendorPrefixes({ 'transform': 'translate3d(' + (_globals.appWidth * -1) + 'px,0,0)', 'opacity': 0}) );
			}
		}
	}

	var setSlideContent = function( metaphor ) {
		var m = metaphor;
		_globals.slides.each(function( i ) {
			$('p', this).html( m.copy[ i ] );
			$('.slide-icon', this).css({'background-position': m.images[ i ] +'px 0'});
		});
	}

	var getNextMetaphor = function() {
		disableSwipes();
		var meta = _globals.game.selectNextMetaphor();
		hideMetaphorText();
		setSlideContent( meta );
		delay( function(){ _globals.uiElements.theMetaphor.css('background-position','0 ' + meta.nameImage + 'px'); }, 200);
		delay( showMetaphorText, 500);
		delay( hideMetaphorGraphics, 400);
		delay( function(){ _globals.metaphorGraphics.each(function( i ) { $(this).css({'background-position': meta.images[ i ] + 'px 0'}); }); }, 1200);
		delay( showMetaphorGraphics, 2200 );
		//tracking
		trackPage('/core_metaphors/spin');
		trackEvent('core_metaphors','spin','spin');
		trackEvent('core_metaphors','system_measure','metaphor_displayed', meta.name); // 4th param must be int
		if ( _globals.firstMetaphor ) {
			trackEvent('core_metaphors','system_measure','first_metaphor', meta.name);
		}
		_globals.currentMetaphor = meta;
	}

	var hideMotionBlur = function() {
		_globals.uiElements.motionBlur.css('display', 'none');
	}

	var showMotionBlur = function() {
		_globals.uiElements.motionBlur.css('display', 'block');
	}

	var hideMetaphorGraphics = function( ) {
		showMotionBlur();
		delay( function(){ _globals.metaphorGraphics.css( applyVendorPrefixes({ 'transform': 'translate3d(0,100px,0)', 'opacity': 0}) ); }, 350);
	}

	var showMetaphorGraphics = function( $obj ) {

		_globals.metaphorGraphics.each(function( i ) {
			var $this = $(this);
			$this.css( applyVendorPrefixes({ 'transform': 'translateY(-100px) translateZ(0)'}) );
			delay(function(){ $this.css( applyVendorPrefixes({ 'transform': 'translate3d(0,0px,0)', 'opacity': 1}) ); }, 200 * i);
		});

		delay(function(){ enableSwipes(); hideMotionBlur(); enableSwipes(); }, 600);
	}

	var hideMetaphorText = function() {
		_globals.uiElements.textBlur.css('display','block');
		_globals.uiElements.theMetaphor.css( applyVendorPrefixes({'transform': 'translate3d(0,50px,0)', 'opacity': 0}) );
	}

	var showMetaphorText = function() {
		_globals.uiElements.theMetaphor.css( applyVendorPrefixes({'transform': 'translate3d(0,-50px,0)', 'opacity': 0}) );
		delay( function(){ 
			_globals.uiElements.theMetaphor.css( applyVendorPrefixes({'transform': 'translate3d(0,0px,0)', 'opacity': 1}) );
			_globals.uiElements.textBlur.css('display','none');
		}, 100);
	}


	var disableSwipes = function() {
		_globals.swipeZone.css('display','none');
		_globals.isSpinning = true;
	}

	var enableSwipes = function() {
		_globals.swipeZone.css('display','block');
		_globals.isSpinning = false;
	}

	var showHelperRibbon = function() {
		_globals.uiElements.swipeRibbon.css( applyVendorPrefixes( {'transform': 'translate3d(0,0,0)'}) );
	}

	var hideHelperRibbon = function() {
		_globals.uiElements.swipeRibbon.css( applyVendorPrefixes( {'transform': 'translate3d(0,-100px,0)'}) );
	}

	var hideArm = function() {
		_globals.arm.hide();
		_globals.swipeZoneActive = false;
	}

	var showArm = function() {
		_globals.arm.show();
		_globals.swipeZoneActive = true;
	}

	var startGame = function() {
		_globals.uiElements.splashRibbon.css( applyVendorPrefixes({'transform':'translate3d(0,-200px,0)'}) );
		delay(function(){ moveToSection(1); shopper_app.scrollToApp(); }, 1000);
		delay(showHelperRibbon, 2000);
		_globals.gameStarted = true;
		delay( function(){ shopper_app.setAutoScroll( true);  }, 2000);
	}

	var moveToSection = function( sectionIndex ) {
		var translate = sectionIndex * -_globals.appHeight;
		if ( sectionIndex > 0 ) {
			//delay( function(){ _globals.screens[0].css('display','none'); }, 2600);
		}
		if (sectionIndex == 2) { 
			hideProcessorTable(); 
			//hide game and splash screen to prevent redrawing them
		}
		_globals.uiElements.gameSections.css( applyVendorPrefixes({'transform': 'translate3d(0,' + translate + 'px,0)'}) );
	}

	var onafterhandlepull = function() {
		if ( _globals.gameStarted ) { getNextMetaphor(); } else { startGame(); getNextMetaphor(); }
	}

	var showProcessorTable = function() {
		var h = _globals.uiElements.processorCarouselContainer.height();
		_globals.uiElements.processorCarouselContainer.css( applyVendorPrefixes({'transform': 'translate3d(0,' + (h*-1) + 'px,0)'}) );
		_globals.uiElements.processorTable.css( applyVendorPrefixes({'transform': 'translate3d(0,0px,0)'}) );
	}

	var hideProcessorTable = function() {
		var h = _globals.uiElements.processorCarouselContainer.height();
		_globals.uiElements.processorCarouselContainer.css( applyVendorPrefixes({'transform': 'translate3d(0,0px,0)'}) );
		_globals.uiElements.processorTable.css( applyVendorPrefixes({'transform': 'translate3d(0,' + h +  'px,0)'}) );
	}
	var handlegameTouch = function( e ) {
		e.preventDefault();
		if ( _globals.isSpinning ) { return; }
		var target = $(this).attr('data');
		changeSlide( target );
		_globals.slideSelector.removeClass('active');
		$(_globals.slideSelector[ target ]).addClass('active');
		moveToSection(2);
		disableSwipes();
		delay( function(){ hideArm(); hideHelperRibbon(); }, 500);
		//tracking
		var processorTranslation = ['i3','i5','i7'];
		trackPage('/core_metaphors/' + _globals.currentMetaphor.name + '_' + processorTranslation[ target ] );
	}

	/* event handlers */
	_globals.swipeZone.bind( 'click', function( e ) {
		e.preventDefault();
	});

	_globals.swipeZone.bind( (_globals.touchCapable) ? 'touchstart' : 'mousedown', function( event ) {
		event.preventDefault();
		$(this).css({'width': '100%', 'height': '100%'});
		var e = getMousePosition( event );
		if ( e.y > _globals.swipeZoneLimit ) { return; }
		_globals.swipeStart = e.y - ( _globals.swipeZoneOffset + 10 );
		_globals.isDraggingArm = true;
		
	});

	_globals.swipeZone.bind( (_globals.touchCapable) ? 'touchmove' : 'mousemove', function( event ) {
		event.preventDefault();
		var e;
		
		if ( _globals.isDraggingArm /*&& _globals.swipeZoneActive*/ ) {
			e = getMousePosition( event );
			e.y -= _globals.swipeZoneOffset + 10;
			//if ( e.y > _globals.swipeZoneLimit ) { _globals.isDraggingArm = false; _globals.arm.swingBack(); return; }
			e.y = (e.y < 0) ? 0 : e.y;
			var amount = ( e.y - _globals.swipeStart ) / _globals.swipeZoneLimit;
			_globals.arm.pull( amount );
		}
	});

	_globals.swipeZone.bind( (_globals.touchCapable) ? 'touchend' : 'mouseup', function( event ) {
		event.preventDefault();
		$(this).css({'width': '150px', 'height': '150px'});
		if ( _globals.isDraggingArm ) {
			_globals.isDraggingArm = false;
			_globals.arm.swingBack();
		}
	});

	_globals.cores.bind( shopper_app.touchClick, handlegameTouch );

	$('.overlay a').bind( shopper_app.touchClick, handlegameTouch);

	_globals.uiElements.spinAgain.bind( shopper_app.touchClick, function( e ) {
		e.preventDefault();
		moveToSection(1);
		delay( showArm, 1000);
		delay( function(){ showHelperRibbon(); enableSwipes(); }, 1500);
		//tracking
		trackEvent('core_metaphors','back','play_again');
	});

	_globals.slideSelector.bind( shopper_app.touchClick, function( e ) {
		e.preventDefault();
		var $this = $(this);
			target = $this.attr('data');

		_globals.slideSelector.removeClass('active');
		$this.addClass('active');
		changeSlide( target );
	});

	_globals.uiElements.compareProcessorsBtn.bind( shopper_app.touchClick, function( e ) {
		e.preventDefault();
		showProcessorTable();
		//tracking
		trackPage('/core_metaphors/compare_processors');
	});

	_globals.uiElements.backToMetaphors.bind( shopper_app.touchClick, function( e ) {
		e.preventDefault();
		hideProcessorTable();
	});

	//init
	(function(){

		shopper_app.setHeight();
		var appWidth = _globals.wrapper.width();

		_globals.game.shuffle();
		_globals.arm.hide();

		//var metaphorSprite = new Image();
		//metaphorSprite.src = '../images/core_metaphors/metaphors.png';

		//metaphorSprite.onload = function() {}

		var animationSupported = (function() {
			var vendors = ['webkit','Moz','o','ms',''];
			var d = document.createElement("div");
			if( typeof d.style.animationName !== 'undefined' ) { return true; } 
			for ( var i = 0; i < vendors.length; i++ ) { if ( typeof d.style[ vendors[i] + 'AnimationName'] !== 'undefined' ) { return true; } }
			return false;
		})();

		_globals.arm.onAfterPull( onafterhandlepull );
		_globals.arm.onFirstPull( function() {
			_globals.uiElements.splashRibbon.css( applyVendorPrefixes({'transform':'translate3d(0,0,0)'}) );
			_globals.uiElements.gameInstructions.css({'opacity': 0});
			_globals.uiElements.ghostArms.css({'opacity': 0});
		});
		_globals.arm.onFirstPullCancel( function() {
			_globals.uiElements.splashRibbon.css( applyVendorPrefixes({'transform':'translate3d(0,-180px,0)'}) );
			_globals.uiElements.gameInstructions.css({'opacity': 1});
			_globals.uiElements.ghostArms.css({'opacity': 1});
		});
		
		delay( function(){ 
			_globals.arm.self.css('opacity',1);
			showArm(); 
			_globals.uiElements.ghostArms.css({'opacity': 1});
		}, 1000 );

		hideProcessorTable();

		$('.app-container').css('height', parseInt(_globals.appHeight * 3) + 'px');
		$('.app-container > .section').css('height', _globals.appHeight + 'px');
	})();

}


