// Let the main JS file know we exist, controller will be added to
// intel.mobile.controller.controllerName namespace
intel && intel.mobile && intel.mobile.register('controllerName', {
    
    // Init function - automatically called on document ready
    init: function() {
        var self = this;
        // self.doSomething()
    },
    
    doSomething: function(){    
        var self = this;
    }
});

intel && intel.mobile && intel.mobile.register('viewPreference', {
    
    cache : {
        prefBtn : $('.view-pref'),
        items : $('#main .bd > .items')
    },

    init: function() {
        var self = this;

        self.cache.prefBtn.on('click', {'self' : self}, self.changeView)
        
    },
    
    changeView: function(e){    
        var self = e.data.self,
            tar = e.target,
            curClass = e.target.className;

        switch(curClass) {
            case 'grid' :
                /*$(tar).removeClass('grid').addClass('list');
                self.cache.items.removeClass('tiles');*/
                window.location = '/prodList.shtml';
            break;

            case 'list' :
                /*$(tar).removeClass('list').addClass('grid');
                self.cache.items.addClass('tiles');*/
                window.location = '/prodGrid.shtml'
            break;
        }
    }
});

intel && intel.mobile && intel.mobile.register('accordion', {   
    // Init function - automatically called on document ready
    init: function() {
        var self = this;
        intel.mobile.cache.accordion.find('h5')
            .on( 'click', function(evt) {
                self.handler(evt)
            })
    },

    
    handler: function(evt){ 
        var self = this;
        evt.preventDefault();

       $(evt.currentTarget).next().slideToggle('slow', function() {
            $(evt.currentTarget).toggleClass('closed')
       });

    }
});

intel && intel.mobile && intel.mobile.register('viewmore', {
    cache : {
        viewmore : $('.view-more-control')
    },  
    init: function() {
        var self = this;
        self.cache.viewmore.on( 'click', function(evt) {
            self.handler(evt)
        })
    },

    
    handler: function(evt){ 
        var self = this;
            _cached = self.cache,
            tar = $(evt.target),
            closedCopy = tar.attr('data-closedcopy'),
            openCopy = tar.attr('data-opencopy');

       evt.preventDefault();
       
       tar.prev('.view-more').slideToggle('slow', function() {
            tar.toggleClass('open');
            if (tar.hasClass('open') === true) {
                tar.html(openCopy);
            } else {
                tar.html(closedCopy);
            }
       });

    }
});

