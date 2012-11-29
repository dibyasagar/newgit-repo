<%--

  HPC Enquiry Component. 

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%@page import="com.day.cq.wcm.api.WCMMode"%>

<link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/email.css" media="all">     
<div id="main" role="main">
<%
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
    out.println("Double Click to Edit Hpc Enquiry Component");
}
%>                         
   
<div id="email-contact" class="article-detail"> 
<h1><c:if test="${properties.headertitle ne '' && not empty properties.headertitle }">
                    <c:out value="${properties.headertitle}" escapeXml="false"/>
              
                </c:if></h1>
                    <div class="hero">
<img src="${properties.picture}" alt="${properties.title}"> 
  
<form class="contact_form" action="" method="post" name="emailForm" id="emailForm" >                     
<div class="content">
       <h3><c:if test="${properties.title ne '' && not empty properties.title }">
                    <c:out value="${properties.title}" escapeXml="false"/>
              
                </c:if> </h3>     
                           <div class="emailfeatures">
                           <c:if test="${properties.hpcdescription ne '' && not empty properties.hpcdescription }">
                    <p><c:out value="${properties.hpcdescription}" escapeXml="false"/></p>
              
                </c:if>
                    </div>        
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
<div  style="display:none" id="mailerr">
            <h4  display=false backgroundcolor="#FF0000"> Enter a valid email id</h4> 
  </div>
<input type="hidden" id="fromemailaddr" name="fromemail" value="<%=properties.get("source",String.class)%>" />                                     
<input type="hidden" id="toemailaddr" name="toemail" value="<%=properties.get("destination",String.class)%>" />                                        
<input type="hidden" id="emailbody" name="body" value="<%=properties.get("hpcdescription",String.class)%>" />                                            
<input type="hidden" id="signupinfo" name="signup" value="<%=properties.get("signup",String.class)%>" />   
                            <div class="items">
                                <div class="item">
                                    <table class="contact-table">
                                        <tbody><tr>
                                            <td>
                                                <div class="text-input">
                                                    <input id="email" name="email" type="text" class="text" placeholder="Email Address">
                                                </div>
                                            </td>
                                            <td>
                                                     <li class="compare-btn email-btn"><a href="#" id="submit" class="button primary" title="Submit">Submit</a></li>

                                          
                                            </td>
                                        </tr>
                                    </tbody></table>        
                                    
                                            
                                </div>
                                
                                <div class="item">
                                        <table>
                                        <tbody><tr>
                                        <td width="8%">
                                            <!--<div class="text-input">-->
                                            <input id="signme" name="signme" type="checkbox" class="text">
                                            <!--</div>-->
                                        </td>
                                        
                                        <td valign="top">
                                        <div class="chbox-label">   
                                        <h3 class="form-label">
  <c:if test="${properties.signup ne '' && not empty properties.signup }">
                    <c:out value="${properties.signup}"/>
                </c:if></h3>
                                        </div>
                                        </td>
                                        </tr></tbody></table>
                                        
                                    </div>  
 <div  style="display:none" id="popup">
            <h3  display=false backgroundcolor="#8B8989"> Email was successfully sent</h3>
  </div 
 </form>                                  
                                    <div class="email-url">
                                        <div class="grad">
                                            <ul class="item">
                                                <li>
                                                <a href="<c:out value="${properties.learnlink}"/>">
  <c:if test="${properties.learnmore ne '' && not empty properties.learnmore }">
                    <c:out value="${properties.learnmore}"/>
                </c:if></a>
                                                </li>
                                            </ul>
                                        </div>
                             
                                        <div class="grad contact-grad">
                                        <li class="compare-btn"><a href="<c:out value="${properties.contactlink}"/>" class="button primary" title="Submit">Contact Us</a></li>
                                        </div>
                                    </div>
                                    <div class="item">
                                        
                                    </div>
                                    
                            </div>
                        </div> 
                  
                </div>
            </div>
   </div>         
 <script>
$("#submit").click(function() {
function verifyEmail(){
$('#mailerr').hide();
var status ="";     
var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
     if (document.emailForm.email.value.search(emailRegEx) == -1) {
         status="wrong";
       
     } 
else
status="right";
 return status;
 }
function validate(){
  var remember = document.getElementById('signme');
  var msg="";
  if (signme.checked){
   msg="The user wants to sign-up for the newsletter ";
  }else{
    msg="The user doesnot want to sign-up for the newsletter";
  }
return msg;
}
var signconfirm=validate();
var failure = function(err) {
      alert("Unable to send mail "+err);
        // TODO - clear the form
    };
// we want to store the values from the form input box, then send via ajax below
var fromemailaddr= $('#fromemailaddr').attr('value');
var toemailaddr= $('#toemailaddr').attr('value');
var emailbody= $('#emailbody').attr('value'); 
var signupinfo= $('#signupinfo').attr('value'); 
var useremail= $('#email').attr('value');
var mailvalidate=verifyEmail();
if(mailvalidate=="right"){
$.ajax({
        type: "POST",
        url: "/bin/HPCEmail",
        data: "fromemail="+ fromemailaddr+ "&toemail="+ toemailaddr+ "&body=" + emailbody+ "&signup=" + signconfirm + "&email=" + useremail,
        success: function(){
            $('#popup').show();
             $('#popup').fadeOut(5000); 
            },
    error: function(xhr, status, err) { 
            failure(err);
        } 
    }); // End .ajax fucntion 
}
else
$('#mailerr').show();
return false;
}); 
</script> 
                                                 