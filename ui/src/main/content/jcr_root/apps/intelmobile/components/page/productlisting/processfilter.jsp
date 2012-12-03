<%@include file="/libs/foundation/global.jsp"%>


<%@page import="com.intel.mobile.filter.ProductListingFilter,java.util.List,java.util.Map,java.util.Set,java.util.*,com.intel.mobile.vo.ProductFilterVO,javax.servlet.http.HttpSession"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 


<%


// String str = request.getParameter("chk_Desktop");
HttpSession session = request.getSession();
Map map = request.getParameterMap() ;
Map filterMap = (Map)session.getAttribute("filterMap");

log.info("Filter Map >>>>>>" + filterMap);
String subFilterName = request.getParameter("hiddensubfilterName");


if(filterMap == null) {
	filterMap = new HashMap<String, List>();
}
Set keySet = map.keySet();

Iterator iter = keySet.iterator();
List<String> keyList = new ArrayList<String>();


while (iter.hasNext()) {
  	String paramName = (String)iter.next();
	log.info("Keys in Request/value in Process Filter>>" + paramName + "/" + map.get(paramName));
	keyList.add(paramName) ;
}
filterMap.put(subFilterName ,keyList);

session.setAttribute("filterMap",filterMap);

getServletContext().getRequestDispatcher("/content/intelmobile/en/products/223.filter.html").forward(request, response);


%>