intel && intel.mobile && intel.mobile.register('carousel', {

    cache : {
            carousel :      $(".carousel"),
            caroContent :   $(".carousel-content"),
            tiles :         $(".carousel-content li"),
            viewport :      '',
            carouselInfo :  []
    },

    init : function () {
        var self = this, 
            _cached = self.cache;
       
        $(window).on('resize', {'self' : self}, self.rotation);

        // create separate data sets for each carousel instance on the page
        $(_cached.carousel).each(function(idx) {
            var totalTiles = $('li', this).length,
                showTiles = parseInt($(this).attr('data-count'), 10);

            _cached.carouselInfo.push({
                'curTile' : 1,
                'totalTiles' : totalTiles,
                'showTiles' : showTiles,
                'maxScroll' : '',
                'tileWidth' : ''
            });

            if (Modernizr.touch === false && totalTiles > showTiles ) { // touch is not enabled
                $('.pagination', this).wrap('<div class="navigation" />');
                $('.navigation', this).wrap('<div class="navigation-container" />').append('<a href="#" class="click-right end"></a>').prepend('<a href="#" class="click-left"></a>');
            }
            self.setsize(idx); // resize images
            self.pagination(idx); // populate pagination div
        });
        
        // listeners for swipe events
        self.cache.caroContent.swipe({
          swipeLeft : function(event, direction, distance, duration, fingerCount) {
            var cIDX = $(event.target).closest('.carousel').index('.carousel');
            self.swipeLeft(event, cIDX)
          },
          swipeRight : function(event, direction, distance, duration, fingerCount) {
            var cIDX = $(event.target).closest('.carousel').index('.carousel');
            self.swipeRight(event, cIDX)
          }/*,
          click : function(event, target) {
            var vid = $(target).closest('.video-container');
            event.preventDefault();
            if (vid.length > 0) {
                intel.mobile.controller.videoPlayer.loadVideoPlayer(event);
            }
          }*/
        });


        if (Modernizr.touch === false) { // touch is not enabled

            $('.navigation').on('click', {'self' : self}, function(evt) {
                var direction = evt.target.className,
                    cIDX = $(evt.target).closest('.carousel').index('.carousel');

                switch(direction) {
                    case 'click-left' :
                    self.swipeLeft(evt, cIDX);
                    break;

                    case 'click-right' :
                    self.swipeRight(evt, cIDX);
                    break;
                }
            })
        } 

    },
    
    rotation : function (evt) {
        var self = evt.data.self,
            _cached = self.cache,
            resize = function resize() { 
                $(_cached.carousel).each(function(idx) {
                    self.setsize(idx); // reset tile sizes based on new orientation
                    self.pagination(idx); // reset pagination dots base on new orientation
                });
            };
        window.setTimeout(resize, 10) // on rotation wait 500ms for window data
    },
	
	
    
    setsize : function (cIDX) {
        var self = this,
            _cached = self.cache,
            winOrient = window.orientation,
            caroContent = $('.carousel-content', _cached.carousel[cIDX]),
            caroType = (caroContent.find('.video-container').length <= 0) ? 'images' : 'video',
            animateType = ($('html').hasClass('iphone3')) ? 'js' : '3d',
            winWidth = $(_cached.carousel[cIDX]).width() // setting the max width to the parent container
            tileWidth = '',
            scrollDistance = (_cached.carouselInfo[cIDX].curTile - 1) * winWidth,
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';
        
        _cached.carouselInfo[cIDX].maxScroll = Math.ceil( _cached.carouselInfo[cIDX].totalTiles / _cached.carouselInfo[cIDX].showTiles ); // set how many tiles we can scroll before we hit the end
        _cached.carouselInfo[cIDX].showTiles = parseInt($(_cached.carousel[cIDX]).attr('data-count'), 10); // set how many tiles we want to see at a time from the data-count attribute
        tileWidth = (_cached.carouselInfo[cIDX].showTiles === 1) ? $(_cached.carousel[cIDX]).width() / _cached.carouselInfo[cIDX].showTiles : ($(_cached.carousel[cIDX]).width() / _cached.carouselInfo[cIDX].showTiles) - 5;
        _cached.carouselInfo[cIDX].tileWidth = tileWidth; // set the width of each tile in the tile info obj

        $('.carousel-content li', _cached.carousel[cIDX]).each(function (idx) {
            $(this).css({'width': tileWidth}) // apply tile width to the element
            if (_cached.carouselInfo[cIDX].showTiles > 1) {
                $(this).css({'height': tileWidth}) 
            }
        }) 

        /*if (_cached.carouselInfo[cIDX].showTiles === 1) { // if we're only seeing 1 tile at a time
            if( caroType === 'images' && animateType === '3d' && Modernizr.csstransforms3d ) { 
                caroContent.attr( 'style', openStyle3d ); // adjust the position of the slides
            } else {
                caroContent.animate({ left : '-=' + scrollDistance }, 200)
                } 
        } */  
        
/*
        if (winOrient === 90 || winOrient === -90) { // is it landscape?

            if (_cached.carouselInfo[cIDX].showTiles === 2) { // currently 2-up layouts switch to show 3 in landscape
                tileWidth = (winWidth / 3) - 2; // show 3 up if landscape
                _cached.carouselInfo[cIDX].maxScroll = Math.ceil( _cached.carouselInfo[cIDX].totalTiles / 3 );
                _cached.carouselInfo[cIDX].showTiles = 3;

                $('.carousel-content li', _cached.carousel[cIDX]).each(function (idx) {
                    $(this).css({'width': tileWidth - 5}) // apply tile width to the element
                    if (_cached.carouselInfo[cIDX].showTiles > 1) {
                        $(this).css({'height': tileWidth}) 
                    }
                })
                 caroContent.attr( 'style', "" );
                
                self.swipeRight('click', 0); 
            }
        }
         else
        {
            
            caroContent.attr( 'style', "" );
            
            self.swipeRight('click', 0);
        
        }
		*/
         

        //if (window.innerWidth>window.innerHeight) { // is it landscape?
          if (winOrient === 90 || winOrient === -90) { // is it landscape?  
           
            if (_cached.carouselInfo[cIDX].showTiles === 2) { // currently 2-up layouts switch to show 3 in landscape
                tileWidth = (winWidth / 3) - 2; // show 3 up if landscape
                _cached.carouselInfo[cIDX].maxScroll = Math.ceil( _cached.carouselInfo[cIDX].totalTiles / 3 );
                _cached.carouselInfo[cIDX].showTiles = 3;

                $('.carousel-content li', _cached.carousel[cIDX]).each(function (idx) {
                    $(this).css({'width': tileWidth - 5}) // apply tile width to the element
                    if (_cached.carouselInfo[cIDX].showTiles > 1) {
                        $(this).css({'height': tileWidth}) 
                    }
                }) 
                
                caroContent.attr( 'style', "" );
                //self.incrementPagination(0); // populate pagination div
                self.MoveRightCaro(0);
				//caroContent.attr( 'style', "" );
				
                
                
            }
        }
        else if(winOrient === 0)
        {
           
            if (_cached.carouselInfo[cIDX].showTiles === 2) { // currently 2-up layouts switch to show 3 in landscape
				
                tileWidth = (winWidth / 2) - 2; // show 3 up if landscape
                _cached.carouselInfo[cIDX].maxScroll = Math.ceil( _cached.carouselInfo[cIDX].totalTiles / 2 );
                _cached.carouselInfo[cIDX].showTiles = 2;

                $('.carousel-content li', _cached.carousel[cIDX]).each(function (idx) {
                    $(this).css({'width': tileWidth - 5}) // apply tile width to the element
                    if (_cached.carouselInfo[cIDX].showTiles > 1) {
                        $(this).css({'height': tileWidth}) 
                    }
                }) 
                
                caroContent.attr( 'style', "" );
                //self.incrementPagination(0); // populate pagination div
                self.MoveRightCaro(0);
				//caroContent.attr( 'style', "" );
				
                
                
            }
		
			//caroContent.attr( 'style', "" );
            //self.incrementPagination(0); // populate pagination div
            //self.MoveRightCaro(0);
			//caroContent.attr( 'style', "" );
			
        
        }
		
        

    },
	/*right :
    */ 
    MoveRightCaro : function (cIDX) {

        var self = this,
            _cached = self.cache,
            caroContent = $('.carousel-content', _cached.carousel[cIDX]), // set carousel context
            caroType = (caroContent.find('.video-container').length <= 0) ? 'images' : 'video',
            animateType = ($('html').hasClass('iphone3')) ? 'js' : '3d',
            rightMargin = parseInt($('.carousel-content li', _cached.carousel[cIDX]).css('margin-right').split('px')[0], 10),
            scrollDistance = ( ($(_cached.carousel[cIDX]).width() + rightMargin) * _cached.carouselInfo[cIDX].curTile) - ( ($(_cached.carousel[cIDX]).width() + rightMargin) * 2),
            pag = $('.pagination', _cached.carousel[cIDX]),
            i = pag.length,
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';


        if (_cached.carouselInfo[cIDX].curTile === 1 ) { return }; // if we're at the end, stop

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation .click-left').removeClass('end');
        }

        if( caroType === 'images' && animateType === '3d' ) {

            //caroContent.attr( 'style', openStyle3d );
            _cached.carouselInfo[cIDX].curTile = 1;
            self.incrementPaginationCaro(0);

        } else {
            caroContent.animate({left : '+='+ ($(_cached.carousel[cIDX]).width() + rightMargin) }, 200, function () {
                _cached.carouselInfo[cIDX].curTile = 1;
                self.incrementPaginationCaro(0);
            })

        } 

        if (Modernizr.touch === false) { // touch is not enabled
            if ((_cached.carouselInfo[cIDX].curTile - 1) === 1 ) {
                $('.navigation .click-right').addClass('end');
                $('.navigation .click-left').removeClass('end');
            }
        }       
    },
    /* SWIPE HANDLERS
    left : */
    swipeLeft : function (evt, cIDX) {
		
        var self = this,
            _cached = self.cache,
            caroContent = $('.carousel-content', _cached.carousel[cIDX]), // set carousel context
            caroType = (caroContent.find('.video-container').length <= 0) ? 'images' : 'video',
            animateType = ($('html').hasClass('iphone3')) ? 'js' : '3d',
            rightMargin = parseInt($('.carousel-content li', _cached.carousel[cIDX]).css('margin-right').split('px')[0], 10),
            scrollDistance = ($(_cached.carousel[cIDX]).width() + rightMargin-4) * _cached.carouselInfo[cIDX].curTile,
            pag = $('.pagination', _cached.carousel[cIDX]),
            i = pag.length, 
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';   

        if (_cached.carouselInfo[cIDX].curTile === _cached.carouselInfo[cIDX].maxScroll ) { return; } // if we're at the end, stop

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation .click-right').removeClass('end');
        }

        if(caroType === 'images' && animateType === '3d' && Modernizr.csstransforms3d) {

            caroContent.attr( 'style', openStyle3d );
            _cached.carouselInfo[cIDX].curTile = _cached.carouselInfo[cIDX].curTile + 1; // increment the current slide count
            self.incrementPagination(cIDX);

        } else {

            caroContent.animate({ left : '-=' + ( $(_cached.carousel[cIDX]).width() + rightMargin) }, 200 , function () {
                _cached.carouselInfo[cIDX].curTile = _cached.carouselInfo[cIDX].curTile + 1; // increment the current slide count
                self.incrementPagination(cIDX);
            })

        }

        if (Modernizr.touch === false) { // touch is not enabled
            if ((_cached.carouselInfo[cIDX].curTile + 1) === _cached.carouselInfo[cIDX].maxScroll) {
                $('.navigation .click-left').addClass('end');
                $('.navigation .click-right').removeClass('end')
            }
        }
        
   },

    /*right :
    */ 
    swipeRight : function (evt, cIDX) {
	
        var self = this,
            _cached = self.cache,
            caroContent = $('.carousel-content', _cached.carousel[cIDX]), // set carousel context
            caroType = (caroContent.find('.video-container').length <= 0) ? 'images' : 'video',
            animateType = ($('html').hasClass('iphone3')) ? 'js' : '3d',
            rightMargin = parseInt($('.carousel-content li', _cached.carousel[cIDX]).css('margin-right').split('px')[0], 10),
            scrollDistance = ( ($(_cached.carousel[cIDX]).width() + rightMargin-3) * _cached.carouselInfo[cIDX].curTile) - ( ($(_cached.carousel[cIDX]).width() + rightMargin) * 2),
            pag = $('.pagination', _cached.carousel[cIDX]),
            i = pag.length,
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';


        if (_cached.carouselInfo[cIDX].curTile === 1 ) { return }; // if we're at the end, stop

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation .click-left').removeClass('end');
        }

        if( caroType === 'images' && animateType === '3d' && Modernizr.csstransforms3d ) {

            caroContent.attr( 'style', openStyle3d );
            _cached.carouselInfo[cIDX].curTile = _cached.carouselInfo[cIDX].curTile - 1;
            self.incrementPagination(cIDX);

        } else {
            caroContent.animate({left : '+='+ ($(_cached.carousel[cIDX]).width() + rightMargin) }, 200, function () {
                _cached.carouselInfo[cIDX].curTile = _cached.carouselInfo[cIDX].curTile - 1;
                self.incrementPagination(cIDX);
            })

        } 

        if (Modernizr.touch === false) { // touch is not enabled
            if ((_cached.carouselInfo[cIDX].curTile - 1) === 1 ) {
                $('.navigation .click-right').addClass('end');
                $('.navigation .click-left').removeClass('end');
            }
        }       
    },
	
	

    incrementPagination : function(cIDX) {
        var self = this,
            _cached = self.cache;
			


        $('.pagination', _cached.carousel[cIDX]).each(function(i) {
            $(this).children('span').each(function(idx) { // make the next pagination dot active
                var idx = idx +1;
                if ( (idx) === _cached.carouselInfo[cIDX].curTile ) {
					
                    $(this).addClass('active');
                } else {
                    $(this).removeClass('active');
                }
            })
        })
    },
	
	incrementPaginationCaro : function(cIDX) {
        var self = this,
            _cached = self.cache;
			

		//$('.pagination')[0].children('span')[0].addClass('active');
		
        $('.pagination', _cached.carousel[cIDX]).each(function(i) {
            $(this).children('span').each(function(idx) { // make the next pagination dot active
				
                var idx = idx +1;
				
                if ( (idx) === _cached.carouselInfo[cIDX].curTile ) {
					
                    $(this).addClass('active');
                } else {
                    $(this).removeClass('active');
                }
            })
        })
		
    },

    pagination : function (cIDX) {
        var self = this,
            _cached = self.cache,
            frag = document.createDocumentFragment(),
            i =  _cached.carouselInfo[cIDX].maxScroll + 1; // add 1 b/c it's a zero base count

            if( _cached.carouselInfo[cIDX].totalTiles > _cached.carouselInfo[cIDX].showTiles ) {
                while (--i) { // loop through and add the appropriate number of spans
                    frag.appendChild(document.createElement("span"));
                };
                frag.childNodes[(_cached.carouselInfo[cIDX].curTile - 1)].setAttribute('class', 'active');
                $('.pagination', self.cache.carousel[cIDX]).html('').append(frag); // append now full-of-spans-fragment to the DOM
            }
    }
});

