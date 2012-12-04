<%@page import="com.intel.mobile.util.IntelUtil"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>
<%
String internalLink = "";
String validLink = "";
if (properties.get("linkpath") != null) {
internalLink = properties.get("linkpath").toString();
validLink = IntelUtil.getLinkUrl(internalLink,resourceResolver);
}
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName() );
pageContext.setAttribute("validLink",validLink);

%>
<c:set var="contentstyle" value="${properties.contentstyle}" />
<c:if test="${contentstyle eq null or contentstyle eq ''}">
	<c:set var="contentstyle" value="pshowcase" />
</c:if>
<div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
<c:set var="imagepostion" value="${properties.imageposition}" />
<c:if test="${imagepostion eq null or imagepostion eq ''}">
	<c:set var="imagepostion" value="top" />
</c:if>


<c:if test="${contentstyle eq 'pshowcase'}">
	<c:if test="${imagepostion eq 'top' or imagepostion eq 'bottom'}">	
		<div class="item">
			<c:if test="${properties.imageposition == 'top' and properties.imageFileReference != null and properties.imageFileReference != ''}">	
				<img src="${properties.imageFileReference}" alt="${properties.alttext}">
			</c:if>
			<h3>
				<cq:text property="contenttitle" default="" escapeXml="false"/>
			</h3>
			<p class="gen_features">
			   <div class="rte_text">
				 <cq:text property="contenttext" default="" escapeXml="false"/>
		       </div>		
				<c:if test="${validLink ne '' && properties.linklabel ne ''}">
				 <c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
				    <a href="${validLink}" target="${window}">
						<cq:text property="linklabel" escapeXml="false"/>
					</a>
				</c:if>
			</p>
			<c:if test="${properties.imageposition == 'bottom' and properties.imageFileReference != null and properties.imageFileReference != ''}">	
				<img src="${properties.imageFileReference}" alt="${properties.alttext}">
			</c:if>		
		</div>
	</c:if>
	<c:if test="${imagepostion eq 'left' or imagepostion eq 'right'}">
		<div class="item table-list">
			<c:if test="${properties.imageposition == 'left' and properties.imageFileReference != null and properties.imageFileReference != ''}">	
				<img class="table-cell" src="${properties.imageFileReference}" alt="${properties.alttext}">
			</c:if>			
			<div class="table-cell">
				<h3>
					<cq:text property="contenttitle" default="" escapeXml="false"/>
				</h3>
				<p class="gen_features">
					<cq:text property="contenttext" default="" escapeXml="false"/>
					<c:if test="${validLink ne '' && properties.linklabel ne ''}">
					 <c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
				    <a href="${validLink}" target="${window}">
						<cq:text property="linklabel" escapeXml="false"/>
					</a>
					</c:if>
				</p>
			</div>
			<c:if test="${properties.imageposition == 'right' and properties.imageFileReference != null and properties.imageFileReference != ''}">	
				<img class="table-cell" src="${properties.imageFileReference}" alt="${properties.alttext}">
			</c:if>						
		</div>
	</c:if>
</c:if>

<c:if test="${contentstyle eq 'pdetail'}">
	<div class="promo content">
		<c:if test="${properties.imageFileReference != null and properties.imageFileReference != ''}">
			<img src="${properties.imageFileReference}" alt="${properties.alttext}" />
		</c:if>
		<div class="inner">
			<h6>
				<cq:text property="contenttitle" default="" escapeXml="false"/>
			</h6>
			
			<p class="gen_features">
			   <div class="rte_text">
				  <cq:text property="contenttext" default="" escapeXml="false"/>
				</div>  
			</p>
			<c:if test="${validLink ne '' && properties.linklabel ne ''}">
			  <c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
				    <a href="${validLink}" target="${window}">
						<cq:text property="linklabel" escapeXml="false"/>
					</a>
			</c:if>									
		</div>
	</div>
</c:if>

<c:if test="${contentstyle eq 'articlelanding'}">
	<div class="table-list">
	   <c:if test="${properties.imageFileReference != null and properties.imageFileReference != ''}">
		   <img class="table-cell" src="${properties.imageFileReference}" alt="${properties.alttext}">
		</c:if>
		<div class="table-cell">
			<h4><cq:text property="contenttitle" default="" escapeXml="false"/></h4>
			<p class="gen_features">
			      <div class="rte_text">
			         <cq:text property="contenttext" default="" escapeXml="false"/>
			      </div>
			  </p>
			<c:if test="${validLink ne '' && properties.linklabel ne ''}">
			   <c:set var="window" value="" />
				  <c:if test="${properties.newwindow eq 'yes'}">
                          <c:set var="window" value="_blank" />
                      </c:if>
				    <a href="${validLink}" target="${window}">
						<cq:text property="linklabel" escapeXml="false"/>
					</a>
			</c:if>	
		</div>
	</div>
</c:if>

<c:if test="${contentstyle eq 'articledetailterms'}">
	<div class="item gen_features">
		<h3><cq:text property="contenttitle" default="" escapeXml="false"/></h3>
		<div class="rte_text">
		<cq:text property="contenttext" default="" escapeXml="false"/>
		</div>
	</div>
</c:if>
<c:if test="${contentstyle eq 'features'}">
	<li class="gen_features"> 
	   <strong><cq:text property="contenttitle" default="" escapeXml="false"/></strong>
	   <div class="rte_text">
	   <cq:text property="contenttext" default="" escapeXml="false"/>
	   </div>
	 </li>
</c:if>
</div>