var intel = intel || {};
intel.mobile = {

    init: function() {
    
        var self = this;
        
        // Will supress console.log() if false or removed.
        // Only for use in dev, remove for production or set to false.
        this.debug = true;
        
        /* 
        IMPORTANT: 
        There is a bug in Android OS 4.0.4 (Ice Cream Sandwich) that's causing the drop-down menus 
        in the header not to work when animated with transform3d. Adding a specific CSS class to the
        header so we can make a CSS exception for the specific version of Android OS.
        */
        if (self.constants.isAndroidOS404) {
            $("header").addClass("ics404");
        }
        if (self.constants.isiPhone3) {
            $('html').addClass('iphone3');
        }

        // Call functions when DOM is ready, with proper context
        $(function(){ self.domReady.call( self ); });

    },

    // Set any constants here
    constants: {
        isAndroidOS404: (navigator.userAgent.toLowerCase().indexOf("android 4.0") > -1) ? true : false,
        isiPhone3: (navigator.userAgent.toLowerCase().indexOf("iphone os 4_3_5") > -1) ? true : false,
        isAndroidOS23x: (navigator.userAgent.toLowerCase().indexOf("android 2.3") > -1) ? true : false,
        isBlackberry: (navigator.userAgent.toLowerCase().indexOf("blackberry") > -1) ? true : false
    },

    // Common lookups
    cache: {
        body:           $('body'),
        window:         $(window),
        document:       $(document),
        globalHeader:   $('header'),
        headerBar:      $('#header-bar'),
        main:           $('#main'),
        ultra_content:  $('#ultrabook_content'),
        footer:         $('.footer'),
        ultra_content:  $('#ultrabook_content'),
        searchTerm:     $('#search-term'),
        searchClear:    $('#clear-search'),
        disclaimer:     $('#disclaimers'),
        accordion:      $('.accordion')
    },
    
    
    /**************************************
    * Call global DOM ready functions
    * 
    **************************************/
    domReady: function () {

        var self = this;

        self.console();

        // Init header & footer
        self.module.globalHeader.init();
        self.module.globalFooter.init();
        MBP.hideUrlBarOnLoad(); 
    },



    /************************************
    * Prop to contain global JS utilities.
    * 
    ************************************/
    utils: {
        
        /**
        * Function explanation
        * 
        * @usage demo usage
        * @name sampleFunction
        */
        sampleFunction: function() {
            // doSomething()
        },

        /**
        * Callback for change event of select box that should navigate to 
        * selected <option value="URL HERE"> URL.
        * Context (this) should be the select box.
        * 
        * @usage $('#selectID').on('change', intel.mobile.utils.navigateFromSelect);
        * @name sampleFunction
        */
        navigateFromSelect: function() {
            var myUrl = $(this).val();

            if(myUrl.length) {
                if( myUrl.indexOf('http') < 0 ) {
                myUrl = window.location.protocol + "//" + window.location.host + myUrl;
            } 
                window.location = myUrl;
            }
        }
        
    },
    
    /************************************
    * Globl modules
    * 
    ************************************/
    module: {
        
        globalHeader: {
            
            init: function(){
                this.initHeaderMenus();
                this.initSiteSearch();
                this.clearSelected();
            },

            // clear selected menus
            clearSelected: function() {
                var selectEl = $('#category-menu select')
                selectEl.each(function(idx){
                    this.selectedIndex = 0;
                });
            },
            
            // Init header "Search" and "Menu" menus
            initHeaderMenus: function(){
                
                var cachedElements  = intel.mobile.cache,
                    openMenu, open, close;

                // Bind event handlers for menu triggers
                cachedElements.globalHeader.on( 'click', '.dropdown-trigger', function(event) {

                    event.preventDefault();

                    var menuId = $(event.currentTarget).attr("href"),
                        $menu = $(menuId),
                        elStyle;

                    // Activated trigger has an open menu alread, close it
                    if ( $menu.is( openMenu ) ) {

                        // Close menu
                        $menu.trigger( 'close.dropdown' );

                        // Hide trigger indicator
                        $(this).parent().removeClass( 'active' );

                        // Clear open menu
                        openMenu = false;

                    // Activiated trigger does not have a menu open 
                    } else {

                        // Close open menu
                        if( openMenu && openMenu.length ) { openMenu.trigger( 'close.dropdown' ); }

                        // Swap active class for trigger element
                        cachedElements.headerBar.find('li.active').removeClass('active');
                        $(this).parent().addClass( 'active' );

                        // Open menu
                        $menu.trigger( 'open.dropdown' );

                        // Save curently open menu
                        openMenu = $menu;
                    }

                    $menu.attr( 'style', elStyle );

                });


                // Open a menu
                open = function() {

                    var el = $(this),
                        animateType = (intel.mobile.constants.isAndroidOS404 && el.attr('id') === 'search-menu') ? 'useJS' : 'use3d',
                        openStyle3d =   '-webkit-transform: translate3d(0,' + el.data( 'height' ) + 'px, 0);' + 
                                        '-moz-transform: translate3d(0,' + el.data( 'height' ) + 'px, 0);' + 
                                        'transform: translate3d(0,' + el.data( 'height' ) + 'px, 0);';

                    if( Modernizr.csstransforms3d && animateType === 'use3d') {
                        // Open menu
                        el.attr( 'style' , openStyle3d );
                        var ua = navigator.userAgent;
                                                   
                           if (ua.indexOf("BlackBerry") >= 0)
                           {
                             
                           }
                          else
                          {
                            
                            // Move main content down
                           
                           
                            cachedElements.main.attr( 'style', openStyle3d );
                            cachedElements.footer.attr( 'style', openStyle3d );
                            cachedElements.ultra_content.attr( 'style', openStyle3d );
                            }
                       
                        // open keyboard
                    if (el[0].id === 'search-menu') {
                            $('#search-term').focus();
                        }
                    } else {
                        el.slideDown(200);
                        // open keyboard
                    if (el[0].id === 'search-menu') {
                            $('#search-term').focus();
                        }
                        //TODO make sure this works in IEMobile and older Android
                    }

                    // fix for Android 2.3.x menu elements
                    if (intel.mobile.constants.isAndroidOS23x === true) {
                        window.scroll(0, -100);
                        window.scroll(0, 0);
                    }
                };

                // Close a menu
                close = function() {

                    var el = $(this),
                        animateType = (intel.mobile.constants.isAndroidOS404 && el.attr('id') === 'search-menu') ? 'useJS' : 'use3d',
                        closeStyle3d = '-webkit-transform: translate3d(0,0,0); -moz-transform: translate3d(0,0,0); transform: translate3d(0,0,0);';

                    if( Modernizr.csstransforms3d && animateType === 'use3d') {
                        // close keyboard
                       cachedElements.searchTerm.blur();
                        // Close menu
                        el.attr( 'style', closeStyle3d );
                         var ua = navigator.userAgent;
                        // Move main content up
                           if (ua.indexOf("BlackBerry") >= 0)
                           {
                             
                           }
                          else
                          {
                            // Move main content down
                            cachedElements.main.attr( 'style', closeStyle3d );
                            cachedElements.footer.attr( 'style', closeStyle3d );
                            cachedElements.ultra_content.attr('style', closeStyle3d );

                            }
                            // Move main content down
                           
                        
                        if(el[0].id === 'search-menu')
                        {
                            
                            cachedElements.searchTerm.val('');
                            $("#suggestions").empty();
                            $("#suggestions").hide();
                        }
                    } else {
                        // close keyboard
                        cachedElements.searchTerm.blur();
                        el.slideUp(200);
                        if(el[0].id === 'search-menu')
                        {
                           
                            cachedElements.searchTerm.val('');
                            $("#suggestions").empty();
                            $("#suggestions").hide();
                        }
                        //TODO make sure this works in IEMobile and older Android
                    }
                };

                // Init menus
                cachedElements.globalHeader.find('.dropdown-menu').each(function(){
                    var el = $(this),
                        elHeight;

                    // Expand but hide element to get height, then cache it
                    // We need this for 3dtransforms
                    el.css({'position':'absolute','visibility':'hidden','display':'block'});
                    elHeight = el.outerHeight();
                    el
                        .data( 'height', elHeight )
                        .addClass( 'inited' )
                        .removeAttr( 'style' );

                    // Bind to open/close events
                    el
                        .on( 'open.dropdown', open )
                        .on( 'close.dropdown', close );

                });

                // Bind change events in select elements to act as hrefs
                var jumpMenu = $('#jump-to-submenu');
                if(jumpMenu.length) {
                    jumpMenu.on('change', intel.mobile.utils.navigateFromSelect);
                }
                $('#category-menu').find('select').on('change', intel.mobile.utils.navigateFromSelect);     

            // end initHeaderMenus
            },
            
            // Init global search functionality
            initSiteSearch: function(){
                
                var cachedElements = intel.mobile.cache;
 if(cachedElements.searchTerm.val()!="")
                {
                    cachedElements.searchClear.css('display', 'inline');
                    
                }

                cachedElements.searchTerm.on('keyup', function() {
                    cachedElements.searchClear.css('display', 'inline');
                })
                
                // Clear text when clicking "x" icon 
                cachedElements.searchClear.on('click', function() {
                    cachedElements.searchTerm.val('');
                    $("#suggestions").empty();
                    $("#suggestions").hide();
                    $('#search-term').focus();
                });
                
            // end initSiteSearch
            }

        // end globalHeader 
        },
        
        globalFooter: {
            
            init: function(){
                this.initDisclaimerToggle();
            },
            
            initDisclaimerToggle: function(){
                var dislaimerContent = $('#disclaimer-content');
                intel.mobile.cache.disclaimer.find('.expand').on('click', function(ev) {
                    ev.preventDefault();
                    intel.mobile.cache.disclaimer.find('.expand').toggleClass("open")
                    dislaimerContent.toggleClass("open");
                });
            }
            
        }
        
        
        
    },

    
    /************************************
    * Contains feature detection utilities
    * 
    ************************************/
    support: {

        useTransform3d:function(){
            var hasModernizr = typeof Modernizr !== 'undefined';
            if(this._useTransform3d === undefined) {
                this._useTransform3d = $.cssHooks && $.browser.webkit && hasModernizr && Modernizr.csstransforms3d;
            }
            return this._useTransform3d;
        },
        
        useTouch:function(){
            if(this._useTouch === undefined) {
                // this._useTouch = $.browser.webkit && Modernizr && Modernizr.touch;
                this._useTouch = false;
            }
            return this._useTouch;
        }
    
        
    },


    /*************************************
    * Register js controller with Framework
    * 
    * If an init() method is found in the
    * controller, it will me automatically 
    * executed on DOM ready
    * 
    * @param String name The controller's namespace.
    * @param Object obj An object containing the controller's members.
    * 
    * @name register
    * @author GN@Sape
    **************************************/
    register: function () {

        var self = this,
            name = arguments[0],
            obj = arguments[1];

        // Add controller to intel.mobile.controller namespace
        if(!self.controller) { self.controller = {}; }
        
        self.controller[name] = obj;
            
        // Run controller init method when DOM is ready
        if (self.controller[name].init) {
            $(function () {
                self.controller[name].init();
            });
        }

    },
    

    /***************************************
    * Rewrite the console functionality to
    * not break IE or surpress console.log()
    * if debugging is off
    * 
    * @name console
    * @author GN@Sape
    **************************************/
    console: function () {
        if ( !window.console || !this.hasOwnProperty('debug') || !this.debug ) {
            window.console = {};
            var f = function () { },
            methods = ['log', 'debug', 'info', 'warn', 'error', 'time', 'timeEnd', 'group', 'groupEnd'];
            $.each(methods, function (i, item) {
                window.console[item] = f;
            });
        }
    }

};

// Start the Framework
intel.mobile.init();