intel && intel.mobile && intel.mobile.register('compare', {
    
    cache : {
        compare      : $(".compare"),
        addCompare   : $(".add-compare"),
        resetCompare : $(".reset", ".compare"),
        compareCount : $("#compare-widget-count"),
        compareAdd : $('.cta-tile-add'),
        compareRemove: $('.cta-tile-remove')
    },


    init : function() {
        var self = this;

        obj = {
            'removeItem': self.removeItem,
            'addItem' : self.addItem,
            'createCookie' : self.createCookie,
            'popList' : self.popList,
            'showCompare' : self.showCompare,
            'reset' : self.resetCompare
        };
        
        self.listen(obj);

        //self.showCompare({self:self})

        
        self.cache.addCompare.on('click', {'self' : self }, function(evt) {
            var self = evt.data.self;

            evt.preventDefault();

            if ($(this).hasClass('cta-tile-add')) {
                self.notify('addItem', {target: evt.target, self: self});
            } else if ($(this).hasClass('cta-tile-remove')) {
                self.notify('removeItem', {prodID : evt.target.getAttribute('data-prod-id'), 'self' : self});
            }
        });
        

        self.cache.resetCompare.on('click', {'self' : self}, function(evt) { // click on reset
            var self = evt.data.self;
            evt.preventDefault();
            self.notify('reset', {'self' : self}) 
        });

        $('#compare-widget-template li').on('click', function(evt) {
            evt.preventDefault();

            if ($(evt.target).hasClass('cta-tile-remove')) { // click on minus
                self.notify('removeItem', {prodID : evt.target.getAttribute('data-prod-id'), 'self' : self});
            }

            if ($(evt.target).attr('title') === 'Compare') { // click on minus
                console.log('compare')
            }

        });

        self.preLoad();
    },

    /* this is my pubsub pattern, short n sweet */
    subs : {},
    
    listen : function(obj) {
        for (var i in obj) {
            this.subs[i] = this.subs[i] || [];
            this.subs[i].push(obj[i]);
        }
    },
    
    notify : function(name, args) {
        var i = this.subs[name].length;
        while(i--) {
            this.subs[name][i](args);
        }
    },

    createCookie : function (args) { // name, value, days
        if (args.days) {
            var date = new Date();
            date.setTime(date.getTime()+(args.days*24*60*60*1000));
            var expires = "; expires="+date.toGMTString();
        }
        else var expires = "";
        document.cookie = args.name+"="+args.value+expires+"; path=/";
    },

    readCookie : function(name) { // name
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    },

    deleteCookie : function (name) {
        var self = this;
        self.createCookie({'name' : name, value : "", days : -1});
    },

    popList : function(args) { // self
    
        var self = args.self,
            cookieArr,
            i,
            view = {'items' : []},
            templ = '{{#items}}<li><img src="{{data-prod-img}}" alt="{{data-prod-name}}"><div><h3>{{data-prod-name}}</h3>From <span class="price">${{data-prod-price}}</span><span class="category">{{data-prod-cat}}</span></div><a href=""  data-prod-id="{{data-prod-id}}" data-prod-img="{{data-prod-img}}" data-prod-name="V{{data-prod-name}}" data-prod-price="{{data-prod-price}}" data-prod-cat="{{data-prod-cat}}" class="cta-tile-remove" title="Remove" ></a></li>{{/items}}',
            html;

            if (document.cookie.indexOf('compare-products') > -1) {
            cookieArr = self.readCookie('compare-products').split(',');
            i = cookieArr.length;

            while (i--) {
                view.items.push(JSON.parse(window.sessionStorage.getItem(cookieArr[i])));
                
                try {
                    $('#' + cookieArr[i] + ' .add-compare').removeClass('cta-tile-add').addClass('cta-tile-remove');
                } catch (e) {
                    $('#product-details .hero .add-compare').removeClass('cta-tile-remove').addClass('cta-tile-add');
                }
            }

            html = Mustache.to_html(templ, view);
            $("#template-content").html(html);
            // update count
            self.cache.compareCount.html(cookieArr.length);

        } else {
            self.hideCompare();
        }
        
        
    },

    getItemData : function(el) {
        var results = {},
            attrArr = el.attributes,
            i = attrArr.length,
            re = /data-prod-\w+/,
            attrName;

        // loop through the attributes on the element and return the dataset
        while(i--) {
            attrName = attrArr[i].name;
            
            if (re.test(attrName) === true) {
                results[attrName] = attrArr[i].value
            }
        }
        return results;
    },

    addItem : function(args){ // target, self
    
        var self = args.self,
            target = args.target,
            dataObj = self.getItemData(target),
            item = dataObj['data-prod-id'],
            cookieData = self.readCookie('compare-products'),
            cookieArr = [],
            duplicate = [],
            i;

        // add to sessionStorage
        //window.sessionStorage.setItem(item, JSON.stringify(dataObj));

        //if (sessionStorage.length > 10) { return } // bail if there's already 10

        // add to cookie
        /*
        if (document.cookie.indexOf('compare-products') > -1) { // check that the cookie exists already
            cookieArr = cookieData.split(',');
            i = cookieArr.length;

            while(i--) {
                if (cookieArr[i] === item) {
                    duplicate.push(item)

                }
                if (cookieArr[i].length <= 0) {
                    cookieArr.splice(i, 1)
                } 
            }

            if (duplicate.length === 0) { // if it's not already in the cookie add it
                cookieArr.push(item);
            }

            self.notify('createCookie', {name : 'compare-products', value : cookieArr.join(',')}); // set new cookie
        } else {
            self.notify('createCookie', {name : 'compare-products', value : item}); // no cookie, so make one
        }
        */
        //$(target).closest('li').toggleClass('compare-item'); // toggle class for add/remove
        //$(target).removeClass('cta-tile-add').addClass('cta-tile-remove');
        /*
        if (document.getElementById('compare-widget-template').style.display === 'block') {
            self.notify('popList', {self : self});
        } else {
            self.notify('popList', {self : self});
            self.notify('showCompare', {self : self});
        }
        */
        
        
    },

    removeItem : function(args) { // prodID, self
        
        var self = args.self,
            item = args.prodID,
            cookieData = self.readCookie('compare-products');
            cookieArr = cookieData.split(','),
            i = cookieArr.length;

        // remove from sessionStorage
        window.sessionStorage.removeItem(item)

        while (i--) {
            if (cookieArr[i] === item) {
                cookieArr.splice(i, 1); // remove item from array
            }
        }
        if (cookieArr.length > 0) {
            self.notify('createCookie', {name : 'compare-products', value : cookieArr.join(',')}); // update cookie
        } else {
            self.deleteCookie('compare-products');
        }
        
        $('[data-prod-id="' + item + '"]').closest('li.compare-item').removeClass('compare-item');
        $('[data-prod-id="' + item + '"]').removeClass('cta-tile-remove').addClass('cta-tile-add');
        //$('.cta-tile-add').on('click', {'self' : self }, self.notify('showCompare');
        self.notify('popList', {self : self});
        
        
    },

    showCompare : function(args){   
        var self = args.self;
        self.cache.compare.show();
    },

    hideCompare : function() {
        var self = this;
        self.cache.compare.fadeOut()
    },

    resetCompare : function(args) {
        var self = args.self,
            cookieArr = self.readCookie('compare-products').split(','),
            i = cookieArr.length;

        while (i--) {
            self.notify('removeItem', {prodID : cookieArr[i], 'self' : self})
        }
    },

    preLoad : function() {
    
        var self = this,
            cookieData,
            cookieArr,
            i;

        if (document.cookie.indexOf('compare-products') === -1) { return } // if there's no cookie don't do anything
        
        cookieData = self.readCookie('compare-products'),
        cookieArr = cookieData.split(','),
        i = cookieArr.length;

        //if (document.getElementById('product-list') || document.getElementById('product-grid')) {
            while(i--) {
                $('[data-prod-id="' + cookieArr[i] + '"]', 'ul.items').removeClass('cta-tile-add').addClass('cta-tile-remove');
            }
            self.notify('popList', {self : self});
            self.notify('showCompare', {self : self});
        //}

        //$(target).closest('li').toggleClass('compare-item'); // toggle class for add/remove
    
    }
    
});
intel && intel.mobile && intel.mobile.register('filter', {
    cache: {
        filterBtn: $('#filter'),
        filterMenu: $('.filter'),
        filterContBtn: $('.continue', '.filter'),
        filterCancelBtn: $('.cancel', '.filter'),
        filterLevel1: $('.level1', '.filter'),
        filterLevel2: $('.level2', '.filter'),
        searchTerm: $('#search-term'),
        searchSuggest: $('#search-menu .suggest')
    },
    
    // Init function - automatically called on document ready
    init: function() {
        var self = this;
        self.cache.filterBtn.on('click', {'self': self}, self.showFilterLevel1);
        self.cache.filterContBtn.on('click', {'self': self}, self.toggleFilterLevel);
        self.cache.filterCancelBtn.on('click', {'self': self}, self.toggleFilterLevelCancel);
        //self.cache.searchTerm.on('keyup', {'self': self}, self.showSuggest)
        //self.cache.searchTerm.on('blur', {'self': self}, self.hideSuggest)
    },

    resetLevel1 : function(evt) {
        var self = evt.data.self;
        evt.preventDefault();
        
        $('li', self.filterLevel1).removeClass('selected');
    },

    showFilterLevel1: function(evt){   
       
        var self = evt.data.self;
        evt.preventDefault();

        $('.results, .ft, .sort-filter' ).hide(); // hide the results list
        self.cache.filterMenu.show(); // show the filter menu
        $('div.level2 .continue').hide();
        $('div.level1 .continue').show();
        //self.cache.filterLevel2.hide(); // hide level 2 if it was open
        //self.cache.filterLevel1.show(); // show level 1

        //$('li .reset', self.cache.filterLevel1).on('click', {'self': self}, self.resetLevel1);
        //$('li', self.cache.filterLevel1).not(':first-child').on('click', {'self': self}, self.selectLevel1);

        // reset cancel button
        //self.cache.filterCancelBtn.off('click', {'self': self}, self.showFilterLevel1);
        //self.cache.filterCancelBtn.on('click', {'self': self}, self.showResults);

        // reset continue button
        
        
        //self.cache.filterContBtn.on('click', {'self': self}, self.showFilterLevel2);
        
    },

    selectLevel1 : function(evt) {
        var self = evt.data.self;
        evt.preventDefault();
        //$(this).closest('li', self.filterLevel1).not(':first-child').toggleClass('selected');
    },

    resetLevel2 : function(evt) {
        var self = evt.data.self;
        evt.preventDefault();

        $('input', self.cache.filterLevel2).attr('checked', false)
    },
    
    
    
    toggleFilterLevel:function(evt) {
        

        var self = evt.data.self;
        //evt.preventDefault();
        if(document.getElementById('level1').style.display=="block")
        {
            
            // Place your ajax call to get search values
        
            $(".filter").hide(); // hide the filter menu
            $('.results, .ft, .sort-filter' ).show(); // show the results list
            executeFilter();
        }
        else if(document.getElementById("search_level2").style.display=="block")
        {
            
            // Place your ajax call to get search values
            //self.cache.filterMenu.hide();
            self.cache.filterLevel2.hide(); // hide level 2 if it was open
            self.cache.filterLevel1.show();
            //document.getElementById('search_level2').style.display="none";
            //$("#level1").show(); // show level 1
            //document.getElementById('level1').style.display="block";
            
            
        }
    },
    
    toggleFilterLevelCancel:function(evt) {
            
        var self = evt.data.self;
        //evt.preventDefault();
        if(document.getElementById('level1').style.display=="block")
        {

            // Place your ajax call to get search values
        
            $(".filter").hide(); // hide the filter menu
            $('.results, .ft, .sort-filter' ).show(); // show the results list
        }
        else if(document.getElementById("search_level2").style.display=="block")
        {
            
            // Place your ajax call to get search values
            //self.cache.filterMenu.hide();
            self.cache.filterLevel2.hide(); // hide level 2 if it was open
            self.cache.filterLevel1.show(); // show level 1
        }
    },
    
    showFilterLevel2: function(evt){

        var self = evt.data.self;
        evt.preventDefault();

        /*$('input', self.cache.filterLevel2).on('change', function() {
            $(this).closest('li').toggleClass('selected');
        });*/

        //$('li:first-child a', self.cache.filterLevel2).on('click', {'self': self}, self.showFilterLevel1)
        //self.cache.filterLevel1.hide();
        //self.cache.filterLevel2.show();

        //$('li .reset', self.cache.filterLevel2).on('click', {'self': self}, self.resetLevel2);

        // reset the continue button
        //self.cache.filterContBtn.off('click', {'self': self}, self.showFilterLevel2)
        //self.cache.filterContBtn.on('click', {'self': self}, self.showResults)

        // reset the cancel button
        //self.cache.filterCancelBtn.off('click', {'self': self}, self.showResults);
        //self.cache.filterCancelBtn.on('click', {'self': self}, self.showFilterLevel1);
   
    },

    showResults: function(evt){ 
        var self = evt.data.self;
        evt.preventDefault();

        self.cache.filterMenu.hide(); // hide filter
        self.cache.filterLevel2.hide(); // hide level 2
        self.cache.filterLevel1.show(); // leave level 1 showing for reopen

        // reset the continue button
        self.cache.filterContBtn.off('click', {'self': self}, self.showResults);
        self.cache.filterContBtn.on('click', {'self': self}, self.showFilterLevel2);

        // reset the cancel button
        self.cache.filterContBtn.off('click', {'self': self}, self.showResults)
        self.cache.filterCancelBtn.off('click', {'self': self}, self.showFilterLevel1);
        
        $('.filter ~ *' ).show();
    },

    showSuggest: function(evt){
        var self = evt.data.self;
        self.cache.searchSuggest.css('top', $('#search-menu').height() + 'px' ).slideDown(200);
    },

    hideSuggest: function(evt){
        var self = evt.data.self;
        self.cache.searchSuggest.slideUp(200);
    }
    

});

