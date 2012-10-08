<%@include file="/libs/foundation/global.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %> 

<%@page import="com.intel.mobile.filter.ProductListingFilter,java.util.List,java.util.Map,java.util.Set,java.util.*,javax.jcr.Node" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%

	
	String filterTags = "" ;
	String path = currentPage.getPath();
	
	Node node = currentPage.getContentResource().adaptTo(Node.class);

	if(node.hasNode("productLister")){
		
		Node productLister = node.getNode("productLister");
		if(productLister.hasProperty("filterbrowse")){
		filterTags = productLister.getProperty("filterbrowse").getValue().getString();
		}
		
	}
	
	
	log.info("current Page in filterTags >>>>>>> :" + filterTags);
	log.info("current Page in filter path :" + path);	
	
    new ProductListingFilter().getFilters(request,currentPage,filterTags);
    

%>
     
<%

/**

Removing the session when not set by the this paricular category filter --> Start

*/
if(request.getSession().getAttribute("category") != null && !request.getSession().getAttribute("category").equals(currentPage.getPath().toString())){
	
	log.info("Holding Session for Session Category and current page is not the same in Filter :: " + request.getSession().getAttribute("category"));
	request.getSession().setAttribute("category" ,currentPage.getPath());
	request.getSession().removeAttribute("filterMap");
	
}


log.info("Session Map in Filter" + request.getSession().getAttribute("filterMap"));

/**

Removing the session when not set by the this paricular category filter --> End

*/


HttpSession session = request.getSession();
Map map = (Map)session.getAttribute("filterMap");
pageContext.setAttribute("filterMap", map);
log.info("Map in session in Filter :: " + map);

List<String> valueList = new ArrayList<String>();


if(map != null){
	Set keySet = map.keySet() ;
	Iterator iter = keySet.iterator();
	while (iter.hasNext()) {
	  	String paramName = (String)iter.next();
	  	log.info("\nKeys in Session/value in Filter >>" + paramName + "/" + map.get(paramName));
	  	valueList = (List)map.get(paramName) ;
	  	log.info("Size of subfilters selected for filter : "+paramName+ "is " + valueList.size() );
	  	
	}
	
	
}


log.info("Current Page in Filter" + currentPage.getPath());

%>        


<html>
<cq:include script="head.jsp"/>
<body marginheight="0" topmargin="0" marginwidth="0" style="height:auto;"> 
	<div id="wrapper" class="page mobilepage shoppage touch ">
	<cq:include script="headerrow.jsp" />


	<!-- Filter Body Start  -->
	<div id="main" role="main">
	    	<div class="search-results">
	    		<h2></h2>
	    		<div class="bd">
	    			<div class="filter" style="display: block; ">
	    				<div class="cta">
	    					<a href="#" class="cancel" onClick="history.back()">Cancel</a>
	    					<a href="<%=currentPage.getPath()%>.html" class="continue">Refine</a>
	    				</div>
	    				<ul class="level1">
	    					<li>Filter By: <a href="#">(Reset)</a></li>			
	    					<c:forEach var="filter" items="${productFilterVOList}">   
							   <li><a href="<%= currentPage.getPath() + ".subfilter."%><c:out value="${filter.filterName}"/>.html"><c:out value="${filter.filterName}" /> (<c:out value="${fn:length(filterMap[filter.filterName])}" />)</a></li>
							</c:forEach>
	    				</ul>
	    				<div class="cta">
	    					<a href="#" class="cancel">Cancel</a>
	    					<a href="<%=currentPage.getPath()%>.html" class="continue">Refine</a>
	    				</div>
	    			</div>
	    		</div>
	    	</div>
		</div>
	<!-- Filter Body End -->



	<cq:include script="footerrow.jsp" />
	</div>
</body>
</html>