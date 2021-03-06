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
            
            var $mScroll="";
            
            
            var isAndroidOS2=(navigator.userAgent.toLowerCase().indexOf("android") > -1) ? true : false;
            var isBB= (navigator.userAgent.toLowerCase().indexOf("blackberry") > -1) ? true : false;
            var isiPhone3=(navigator.userAgent.match(/iPhone/i)) ? true : false;
            var isIE= (navigator.userAgent.toLowerCase().indexOf("msie") > -1) ? true : false;
            
            setTimeout(function(){
           
            if(isAndroidOS2||isBB||isiPhone3)
            {
           
                if($("#menu-item").attr("class")=="active")
                {
                    
                    var $iMenu=  $("#category-menu").height();
                    $mScroll=$iMenu+100;
                   
                }
                else if($("#search-item").attr("class")=="active")
                {
                    var $isearchMenu=  $("#search-menu").height();
                    $mScroll=$isearchMenu+100;
                   
                }
                
              if(isiPhone3)
              {
                
                if($mScroll!="")
                  {
                      
                      if($iScroll-$mScroll<0)
                      {
                        $mScroll=40;
                      }
                      else
                      {
                        $mScroll=($iScroll-$mScroll);
                      }
                      //$mScroll = ( $iScroll <= 40 ) ? 40 : ($iScroll-$mScroll) ;
                      $oSticky.css( { "top":$mScroll} ) ; 
                  }
                  else
                  {
                      document.getElementById("ultrabook_content").removeAttribute("style");
                      $(".footer").removeAttr("style");
                      document.getElementById("category-menu").removeAttribute("style");
                      
                      $iScroll = ( $iScroll <= 40 ) ? 40 : 0;
                      
                      $oSticky.css( { "top":$iScroll +100 } ) ; 
                  }
              }
              else
              {
              if($mScroll!="")
              {
              $mScroll = ( $mScroll <= 40 ) ? 40 : $mScroll ;
              $oSticky.css( { "top":$mScroll +100 } ) ; 
              }
              else
              {
                  $iScroll = ( $iScroll <= 40 ) ? 40 : 0 ;
                  $oSticky.css( { "top":$iScroll +100 } ) ; 
              }
              }
               
           }
           else
           {
                if($("#menu-item").attr("class")=="active")
                {
                    
                    var $iMenu=  $("#category-menu").height();
                    $mScroll=$iMenu+100;
                   
                }
                else if($("#search-item").attr("class")=="active")
                {
                    var $isearchMenu=  $("#search-menu").height();
                    $mScroll=$isearchMenu+100;
                   
                }
           
           
           if($mScroll!="")
                  {
                      
                      if($iScroll-$mScroll<0)
                      {
                        $mScroll=40;
                      }
                      else
                      {
                        $mScroll=($iScroll-$mScroll);
                      }
                      //$mScroll = ( $iScroll <= 40 ) ? 40 : ($iScroll-$mScroll) ;
                      $oSticky.css( { "top":$mScroll} ) ; 
                  }
                  else
                  {
                      
                      document.getElementById("ultrabook_content").removeAttribute("style");
                      $(".footer").removeAttr("style");
                      document.getElementById("category-menu").removeAttribute("style");
                      //document.getElementById("ultrabook_content").style="";
                      
                      $iScroll = ( $iScroll <= 40 ) ? 40 : 0;
                      
                      $oSticky.css( { "top":$iScroll +100 } ) ; 
                  }
           }
           },1000);
                

            } ;

            this.xOpens = function()
            {
                $oMenus.show() ;

                $iCurScrollTop = xGetScrollTop() ;
                
                 var isBB= (navigator.userAgent.toLowerCase().indexOf("blackberry") > -1) ? true : false;
               
                if(isBB)
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
                    
                    setTimeout(function(){
                    
                    $oContent.hide() ;
                    $oHeader.hide() ;
                    $oFooter.hide() ;
                    },1000);
                }
                
                
                else
                {

                $oContent.hide() ;
                $oHeader.hide() ;
                $oFooter.hide() ;
                }
                
                //$("html,body").scrollTop( 0 ) ;

             
               
              

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

