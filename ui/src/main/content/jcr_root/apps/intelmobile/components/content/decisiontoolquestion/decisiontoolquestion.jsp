<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<script type="text/javascript" src="/etc/designs/intelmobile/appclientlibs/js/example-controller.js"></script>   
<script type="text/javascript">
	function doRecommend() {
		var gamingValue = 0;		
		var photosVideoValue = 0;
		var communicationValue = 0;
		var multitaskingValue = 0;
		var total = 0;
		var gameOverride;
		
		var pathi3 = '${properties.pathi3}.html';
		var pathi5 = '${properties.pathi5}.html';
		var pathi7 = '${properties.pathi7}.html';
		
		gamingValue = intel.mobile.controller["decision-slider"].cache.sliderTickCount[0] + 1;
		photosVideoValue = intel.mobile.controller["decision-slider"].cache.sliderTickCount[1] + 1;
		communicationValue = intel.mobile.controller["decision-slider"].cache.sliderTickCount[2] + 1;
		multitaskingValue = intel.mobile.controller["decision-slider"].cache.sliderTickCount[3] + 1;
		
		total = gamingValue + photosVideoValue + communicationValue + multitaskingValue;
		gameOverride = gamingValue > 1;
		
		if(total>0) {
			if(gameOverride) {
				window.location.href = pathi7;
			} else if(total<=5) {		
				window.location.href = pathi3;
			} else if(total<=9) {
				window.location.href = pathi5;
			} else {
				window.location.href = pathi7;
			}
		} 
	}
</script>
<%
pageContext.setAttribute("componentId",IntelUtil.getComponentId(resource));
pageContext.setAttribute("componentName",component.getName());
%>

 <div class="component" data-component="<c:out value="${pageScope.componentName}"/>" data-component-id="<c:out value="${pageScope.componentId}"/>">
           <h1><c:out value="${properties.heading}" escapeXml="false"/></h1>	
                    <div class="hero">
                        <img src="${properties.heroImageFileReference}" alt="">
                        <div class="content">
                            <h3><c:out value="${properties.subHeading}" escapeXml="false"/></h3>
                            <p><c:out value="${properties.bodyCopy}" escapeXml="false"/></p>
                        </div>	
                    </div>
                <div class="sections">
                    <div class="section questions">
                        <div class="question">
                            <div class="hd">
                                <span class="label block-grad"><cq:text property="imageDisplayCopy1" default="Gaming" escapeXml="false"/></span>
                                <img src="${properties.question1ImageFileReference}" alt="" />
                            </div>
                            <div class="bd">
                                <div class="slider">
                                    <div class="dragger"></div>
                                    <div class="track"></div>
                                </div>
                                <ul>
                                	<input id="answerCopy1" type="hidden" value="" />
                                    <li>
                                        <a data-tick="0" href="javascript:void(0);">
                                        	<cq:text property="answer1Copy1" escapeXml="false"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a data-tick="1" href="javascript:void(0);">
                                        	<cq:text property="answer2Copy1" escapeXml="false"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a data-tick="2" href="javascript:void(0);">
                                        	<cq:text property="answer3Copy1" escapeXml="false"/>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="ft"></div>
                        </div>
                             <div class="question">
                                 <div class="hd">
                                    <span class="label block-grad"><cq:text property="imageDisplayCopy2" default="Photos & Videos" escapeXml="false"/></span>
                                    <img src="${properties.question2ImageFileReference}" alt="" />
                                </div>
                                <div class="bd">
                                    <div class="slider">
                                        <div class="dragger"></div>
                                        <div class="track"></div>
                                    </div>
                                    <ul>
                                    	<input id="answerCopy2" type="hidden" value="" />
                                        <li>
                                        	<a data-tick="0" href="javascript:void(0);">
                                        		<cq:text property="answer1Copy2" escapeXml="false"/>                                        	
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="1" href="javascript:void(0);">
                                        		<cq:text property="answer2Copy2" escapeXml="false"/>
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="2" href="javascript:void(0);">
                                        		<cq:text property="answer3Copy2" escapeXml="false"/>
                                        	</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="ft"></div>
                            </div>

                             <div class="question">
                                 <div class="hd">
                                    <span class="label block-grad"><cq:text property="imageDisplayCopy3" default="Communication" escapeXml="false"/></span>
                                    <img src="${properties.question3ImageFileReference}" alt="" />
                                </div>
                                <div class="bd">
                                    <div class="slider">
                                        <div class="dragger"></div>
                                        <div class="track"></div>
                                    </div>
                                    <ul>
                                    	<input id="answerCopy3" type="hidden" value="" />
                                        <li>
                                        	<a data-tick="0" href="javascript:void(0);">
                                        		<cq:text property="answer1Copy3" escapeXml="false"/>
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="1" href="javascript:void(0);">
                                        		<cq:text property="answer2Copy3" escapeXml="false"/>
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="2" href="javascript:void(0);">
                                        		<cq:text property="answer3Copy3" escapeXml="false"/>
                                        	</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="ft"></div>
                             </div>
                            <div class="question">
                                 <div class="hd">
                                    <span class="label block-grad"><cq:text property="imageDisplayCopy4" default="Multitasking" escapeXml="false"/></span>
                                    <img src="${properties.question4ImageFileReference}" alt="" />
                                </div>
                                <div class="bd">
                                    <div class="slider">
                                        <div class="dragger"></div>
                                        <div class="track"></div>
                                    </div>
                                    <ul>
                                    	<input id="answerCopy4" type="hidden" value="" />
                                        <li>
                                        	<a data-tick="0" href="javascript:void(0);">
                                        		<cq:text property="answer1Copy4" escapeXml="false"/>
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="1" href="javascript:void(0);">
                                        		<cq:text property="answer2Copy4" escapeXml="false"/>
                                        	</a>
                                        </li>
                                        <li>
                                        	<a data-tick="2" href="javascript:void(0);">
                                        		<cq:text property="answer3Copy4" escapeXml="false"/>
                                        	</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="ft">
                                    <div class="cta grad">
                                        <a href="javascript:doRecommend()"><cq:text property="submitButtonCopy" default="Get Recommendation" escapeXml="false"/></a>
                                    </div>
                                </div>
                             </div>


                        </div>
                    </div>
       </div>
    
