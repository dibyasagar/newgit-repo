<!--  Purchasing option Component -->

<%@include file="/libs/foundation/global.jsp"%>
<%@page import="org.apache.sling.api.resource.Resource,
                com.intel.mobile.util.ConfigUtil,
                java.util.List,javax.jcr.Node,
                javax.jcr.NodeIterator,
                com.day.cq.wcm.api.WCMMode,
                com.intel.mobile.util.ProductUtil,
                com.intel.mobile.util.IntelUtil"%>
<%@page session="false"%>
<cq:setContentBundle />
<%
	String purchasedisplayCopy = "";
	String pagepath = "";
	String currencySymbol = "";
	
	pagepath = currentPage.getPath();
	currencySymbol = ConfigUtil.getConfigValues(resourceResolver,
			pagepath, "currencysymbol");
	pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
	pageContext.setAttribute("componentName",component.getName() );

	String compName[] = null;
	String compUrl[] = null;
	String newWindow[] = null;
	String logoImage[] = null;
	String prodPrice[] = null;

	compName = (String[]) properties.get("companyname", new String[0]);
	compUrl = (String[]) properties.get("companyurl", new String[0]);
	newWindow = (String[]) properties.get("newwindow", new String[0]);
	logoImage = (String[]) properties.get("logoimage", new String[0]);
	prodPrice = (String[]) properties.get("productprice", new String[0]);
	
	pageContext.setAttribute("wapData",ProductUtil.getWapData(currentPage)); 
%>
<c:set var="currencySymbol" value="<%=currencySymbol%>" />

<c:set var="companyName" value="<%=compName %>" />
<c:set var="companyUrl" value="<%=compUrl %>" />
<c:set var="newWindow" value="<%=newWindow %>" />
<c:set var="prodPrice" value="<%=prodPrice %>" />
<c:set var="logoImage" value="<%=logoImage %>" />

<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<div class="grad">
   <c:choose>
		<c:when	test="${fn:length(companyName) gt 0  }">
	<div class="purchase-options">
		<h4>
			<fmt:message key="productdetailsCMS.label.purchasing_options" />
		</h4>
		<ul class="items">
			<c:set var="counter" value="0" />
			<c:choose>
				<c:when
					test="${fn:length(companyName) gt 0 && fn:length(companyName) <= 2}">
					<c:forEach items="${companyName}" var="name" varStatus="status">
						<li><img src="${logoImage[status.index]}"
							style="width: 150px; height: 50px" /> <span class="price"><c:out
									value="${currencySymbol}" escapeXml="false"/>${prodPrice[status.index]}</span> 
								<c:set var="window" value="" />
						  <c:if test="${newWindow[status.index] eq 'yes'}">
                          <c:set var="window" value="_blank" />
                          </c:if>
									
						<a href="${companyUrl[status.index]}" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${name}","model":"${wapData.name}","price":"${prodPrice[status.index]}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${name}" escapeXml="false"/></a></li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:if test="${fn:length(companyName) gt 2}">
						<c:forEach items="${companyName}" var="name" varStatus="status">
							<c:choose>
								<c:when test="${status.count <= 2}">
									<li><img src="${logoImage[status.index]}"
										style="width: 150px; height: 50px" /> <span class="price"><c:out
												value="${currencySymbol}" />${prodPrice[status.index]}</span> 
										<c:set var="window" value="" />
						     <c:if test="${newWindow[status.index] eq 'yes'}">
                             <c:set var="window" value="_blank" />
                            </c:if>		
										<a href="${companyUrl[status.index]}" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${name}","model":"${wapData.name}","price":"${prodPrice[status.index]}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${name}" escapeXml="false"/></a></li>
								</c:when>
					            <c:otherwise>
									<c:choose>
										<c:when test="${status.count == 3}">
		                               </ul>
		                                   <div class="view-more">
			                                  <ul class="items">
				                     <li><img src="${logoImage[status.index]}"
					                       style="width: 150px; height: 50px" /> <span class="price"><c:out
							                value="${currencySymbol}" />${prodPrice[status.index]}</span>
							                
							                <c:set var="window" value="" />
						     <c:if test="${newWindow[status.index] eq 'yes'}">
                             <c:set var="window" value="_blank" />
                                </c:if>  
							                 <a href="${companyUrl[status.index]}" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${name}","model":"${wapData.name}","price":"${prodPrice[status.index]}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${name}" escapeXml="false"/></a></li>
				                          </c:when>

				                       <c:otherwise>
					                    <c:choose>
					                  	<c:when test="${status.count > 2}">
							              <li><img src="${logoImage[status.index]}"
								style="width: 150px; height: 50px" /> <span class="price"><c:out
										value="${currencySymbol}" />${prodPrice[status.index]}</span> 
									<c:set var="window" value="" />
						  <c:if test="${newWindow[status.index] eq 'yes'}">
                          <c:set var="window" value="_blank" />
                          </c:if>	
								<a href="${companyUrl[status.index]}" data-wap='{"linktype":"seeproduct","manufacturer":"${wapData.manufacturer}","processor":"${wapData.processor}","retailer":"${name}","model":"${wapData.name}","price":"${prodPrice[status.index]}","formFactor":"${wapData.formFactor}"}' target="${window}"><c:out value="${name}" escapeXml="false"/></a></li>
						               </c:when>
						               <c:otherwise>
						              </c:otherwise>
					                  </c:choose>
				</c:otherwise>
				</c:choose>

				</c:otherwise>
				</c:choose>

				</c:forEach>
				</c:if>
				</c:otherwise>

				</c:choose>

			</ul>
		</div>
		<c:if test="${fn:length(companyName) gt 2}">
			<a class="view-more-control" data-opencopy="See less purchasing options" data-closedcopy="See more purchasing options" href="javascript:void(0)">See more purchasing options</a>
		</c:if>
		</c:when>
		<c:otherwise>
			<div>Double Click to Edit Purchase Option Component</div>
		</c:otherwise>
		</c:choose>
	</div>
	</div>
	
