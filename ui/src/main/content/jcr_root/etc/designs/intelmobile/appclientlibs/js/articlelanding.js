function managewidth()
{
    
    var docWidth="";
    
    
    if($(".section li"))
    {
        docWidth=$("#article-landing .sections").width();
        
    }
    
    
    


    if($("#article-landing .accordion .carousel-content li"))
    {
        //$("#article-landing .accordion .carousel-content li").attr("style","width:"+(docWidth)+"px");
        $("#article-landing .accordion .carousel .carousel-content li").attr("style","width:"+(docWidth)+"px");
        $("#article-landing .hero .carousel .carousel-content li").attr("style","width:"+(docWidth+20)+"px");
        
    }
}



$(window).bind('orientationchange', _orientationHandler);
$(document).ready(function(){
    
    setTimeout('managewidth()',1000);
    
});

function _orientationHandler()
{
    setTimeout('managewidth()',1000);
}

