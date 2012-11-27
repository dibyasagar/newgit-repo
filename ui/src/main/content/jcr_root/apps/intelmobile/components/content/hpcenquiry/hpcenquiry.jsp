<%--

  HPC Enquiry Component.

  

--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%@page import="com.day.cq.wcm.api.WCMMode"%>
<%
if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
    out.println("Double Click to Edit Hpc Enquiry Component");
}
%>
<link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/ultrabook/email.css" media="all">     
<div id="main" role="main">
            <div id="email-contact">
               
                    <div class="hero">
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
            <h3  display=false backgroundcolor="#8B8989"> email was successfully sent</h3>
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
var failure = function(err) {
      alert("Unable to retrive data "+err);
        // TODO - clear the form
    };
// we want to store the values from the form input box, then send via ajax below
var fromemailaddr= $('#fromemailaddr').attr('value');
var toemailaddr= $('#toemailaddr').attr('value');
var emailbody= $('#emailbody').attr('value'); 
var signupinfo= $('#signupinfo').attr('value'); 
var useremail= $('#email').attr('value');
$.ajax({
        type: "POST",
        url: "/bin/HPCEmail",
        data: "fromemail="+ fromemailaddr+ "&toemail="+ toemailaddr+ "&body=" + emailbody+ "&signup=" + signupinfo + "&email=" + useremail,
        success: function(){
            $('#popup').show();
             $('#popup').fadeOut(5000); 
            },
    error: function(xhr, status, err) { 
            failure(err);
        } 
    }); // End .ajax fucntion 
return false;
}); 
</script>
                                              