/* added by shishir for image change on device rotation Start*/
/*

function tImage()
{
           
           
           var isIE= (navigator.userAgent.toLowerCase().indexOf("msie") > -1) ? true : false;
            
            if(isIE)
            {
                if(window.innerWidth>window.innerHeight)
                {
                    //landscape
                     var pImage=$('.vertical');
                          var lImage=$('.imgland');
                          var hImage=$('.camp_vertical');
                          var vImage=$('.camp_landscape');
                  
                          hImage.attr("style","display:none");
                          vImage.attr("style","display:block");
                          
                          pImage.attr("style","display:none");
                          lImage.attr("style","display:block");
                }
                else
                {
                    //portrait
                    var pImage=$('.vertical');
                  var lImage=$('.imgland');
                  var hImage=$('.camp_vertical');
                  var vImage=$('.camp_landscape');
                  
                  hImage.attr("style","display:block");
                  vImage.attr("style","display:none");
                  pImage.attr("style","display:block");
                  lImage.attr("style","display:none");
                }
            }
            
            else
            {
            if(window.orientation == 0) {
                  // do something

                  var pImage=$('.vertical');
                  var lImage=$('.imgland');
                  var hImage=$('.camp_vertical');
                  var vImage=$('.camp_landscape');
                  
                  hImage.attr("style","display:block");
                  vImage.attr("style","display:none");
                  pImage.attr("style","display:block");
                  lImage.attr("style","display:none");
                       
          
              } 
              else if (window.orientation == 90 || window.orientation == -90) {
                       // do something else 
                         
                          var pImage=$('.vertical');
                          var lImage=$('.imgland');
                          var hImage=$('.camp_vertical');
                          var vImage=$('.camp_landscape');
                  
                          hImage.attr("style","display:none");
                          vImage.attr("style","display:block");
                          
                          pImage.attr("style","display:none");
                          lImage.attr("style","display:block");
                               
                       }
               } 
                       
                
          

      }


$(window).bind('orientationchange resize', _imgHandler);
function _imgHandler()
{
    
    //setTimeout('tImage()',100);
}

*/


/* added by shishir for image change on device rotation END*/

$(document).ready(function(){
    
    
    $("#wrapper").addClass("wapwrapper");
    $("#wrapper").attr("data-component-id","1");
    $("#wrapper").attr("data-component","ultrabook-mobile-campaign-2012");
    var isAndroidOS2=(navigator.userAgent.toLowerCase().indexOf("android 2.3") > -1) ? true : false;
    var isiPhone3g= (navigator.userAgent.toLowerCase().indexOf("iphone os 5_1_1") > -1) ? true : false;
    var isIE= (navigator.userAgent.toLowerCase().indexOf("msie") > -1) ? true : false;
    var isAndroidOS3=(navigator.userAgent.toLowerCase().indexOf("android 4.0.4") > -1) ? true : false;
    var isBB= (navigator.userAgent.toLowerCase().indexOf("blackberry") > -1) ? true : false;
   
    if(isAndroidOS3)
    {
        $(".ultrabook .slide-0 .camp_headerimg").addClass("s3_orig");
    }
    if(isAndroidOS2)
    {
        
        
        $(".ultrabook .slide .item .inside").addClass("s2_orig");
        $(".ultrabook .slide-0 .camp_headerimg").addClass("s2_space");
        
    }
    if(isiPhone3g)
    {
        
        
        $(".ultrabook .slide .item .inside").addClass("iphone_orig");
        
    }
    if(isIE)
    {
        
        
        $(".ultrabook .slide .item .inside").addClass("ie_orig");
        
    }
    if(isBB)
    {
        $(".ultrabook .slide-0 .camp_headerimg").addClass("bb_space");
    }
   //alert("text: "+$(".ultrabook .shop a span").html().length); 
   if($(".ultrabook .shop a span").html().length>19)
   {
		$(".ultrabook .shop a span").addClass("WrapNew");
		$(".ultrabook .slide-z .shop a span").addClass("WrapLast");
   }
//var currentLocale = "${locale}";
//alert(currentLocale);
 
});

$(document).ready(function()
   {
       var headTxt=$(".slide-2 div.head h1");
       
       for(i=0;i<headTxt.length;i++)
       {
       
           var newTxt=headTxt[i].innerHTML;
       
           newTxt=$.trim(newTxt);
       
           if(newTxt.length>15&&newTxt.indexOf(' ')>0)
           {
		
              $(".slide-2 div.head")[i].className +=" hed_ru_style";
			  
			  //var html = newTxt;
			  //html = html.substring(0, 15) + "- " + html.substring(15);
			  //headTxt[i].innerHTML=html;
           }
		   else if(newTxt.length>15&&newTxt.indexOf(' ')<0)
           {
		
              //$(".slide-2 div.head")[i].className +=" ru_newheadstyle";
			  
			  var html = newTxt;
			  html = html.substring(0, 15) + "- " + html.substring(15);
			  headTxt[i].innerHTML=html;
           }
		   else if(newTxt.length>10&&newTxt.length<15&&newTxt.indexOf(' ')<0)
		   {
				$(".slide-2 div.head")[i].className ="head ru_newheadstylesmall";
				//$(".slide-2 div.head")[i].style.marginTop="-45px";
		   }
       }
   });
    