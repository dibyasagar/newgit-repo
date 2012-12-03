<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false"%>
<div id="main" role="main">
    <div id="decision-tools" class="quiz products">
        <cq:include path="decisionquizresults" resourceType="intelmobile/components/content/decisionquizresults" />
        <div class="sections">
            <div class="section">
                <ul class="accordion">
					<cq:include path="recommendations" resourceType="foundation/components/parsys" />
                </ul>
                <cq:include path="similarproducts" resourceType="intelmobile/components/content/similarproducts" />
            </div>			
        </div>
    </div>
</div>	