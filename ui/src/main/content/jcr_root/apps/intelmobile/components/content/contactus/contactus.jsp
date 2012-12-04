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
										<div class="text-input">
											<input id="fName" name="fName" type="text" class="text">
										</div>
									</div>
									
									<div class="item">
										
										<h3 class="form-label"><c:out value="${properties.questionlabel}" escapeXml="false"/></h3>
										
									</div>
									<div class="item">
										<div class="toolbar">
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
										<div class="text-input">
											<input id="email" name="email" type="email" class="text" placeholder="Email Address">
											<input type="hidden" name="toAddress" id="toAddress" value="${properties.destinationmailaddr}">
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
										<div class="chbox-label">	
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
			    
		
       <!--  <div id="disclaimers" class="clearfix">
            <a class="expand" href="#disclaimer-content">Disclaimers</a>
            <div id="disclaimer-content">
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                    ullamco laboris nisi ut aliquip ex ea commodo consequats.  
                </p>
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna
                    aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                    ullamco laboris nisi ut aliquip ex ea commodo consequats.  
                </p>
            </div>
        </div> -->
        <div  style="display:none" id="popup">
            <h3  display=false backgroundcolor="#8B8989"> email was successfully sent</h3>
            </div>
        <script>

  $("#submit").click(function() {
	  function checkEmail() { 
		  var sEmail = $('#email').val();
	  var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	  if (!filter.test(sEmail) ) {
		 alert('Please enter valid email address');
		 email.focus;
		 return false;
	}
	  else
		   return true;
	  }
	         
         var failure = function(err) {
             alert("Unable to send mail "+err);
            // TODO - clear the form
           };
         // we want to store the values from the form input box, then send via ajax below
       var fromAddress= $('#email').attr('value');
       var toAddress= $('#toAddress').attr('value');
       var mailvalidate=checkEmail();
       if(mailvalidate){ 
       $.ajax({
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
      }); // End .ajax fucntion 
     } 
      return false;
	 
  }); 
</script>
		
		<!--#include file="includes/footer.html"-->
		<!--#include file="includes/script-includes.html"-->
		<script type="text/javascript" src="js/plugins.js"></script>		
		<script type="text/javascript" src="js/example-controller.js"></script>    
        

	