intel && intel.mobile && intel.mobile.register('compare-carousel', {

    cache : {
            comCarousel :       $(".caro-parent"),
            comCaroContent :    $(".container"),
            comTiles :      $(".sections", ".container "),
            comViewport :       $(window).width()-20,
            comPagination :     $(".pagination", "#compare"),
            comTileHeight :     {},
            comTileCount :  {},
            comSlidesCount:     {},
            comOrientation :    {},
            comCurrentSlide :   1
            },

    init : function () {
        var self = this, 
            _cached = self.cache; //alias cache

        $(window).on('orientationchange', {'self' : self}, self.rotation);

        //set max number of sections to swipe through
        _cached.comTileCount   = _cached.comTiles.length;
        _cached.comSlidesCount = _cached.comTileCount;

        self.comsetsize();

        self.cache.comTiles.swipe({
          swipeLeft : function(event, direction, distance, duration, fingerCount) {
            self.swipeLeft();
          },
          swipeRight : function(event, direction, distance, duration, fingerCount) {
            self.swipeRight()
          }
        });

        $('.cta-tile-remove', '#compare').on('click', {'self': self}, function(evt) {
            var self = evt.data.self,
                prodID = $(evt.target).attr('data-prod-id');
            
            evt.preventDefault();
            self.removeCompareItem({'prodID' : prodID, 'self' : self});
        });

        $(_cached.comTiles).each(function(idx) {
            self.pagination(idx);

            if (Modernizr.touch === false && _cached.comTileCount > 1 ){ // touch is not enabled
                $('.pagination', this).wrap('<div class="navigation" />');
                $('.navigation', this).wrap('<div class="navigation-container" />').append('<a href="#" class="click-right end"></a>').prepend('<a href="#" class="click-left"></a>');
            }
        })

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation').on('click', {'self' : self}, function(evt) {
                var direction = evt.target.className,
                    self = evt.data.self;
                evt.preventDefault();

                switch(direction) {
                    case 'click-left' :
                    self.swipeLeft(evt);
                    break;

                    case 'click-right' :
                    self.swipeRight(evt);
                    break;
                }
            })
        }
        
        
    },

    removeCompareItem : function(args) { // prodID, self
        var self = args.self,
            self2 = intel.mobile.controller.compare,
            item = args.prodID,
            cookieData = self2.readCookie('compare-products');
            cookieArr = cookieData.split(','),
            i = cookieArr.length;

        while (i--) {
            if (cookieArr[i] === item) {
                cookieArr.splice(i, 1); // remove item from array
            }
        }
        if (cookieArr.length > 0) {
            self2.notify('createCookie', {name : 'compare-products', value : cookieArr.join(',')}); // update cookie
        } else {
            self2.deleteCookie('compare-products');
        }

        window.location.reload(); //reloads the page to re-render off the newly adjusted cookie
    },
    
    rotation : function (evt) {
        var self = evt.data.self,
        _cached = self.cache,
        resize = function resize() { 
            self.comsetsize();
            self.pagination();
        };
        window.setTimeout(resize, 500)
    },
    
    comsetsize : function () {
        var self = this,
            _cached = self.cache,
            winWidth = $(window).width() - 20,
            scrollDistance = $(window).width() * (_cached.comCurrentSlide - 1),
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';
        _cached.comTiles.each(function (idx) {
            $(this).css({'width': winWidth})
        });

        if( Modernizr.csstransforms3d ) { 
            _cached.comCaroContent.attr( 'style', openStyle3d ); // adjust the position of the slides
        } else {
            _cached.comCaroContent.animate({ left : '-' + scrollDistance }, 200) 
        }        
    },

    /* SWIPE HANDLERS
    left : */
    swipeLeft : function (evt) {
        var self = this,
            _cached = self.cache,
            winWidth = _cached.comCarousel.width(),
            scrollDistance =  winWidth * _cached.comCurrentSlide,
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';

        if (_cached.comCurrentSlide == _cached.comSlidesCount ) {return; } 

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation .click-right').removeClass('end');
        }

        if( Modernizr.csstransforms3d ) {

            _cached.comCaroContent.attr( 'style', openStyle3d );
            _cached.comCurrentSlide = _cached.comCurrentSlide += 1; // advance slide count
            $(_cached.comPagination[_cached.comCurrentSlide - 1]).children('span').each(function(idx) { // advance pagination
                if ( (idx) === (_cached.comCurrentSlide - 1) ) {
                    $(this).addClass('active'); // make the new comCurrentSlide dot active
                } else {
                    $(this).removeClass('active'); // make the rest of the dots inactive
                }
            })
            if (Modernizr.touch === false) { // touch is not enabled
                if (_cached.comCurrentSlide === _cached.comSlidesCount) {
                    $('.navigation .click-left').addClass('end');
                    $('.navigation .click-right').removeClass('end')
                }
            }
        } else { // Lumina animation
            _cached.comCaroContent.animate({ left : '-=' + (winWidth) }, 200 , function () {
                _cached.comCurrentSlide = _cached.comCurrentSlide += 1; // advance slide count
                $(_cached.comPagination[_cached.comCurrentSlide - 1]).children('span').each(function(idx) { // advance pagination
                    if ( (idx) === (_cached.comCurrentSlide - 1) ) {
                        $(this).addClass('active'); // make the new comCurrentSlide dot active
                    } else {
                        $(this).removeClass('active'); // make the rest of the dots inactive
                    }
                });
                if (Modernizr.touch === false) { // touch is not enabled
                    if (_cached.comCurrentSlide === _cached.comSlidesCount) {
                        $('.navigation .click-left').addClass('end');
                        $('.navigation .click-right').removeClass('end')
                    }
                }
            }); // eo animate callback
        }
   },

    /*right : */
    swipeRight : function (evt) {
        var self = this,
            _cached = self.cache,
            winWidth = _cached.comCarousel.width(),
            scrollDistance = (winWidth * (_cached.comCurrentSlide - 1)) - winWidth,
            openStyle3d =   '-webkit-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            '-moz-transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0);' + 
                            'transform: translate3d(-' + scrollDistance + 'px,' + '0' + 'px,0););';

        if (_cached.comCurrentSlide === 1 ) { return }; // if we're at the end don't animate

        if (Modernizr.touch === false) { // touch is not enabled
            $('.navigation .click-left').removeClass('end');
        }

        if( Modernizr.csstransforms3d ) {
            _cached.comCaroContent.attr( 'style', openStyle3d );
            _cached.comCurrentSlide = _cached.comCurrentSlide -= 1; // advance slide count
                $(_cached.comPagination[_cached.comCurrentSlide - 1]).children('span').each(function(idx) { // advance pagination
                    if ( (idx) === (_cached.comCurrentSlide - 1) ) {
                        $(this).addClass('active'); // make the new comCurrentSlide dot active
                    } else {
                        $(this).removeClass('active'); // make the rest of the dots inactive
                    }
                });
                if (Modernizr.touch === false) { // touch is not enabled
                    if (_cached.comCurrentSlide === 1 ) {
                        $('.navigation .click-right').addClass('end');
                        $('.navigation .click-left').removeClass('end');
                    }
                }
        } else {
            _cached.comCaroContent.animate({left : '+='+ (_cached.comCarousel.width()) }, 200, function () {
                _cached.comCurrentSlide = _cached.comCurrentSlide -= 1; // advance slide count
                $(_cached.comPagination[_cached.comCurrentSlide - 1]).children('span').each(function(idx) {
                    if ( (idx) === (_cached.comCurrentSlide - 1) ) {
                        $(this).addClass('active'); // make the new comCurrentSlide dot active
                    } else {
                        $(this).removeClass('active'); // make the rest of the dots inactive
                    }
                });
                if (Modernizr.touch === false) { // touch is not enabled
                    if (_cached.comCurrentSlide === 1 ) {
                        $('.navigation .click-right').addClass('end');
                        $('.navigation .click-left').removeClass('end');
                    }
                }
            });  // eo animate callback
        }                   
    },

    pagination : function (cIDX) {
        var self = this,
            frag = document.createDocumentFragment(),
            winOrient = window.orientation,
            i = self.cache.comTileCount + 1;
        if( i > 2 ) {
            while (--i) {
                    frag.appendChild(document.createElement("span"));
                    if(i === 1) { 
                        frag.firstChild.setAttribute('class', 'active')
                }
            };
            $(self.cache.comPagination).html('').append(frag); // append now full-of-spans-fragment to the DOM
        }

    }
});

