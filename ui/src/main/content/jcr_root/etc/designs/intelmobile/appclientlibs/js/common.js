var fadeDuration = 600;
$(document).ready(function(){
    $("#menu-list").css("margin","0");
    $("#menu-list").hide(); 
    $("#search-container").hide();
    $("#site-content > div.ui-select > div").removeClass("ui-btn-corner-all");
    $(".menu-popup > ul > li > a").removeClass("ui-link");
    
    $(document).bind('click', function (event) {
        if ( $(event.target).parents(".language, .nav-lang-container").length == 0 && !$(event.target).hasClass("language") ) {
            hideLangList();
        }
        if ( $(event.target).parents(".nav-jumpto, .nav-jumpto-container").length == 0 && !$(event.target).hasClass("nav-jumpto") ) {
            hideJumpto();
        }
    });
    $("#nav-menu").bind( "click", function() {
        //$("#menu-icon").toggleClass("show");
        //$("#menu-icon").toggle();
        //$("#search-icon").hide();
        $("#search-container").hide();
        $("#menu-list").toggle();
        
        //setFooter();
        //setLanguageList();
        //hideLangList();     
    });
    
    $("#nav-search").bind( "click", function() {
        //$("#menu-icon").hide();
        //$("#search-icon").show();
        
        $("#menu-list").hide();
        //$("#site-content").hide();
        $("#search-container").toggle();
        //setFooter();
        //setLanguageList();
        //hideLangList();
    });
    
    $("#nav-jumpto").bind( "click", function(event, ui) {
        $("#nav-jumpto-container").toggleClass("show");
    });   

    
    $(".jumpto-icon").live( "click", function(event, ui) {
        $("#nav-jumpto-container").toggleClass("show");
    });

    $("#nav-lang-list > div").live("click", function (){
        var self = this;
        var txt = $(self).text();
        $("#select-lang").text(txt);
        hideLangList();
    });
    
    $("#nav-lang").click(function(){
        $("#nav-lang-list").toggleClass("show");
        $("#nav-lang").toggleClass("selected");  
    });
    
    //var popup_width = $("bd").width() + "px";
    //var popup_height = "200px";
    /*var popup_width = "auto";
    var popup_height = "auto";
    
    var $modal = $('<div>This is my modal.</div>')
      .attr('id', 'modal')
      .css({
        background: '#fff',
      zIndex: 3000,
      padding: '10px',
      width: popup_width,     
      margin: '0 auto',
      opacity: 1,
      position: 'absolute',
      top: '10%',
      left: '10%'
    });
    
    $('a.popup').click(function(evt) {
      evt.preventDefault();
      var popup_container = $(this).attr("href");
      var popup_html = $(popup_container).html()
      $(this).overlay({
        effect: 'fade',
        opacity: 0.8,
        closeOnClick: true,
        onShow: function() {
          $('body').append(popup_html);
        },
        onHide: function() {
          popup_html.remove();
        },
      })
    });*/
});

$(window).load(function(){    
  $('.flexslider').flexslider({
    animation: "slide",
    animationLoop: false,
    itemWidth: 510,
    itemMargin: 5,
    start: function(slider){
      $('body').removeClass('loading');
    }
  });
});
function hideJumpto(){
    $("#nav-jumpto-container").removeClass("show");
    $("#nav-jumpto").toggleClass("selected");
}
function hideLangList(){
    $("#nav-lang-list").removeClass("show");
    $("#nav-lang").toggleClass("selected");
}
function getWindowHeight() {
    var windowHeight = 0;
    if (typeof(window.innerHeight) == 'number') {
        windowHeight = window.innerHeight;
    }
    else {
        if (document.documentElement && document.documentElement.clientHeight) {
            windowHeight = document.documentElement.clientHeight;
        }
        else {
            if (document.body && document.body.clientHeight) {
                windowHeight = document.body.clientHeight;
            }
        }
    }
    return windowHeight;
}
function setFooter() {
    if (document.getElementById) {
        var windowHeight = getWindowHeight();
        if (windowHeight > 0) {
            var headerHeight = document.getElementById('hd').offsetHeight;
            var contentHeight = document.getElementById('bd').offsetHeight;
            var footerElement = document.getElementById('ft');
            var footerHeight  = footerElement.offsetHeight;
            if (windowHeight - (headerHeight + contentHeight + footerHeight) >= 0) {
                footerElement.style.position = 'relative';
                footerElement.style.top = (windowHeight - (headerHeight + contentHeight + footerHeight)) + 'px';
            }
            else {
                footerElement.style.position = 'static';
            }
        }
    }
}

function setLanguageList() {
    var ht = 0
    
    if ($("#bd").height() > 50) {
        ht = ($("#hd").height() + $("#bd").height()) - $("#nav-lang-list").height();
    }
    else {
        ht = - $("#nav-lang-list").height();
    }
    ht = ht + "px";
    $("#nav-lang-list").css("top",ht);
}

window.onload = function() {
    setLanguageList();
}

window.onresize = function() {
    setLanguageList();
}