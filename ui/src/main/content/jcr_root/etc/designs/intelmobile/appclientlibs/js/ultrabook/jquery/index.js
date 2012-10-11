/*
    Author: James Ma
    Author: Jeyhun Aliyev
    Dependencies: jQuery, jQuery Mobile
    Description: Intel Ultrabook Mobile

*/
(
    function( $names,$,undefined )
    {
        /* Menus */

        $names.Menus = function()
        {
            /* OOOOO */

        var $class = this ;

            /* OOOOO */

        var $oMenus = {} ;
        var $oContent = {} ;
        var $oHeader = {} ;
        var $oFooter = {} ;

        var $oSticky = {} ;

            /* OOOOO */

        var $iCurScrollTop = 0 ;

            /* OOOOO */

        var xGetScrollTop = function()
            {
            var $iHtml = $("html").scrollTop() ;
            var $iBody = $("body").scrollTop() ;
            
            
         
                    return ( $iHtml >= $iBody ) ? $iHtml : $iBody ;
         
            } ;

            this.xSticky = function()
            {
            var $iScroll = xGetScrollTop() ;
            
            var isAndroidOS2=(navigator.userAgent.toLowerCase().indexOf("android") > -1) ? true : false;
            var isBB= (navigator.userAgent.toLowerCase().indexOf("blackberry") > -1) ? true : false;
            
            setTimeout(function(){
           
            if(isAndroidOS2||isBB)
            {
           
                if($("#menu-item").attr("class")=="active")
                {
                    
                    var $iMenu=  $("#category-menu").height();
                    $iScroll=$iMenu+30;
                   
                }
                else if($("#search-item").attr("class")=="active")
                {
                    var $isearchMenu=  $("#search-menu").height();
                    $iScroll=$isearchMenu+30;
                   
                }
               
           }
           $iScroll = ( $iScroll <= 40 ) ? 40 : $iScroll ;
           $oSticky.css( { "top":$iScroll +30 } ) ; 
           },1000);
                

            } ;

            this.xOpens = function()
            {
                $oMenus.show() ;

                $iCurScrollTop = xGetScrollTop() ;
                
                
                
                $("html,body").scrollTop( 0 ) ;

                $oContent.hide() ;
                $oHeader.hide() ;
                $oFooter.hide() ;
               
              

            } ;

            this.xClose = function( $b )
            {
                
                var isiPhone3=(navigator.userAgent.match(/iPhone/i)) ? true : false;
               
                if(isiPhone3)
                {
                    var video=$('.video-container');
                   
                    if(video.length>0)
                    {
                        for(i=0;i<video.length;i++)
                        {
                          
                           var newsrc=video[i].getElementsByTagName('iframe')[0].src;
                           video[i].getElementsByTagName('iframe')[0].src=newsrc;
                        }
                    }
                }
                
                $oHeader.show() ;
                $oFooter.show() ;
                $oContent.show() ;
                
              

                if( $b )
                {
                    $("html,body").scrollTop( $iCurScrollTop ) ;

                }

                $oMenus.hide() ;

            } ;

            /* OOOOO */

        var xBinds = function()
            {
                $oSticky.click
                (
                    function()
                    {
                        $class.xOpens() ;

                    }

                ) ;

                $oMenus.find(".close").click
                (
                    function()
                    {
                        $class.xClose( true ) ;


                    }

                ) ;

                $oMenus.find(".item").click
                (
                    function()
                    {
                        $class.xClose( false ) ;

                    }

                ) ;

                $(window).scroll
                (
                    function()
                    {
                        $class.xSticky() ;

                    }

                ) ;
                
                 $(".dropdown-trigger").click
                (
                    function()
                    {
                        $class.xSticky() ;

                    }

                ) ;

            } ;

            /* OOOOO */

        var xStart = function()
            {
                $oMenus = $(".menus") ;
                $oContent = $(".content") ;
                $oHeader = $("header") ;
                $oFooter = $("footer") ;

                $oSticky = $(".sticky") ;

                xBinds() ;

            } ;

            xStart() ;



        } ;

        /* Video */

        $names.Video = function()
        {
            /* OOOOO */

        var $class = this ;
        var $Bcove = window.brightcove ;

            /* OOOOO */

        var $oVideo = {} ;
        var $oThumb = {} ;

            /* OOOOO */

        var xBinds = function()
            {
                $(window).bind
                (
                    "orientationchange",function()
                    {
                        $oVideo.hide() ;
                        $oThumb.show() ;

                    }

                ) ;

                $oThumb.click
                (
                    function()
                    {
                    var $iWidth = $( this ).width() ;
                    var $iHeight = $( this ).height() ;

                    var $oParent = $( this ).closest(".video-a") ;
                    var $oPlays = $oParent.find(".video-aa") ;
                    var $oDatas = $oPlays.attr("data-video") ;

                    var $sVideo =
                        '<object id="BCOVE'+$oDatas+'" class="BrightcoveExperience" >' +

                            '<param name="bgcolor" value="#000000" />' +
                            '<param name="playerID" value="1768181851001" />' +
                            '<param name="playerKey" value="AQ~~,AAAAqwZd9wk~,X1Exj3sUi-19aVuw9KL_IGMiTkASW7rF" />' +
                            '<param name="dynamicStreaming" value="true" />' +
                            '<param name="videoSmoothing" value="true" />' +
                            '<param name="wmode" value="transparent" />' +
                            '<param name="isVid" value="true" />' +
                            '<param name="isUI" value="true" />' +

                            '<param name="includeAPI" value="true" />' +
                            '<param name="templateLoadHandler" value="vTempsLoads" />' +
                            '<param name="htmlFallback" value="true" />' +
                            '<param name="forceHTML5" value="true" />' +

                            '<param name="@videoPlayer" value="'+$oDatas+'" />' +

                            '<param name="height" value="'+$iHeight+'" />' +
                            '<param name="width" value="'+$iWidth+'" />' +

                        '</object>' ;

                        $( this ).hide() ;
                        $oPlays.empty().append( $sVideo ).show() ;
                        $Bcove.createExperiences() ;

                    }

                ) ;

            } ;

            /* OOOOO */

        var xStart = function()
            {
                $oVideo = $(".video-aa") ;
                $oThumb = $(".video-ab") ;

                xBinds() ;

            } ;

            xStart() ;



        } ;

        /* Mobil */

        $names.Mobil = function()
        {
            /* OOOOO */

        var $oLearn = {} ;

            /* OOOOO */

        var xBinds = function()
            {
                $oLearn.click
                (
                    function()
                    {
                    var $oParent = $( this ).closest(".slide") ;

                        if( !$( this ).hasClass("close") )
                        {
                            $( this ).addClass("close") ;
                            $( this ).text( $( this ).attr("data-less") ) ;
                            $oParent.find(".more").show() ;

                        }
                        else
                        {
                            $( this ).removeClass("close") ;
                            $( this ).text( $( this ).attr("data-more") ) ;
                            $oParent.find(".more").hide() ;

                            $("html,body").scrollTop
                            (
                                ( $oParent.find(".inside").offset().top )-10

                            ) ;

                        }

                    }

                ) ;

            } ;

            /* OOOOO */

        var xStart = function()
            {
                $(document).ready
                (
                    function()
                    {
                        $names.Menus =
                        new $names.Menus() ;

                        $names.Video =
                        new $names.Video() ;

                        $oLearn = $(".learn") ;

                        xBinds() ;

                    }

                ) ;

                /* Address bar hide */

                $(window).load
                (
                    function()
                    {
                        //setTimeout( function(){ window.scrollTo(0,1) ; },0 ) ;

                    }

                ) ;

            } ;

            xStart() ;



        } ;

        $names.Mobil =
        new $names.Mobil() ;



    }

)
(
    window.$maliv=
    window.$maliv||{},
    jQuery

) ;

function vTempsLoads( $k )
{
    // console.log( $k ) ;

// var $oModulA = brightcove.api.getExperience( $k ) ;

    // $oModulM = $oModulA.getModule( brightcove.api.modules.APIModules.MEDIA ) ;
    // $oModulV = $oModulA.getModule( brightcove.api.modules.APIModules.VIDEO_PLAYER ) ;

    // $oModulM.addEventListener
    // (
        // brightcove.api.events.MediaEvent.PLAY ,
        // function()
        // {
            // $oModulV.goFullScreen() ;

        // }

    // ) ;



}