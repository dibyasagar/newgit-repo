<%--

  Campaign Header component.

  NA

--%><%@page import="com.day.cq.wcm.api.WCMMode"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %>

            <section class="slide">
                <div class="slide-0">
                
                <div class="item">
                 
                <article class="inside clear">
                    <div class="inside_image">
                        <div class="camp_headerimg">
                            <img src="<c:out value="${properties.imagePath}"/>" class="slide slide-0"/>
                        </div>
                    
                    <div class="head" style="">

                        <h2><c:out value="${properties.sectiontitle}" escapeXml="false"/></h2>
                        <h2><c:out value="${properties.description}" escapeXml="false"/></h2>
                        
                        <div class="spacer"></div>
                        <div class="ultra"></div>
                         
                    </div>
                  	
                    </div>
					
                </article>
                
                 
                  		 
                </div>
                </div>
				<c:if test="${properties.displaysocial ne '' && not empty properties.displaysocial}">
					    <c:if test="${properties.displaysocial eq 'yes'}">
					        <cq:include script="/apps/intelmobile/components/content/socialmedia/socialmedia.jsp"/>
					    </c:if>             
					</c:if> 	
            </section>