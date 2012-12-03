<%@include file="/libs/foundation/global.jsp"%>


<%@page import="com.intel.mobile.filter.ProductListingFilter,com.intel.mobile.servlets.FilterProcessorServlet,java.util.List,com.intel.mobile.vo.ProductFilterVO,java.util.List,java.util.Map,java.util.Set,java.util.*,javax.jcr.Node"%>
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


new ProductListingFilter().getFilters(request,currentPage,filterTags);
String[] select = slingRequest.getRequestPathInfo().getSelectors();
String sourceFilter = select[1] ;
pageContext.setAttribute("filterReq", sourceFilter); 
Map map = (Map)request.getSession().getAttribute("filterMap");
log.info("MAP :"+map);
if (map != null) {
    pageContext.setAttribute("list", map.get(sourceFilter));
}
pageContext.setAttribute("filterMap", map);
%>       
<!DOCTYPE html>
<html>
<cq:include script="head.jsp"/>
<body marginheight="0" topmargin="0" marginwidth="0" style="height:auto;"> 
    <div id="wrapper" class="page mobilepage shoppage touch ">
	<cq:include script="headerrow.jsp" />


	<!-- Filter Body Start  -->
	
	<div id="main" role="main">
	    	<div class="search-results">
	    		<h1>${filterReq}</h1>
	    		<form id="subfilterForm" action="/bin/FilterProcessor">
	    		<div class="bd">
	    			<div class="filter" style="display: block; ">
	    				<div class="cta">
	    					<a href="#" class="cancel" onClick="history.back()">Cancel</a>
	    					<button class="continue" type="submit">Continue</button>
	    				</div>
	    			
	    			<input type="hidden" name="pagePath" value="<%= currentPage.getPath()%>">
					<input type="hidden" name="filterName" value="<%=sourceFilter%>">
					<ul class="level2" style="display: block;">
						<li>Content Type: <a href="#">(Reset)</a>
						</li>
						<c:forEach var="filter" items="${productFilterVOList}">

							<c:if test="${filter.filterName == filterReq}">
								<c:if test="${fn:length(filter.subFilters) > 0}">
									<c:forEach var="ab1" items="${filter.subFilters}">
										<li><c:set var="contains" value="false" /> <c:forEach
												var="item" items="${list}">
												<c:if test="${item == ab1.subFilterName}">
													<c:set var="contains" value="true" />
												</c:if>
											</c:forEach> <c:choose>
												<c:when test="${contains}">
													<input checked="checked" type="checkbox"
														name="${ab1.subFilterName}" />
												</c:when>
												<c:otherwise>
													<input type="checkbox" name="${ab1.subFilterName}" />
												</c:otherwise>
											</c:choose> <label for="<c:out value="${ab1.subFilterName}" />"><c:out
													value="${ab1.subFilterName}" />
										</label></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:forEach>

					</ul>
					
					<div class="cta">
	    					<a href="#" class="cancel" onClick="history.back()">Cancel</a>
	    					<button class="continue" type="submit">Continue</button>
	    				</div>
	    			</div>
	    		</div>
	    		</form>	
	    	</div>
		</div>
	<!-- Filter Body End -->



	<cq:include script="footerrow.jsp" />
	</div>
</body>
</html>
   
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$('#checkAll').click(function(){
		var allCheck = $(this);
		
		if(allCheck.is(':checked')){
			$('.chkProductOption').attr('checked','true');
			$('#checkAll').attr('checked','true');
		}
		else{
			$('.chkProductOption').removeAttr('checked');
			$('#checkAll').removeAttr('checked');
		}
		
	});
	
	$('.chkProductOption').bind('click', function(){
		var checked_items = $('#subfilterForm > div > input:checked').length;
		var total_items = $('#subfilterForm > div > input').length - 1;
		var $self = $(this);
		
		if (!$self.is(":checked") 
				&& (checked_items == total_items)){
			$('#checkAll').removeAttr('checked');
		}
	});
	
});

</script>