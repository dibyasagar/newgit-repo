    //alert("called");
     if($("#homepage"))
    {
       //alert("homepage");
        $("#homepage .tiles li").attr("style","width:48% !important;margin:1% !important");
       
       
        
        
    }
    if($("#prodGrid"))
    {
        //alert("called");
        $("#prodGrid").addClass("design_auth");
    $("#prodGrid li").attr("style","width:130px");
    $("#main div.bd div.criteria-filter span").attr("style","margin-right:0px");
    }
    if($("#product-showcase"))
    {
        var showcase_video="";
        if($("#product-showcase .videoplayer"))
        {
        
            showcase_video=$("#product-showcase .videoplayer ").width();
       
            $(".carousel-content li").attr("style","width:"+(showcase_video)+"px");
        }
    }

$(document).ready(function(){
    
    setTimeout('similarPro()',100);
    
});
    

function similarPro()
{
    //alert("called");
    var similardocWidth="";
    var similardocWidthPro="";
    if($("#main .simillarproducts"))
    {
    
        similardocWidth=$("#main .simillarproducts").width();
    }
    if($("#main #similar_products"))
        {
    
            
            similardocWidthPro=$("#main #similar_products").width();
        
        }
    
        
    if($("#main #similar_products"))
    {
        
        $("#main #similar_products .carousel-content li").attr("style","width:"+(similardocWidthPro/2)+"px");
    }
    if($(".simillarproducts .accordion .carousel-content li"))
    {
        //alert("width: "+similardocWidth);
        $(".simillarproducts .accordion .carousel-content li").attr("style","width:"+(similardocWidth/2)+"px");
        $(".simillarproducts .carousel-content li").attr("style","width:"+(similardocWidth/2)+"px");
    }
}   