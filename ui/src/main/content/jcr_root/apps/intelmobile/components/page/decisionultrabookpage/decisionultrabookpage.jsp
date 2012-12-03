<%--

  Wide Full Width Component component.

  
    This is the main template source file, it has been divided to include the head.jsp and it's related header files and the body.jsp 
    The Template has been broken down into sub files so that extending it and adapting elements is simple and performed by overriding any of the
    jsp files defined in this top level template.
    
--%><%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%
    // TODO add you code here
%>
<!DOCTYPE html>
<html>
<cq:include script="head.jsp"/>
<cq:include script="body.jsp"/>
</html>

<script>
			
			$(function(){
				var meetUltrabook = intel.initMeetUltrabook();
				meetUltrabook.myScroll = new iScroll('primary', {
					momentum: true,
					hScrollbar: false,
	 		 		vScrollbar: false, 
	 		 		bounce: false,
	 		 		vScroll:true,
					hScroll:true,
	 		 		onScrollEnd: function () {                   
	 		 			meetUltrabook.slidePos();      
	 		 		},
	 		 		onScrollStart: function () {
	 		 			meetUltrabook.slidePos();                      
	 		 			meetUltrabook.hideCallout();     
	 		 		}
	 		 	});
	 		 });

		//	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	    	
        </script>
        