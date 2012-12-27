<%--
  Contact Us Component.
--%>

<%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>

 <div id="main" role="main">
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
            <div id="email-component" class="article-detail">
                
                    
                <div class="sections">
                    
                            <div class="border-list content">
                                <div class="items">
                                   
                                    <div class="item">
                                        <h3 class="headTitle"><c:if test="${properties.contactusheading ne '' && not empty properties.contactusheading }">
                    <c:out value="${properties.contactusheading}" escapeXml="false"/>
              
                </c:if></h3>
                                        
                                        
                                    </div>
                                    
                                     <div class="item">
                                       
                                        <h3 class="descTitle"><c:if test="${properties.subheading ne '' && not empty properties.subheading }">
                    <c:out value="${properties.subheading}" escapeXml="false"/>
              
                </c:if></h3>
                                        
                                    </div>
                                    <form id="email-form" name="email-form" action="" method="POST">
                                    <div class="item">
                                        <div class="grad">
                                            <h3 class="form-label"><c:if test="${properties.namelabel ne '' && not empty properties.namelabel }">
                    <c:out value="${properties.namelabel}" escapeXml="false"/>
              
                </c:if></h3>
                                        </div>
                                    </div>
                                    <div class="item txtbox">
                                     
                                        <div class="text-input">
                                                  <input id="fName" name="fName" type="text" class="text" placeholder="<c:out value="${properties.defaultname}"/>"/>
                                                </div>
                                        <div id="errname" style="display:none">
                                       <h3  style="color:#FF0000"><c:if test="${properties.blankname ne '' && not empty properties.blankname }">
                                            <c:out value="${properties.blankname}" escapeXml="false"/>
                                      
                                        </c:if></h3>
                                     </div>  
                                    </div>
                                    
                                    <div class="item frmlbl">
                                        
                                        <h3 class="form-label"><c:if test="${properties.dropdownlabel ne '' && not empty properties.dropdownlabel }">
                    <c:out value="${properties.dropdownlabel}" escapeXml="false"/>
              
                </c:if></h3>
                                        
                                    </div>
                                    <div class="item frmlbl">
                                        <div class="toolbar">
                                        
                                       <%if(questionCount>1){%>   
                                            <div class="selectbox">
                        
                                                <div id="sel-question">
                                                
                                                <select id="question-submenu">
                                                    <option value=""><c:if test="${properties.dropdowndefault ne '' && not empty properties.dropdowndefault }">
                    <c:out value="${properties.dropdowndefault}" escapeXml="false"/>
              
                </c:if></option>
                                                    <c:forEach var="element" items="${questionArray}" varStatus="row">
                                                     <option value="#url_goes_here"><c:out value="${questionArray[row.index]}" /></option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                   <%}
                                  else{%> 
                                  <style>
                                     #question  {
                                           color:grey;
                                                  }

                                             </style>
                        <div id="question"> 
                                                   
                                                    <c:forEach var="element" items="${questionArray}" varStatus="row">
                                                     <c:out value="${questionArray[row.index]}" />
                                                    </c:forEach>
                                               
                                            </div>
                                        
                                   
                                   <%}%>
                                   <div id="erroption" style="display:none">
                                                  <h3  style="color:#FF0000"><c:if test="${properties.notopic ne '' && not empty properties.notopic }">
                                                    <c:out value="${properties.notopic}" escapeXml="false"/>
              
                                                    </c:if></h3>
                                                </div>
                                    </div>
                                </div>
                                <div class="item frmlbl">
                                        
                                            <h3 class="form-label"><c:if test="${properties.emaillabel ne '' && not empty properties.emaillabel  }">
                    <c:out value="${properties.emaillabel }" escapeXml="false"/>
              
                </c:if></h3>
                                        
                                    </div>
                                    
                                    <div class="item frmlbl">
                                        
                                       
                                        <div class="text-input">
                                            <input id="contactemail" name="contactemail" type="email" class="text" placeholder="<c:out value="${properties.defaultemail}"/>"/>
                                             <input type="hidden" name="toAddress" id="toAddress" value="${properties.destination}">
                                            <input type="hidden" id="signupchecked" name="signupchecked" value="${properties.signmetext}" />                            
                                            <input type="hidden" id="signupunchecked" name="signupunchecked" value="${properties.dontsignmetext}" />
                                             <input type="hidden" id="singlequestion" name="singlequestion" value="<c:out value="${questionArray[0]}" />"
                                        </div>
                                       
                                        
                                    </div>
                                    
                                     <div id="erremail" style="display:none">
                                       <h3  style="color:#FF0000"><c:if test="${properties.wrongemail ne '' && not empty properties.wrongemail }">
                    <c:out value="${properties.wrongemail }" escapeXml="false"/>
              
                </c:if></h3>
                                     </div>
                            <div id="contactblankemail" style="display:none">
                                       <h3  style="color:#FF0000"><c:if test="${properties.blankemail ne '' && not empty properties.blankemail }">
                    <c:out value="${properties.blankemail }" escapeXml="false"/>
              
                </c:if></h3>
                                     </div>         
                                     
                                     
                               <div  style="display:none" id="popup">
            <h3  style="color:#086DB6"><c:if test="${properties.successcopy ne '' && not empty properties.successcopy }">
                    <c:out value="${properties.successcopy}" escapeXml="false"/>
              
                </c:if></h3>
            </div>     
                           <div  style="display:none" id="errpopup">
            <h3  style="color:#FF0000"><c:if test="${properties.systemerror ne '' && not empty properties.systemerror }">
                    <c:out value="${properties.systemerror}" escapeXml="false"/>
              
                </c:if></h3>
            </div>             
                                   
                                    <c:if test="${properties.checkbox ne '' && not empty properties.checkbox }">
                    
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
                                        <h3 class="form-label"><c:if test="${properties.checkbox ne '' && not empty properties.checkbox }">
                    <c:out value="${properties.checkbox}" escapeXml="false"/>
              
                </c:if></h3>
                                        </div>
                                        </td>
                                        </tr></table>
                                        
                                    </div>  
               </c:if>                     
                                    <div class="item">
                                        <li class="compare-btn"><a href="#" class="button primary" id="contactsubmit"><c:if test="${properties.submit ne '' && not empty properties.submit }">
                    <c:out value="${properties.submit}" escapeXml="false"/>
              
                </c:if></a></li>
                                    </div>
                                    </form> 
                                    </div>
                                    
                                    
                                </div>
                            </div>
                </div>
        </div>        
       
  </div>       
        <script>

   $("#contactsubmit").click(function() {
      $('#erroption').hide();
      $('#errname').hide();
      $('#erremail').hide();
      $('#contactblankemail').hide();
       $('#errpopup').hide();
      function checkEmail() { 
      var sEmail = $('#contactemail').val();
      var filter = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i; 
     if(sEmail=="" || sEmail== null){
      $('#contactblankemail').show();
         return false;
    }
     else{ 
      if (!filter.test(sEmail) ) {
          $('#erremail').show();
         return false;
    }
      else
          $('#erremail').hide();
           return true;
      }
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
          var msg=null;
          if(remember!=null){
          if($('#signme').attr('checked')){
           msg= "Yes"; 
          }else{
            msg="No"; 
          }
       }
        return msg;
        }
      var signconfirm=validate();
            
         var failure = function(err) {
             alert("Unable to send mail "+err);
            // TODO - clear the form
           };
         // we want to store the values from the form input box, then send via ajax below
      var fromAddress= $('#contactemail').attr('value');
       var toAddress= $('#toAddress').attr('value');
       var firstName=$('#fName').attr('value');
      //alert(firstName);
       var currenturl=window.location.href;
       currenturl=currenturl.substring(7);
       var e = document.getElementById("question-submenu");
       if(e!=null)
       var strUser = e.options[e.selectedIndex].text;
      else
      strUser=$('#singlequestion').attr('value');
       var subject= strUser + " " + currenturl; 
       //alert(subject);
       var datetime = new Date();
       //alert(datetime );
       var namevalidate=validateName();
       var mailvalidate=checkEmail();
       var selectvalidate=checkOption(); 
     // alert(currenturl);
       if(namevalidate && mailvalidate && selectvalidate){ 
           
       if(signconfirm!=null){   
       $.ajax({
         type: "POST",
         url: "/bin/contactUs",
         data: "datetime="+ datetime + "&subject="+ subject + "&firstName="+ firstName + "&fromAddress="+ fromAddress+ "&toAddress="+ toAddress +"&signup=" + signconfirm,
         success: function(){
            $('#popup').show();
             $('#popup').fadeOut(5000); 
            },
         error: function(xhr, status, err) { 
          
         $('#errpopup').show();
          //failure(err);
        } 
      }); // End .ajax fucntion 
    }
   else{
     $.ajax({
         type: "POST",
         url: "/bin/contactUs",
         data: "datetime="+ datetime + "&subject="+ subject + "&firstName="+ firstName + "&fromAddress="+ fromAddress+ "&toAddress="+ toAddress,
         success: function(){
            $('#popup').show();
             $('#popup').fadeOut(5000); 
            },
         error: function(xhr, status, err) { 
          
         $('#errpopup').show();
          //failure(err);
        } 
      }); // End .ajax fucntion 
    }
    
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
 

<script>

$(document).ready(function(){
    
if ( $.browser.msie ) {
    var fNameTitle='<c:out value="${properties.defaultname}"/>';
    var Emailtitle='<c:out value="${properties.defaultemail}"/>';
    $("#fName").val(fNameTitle);
    document.getElementById("fName").style.color="#666666";
    $("#fName").focus(function(){
        if($("#fName").val()==fNameTitle)
        {

            $("#fName").val("");
        }

    });
    
    $("#fName").blur(function(){

        if($("#fName").val()==="")
        {

            $("#fName").val(fNameTitle);
        }

    });
    
    $("#contactemail").val(Emailtitle);
    document.getElementById("contactemail").style.color="#666666";
    $("#contactemail").focus(function(){
        if($("#contactemail").val()==Emailtitle)
        {

            $("#contactemail").val("");
        }

    });
    
    $("#contactemail").blur(function(){

        if($("#contactemail").val()==="")
        {

            $("#contactemail").val(Emailtitle);
        }

    });
}    
});

</script> 
 
      