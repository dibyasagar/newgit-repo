<%--
  Contact Us Component.
--%>

<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
 pageContext.setAttribute("wcmMode",WCMMode.fromRequest(request));
 if(WCMMode.fromRequest(request) == WCMMode.EDIT) {
    %>       
        <br/><div style="color:#FFFFFF"> Right click to Edit Contact Us Component </div><br/>                 
   <%    
 }
 int questionCount = Integer.parseInt(properties.get("questions", "0"));
 String question[] = new String[questionCount];
 pageContext.setAttribute("questionArray",properties.get("question", question));
   
 %> 
 <div id="main" role="main">
	    	<div id="email-component" class="article-detail">
		    	<h1>Intel® High Performance Computing</h1>
                	
		    	<div class="sections">
                    
                            <div class="border-list content">
                                <div class="items">
                                   
                                    <div class="item">
                                        <h3 class="headTitle"><c:out value="${properties.contactusheading}" escapeXml="false"/></h3>
										
                                        
                                    </div>
									
									 <div class="item">
                                       
										<h3 class="descTitle">Complete the fields below to get more detailed information about Intel HPC solutions.</h3>
                                        
                                    </div>
									<form id="email-form" name="email-form" action="" method="POST">
									<div class="item">
										<div class="grad">
											<h3 class="form-label"><c:out value="${properties.namelabel}" escapeXml="false"/></h3>
										</div>
									</div>
									<div class="item">
									 <div id="errname" style="display:none">
									   <h3  display=false backgroundcolor="##FF0000">Please enter name.</h3>
									 </div>  
										<div class="text-input">
											<input id="fName" name="fName" type="text" class="text">
										</div>
									</div>
									
									<div class="item">
										
										<h3 class="form-label"><c:out value="${properties.questionlabel}" escapeXml="false"/></h3>
										
									</div>
									<div class="item">
										<div class="toolbar">
										<div id="erroption" style="display:none">
									              <h3  display=false backgroundcolor="##FF0000">Please select an option.</h3>
									            </div>
											<div class="selectbox">
		    			
												<div id="sel-question">
												
												<select id="question-submenu">
													<option value="">Select one</option>
													<c:forEach var="element" items="${questionArray}" varStatus="row">
													 <option value="#url_goes_here"><c:out value="${questionArray[row.index]}" /></option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="item">
										
											<h3 class="form-label"><c:out value="${properties.emaillabel}" escapeXml="false"/></h3>
										
									</div>
									
									<div class="item">
									 <div id="erremail" style="display:none">
									   <h3  display=false backgroundcolor="##FF0000">Please enter valid email address.</h3>
									 </div>
										<div class="text-input">
											<input id="email" name="email" type="email" class="text" placeholder="Email Address">
											<input type="hidden" name="toAddress" id="toAddress" value="${properties.destinationmailaddr}">
											<input type="hidden" id="signupchecked" name="signupchecked" value="${properties.signmetext}" />                            
                                            <input type="hidden" id="signupunchecked" name="signupunchecked" value="${properties.dontsignmetext}" />
										</div>
									</div>
									<div class="item">
										<table>
										<tr>
										<td width="8%">
											<!--<div class="text-input">-->
											<input id="signme" name="signme" type="checkbox" class="text">
											<!--</div>-->
										</td>
										
										<td valign="top">
										<div class="chbox-label" id="chbox-label">	
										<h3 class="form-label"><c:out value="${properties.signmetext}" escapeXml="false"/></h3>
										</div>
										</td>
										</tr></table>
										
									</div>	
									<div class="item">
										<li class="compare-btn"><a href="#" class="button primary" id="submit" title="Submit">Submit</a></li>
									</div>
									</form>	
									</div>
									
                                    
                                </div>
                            </div>
                </div>
		</div>        
		
		 <div  style="display:none" id="popup">
            <h3  display=false backgroundcolor="#8B8989"> email was successfully sent</h3>
            </div>
        <script>

   $("#submit").click(function() {
	  function checkEmail() { 
		  var sEmail = $('#email').val();
	  var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	  if (!filter.test(sEmail) ) {
		  $('#erremail').show();
		 return false;
	}
	  else
		  $('#erremail').hide();
		   return true;
	  }
	  function validateName(){
		  var name=$('#fName').val();
		  if(name.length==0){
			  $('#errname').show();
			  return false;
		  }
		  $('#errname').hide();
		  return true;
	  }
	  function checkOption(){
		  var option=$('#question-submenu').val();
		   if(option==""){
			  $('#erroption').show();
			   return false;
		  }
		   $('#erroption').hide();
		  return true; 
	}
	  function validate(){
		  var remember = document.getElementById('signme');
		  var msg="";
		  if (signme.checked){
		   msg= $('#signupchecked').val();
		  }else{
		    msg= $('#signupunchecked').val(); 
		  }
		return msg;
		}
	  var signconfirm=validate();
	         
         var failure = function(err) {
             alert("Unable to send mail "+err);
            // TODO - clear the form
           };
         // we want to store the values from the form input box, then send via ajax below
       var fromAddress= $('#email').attr('value');
       var toAddress= $('#toAddress').attr('value');
       
        var namevalidate=validateName();
       var mailvalidate=checkEmail();
       var selectvalidate=checkOption(); 
       if(namevalidate && mailvalidate && selectvalidate){ 
    	   
    	  
       $.ajax({
         type: "POST",
         url: "/bin/contactUs",
         data: "fromAddress="+ fromAddress+ "&toAddress="+ toAddress +"&signup=" + signconfirm,
         success: function(){
            $('#popup').show();
             $('#popup').fadeOut(5000); 
            },
         error: function(xhr, status, err) { 
            failure(err);
        } 
      }); // End .ajax fucntion 
     } 
       
      return false;
      
  });    
/*   $(document).ready(function() {
	  $(".email-form").validate({
		  alert('entered validate');
	    rules: {
	    	fName: {
	    		required: true,
	    		minlength: 3// simple rule, converted to {required: true}
	    	},
	      email: {             // compound rule
	      required: true,
	      email: true
	      },
	    },
	    messages: {
	    	fName:{
	    		required : alert('enter name');
	    minlength : alert('enter name more than 3');
	    	},
	    	
	    	email:  alert('enter email');
	      },
	     submitHandler: function(form) {
	    	 $(form).ajaxSubmit({
	             type: "POST",
	             url: "/bin/contactUs",
	             data: "fromAddress="+ fromAddress+ "&toAddress="+ toAddress,
	             success: function(){
	                $('#popup').show();
	                 $('#popup').fadeOut(5000); 
	                },
	             error: function(xhr, status, err) { 
	                failure(err);
	            } 
	          });
	      }
	  });
	});  */ 
</script>
		
		<!--#include file="includes/footer.html"-->
		<!--#include file="includes/script-includes.html"-->
		<script type="text/javascript" src="js/plugins.js"></script>		
		<script type="text/javascript" src="js/example-controller.js"></script> 
		   
        

	