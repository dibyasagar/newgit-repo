<%--

  Jump To component.


--%><%@page import="com.intel.mobile.search.ProductDetails,java.util.*,com.day.cq.wcm.api.WCMMode,com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<%
    String internalLink[] = null;
    String copyText[] = null;
    String templateitems[] = null;
    String displaynames[] = null;
    String showtemplates[] = null;
    String validLink[] = null;
    String tempItems="";
    String dispName="";
    String showTemp="";
    int index = 0;

    templateitems = (String[]) properties.get("templatetype", new String[0]);
    displaynames = (String[]) properties.get("displayname", new String[0]);
    showtemplates = (String[]) properties.get("showtemplatetype", new String[0]);
    internalLink = (String[]) properties.get("internalUrl", new String[0]);
    copyText = (String[]) properties.get("copytext", new String[0]);
    if (internalLink != null){ validLink = IntelUtil.getIntenalUrl(internalLink,resourceResolver);}
    
    pageContext.setAttribute("editmode",WCMMode.fromRequest(request) == WCMMode.EDIT);
    pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName());
	pageContext.setAttribute("tempItems",tempItems);
	pageContext.setAttribute("internalLink",internalLink);
    pageContext.setAttribute("copyText",copyText);
	pageContext.setAttribute("showtemplates",showtemplates);
	pageContext.setAttribute("displaynames",displaynames);
	pageContext.setAttribute("templateitems",templateitems);
	pageContext.setAttribute("validLink",validLink);
	pageContext.setAttribute("jumptolab",properties.get("jumptolab").toString());

%> 
          <c:if test="${(fn:length(templateitems) gt 0)}">
                <c:forEach items="${templateitems}" var="title" varStatus="status">
				<c:choose>
				<c:when test="${tempItems eq null}">
                <c:set var="tempItems" value="${title},${displaynames[status.index]},${showtemplates[status.index]}" />
			    </c:when>
				<c:otherwise>
				<c:set var="tempItems" value="${tempItems}|${title},${displaynames[status.index]},${showtemplates[status.index]}" />
				</c:otherwise>
				</c:choose>
                </c:forEach>
            </c:if>
             <c:if test="${editmode eq 'true'}">
		           <div>Double Click to Edit Jump To Component</div>
	          </c:if>            
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div class="toolbar">
    <div class="selectbox">   
		<form id="sort" action="">

        <select id="jump-to-submenu">        	
            <option value="#"><c:out value="${jumptolab}" escapeXml="false"/></option>
            <c:if test="${fn:length(validLink) gt 0}">
              <c:forEach items="${validLink}" var="title" varStatus="status">
              <option value="${title}">${copyText[status.index]}</option>
              </c:forEach>

            </c:if>    
        </select>
		</form>
    </div>
</div>
</div>
<script text="text/javascript">
$(document).ready(function(){

    var tempLength='${tempItems}';
	var authorTemplate = tempLength.split("|");
	var HTML="";
	var cookieName="intelmobile_last_visited_page";
	var allCookies = document.cookie.split(';');
	for(var i=0;i<authorTemplate.length;i++)
	{
		var SplitTName = authorTemplate[i].split(",");
		for (var j=0;j<allCookies.length;j++) {
			var cookiePair = allCookies[j].split('=');
			var cookieVal=cookiePair[1]; // Title | Url
			var SplitVal = cookieVal.split("|");
			if(SplitVal[0]===SplitTName[0]) {
				if(SplitTName[2]=="yes")
				{
					HTML='<option value="'+SplitVal[1]+'.html">'+SplitTName[1]+'</option>';
					$("#jump-to-submenu option:first-child").after(HTML);
				}
			}
		}
	}
});
</script>