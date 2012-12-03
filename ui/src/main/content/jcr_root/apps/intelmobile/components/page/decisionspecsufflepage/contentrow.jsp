<%@include file="/libs/foundation/global.jsp"%>
<%@page import="com.intel.mobile.util.IntelUtil"%>
<%
  String rootPath = IntelUtil.getRootPath(currentPage);
%>
        <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/decision/spec_shuffle.css" />
        <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/decision/shop_spot_widget.css" />
         <link rel="stylesheet" href="/etc/designs/intelmobile/appclientlibs/css/decision/core_metaphors.css" />

<!--        <div id="main" role="main">     -->
        <div id="shopper-app" class="spec-shuffle">

            <div id="fb-root"></div>
            <script>(function(d, s, id) {
              var js, fjs = d.getElementsByTagName(s)[0];
              if (d.getElementById(id)) return;
              js = d.createElement(s); js.id = id;
              js.src = "http://connect.facebook.net/en_US/all.js#xfbml=1&appId=324997220917852";
              fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>
            
            <div class="app-header-wrap">
                <div class="app-header white-bg splatter">
                    <div class="blue-bg scratched">
                        <div id="active-survey-data">
                            <p id="progress-indicator">
                                <span id="question-title"></span>
                                <span class="question-indicator-wrap splatter"><span id="currentQuestion"></span></span>
                                <span id="outOf"></span>
                                <span class="question-indicator-wrap splatter"><span id="totalQuestions"></span></span>
                            </p>
                            <p id="question">How often do you use social networks, online messaging and email?</p>
                        </div>
                        <div id="finishedSurvey"></div>
                        <a href="#" class="back-btn"></a>
                    </div>
                </div>
            </div>

            <div class="game-wrap">
                <div class="deck">
                    <div class="zone">
                        <div class="touchzone freq" data="0"><h2></h2></div>
                        <div class="touchzone some" data="1"><h2></h2></div>
                        <div class="touchzone rare" data="2"><h2></h2></div>
                        <canvas id="gamelights" width="320" height="400"></canvas>
                    </div>
                    <span class="puck"><b><span>1</span></b></span>
                    <span class="puck"><b><span>2</span></b></span>
                    <span class="puck"><b><span>3</span></b></span>
                    <span class="puck"><b><span>4</span></b></span>
                    <span class="puck"><b><span>5</span></b></span>
                    <span class="puck"><b><span>6</span></b></span>
                    <div class="blockout"><span class="thumb-icon"></span></div>
                </div>
                <div class="splash">
                    <div class="white-bg splatter">
                        <div class="splash-inner blue-bg scratched">
                            <div class="splash-grad">
                                <div class="deck-footer">
                                    
                                </div>
                                <h1 id="app-title"></h1>
                                 <p>Answer six questions. Tap three zones.<br/>Find your ideal PC Specs.</p>
                                <a href="#" id="startGame" class="btn"></a>
                                <!-- NOTE: this data-href value needs to be the final href of the spec shuffleboard page in prod -->
                                <div class="fb-like" data-href="<%=rootPath%>/decision-template.html" data-send="false" data-layout="button_count" data-width="100" data-show-faces="false" data-font="verdana"></div>

                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <div class="spec-sheet">
                <div>
                    <div id="specBtns">
                        <div class="see-specs-container white-bg orange-splatter">
                            <a href="#" id="seeSpecksDetail" class="orange-bg">
                                <span class="show-specs-btn specs-btn-left"></span>
                                <span class="show-specs-btn specs-btn-right"></span>
                                <p></p>
                            </a>
                        </div>
                            
                        <a href="#" class="specs-header white-bg splatter">
                            <span class="show-survey-btn show-survey-btn-left"></span>
                            <span class="show-survey-btn show-survey-btn-right"></span>
                            <p></p>
                        </a>
                </div>

                    <div id="specsTable" class="white-bg splatter">
                        <div class="specs white-bg splatter">
                            
                            <div class="spec-panel-wrapper blue-bg scratched">

                                <div class="panel specs-panel">
                                    <div class="spec-sheet-inner clearfix">
                                        <div class="specs-message"><a href="#" id="whatSpecsMean"></a></div>

                                        <div class="row"><label>Processor</label><span id="processor"></span></div>
                                        <div class="row"><label>RAM</label><span id="ram"></span></div>
                                        <div class="row"><label>Hard Drive</label><span id="harddrive"></span></div>
                                        <div class="row"><label>Screen Size</label><span id="screensize"></span></div>
                                        <div class="row no-bg"><label>Portability</label><span id="portability"></span></div>

                                    </div>
                                    <a href="#" id="emailSpecsBtn"></a>
                                </div>

                                <div class="panel email-panel">

                                    <form id="emailForm" method="" action="">
                                        <div id="sendSpecsMessage"></div>
                                        <input type="email" id="emailField" value="Your Email Address Here" title="Your Email Address Here" data-error="You Must Enter a Valid Email" class="text-field" />
                                        <input type="submit" id="emailSubmit" value="" class="btn" readonly="readonly" />
                                        <a href="#" class="specsFromEmail"></a>
                                    </form>

                                    <div id="emailConfirmMessage">
                                        <div class="confirm-message"></div>
                                        <a href="#" class="specsFromEmail btn"></a>
                                    </div>

                                </div>

                                <div class="panel desc-panel">
                                    <div class="desc-panel-header"><a href="#" id="returnToDescPanel"></a></div>
                                    <div class="desc-panel-detail">
                                        <p><b>Processor</b>These are the engines behind your PC. The more powerful, the greater your possibilities.</p>
                                        <p><b>RAM</b>Are you a do-everything-at-once person? More RAM ensures fewer slowdowns to keep your life moving.</p>
                                        <p><b>HARD DRIVE</b>The bigger your hard drive, the more photos, movies and music you can store on your PC.</p>
                                        <p><b>Screen Size</b>Opt for a bigger screen if you love cinematic experiences or pushing your creative boundaries.</p>
                                        <p class="no-bg"><b>Portability</b>From desktops to laptops to Ultrabooks, choose a PC that fits your needs, where you need it.</p>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>

                    <div id="shopSpot">
                        
                        <div class="shop-spot-mini">
                            <!-- NOTE: this href value needs to be the final of the decision landing page in prod -->
                            <a href="<%=rootPath%>/shopspot.html" data="main_menu_from_find_your_pc_fit" class="return-to-shop-spot"><span></span></a>
                            <div class="shop-spot-mini-shelf">
                                <span class="shop-spot-mini-shelf-grad"></span>
                                <div class="shop-spot-mini-products-container">
                                    <!-- NOTE: this href value needs to be the final of the core metaphors page in prod -->
                                    <a href="<%=rootPath%>/decision-metaphores.html" class="shop-spot-mini-product" data="core_metaphors_from_find_your_pc_fit"><img src="/etc/designs/intelmobile/img/decision/core_metaphors_small.png" alt=""/></a>
                                    <!-- NOTE: this href value needs to be the final of the meet ultrabook page in prod -->
                                    <a href="<%=rootPath%>/decision-ultrabook.html" class="shop-spot-mini-product" data="meet_ultrabook_from_find_your_pc_fit"><img src="/etc/designs/intelmobile/img/decision/ultrabook_small.png" alt=""/></a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- </div> --><!-- end spec shuffle app -->