intel && intel.mobile && intel.mobile.register('decision-slider', {
    
    cache : {
        sliderDragger : $('.dragger'),
        sliderQuestions : $('.question'),
        sliderLinks : $('.question ul li a'),
        sliderTickCount : [],
        sliderCTA : $('.cta a', '#main'),
        sliderOrientation : window.orientation
    },

    init: function() {
        var self = this,
            qTotal = self.cache.sliderQuestions.length;

        $(window).on('orientationchange', {'self': self}, self.sliderOrientationChange)

        // halt default click behavoir
        self.cache.sliderCTA.on('click', function(e){ e.preventDefault();} ) // listener for the submit CTA

        // listener for click on the answers
        self.cache.sliderLinks.on('click', {'self' : self}, self.sliderClickLink);

        // pre-pop the ticker count array with undefined values to be replaced with answers
        self.cache.sliderTickCount.length = qTotal;

        // listeners for moving the dragger
        self.cache.sliderDragger.swipe({
            swipeUp : function(event, direction, distance, duration, fingerCount) {
            var question = $(event.target).closest('.question'),
                    qIDX = parseInt(question.index('.question'), 10);

                // activate the slider track and dragger
                if (question.hasClass('active') === false) {
                    question.addClass('active');
                }
                
                // move the dragger and increment the count
                self.sliderSwipeUp(question, qIDX);
            },
            swipeDown : function(event, direction, distance, duration, fingerCount) {
                var question = $(event.target).closest('.question'),
                    qIDX = parseInt(question.index('.question'), 10);

                // activate the slider track and dragger
                if (question.hasClass('active') === false) {
                    question.addClass('active');
                }
                
                // move the dragger and increment the count
                self.sliderSwipeDown(question, qIDX);
            },
            allowPageScroll : 'none'
        });
    },

    sliderOrientationChange : function(e) {
        var self = e.data.self;
        self.cache.sliderOrientation = window.orientation;
    },

    sliderClickLink: function(e) {
        var self = e.data.self,
            tick = parseInt(e.target.getAttribute('data-tick'), 10), 
            question = $(e.target).closest('.question'), 
            qIDX = parseInt(question.index('.question'), 10), 
            dragger = $('.dragger', question), 
            winOrient = (window.innerHeight > window.innerWidth) ? 'portrait' : 'landscape',
            scrollIncrement = (winOrient === 'landscape') ? 75 : 50, // landscape: 75, portrait: 50
            scrollDistance = scrollIncrement * tick,
            openStyle3d =   '-webkit-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            '-moz-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            'transform: translate3d(0,' + scrollDistance + 'px,' + '0);';

        e.preventDefault();


        // activate the slider track and dragger
        if (question.hasClass('active') === false) {
            question.addClass('active');
        }

        if( Modernizr.csstransforms3d ) { // CSS3
            $(dragger).attr( 'style', openStyle3d ); // animate the dragger
            self.cache.sliderTickCount[qIDX] = tick; // log tick in the array
            self.sliderInactive(question); // deactivate the other anwers, remove .active
            self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
            self.ctaActive(); // check to see if we can activate the CTA
            
        } else {
            dragger.animate({ // JS
                top: scrollDistance, // animate the dragger
                }, 500, function() {
                self.cache.sliderTickCount[qIDX] = tick; // log tick in the array
                self.sliderInactive(question); // deactivate the other anwers, remove .active
                self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
                self.ctaActive(); // check to see if we can activate the CTA
            });
        }
    },
    
    sliderSwipeDown: function(question, qIDX){
        var self = this,
            dragger = event.target,
            winOrient = (window.innerHeight > window.innerWidth) ? 'portrait' : 'landscape',
            scrollIncrement = (winOrient === 'landscape') ? 75 : 50, // landscape: 75, portrait: 50
            tickerCount = (isNaN(self.cache.sliderTickCount[qIDX])) ? 1 : parseInt(self.cache.sliderTickCount[qIDX], 10) + 1, 
            scrollDistance = scrollIncrement * tickerCount,
            openStyle3d =   '-webkit-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            '-moz-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            'transform: translate3d(0,' + scrollDistance + 'px,' + '0);';
        if (self.cache.sliderTickCount[qIDX] >= 2) {
            return;
        }
        if( Modernizr.csstransforms3d ) { // CSS3
            $(dragger).attr( 'style', openStyle3d ); // animate the dragger
            self.cache.sliderTickCount[qIDX] = tickerCount; // log tick in the array
            self.sliderInactive(question); // deactivate the other anwers, remove .active
            self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
            self.ctaActive(); // check to see if we can activate the CTA
            
        } else {
            $(dragger).animate({ // JS
            top: '+=' + scrollIncrement, // animate the dragger
            }, 500, function() {
                self.cache.sliderTickCount[qIDX] = tickerCount; // log tick in the array
                self.sliderInactive(question); // deactivate the other anwers, remove .active
                self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
                self.ctaActive(); // check to see if we can activate the CTA
        });
        }
    },

    sliderSwipeUp: function(question, qIDX){    
        var self = this,
            dragger = event.target,
            winOrient = (window.innerHeight > window.innerWidth) ? 'portrait' : 'landscape',
            scrollIncrement = (winOrient === 'landscape') ? 75 : 50, // landscape: 75, portrait: 50
            tickerCount = (isNaN(self.cache.sliderTickCount[qIDX])) ? 0 : parseInt(self.cache.sliderTickCount[qIDX], 10),
            scrollDistance = (scrollIncrement * tickerCount - scrollIncrement),
            openStyle3d =   '-webkit-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            '-moz-transform: translate3d(0,' + scrollDistance + 'px,' + '0);' + 
                            'transform: translate3d(0,' + scrollDistance + 'px,' + '0);';
        if (self.cache.sliderTickCount[qIDX] === 0) {
            return;
        }
        if( Modernizr.csstransforms3d ) { // CSS
            $(dragger).attr( 'style', openStyle3d ); // animate the dragger
            self.cache.sliderTickCount[qIDX] = self.cache.sliderTickCount[qIDX] - 1; // log tick in the array
            self.sliderInactive(question); // deactivate the other anwers, remove .active
            self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
            self.ctaActive(); // check to see if we can activate the CTA
            
        } else {
            $(dragger).animate({ // JS
            top: '-=' + scrollIncrement, // animate the dragger
          }, 500, function() {
            self.cache.sliderTickCount[qIDX] = tickerCount - 1; // log tick in the array
            self.sliderInactive(question); // deactivate the other anwers, remove .active
            self.sliderActive(self.cache.sliderTickCount[qIDX], question); // activate selected answer, add .active
            self.ctaActive(); // check to see if we can activate the CTA
          });
        }
    },

    sliderActive: function(num, el) {
        var self = this;
        $('ul li:eq('+num+') a', el).addClass('active') // add .active to selected answer

    },

    sliderInactive: function(el) {
        var self = this,
            i = el.find('li').length; // max number of answer choices

        while (i--) {
            $('ul li:eq('+i+') a', el).removeClass('active') // remove .active from unselected answers
        }
    },

    ctaActive : function() {
        var self = this,
            i = self.cache.sliderTickCount.length,
            total = 0;

        while(i--) {
                total += parseInt(self.cache.sliderTickCount[i], 10);           
        }
        if (isNaN(total) === false) {
            self.cache.sliderCTA.addClass('active'); // activate CTA
            intel.mobile.quizResults = {'quiz-score' : total}; // score
            self.cache.sliderCTA.on('click', {'self' : self}, self.sliderClickCTA) // listener for the submit CTA
        }
    },

    sliderClickCTA: function(e) {
        var self = e.data.self;
        e.preventDefault();
        window.location = e.target.href;
    }
});

