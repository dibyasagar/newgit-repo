<%--

 Email Subscription Signup Component. 

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%@page import="com.day.cq.wcm.api.WCMMode"%>

<link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/email.css" media="all">      

                        
<div id="main" role="main">
<div id="email-contact" class="article-detail"> 

                    <div class="hero">
 
  <form class="contact_form" action="" method="post" name="emailForm" id="emailForm" >                     
<div class="content">
          <%
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
    out.println("Double Click to Edit Email Subscription Signup Component");
}
%>
                               
                            <div class="grad"> 
                                
                                <h3 class="form-label"><c:if test="${properties.confirmtext ne '' && not empty properties.confirmtext}">
                    <c:out value="${properties.confirmtext}"/>
                </c:if>  </h3>
                            </div>
                            <div class="items">
                                <div class="item">
                                            
                                   <h3 class="form-label">  <c:if test="${properties.emaillabel ne '' && not empty properties.emaillabel }">
                    <c:out value="${properties.emaillabel}"/>
                </c:if> </h3>
                                            
                                </div>
                            </div>

 
<input type="hidden" id="fromemailaddr" name="fromemail" value="<%=properties.get("source",String.class)%>" />                                     
<input type="hidden" id="toemailaddr" name="toemail" value="<%=properties.get("destination",String.class)%>" />                                        
<input type="hidden" id="emailbody" name="body" value="<%=properties.get("mailbody",String.class)%>" />                                            
<input type="hidden" id="subject" name="subject" value="<%=properties.get("emailsubject",String.class)%>" />                              
                            <div class="items">
                                <div class="item">
                                    <table class="contact-table">
                                        <tbody><tr>
                                            <td>
                                                <div class="text-input">
                                                    <input id="email" name="email" type="text" class="text" placeholder=" <c:out value="${properties.emaildefault}"/>">
                                                </div>
                                            </td>
                                            <td>
                                                     <li class="compare-btn email-btn"><a href="#" id="emailsubmit" class="button primary"><c:if test="${properties.submit ne '' && not empty properties.submit }">
                    <c:out value="${properties.submit }" escapeXml="false"/>
              
                </c:if></a></li>

                                          
                                            </td>
                                        </tr>
                                    </tbody></table>        
  <div id="wrongemail" style="display:none">
                                       <h4  style="color:#FF0000"><c:if test="${properties.wrongemail ne '' && not empty properties.wrongemail }">
                    <c:out value="${properties.wrongemail }" escapeXml="false"/>
              
                </c:if></h4>
</div>
<div  style="display:none" id="syserrpopup">
            <h4  style="color:#FF0000"><c:if test="${properties.systemerror ne '' && not empty properties.systemerror }">
                    <c:out value="${properties.systemerror}" escapeXml="false"/>
              
                </c:if></h4>
            </div>            
 <div id="blankemail" style="display:none">
                                       <h4  style="color:#FF0000"><c:if test="${properties.blankemail ne '' && not empty properties.blankemail }">
                    <c:out value="${properties.blankemail }" escapeXml="false"/>
              
                </c:if></h4>
</div>                                  
                                            
                                </div>
                                
 <div  style="display:none" id="emailpopup">
            <h4  display=false backgroundcolor="#8B8989"><c:if test="${properties.successcopy ne '' && not empty properties.successcopy }">
                    <c:out value="${properties.successcopy }" escapeXml="false"/>
              
                </c:if></h4>
  </div 
  
 
 </form>                                  
                                 
                                    </div>
                        </div> 
                  
                </div>
            </div>
 </div>        

 <script>
$("#emailsubmit").click(function() {
  $('#blankemail').hide();
  $('#wrongemail').hide();
    $('#mailerr').hide();
function checkEmail() { 
     //alert("hi");
      var sEmail = $('#email').val();
      var filter = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
     if(sEmail=="" || sEmail== null){
      $('#blankemail').show();
         return false;
    }
     else{ 
      if (!filter.test(sEmail) ) {
          $('#wrongemail').show();
         return false;
    }
      else
          $('#wrongemail').hide();
           return true;
      }
     }
var failure = function(err) {
      alert("Unable to send mail "+err);
        // TODO - clear the form
    };
// we want to store the values from the form input box, then send via ajax below
var subjectcheck="false";
var fromemailaddr= $('#fromemailaddr').attr('value');
var toemailaddr= $('#toemailaddr').attr('value');
var emailbody= $('#emailbody').attr('value'); 
var signupinfo= $('#signupinfo').attr('value'); 
var useremail= $('#email').attr('value');
var mailsubject=$('#subject').attr('value');
<c:if test="${properties.emailsubject ne '' && not empty properties.emailsubject }">
subjectcheck="true";
</c:if>
var mailvalidate=checkEmail();
if(mailvalidate){
if(subjectcheck=="true"){
$.ajax({
        type: "POST",
        url: "/bin/EmailSub",
        data: "fromemail="+ fromemailaddr+ "&toemail="+ useremail + "&body=" + emailbody + "&email=" + useremail +  "&subject=" + mailsubject,
        success: function(){
           $('#emailpopup').show();
             $('#emailpopup').fadeOut(5000); 
            },
    error: function(xhr, status, err) { 
            $('#syserrpopup').show();
            //failure(err);
        } 
    }); // End .ajax fucntion 
}
else{
$.ajax({
        type: "POST",
        url: "/bin/EmailSub",
        data: "fromemail="+ fromemailaddr+ "&toemail="+ useremail + "&body=" + emailbody + "&email=" + useremail,
        success: function(){
           $('#emailpopup').show();
           $('#emailpopup').fadeOut(5000); 
            },
    error: function(xhr, status, err) { 
            $('#syserrpopup').show();
            //failure(err);
        } 
    }); // End .ajax fucntion 

}


}
else
$('#mailerr').show();
return false;
}); 
</script>  
                                                   
<script>

$(document).ready(function(){
    
if ( $.browser.msie ) {
    
    
    var Emailtitle='<c:out value="${properties.emaildefault}"/>';
    
    
    $("#email").val(Emailtitle);
    document.getElementById("email").style.color="#666666";
    $("#email").focus(function(){
        if($("#email").val()==Emailtitle)
        {

            $("#email").val("");
        }

    });
    
    $("#email").blur(function(){

        if($("#email").val()==="")
        {

            $("#email").val(Emailtitle);
        }

    });
}    
});

</script>   