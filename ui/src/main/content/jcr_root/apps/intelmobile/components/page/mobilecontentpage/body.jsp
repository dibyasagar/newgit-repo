<%@include file="/libs/foundation/global.jsp" %><%
%><%
    final StringBuffer cls = new StringBuffer();
    for (String c : componentContext.getCssClassNames()) {
        cls.append(c).append(" ");
    }
%>
<body marginheight="0" topmargin="0" marginwidth="0" style="height:auto;"> 
	
	<div id="wrapper" class="page mobilepage shoppage touch ">	
	<cq:include script="headerrow.jsp" />
 	<cq:include script="contentrow.jsp" />           
	<cq:include script="footerrow.jsp" />
	</div>
	
</body>