intel && intel.mobile && intel.mobile.register('languageSelect', {
    cache : {
        langLinks : $('.lang .bd > ul li a'),
        langCurLoc : (localStorage.getItem('intel-loc') == null) ? localStorage.setItem('intel-loc', 'usa') : localStorage.getItem('intel-loc')
    },
    
    init: function() {
        var self = this;

        // set the default class on the default lang
        $('a[data-loc="'+self.cache.langCurLoc+'"]').closest('li').addClass('default');

        // add listener to catch clicks
        self.cache.langLinks.on('click', {'self' : self}, self.chooseLink);
    },
    
    chooseLink: function(e) {
        var self = e.data.self,
            loc = e.target.getAttribute('data-loc');

        e.preventDefault();

        // reset classes
        $('.lang .bd > ul li').removeClass('default');
        $(e.target).closest('li').addClass('default');

        // set the language temp functionality. this needs to be developed with integration team
        localStorage.setItem('intel-loc', loc);

        // redirect to homepage
        window.location = e.target.getAttribute('href');
    }
});

intel && intel.mobile && intel.mobile.register('slideShareIframe', {
    cache : {
        ifrm : document.createElement('iframe'),
        slideID : $('.slideshare').attr('data-slide')
    },

    init: function() {
        var self = this,
            _cached = self.cache;

        self.ifrmBuilder();

        $(window).on('orientationchange', function(e) {  self.ifrmBuilder(); })
    },

    ifrmBuilder: function(e) {
        var self = this,
            _cached = self.cache,
            ifrmContainer = $('.slideshare');

        _cached.ifrm.src = 'http://www.slideshare.net/slideshow/embed_code/' + _cached.slideID + '?rel=0';
        _cached.ifrm.width = ifrmContainer.width();
        _cached.ifrm.height = _cached.ifrm.width * .8;
        _cached.ifrm.frameborder = 0;
        _cached.ifrm.marginwidth = 0;
        _cached.ifrm.marginheigh = 0;
        _cached.ifrm.scrolling = "no";

        ifrmContainer.html('').append(_cached.ifrm);
    }
});

