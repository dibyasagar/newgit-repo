function submitSearchForm() {
	//alert(document.getElementById('search-term').value.trim());
    var searchTerm = document.getElementById('search-term').value.trim();
    if(searchTerm == ""){
		return false;
    }
    else{
    	searchTerm =  searchTerm.replace(new RegExp("\\.","g"), "2EDOT46");  	
    }
    var defaultSearch = "intelmobile"
    var formAction = document.forms["form-search"].action;
    var formSelectorAction = formAction.replace("html", searchTerm +"."+ defaultSearch +".html"); 
    //alert(formSelectorAction);
    window.location = formSelectorAction;
    return false;
 }
function getKeys() {
    
     var searchtext= $('#search-term').val();
     if (searchtext == ""){
    	 $("#suggestions").empty();
    	 $("#suggestions").hide();
     }
    // alert(searchtext);
   var searchParams={"keyword":searchtext}
    $.ajax( {

        url : "/bin/SiteSearch" ,
        type : 'GET',
        dataType : "json",
        data:searchParams,
        error : function() {
            //$("#eventsResults").html("Error Loading the page");
           // alert("failure");
        },

        success : function(data) {
            
           var counter=true;
           var strbrnd = '';
           $.each(data, function(index) {
               // alert(data[index].name);
                //alert(data[index]);
                strbrnd =data[index];
                
            });
           //var temp;
           var result=[];
           var delimiter = ",";
           // $("#pid").html(str);
           //temp = strbrnd.split(delimiter);
           $("#suggestions").empty();
           $("#suggestions").show();
           var sugg_html = "<div class='clearfix'>";
           for (i=0;i<strbrnd.length;i++){
               sugg_html += "<label class='suggestions-items' id='searchres_" + i + "'>" + strbrnd[i] +  "</label>";               
           }
           sugg_html += "<div>";
           $("#suggestions").append(sugg_html);
           $(".suggestions-items").bind( "click", function(event, ui) {
                var self = this;
                var selected_item = $(self).text();                 
                $("#search-term").val(selected_item);
                $("#suggestions").hide();
           });                 
        }
    });

}