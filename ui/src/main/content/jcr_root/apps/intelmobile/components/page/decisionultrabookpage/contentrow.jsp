<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
  String rootPath = IntelUtil.getRootPath(currentPage);
%>	
		<link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/decision/meet_ultrabook.css" />
		<link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot_widget.css" />
        <div id="shopper-app" class="ultraBook">	       
            <div id="ubLogo"></div>
            <div id="blocker">            
              <div id="callout"><p></p></div>
            </div>
            <section id="primary">
                <ul>
                    <li class="start">
						<div class="touchAreaTop"></div>     
						<div class="touchAreaBottom"></div>    
						<div class="touchArea"></div>
						<div id="fb-root"></div>
						<script>(function(d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id)) return;
	                        js = d.createElement(s); js.id = id;
	                        js.src = "http://connect.facebook.net/en_US/all.js#xfbml=1&appId=324997220917852";
	                        fjs.parentNode.insertBefore(js, fjs);
	                        }(document, 'script', 'facebook-jssdk'));
						</script>
						<!-- NOTE: this data-href value needs to be the final href of the meet ultrabook page in prod -->
                      <div class="fb-like" data-href="http://m.shopspot.intel.com/meet-ultrabook/" data-send="false" data-layout="button_count" data-width="74" data-show-faces="true"></div>
                   </li>
                    <li> 
						<div class="touchAreaTop"></div>     
						<div class="touchAreaBottom"></div>              
						<div class="touchArea"></div>
						<div class="spot one hotSpot" data="node_one"></div>
						<div class="spot two hotSpot" data="node_two"></div>
						<div class="spot three hotSpot" data="node_three"></div>
						<div class="spot four hotSpot" data="node_four"></div>
						<div class="spot five hotSpot" data="node_five"></div>
						<div class="spot six hotSpot" data="node_six"></div>
						<div class="spot seven hotSpot" data="node_seven"></div>
						<div class="spot eight hotSpot" data="node_eight"></div>
						<div class="spot nine hotSpot" data="node_nine"></div>
                    </li>
                    <li>
						<div class="touchAreaTop"></div>     
						<div class="touchAreaBottom"></div>                       
						<div class="touchArea"></div>
						<!-- NOTE: not sure where this link will end up going  -->
						<a class="externalLink" href="http://m.intel.com/content/intel-us/en/what-is-new/ultrabook-family.touch.html" target="_blank"></a>
						<div id="shopSpot">
							<div class="shop-spot-mini">
							<!-- NOTE: this href value needs to be the final href of the shopspot landing in prod -->
						      <a href="<%=rootPath%>/shopspot.html" class="return-to-shop-spot" data="find_your_pc_fit_from_meet_ultrabook"><span></span></a>
									<div class="shop-spot-mini-shelf">
										<span class="shop-spot-mini-shelf-grad"></span>
										<div class="shop-spot-mini-products-container">
											<!-- NOTE: this href value needs to be the final of the core metaphors page in prod -->
											<a href="#" class="shop-spot-mini-product" data="core_metaphors_from_meet_ultrabook"><img src="/etc/designs/intelmobile/img/decision/core_metaphors_small.png" alt=""/></a>
											<!-- NOTE: this href value needs to be the final of the spec shuffleboard page in prod -->
											<a href="#" class="shop-spot-mini-product" data="find_your_pc_fit_from_meet_ultrabook"><img src="/etc/designs/intelmobile/img/decision/shuffleboard_small.png" alt=""/></a>
										</div>
									</div>
							</div>
						</div>
                    </li>
                </ul>
            </section>
            <div id="support" class="">
                   <div id="close"></div>
                   
                   <div id="imageContainer" class="clearfix"></div>
                    <p>
                        Features Intel® Smart Connect<br>
                        Technology to automatically update <br>
                        apps, social networks &amp; more -<br>
                        even when the system is asleep.
                    </p>
					<!-- NOTE: not sure where this href will end up pointing to -->
                    <a href="http://m.intel.com/content/intel-us/en/what-is-new/ultrabook-family.touch.html" onclick="window.open(this.href); return false" > Learn more about Ultrabook technology</a><br>
					<!-- NOTE: not sure where this href will end up pointing to -->
            </div>
        </div>
        