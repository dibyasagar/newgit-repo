intel.initShuffleboard = function () {

    function loaded() {
        if (typeof window.shopper_app === 'undefined') { window.setTimeout(loaded, 100); return; }
        //shopper_app.setHeight();
        specShuffle();
    }

    loaded();

    /* UI Objects */
    var Puck = function (element) {
        this.self = element;
        this.innerSelf = $('b', element);
        this.id;
        this.isMoving = false;
        this.isActive = false;
        this.isPlaced = false;
        this.width = 60;
        this.height = 67;
        this.firstState = true;
        this.state = {
            x: 0,
            y: 0,
            scale: 1,
            rotation: 0
        };
        this.stateHistory = [];
        this.currentStateIndex = 0;
        this.inZone = 0;

        this.self.css(this.puckProperties('transition', 'all 1.5s cubic-bezier(0.2,1,0,1)'));
    }

    Puck.prototype = {
        changeState: function (x, y, s, r) {
            if (!this.firstState) {
                this.pushState();
                this.currentStateIndex++;
            } else {
                this.firstState = false;
            }

            this.state = {
                x: x || this.state.x,
                y: y || this.state.y,
                scale: s || this.state.scale,
                rotation: r || this.state.rotation
            }
        },
        randomRotate: function () {
            var r, d = (Math.random() > .5) ? -1 : 1;

            if (Math.random() < .7) {
                r = parseInt(-40 + Math.random() * 80);
            } else {
                r = 360 + parseInt(-30 + Math.random() * 60);
                r += (Math.random() < .2) ? 360 : 0;
            }

            return r * d;
        },
        manageCollisions: function (allPucks) {
            var pucks = allPucks,
					len = pucks.length,
					neighbors = [],
					overlapping = false;

            function dist(p1, p2) {
                var xs = 0, ys = 0;
                xs = Math.pow(p2.x - p1.x, 2);
                ys = Math.pow(p2.y - p1.y, 2);
                return parseInt(Math.sqrt(xs + ys));
            }

        },
        setTransition: function () {
            this.self.css(this.puckProperties('transition', 'all 2.5s cubic-bezier(0.1,1,0,1)'));
            this.innerSelf.css(this.puckProperties('transition', 'all 1.2s cubic-bezier(0.1,.8,0,1)'));
        },
        pushState: function () {
            this.stateHistory[this.stateHistory.length] = this.state;
        },
        backup: function () {
            var i = this.currentStateIndex;
            this.currentStateIndex--;
            if (i === 0) {
                return false;
            } else {
                this.stateHistory.pop();
                this.state = this.stateHistory[this.stateHistory.length - 1];
                this.anim();
            }
        },
        puckProperties: function (type, properties) {
            var styles = {},
					t = type || 'transform';

            styles[shopper_app.cssPrefix + t] = properties || 'translate3d(' + parseInt(this.state.x) + 'px,' + parseInt(this.state.y) + 'px' + ',0px) ' + 'scale(' + this.state.scale + ')';

            return styles;
        },
        anim: function (x, y, s, r) {
            if (arguments.length > 0) {
                this.state = {
                    x: x || this.state.x,
                    y: y || this.state.y,
                    scale: s || this.state.scale,
                    rotation: r || this.state.rotation
                }
            }
            if (this.isActive) { this.self.addClass('puck-active'); }
            else if (this.isPlaced) { this.self.removeClass('puck-active').addClass('puck-placed'); }
            this.innerSelf.css(this.puckProperties('transform', 'rotate(' + this.state.rotation + 'deg)'));
            this.self.css(this.puckProperties());
        }
    }

    /* survey */
    function Survey() {
        this.totalQuestions = 6;
        this.questionIndex = 0;
        this.questions = [{ text: "How often do you use social networks, online messaging and email?", answered: false },
								{ text: "How often do you work at home, manage personal finances and/or homework?", answered: false },
								{ text: "How often do you stay<br/>connected while on the go?", answered: false },
								{ text: "How often do you play<br/>the latest games?", answered: false },
								{ text: "How often do you create and<br/>edit videos and photos?", answered: false },
								{ text: "How often do you watch movies,<br/>TV and listen to music?", answered: false}];
        this.ask = $('#question');
        this.progressTracker = $('#currentQuestion');
        this.isComplete = false;
        this.takingSurvey = false;
        this.Processor = [];
        this.ScreenSize = [];
        this.HDD = [];
        this.RAM = [];
        this.Portability = [];
        this.answers = [
				[	//answer set 1
					{'Processor': 2, 'ScreenSize': 2, 'HDD': 'na', 'RAM': 'na', 'Portability': 'na' },
					{ 'Processor': 1, 'ScreenSize': 1, 'HDD': 'na', 'RAM': 'na', 'Portability': 'na' },
					{ 'Processor': 'na', 'ScreenSize': 'na', 'HDD': 'na', 'RAM': 'na', 'Portability': 'na' }
				],
				[	//answer set 2
					{'Processor': 2, 'ScreenSize': 2.5, 'HDD': 'na', 'RAM': 2, 'Portability': 1.5 },
					{ 'Processor': 1, 'ScreenSize': 2, 'HDD': 'na', 'RAM': 1.5, 'Portability': 1.5 },
					{ 'Processor': 'na', 'ScreenSize': 'na', 'HDD': 'na', 'RAM': 'na', 'Portability': 'na' }
				],
				[	//answer set 3
					{'Processor': 2.1/*1.5*/, 'ScreenSize': 'na', 'HDD': 'na', 'RAM': 2, 'Portability': 3 },
					{ 'Processor': 1.5, 'ScreenSize': 'na', 'HDD': 'na', 'RAM': 1.5, 'Portability': 2 },
					{ 'Processor': 'na', 'ScreenSize': 'na', 'HDD': 'na', 'RAM': 'na', 'Portability': 1 }
				],
				[	//answer set 4
					{'Processor': 3.5, 'ScreenSize': 3, 'HDD': 2, 'RAM': 3, 'Portability': 1.5 },
					{ 'Processor': 2, 'ScreenSize': 2, 'HDD': 1.5, 'RAM': 2.5, 'Portability': 1.5 },
					{ 'Processor': 'na', 'ScreenSize': 'na', 'HDD': 1, 'RAM': 'na', 'Portability': 'na' }
				],
				[	//answer set 5
					{'Processor': 3, 'ScreenSize': 3, 'HDD': 3, 'RAM': 3, 'Portability': 1 },
					{ 'Processor': 2, 'ScreenSize': 2, 'HDD': 2.5, 'RAM': 2.5, 'Portability': 1.5 },
					{ 'Processor': 1, 'ScreenSize': 'na', 'HDD': 1, 'RAM': 1, 'Portability': 'na' }
				],
				[	//answer set 6
					{'Processor': 3, 'ScreenSize': 3, 'HDD': 2.5, 'RAM': 2.5, 'Portability': 1.5 },
					{ 'Processor': 2, 'ScreenSize': 2, 'HDD': 2.5, 'RAM': 2.5, 'Portability': 1.5 },
					{ 'Processor': 1, 'ScreenSize': 'na', 'HDD': 1, 'RAM': 1, 'Portability': 'na' }
				]
			];
    }

    Survey.prototype = {
        storeValue: function (key, val) {
            this[key].push(val);
        },
        storeValues: function (vals) {
            for (var p in vals) {
                if (this.hasOwnProperty(p)) {
                    this.storeValue(p, vals[p]);
                }
            }
        },
        removeValues: function () {
            this.Processor.pop();
            this.ScreenSize.pop();
            this.HDD.pop();
            this.RAM.pop();
            this.Portability.pop();
        },
        adjustProgressTracker: function () {
            this.progressTracker.css('background-position', '-1px ' + (((this.totalQuestions - 1) - this.questionIndex) * -23) + 'px');
        },
        showResults: function (specsObject) {
            var results;
            if (typeof specsObject !== 'undefined') {
                results = this.getResults(specsObject);
            } else {
                results = this.getResults();
            }

            document.getElementById('processor').innerHTML = results.processor;
            document.getElementById('ram').innerHTML = results.ram;
            document.getElementById('harddrive').innerHTML = results.hardDrive;
            document.getElementById('screensize').innerHTML = results.screenSize;
            document.getElementById('portability').innerHTML = results.portability;
            return results;
        },
        answerQuestion: function (val) {

            if (this.isComplete) { return; }
            var self = this;

            //tracking
            var eventTranslation = ['always', 'sometimes', 'rarely'];
            trackPage('/find_your_pc_fit/Q' + (this.questionIndex + 1));
            trackEvent('find_your_pc_fit', 'usage_question_answers', 'Q' + (this.questionIndex + 1) + '_' + eventTranslation[val]);

            this.questions[this.questionIndex].answered = true;
            this.storeValues(this.answers[this.questionIndex][val]);
            this.questionIndex++;

            if (this.questionIndex == this.totalQuestions) { this.isComplete = true; return; }
            var nextQuestion = this.questions[this.questionIndex].text;
            window.setTimeout(function () { self.ask.css('opacity', 0); }, 400);
            window.setTimeout(function () { self.adjustProgressTracker(); self.ask.html(nextQuestion).css('opacity', 1); }, 800);

        },
        goBack: function () {

            if (this.questionIndex <= 0) { return; }
            if (this.questionIndex < this.totalQuestions) {
                this.questions[this.questionIndex].answered = false;
            }
            this.removeValues();
            this.questionIndex--;
            this.adjustProgressTracker();
            this.isComplete = false;
            var nextQuestion = this.questions[this.questionIndex].text;
            this.ask.html(nextQuestion);
            //tracking
            trackEvent('find_your_pc_fit', 'back', 'back_to_Q' + (this.questionIndex + 1));
        },
        getResults: function (specsObject) {
            var displayProc, displaysss, displayhd, displayr, displayport,
					proc, ss, hd, r, port;

            if (typeof specsObject !== 'undefined') {
                proc = specsObject.pro;
                ss = specsObject.ss;
                hd = specsObject.hd;
                r = specsObject.ram;
                port = specsObject.por;
            } else {
                proc = getAverage(this.Processor);
                ss = getAverage(this.ScreenSize);
                hd = getAverage(this.HDD);
                r = getAverage(this.RAM);
                port = getAverage(this.Portability);
            }

            // url.pro && url.ram && url.hd && url.ss && url.por;
            var link = window.location.href.split('#')[0] + '#pro=' + proc + '&ram=' + r + '&hd=' + hd + '&ss=' + ss + '&por=' + port;

            function getAverage(arr) {
                var total = 0;
                var answers = 0;
                for (var i = 0; i < arr.length; i++) {
                    if (typeof arr[i] === "number") {
                        total += arr[i];
                        answers++;
                    }
                }
                return Math.round(total / answers);
            }

            //get best processor
            if (proc == 1) {
                displayProc = 'Intel Core i3';
            } else if (proc == 2) {
                displayProc = 'Intel Core i5';
            } else if (proc == 3) {
                displayProc = 'Intel Core i7';
            } else {
                displayProc = 'Intel Core i7';
            }

            //get best screen size
            if (ss == 1) {
                displayss = 'Up to 14"';
            } else if (ss == 2) {
                displayss = '15" - 16"';
            } else if (ss == 3) {
                displayss = '17" and Up';
            } else {
                displayss = "Any Size";
            }

            //get best hard drive
            if (hd == 1) {
                displayhd = 'Up to 500GB';
            } else if (hd == 2) {
                displayhd = '501GB - 999GB';
            } else if (hd == 3) {
                displayhd = '1TB and Up';
            } else {
                displayhd = "1TB and Up";
            }

            //get best ram
            if (r == 1) {
                displayr = '1GB - 4GB';
            } else if (r == 2) {
                displayr = '6GB - 8GB';
            } else if (r == 3) {
                displayr = '10GB - 16GB';
            } else {
                displayr = "10GB - 16GB";
            }

            //get best portability type
            if (port == 1) {
                displayport = 'Desktop';
            } else if (port == 2) {
                displayport = 'Laptop';
            } else if (port == 3) {
                displayport = 'Ultrabook';
            } else {
                displayport = "Ultrabook";
            }

            if ( displayport == 'Ultrabook' ) { displayss = 'Up to 14"'; }

            return {
                processor: displayProc,
                screenSize: displayss,
                hardDrive: displayhd,
                ram: displayr,
                portability: displayport,
                url: link
            }
        }
    }

    var survey = new Survey();

    function specShuffle() {

        var _globals = {
            wrapper: $('.spec-shuffle'),
            appHeight: shopper_app.getHeight(), //$('.spec-shuffle').height()
            appWidth: $('.spec-shuffle').width(),
            backBtn: $('.back-btn'),
            activePuckIndex: 0,
            pucks: new Array(6),
            survey: { questionsAnswered: 0, totalQuestions: 6 },
            game: $('.game-wrap'),
            deck: $('.deck'),
            splash: $('.splash'),
            touchZone: $('.zone'),
            deckoffset: $('.zone').offset().top,
            header: $('.app-header-wrap'),
            headerHeight: $('.app-header-wrap').height(),
            puckPlacementEven: [],
            puckPlacementOdd: [],
            gameLights: $('#gamelights'),
            specSheet: $('.spec-sheet'),
            answerDelay: 1000,
            answerDelayTimer: 0,
            panelTransitionTimer: 0,
            gameWrapTimer: 0,
            gameStarted: false,
            fromEmailLink: false,
            surveyResults: {}
        },
			_config = {
			    puckSelector: $('.puck')
			}

        var cssTrans = function (r, v) {
            var c = {};
            c[shopper_app.cssPrefix + r] = v;
            return c;
        }

        var drawGameLights = function () {
            var node = document.getElementById('gamelights');
            var h = _globals.touchZone.height();
            var w = _globals.touchZone.width();
            var ctx = node.getContext('2d');
            $(node).attr('width', w);
            $(node).attr('height', h);
            var halfWidth = parseInt(w / 2);
            var heightInterval = parseInt(h / 2);
            for (var i = 0; i < 3; i++) {
                var grad = ctx.createRadialGradient(halfWidth, (i * heightInterval), 0, halfWidth, (i * heightInterval), (w * .2));
                grad.addColorStop(0, 'rgba(255,255,255,.7)');
                grad.addColorStop(1, 'rgba(255,255,255,0)');
                ctx.fillStyle = grad;
                ctx.fillRect(0, 0, w, h);
            }
        }

        var showBackBtn = function () {
            _globals.backBtn.css('display', 'block');
            window.setTimeout(function () { _globals.backBtn.addClass('back-btn-visible'); }, 50);
        }

        var hideBackBtn = function () {
            _globals.backBtn.removeClass('back-btn-visible');
            window.setTimeout(function () { _globals.backBtn.css('display', 'none'); }, 400);
        }

        var startApp = function () {
            hideHeader();
            //shopper_app.setHeight();
            var h = parseInt(_globals.appHeight);
            //alert( 'app height: ' + h + ', shopper_app.height: ' + shopper_app.getHeight() );
            //delay( function(){ alert( 'app height: ' + h + ', shopper_app.height: ' + shopper_app.getHeight() ); }, 3000);
            _globals.touchZone.css('opacity', 0);
            _globals.deck.css({ 'height': (h - 65) + 'px' });
            _globals.splash.css({ 'height': (h + 65) + 'px', 'opacity': 1, 'top': (h - 65) + 'px' });
            resetPucks();
            _globals.game.css(applyVendorPrefixes({ 'height': (h * 2) + 'px', 'transform': 'translate3d(0,-' + (h - 100) + 'px,0)' }));
            _globals.specSheet.css({ 'height': h + 66 + 'px' });
            _globals.specSheet.css(cssTrans('transform', 'translate3d(0,' + (h + 66) + 'px,0)'));

            window.setTimeout(function () { _globals.game.css(cssTrans('transition', 'all 1.5s cubic-bezier(0.2,1,0,1)')); }, 200);
            window.setTimeout(showPucks, 800);

            $('.spec-sheet > div').height(_globals.appHeight + 66 + 'px');
            $('.spec-panel-wrapper').height($('#specsTable').height() - 8 + 'px');

            $('.email-panel').css(cssTrans('transform', 'translate3d(' + (window.innerWidth * -1) + 'px,0,0)'));
            $('.desc-panel').css(cssTrans('transform', 'translate3d(' + window.innerWidth + 'px,0,0)'));

            window.setTimeout(function () { $('.panel').css(cssTrans('transition', 'all 1s cubic-bezier(.2,1,0,1)')); }, 100);

            $('.spec-shuffle .touchzone').each(function () {
                var headingHeight = 35;
                var h = $(this).height();
                var topMargin = (h - headingHeight) / 2;
                $('h2', $(this)).css('margin-top', topMargin + 'px');
            });

        }

        var startGame = function () {
            _globals.game.css(cssTrans('transform', 'translate3d(0,0,0)'));
            $('.splash-inner > *', _globals.splash).css('opacity', 0);
            _globals.touchZone.css('opacity', 1);
            window.setTimeout(showHeader, 500);
            _globals.deck.css('opacity', 1);

            window.setTimeout(showBlockout, 600);
            drawGameLights();
            _globals.gameStarted = true;

            delay(function () {
                if (survey.takingSurvey == false) {
                    survey.takingSurvey = true;
                    hideBlockout();
                    _globals.gameLights.css('opacity', 1);
                    adjustPucks();
                }
            }, 5000);

        }

        var showHeader = function (v) {
            var rule = {};
            rule[shopper_app.cssPrefix + 'transform'] = 'translate3d(0,0,0)';
            _globals.header.css(rule);
        }

        var hideHeader = function (v) {
            var rule = {};
            rule[shopper_app.cssPrefix + 'transform'] = 'translate3d(0,-86px,0)';
            _globals.header.css(rule);
        }

        var showPucks = function () {
            _globals.pucks.forEach(function (el, index) {
                el.self.css('opacity', 1);
            });
        }

        var resetPucks = function () {
            var w = window.innerWidth,
					h = _globals.touchZone.height(),
					halfWidth = parseInt(window.innerWidth / 2),
					realIndex = 0,
					rightOfActive = false,
					activePadding = 10,
					spacing = 42,
					totalWidth = 0;

            _globals.pucks.forEach(function (el, index) {

                el.self.css(el.puckProperties('transition', 'none'));
                var posX = 0, scale = .5;

                posX = _globals.puckPlacementEven[realIndex] + 12;

                if (el.isActive) {
                    el.self.removeClass('puck-active');
                }

                el.changeState(posX, (h), scale);
                el.anim();
                window.setTimeout(function () { el.setTransition(); }, 50);
                realIndex++;
            });

            $('.puck-active').removeClass('puck-active');

        }

        var adjustPucks = function () {
            var w = window.innerWidth,
					h = _globals.touchZone.height(),
					halfWidth = parseInt(window.innerWidth / 2),
					realIndex = 0,
					rightOfActive = false,
					activePadding = 0,
					spacing = 34;

            _globals.pucks.forEach(function (el, index) {

                if (el.isPlaced) { return; }

                if (realIndex < 3 && realIndex > 0) { activePadding = 20; }

                var posX = 0, scale = .5;

                if (Math.abs(index - realIndex) % 2 == 0) {
                    posX = _globals.puckPlacementEven[realIndex];
                } else {
                    posX = _globals.puckPlacementOdd[realIndex];
                }

                //Give Active puck a little space
                if (posX < parseInt(window.innerWidth / 2) - 8) {
                    posX -= activePadding;
                } else {
                    posX += activePadding;
                }

                if (el.isActive) {
                    scale = 1;
                }

                el.changeState(posX, (h), scale, 0);
                el.anim();
                realIndex++;
            });

        }

        var advanceSurvey = function () {
            var placed = getActivePuck();
            placePuck(placed);

            _globals.activePuckIndex++;

            if (_globals.activePuckIndex > 5) {
                window.setTimeout(finishSurvey, 500);
            }

            if (_globals.activePuckIndex > 0) {
                showBackBtn();
            }

            var p = getActivePuck();
            if (typeof p === 'undefined') { return; }
            p.changeState(p.state.x, p.state.y, 1);
            p.isActive = true;
            p.isPlaced = false;
            p.self.addClass('puck-active').removeClass('puck-placed');
            p.anim();

        }

        var stepBack = function () {
            var p = _globals.pucks;
            i = p.length;

            _globals.activePuckIndex--;
            if (_globals.activePuckIndex < 0) { _globals.activePuckIndex++; return; }

            isAPuckActive = setActivePuck();

            if (_globals.activePuckIndex == 0) {
                hideBackBtn();
            }

            while (i--) {
                if (p[i].isActive) {
                    p[i].backup();
                    break;
                }
            }

            survey.goBack();
            adjustPucks();
        }


        //show blockout sans message, show specs button
        var finishSurvey = function () {
            $('#active-survey-data').css('display', 'none');
            $('#finishedSurvey').css('display', 'block');
            showBlockout(false);
            showSpecCTA();
            _globals.surveyResults = survey.showResults();
        }

        var showSpecCard = function () {
            var specs = _globals.specSheet;
            specs.css(cssTrans('transition', 'all 1.5s cubic-bezier(.3,1,0,1)'));
            revealPanel($('.specs-panel'));
            hidePanel($('.email-panel'), 'left');
            hidePanel($('.desc-panel'), 'right');
            window.setTimeout(function () { specs.css(cssTrans('transform', 'translate3d(0,0px,0)')); }, 10);
            _globals.gameWrapTimer = window.setTimeout(function () { _globals.game.css('display', 'none'); }, 1550);
        }

        var showSpecCTA = function () {
            var specs = _globals.specSheet;
            window.clearTimeout(_globals.gameWrapTimer);
            _globals.game.css('display', 'block');
            specs.css({ 'z-index': '998', 'display': 'block' });
            specs.css(cssTrans('transition', 'all 1s cubic-bezier(.3,1,0,1)'));
            window.setTimeout(function () { specs.css('opacity', 1).css(cssTrans('transform', 'translate3d(0,' + _globals.appHeight + 'px,0)')); }, 100);
        }

        var placePuck = function (p) {
            var puck;
            if (typeof p !== 'undefined') { puck = p; }
            puck.isPlaced = true;
            puck.isActive = false;
            puck.changeState(puck.state.x, puck.state.y, .5);
            puck.self.removeClass('puck-active').addClass('puck-placed');
            window.setTimeout(function () { puck.manageCollisions(_globals.pucks); puck.anim(); }, 1000);
        }

        var setActivePuck = function () {
            var i = _globals.pucks.length,
					activePuck = false;

            while (i--) {
                var p = _globals.pucks[i];
                if (p.id == _globals.activePuckIndex) {
                    p.isActive = true;
                    p.isPlaced = false;
                    p.self.addClass('puck-active').removeClass('puck-placed');
                    activePuck = true;
                } else {
                    p.isActive = false;
                    p.self.removeClass('puck-active');
                }
            }

            return activePuck;
        }

        var getActivePuck = function () {

            var i = _globals.pucks.length,
					activePuck = undefined;

            while (i--) {
                if (_globals.pucks[i].id == _globals.activePuckIndex) {
                    activePuck = _globals.pucks[i];
                    break;
                }
            }
            return activePuck;
        }

        var showBlockout = function (showMessage) {
            var c = '',
					b = $('.blockout'),
					h = b.height(),
					spanH = 120;

            if (typeof showMessage === 'boolean') { c = 'no-message'; }
            b.removeClass('blockout-hidden').addClass(c);
            $('span', b).css('margin-top', parseInt((h - spanH) / 2) + 'px');
            window.setTimeout(function () { b.css('opacity', 1); }, 10);
        }

        var hideBlockout = function () {
            $('.blockout').css('opacity', 0);
            window.setTimeout(function () { $('.blockout').removeClass('no-message').addClass('blockout-hidden'); }, 600);
        }

        var validateEmail = function () {
            var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
            return pattern.test($('#emailField').val());
        }

        var revealPanel = function (panel) {
            window.clearTimeout(_globals.panelTransitionTimer);
            panel.css('display', 'block');
            window.setTimeout(function () {
                panel.css(cssTrans('transform', 'translate3d(0px,0,0)'));
            }, 100);
        }

        var hidePanel = function (panel, direction) {
            var dir = (direction == 'left') ? -1 : 1;
            panel.css(cssTrans('transform', 'translate3d(' + (window.innerWidth * dir) + 'px,0,0)'));
            _globals.panelTransitionTimer = window.setTimeout(function () { panel.css('display', 'none'); }, 1000);
        };

        var confirmURLParams = function (url) {
            return url.pro && url.ram && url.hd && url.ss && url.por;
        };

        //init
        (function () {

            shopper_app.setHeight();

            var urlObj = parseURL();

            var i = _config.puckSelector.length,
					translation = [5, 3, 1, 0, 2, 4];
            while (i--) {
                _globals.pucks[i] = new Puck($(_config.puckSelector[i]));
                _globals.pucks[i].id = i;
                if (i == 0) {
                    _globals.pucks[i].isActive = true;
                    _globals.activePuckIndex = 0;
                }
            }

            var halfWidth = parseInt(window.innerWidth / 2),
					origin = halfWidth - 33,
					activePadding = 0,
					puckSpacing = 28;

            _globals.puckPlacementEven[_globals.puckPlacementEven.length] = origin; //first puck goes in the center
            _globals.puckPlacementOdd[_globals.puckPlacementOdd.length] = origin;

            for (var el = 1, er = 1, ol = 1, or = 1, counter = 1; counter < _globals.pucks.length; counter++) {
                if (counter % 2 != 0) {
                    _globals.puckPlacementEven[counter] = origin - (el * puckSpacing);
                    _globals.puckPlacementOdd[counter] = (ol * puckSpacing) + origin;
                    ol++;
                    el++;
                } else {
                    _globals.puckPlacementEven[counter] = (er * puckSpacing) + origin;
                    _globals.puckPlacementOdd[counter] = origin - (or * puckSpacing);
                    or++;
                    er++;
                }
            }

            /*if (getDeviceType() == 'iphone' || getDeviceType() == 'android') {
                $('a, input[type="submit"]').bind('click', function (e) {
                    e.preventDefault();
                    return false;
                });
            }*/

            if (urlObj !== undefined && confirmURLParams(urlObj)) {
                _globals.fromEmailLink = true;
                //url
                //finishSurvey();
                //console.log( urlObj );
                _globals.wrapper.css('opacity', 0);
                survey.showResults(urlObj);
                startApp();
                startGame();
                showSpecCTA();
                _globals.wrapper.css(applyVendorPrefixes({ 'transition': 'opacity 2s linear' }));
                delay(function () { _globals.specSheet.css(applyVendorPrefixes({ 'transform': 'translate3d(0,0,0)' })); }, 500);
                delay(function () { _globals.wrapper.css('opacity', 1); }, 1000);
                shopper_app.scrollToApp();
                shopper_app.setAutoScroll(true);
                return;
            }

            startApp();

        })();


        /* event handlers */
        _globals.touchZone.bind(shopper_app.touchClick, function (event) {
            event.preventDefault();

            if (!survey.takingSurvey) { return; }

            var srcEl = event.srcElement, answerVal, touchClick, p;

            if (srcEl.tagName.toLowerCase() == 'h2') { answerVal = parseInt(srcEl.parentNode.getAttribute('data')); }
            else if (srcEl.tagName.toLowerCase() == 'div') { answerVal = parseInt(srcEl.getAttribute('data')); }

            if (answerVal == undefined || isNaN(answerVal)) { return; }

            p = getActivePuck();

            if (typeof p == 'undefined') { return; }

            if (event.type == 'touchstart') {
                var e = (typeof event.touches === 'undefined') ? event.originalEvent : event;
                touchClick = { x: e.touches[0].pageX, y: e.touches[0].pageY - _globals.deckoffset };
            } else {
                touchClick = { x: event.pageX, y: event.pageY - _globals.deckoffset };
            }

            var newX = touchClick.x - (p.width / 2) + parseInt(-20 + Math.random() * 40);
            var newY = touchClick.y - (p.height / 2);

            if (newX < 0) { newX = 0; }
            else if (newX > window.innerWidth - p.width) { newX = window.innerWidth - p.width; }

            if (newY < 10) { newY = 10; }
            else if (newY > _globals.touchZone.height() - p.height) { newY = _globals.touchZone.height() - p.height; }

            p.inZone = answerVal;
            survey.answerQuestion(answerVal);
            p.changeState(newX, newY, p.state.scale, p.randomRotate());
            p.anim();
            advanceSurvey();
            adjustPucks();
        });

        _globals.backBtn.bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            if (!survey.isComplete) { stepBack(); return; }
            hideBlockout();
            $('#finishedSurvey').css('display', 'none');
            $('#active-survey-data').css('display', 'block');
            _globals.specSheet.css(cssTrans('transform', 'translate3d(0,' + (_globals.appHeight + 66) + 'px,0)'));
            stepBack();
            survey.isComplete = false;

        });

        $('.specs-header').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            if (_globals.fromEmailLink) {
                _globals.specSheet.css(cssTrans('transform', 'translate3d(0,' + (_globals.appHeight + 66) + 'px,0)'));
                _globals.fromEmailLink = false;
            } else {
                showSpecCTA();
                $('#emailField').blur(); document.activeElement.blur();
                 $('#emailField').removeClass('text-field-error');
            }

            //tracking
            trackEvent('find_your_pc_fit', 'back', 'play_again');
        });

        $('#whatSpecsMean').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            revealPanel($('.desc-panel'));
            hidePanel($('.specs-panel'), 'left');

        });

        $('#returnToDescPanel').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            revealPanel($('.specs-panel'));
            hidePanel($('.desc-panel'), 'right');

        });

        $('#emailSpecsBtn').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            var form = $('#emailForm'),
					message = $('#emailConfirmMessage');
            $('#emailForm .text-field').val($('#emailForm .text-field').attr('title'));
            form.css('display', 'block');
            message.css('display', 'none');
            revealPanel($('.email-panel'));
            hidePanel($('.specs-panel'), 'right');
            shopper_app.setAutoScroll(false);

        });

        $('.specsFromEmail').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            revealPanel($('.specs-panel'));
            hidePanel($('.email-panel'), 'left');
            shopper_app.setAutoScroll(true);
            $('#emailField').removeClass('text-field-error').blur();
            document.activeElement.blur(); 
        });

        $('.blockout').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            if (survey.isComplete) { return; }
            else if (!_globals.gameStarted) { return; }
            survey.takingSurvey = true;
            hideBlockout();
            _globals.gameLights.css('opacity', 1);
            adjustPucks();
        });

        $('#startGame').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            trackEvent('find_your_pc_fit', 'start', 'find_your_pc_fit');
            startGame();
            shopper_app.scrollToApp();
            window.setTimeout(function () { shopper_app.setAutoScroll(true); }, 1000);
        });

        $('#seeSpecksDetail').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            showSpecCard();
            trackPage('find_your_pc_fit/view_results');
        });

        $('#emailForm .text-field').bind('focus', function (e) {
            shopper_app.setAutoScroll(false);
            $this = $(this);
            if ($this.val() == $this.attr('title') || $this.val() == $this.attr('data-error')) { $this.val(''); }
        }).bind('blur', function (e) {
            $this = $(this);
            if ($this.val() == '' || $this.val().length == 0) {
                if ($this.hasClass('text-field-error')) {
                    $this.val($this.attr('data-error'));
                } else { $this.val($this.attr('title')); }
            }
            shopper_app.scrollToApp();
            shopper_app.setAutoScroll(true);
        });

        $('#specBtns').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
        })

        $('#emailForm').bind('submit', function (e) {
            e.preventDefault();
            return false;
        });

        $('#emailSubmit').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            var form = $('#emailForm'),
					message = $('#emailConfirmMessage'),
					emailField = $('#emailField'),
					//url = window.location.pathname + 'EmailService/EmailService/SendAnEmail',
					url = '/bin/SpecsEmail',
					specsLink = _globals.surveyResults.url;

            if (validateEmail()) {
                emailField.removeClass('text-field-error');
                var emailVal = emailField.val();
                //ajax call here
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: { 'emailAddress': emailVal, 'processor': $('#processor').html(), 'ram': $('#ram').html(), 'hardDrive': $('#harddrive').html(), 'screenSize': $('#screensize').html(), 'portability': $('#portability').html(), 'specsLink': specsLink },
                    dataType: 'json',
                    success: function (data) {  },
                    error: function (xhr, type) {
                        //console.log('fail');
                    }
                });

                form.css('display', 'none');
                message.css('display', 'block');
                document.activeElement.blur();
                //tracking
                trackEvent('find_your_pc_fit', 'email', 'email_specs');
            } else {
                emailField.addClass('text-field-error').val(emailField.attr('data-error'));
                delay(function () { emailField.blur(); document.activeElement.blur(); }, 100);
            }
        });

        //tracking on shop spot navigation
        $('#shopSpot a').bind(shopper_app.touchClick, function (e) {
            e.preventDefault();
            var optLabel = $(this).attr('data'),
					pageTarget = $(this).attr('href');
            //tracking
            trackEvent('find_your_pc_fit', 'main_menu', optLabel);
            //delay(function{}, 50);
            delay(function () { window.location.href = pageTarget; }, 50);
        });

        /*$('body').bind('touchstart', function( e ){
            alert( e.target );
        });*/

    }
}; //end