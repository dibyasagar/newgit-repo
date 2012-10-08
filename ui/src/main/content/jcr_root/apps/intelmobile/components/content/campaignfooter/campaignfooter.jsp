<%--

  Campaign Header component.

  NA

--%><%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>


		<section class="slide">
				<div class="slide-z">
				<div class="item">
				<article class="inside clear">

					<div class="ultra"></div>

					<div class="head">
						<h2><%=properties.get("sectiontitle","")%></h2>
					</div>

					<div class="laptop">
						<img src="<%=properties.get("imagePath","")%>" class="laptop"/>
					</div>

					<div class="shop">
						<a class="ui-link" href="#" title="Shop Ultrabook™" target="_blank">
						<span><%=properties.get("buttontext","")%>™</span></a>
					</div>

					<div class="spacer"></div>
					<div class="spacer"></div>

					<div class="legal">
						<%=properties.get("legal","")%> 
					</div>

				</article>
				</div>
				</div>
			</section>