intel && intel.mobile && intel.mobile.register('videoPlayer', {
    
    cache : {
        videoContainer : $('.video-ab')
    },

    init : function() {
        var self = this,
            _cached = self.cache,
            tag = document.createElement('script');

        // 2. This code loads the IFrame Player API code asynchronously.
        tag.src = "//www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    
    },

    loadVideoPlayer : function (e) {
        var parent = $(e).closest('.video-container'),
        self = intel.mobile.controller.videoPlayer,
        ytID = parent.find('.video-aa').attr('id'),
        pWidth = '100%',
        //pHeight = $('.videoplayer').width() / 1.5,
        player;

        player = new YT.Player(ytID, {
            width: pWidth,
            height: "200",
            videoId: ytID,
            fs: 1,
            playerVars: { 
              'rel': 0, 
              'enablejsapi': 1 
            },

            events: {
            //'onReady': self.onPlayerReady
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
            }
        });
    },

    // 4. The API will call this function when the video player is ready.
    onPlayerReady : function onPlayerReady(event) {
       //event.target.playVideo();
        event.target.setPlaybackQuality('medium');
    }
});

/*
function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.PLAYING) {
        event.target.setPlaybackQuality('hd720');  // <-- WORKS!
    }
}
*/
// global scope for youtube API
function onYouTubeIframeAPIReady() {
    var el = $('.video-container'),
        i = el.length;

    while (i--) {
        intel.mobile.controller.videoPlayer.loadVideoPlayer(el[i])
    }
}