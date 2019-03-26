UAKjGmz = function() {
	andiUA.UAogJrqlha = function(UAVjNBvMWa) {
		andizxc('.UAqColeqh, .UAvZZmSXs').remove();
		if (UAVjNBvMWa !== undefined && UAVjNBvMWa.length > 0) {
		for (var UAQFJslXzA = 0; UAQFJslXzA < UAVjNBvMWa.length; UAQFJslXzA++) {
        var UAhZPpSj = UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN;
        if (andizxc(UAhZPpSj).children().length > 0 && UAhZPpSj.length > 0 && andizxc(UAhZPpSj).css("display") != "none" && andizxc(UAhZPpSj).css("visibility") != "hidden" && andizxc(UAhZPpSj).css("opacity") != "0" && andizxc.trim(andizxc(UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN).text()) != "") {
          andizxc(UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN).prepend('<a class="UANFcMGCskipArea" name="UAKPTXjHb' + UAQFJslXzA + '"  tabindex="0" >' + UAVjNBvMWa[UAQFJslXzA].UASSMftp + ",<br />" + andiUA.UAkwBrKq.UAdziiEqj + "</a>");
        }
        if (UAVjNBvMWa[UAQFJslXzA].UAQbWaadfd && UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN != "undefined" && UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN != undefined && andizxc.trim(andizxc(UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN).text() != "")) {
      //    andizxc("body").prepend('<a id="UAulIfZc" class="UAahwHlctT" name="UAulIfZc" href="#UAMainContent" tabindex="0" > ' + andiUA.UAkwBrKq.UAJOYLWsu + "</a>");
          andizxc(UAVjNBvMWa[UAQFJslXzA].UAGhsuMrN).attr({"role":"main"});
        }
      }
      var UAzBAosyS = andizxc("title").text();
      andizxc("body").append('<a id="UAzDIcef" class="UANFcMGCskipArea" name="UAzDIcef" href="#UAulIfZc" tabindex="0" >' + andiUA.UAkwBrKq.UAqYtjy + UAzBAosyS + " " + andiUA.UAkwBrKq.UAXhFXhm + " </a>");
      andizxc(".UAahwHlctT").click(function(event) {
        event.preventDefault();
        var UAjWhFlQZ = andizxc('[role="main"]');
        if (UAjWhFlQZ != undefined && UAjWhFlQZ.length == 1) {
          andizxc(UAjWhFlQZ).attr("tabindex", "0").focus();
        }
      });
	  
	    andizxc(document).on("click", "#UAzDIcef", function(UAeZhAzmIV) {
    andizxc(".UANFcMGCskipArea").first().attr("tabindex", "0").focus().scrollTop(0);
    //andizxc("body").attr("tabindex", "");
  });
  andizxc(document).on("focus", ".UAzpLPmk", function(UAeZhAzmIV) {
    //andizxc(this).parent().css({"outline":"5px solid #49C0EB"});
    andizxc(this).parent().css({"box-shadow":"0px 0px 3px 5px rgba(73,192,235,1)"});
	

	
  });
  andizxc(document).on("blur", ".UAzpLPmk", function(UAeZhAzmIV) {
    andizxc(this).parent().css({"outline":""});
    andizxc(this).parent().css({"box-shadow":""});
  });
  
			var UAzBAosyS = andizxc("title").text();
			andizxc(".UANFcMGCskipArea").each(function(UAQFJslXzA) {
				 var UAjLdxmGa = andizxc(".UANFcMGCskipArea");
				 if ((UAjLdxmGa.length - 1) == UAQFJslXzA) {
					 andizxc(this).attr({
						 "href": "#UAulIfZc",
						 "name": "UAKPTXjHb" + UAQFJslXzA
					 });
				 } else {
					 andizxc(this).attr({
						 "href": "#UAKPTXjHb" + (UAQFJslXzA + 1),
						 "name": "UAKPTXjHb" + UAQFJslXzA,
						 "id": "UAKPTXjHb" + UAQFJslXzA
					 });
				 }
			});
			andizxc(".UANFcMGCskipArea").click(function(UAeZhAzmIV) {
				 UAeZhAzmIV.preventDefault();
				 var UAjLdxmGaUAskipArea = andizxc(".UANFcMGCskipArea");
				 var UAtrRPuOFP = andizxc.inArray(this, UAjLdxmGaUAskipArea);
				 var offSetTop = andizxc(UAjLdxmGaUAskipArea[UAtrRPuOFP + 1]).scrollTop();
				 if ((UAtrRPuOFP + 1) == UAjLdxmGaUAskipArea.length) {
					 andizxc('#UAulIfZc').attr('tabindex', '0').focus().scrollTop(0);
				 } else {
					 andizxc(UAjLdxmGaUAskipArea[UAtrRPuOFP + 1]).attr('tabindex', '0').focus().scrollTop(offSetTop + 50);
				 }
			});
			andizxc(".UANFcMGCskipArea").focus(function() {
				 andizxc(this).parent().css({
					 'font-size': '16px'
				 });
				 }).blur(function() {
					 andizxc(this).parent().css({
						 'font-size': ''
					 });
				 });
				 andizxc(".UAvZZmSXs, .UAqColeqh").keydown(function(UAeZhAzmIV) {
					 if (UAeZhAzmIV.keyCode == 13) {
						 andizxc(this).find('a').first().click();
				}
			});
		}
	};


	 andiUA.markTextLagn = function(){
		 if(false){
			 if(andiUA.UAJNMLkMp != 'he'){
				 for(var UAQFJslXzA = 0; UAQFJslXzA < andiUA.UAFbllyy.length; UAQFJslXzA++){
					andiUA.UAkGQun(document.body,andiUA.UAFbllyy[UAQFJslXzA],'','he');
				 }
			 }
			 if(andiUA.UAJNMLkMp != 'ar'){
				 for(var UAQFJslXzA = 0; UAQFJslXzA < andiUA.UAvkfGZwc.length; UAQFJslXzA++){
					andiUA.UAkGQun(document.body,andiUA.UAvkfGZwc[UAQFJslXzA],'','ar');
				 }
			 }
			 if(andiUA.UAJNMLkMp != 'en'){
				 for(var UAQFJslXzA = 0; UAQFJslXzA < andiUA.UAtufeFaV.length; UAQFJslXzA++){
					andiUA.UAkGQun(document.body,andiUA.UAtufeFaV[UAQFJslXzA],'','en');
				 }
			 }
			 if(andiUA.UAJNMLkMp != 'ru'){
				 for(var UAQFJslXzA = 0; UAQFJslXzA < andiUA.UAwKhnQPI.length; UAQFJslXzA++){
					andiUA.UAkGQun(document.body,andiUA.UAwKhnQPI[UAQFJslXzA],'','ru');
				 }
			 }
		 }
	 }


	 andiUA.UAvVKiO = function (UAGYPtkiS) {
        if (UAGYPtkiS !=undefined &&  UAGYPtkiS) {
			if(andizxc('#UAgpTVVwqA').length == 0){
				andizxc('head').append('<style id="UAgpTVVwqA">body [UAvGyiRT][title]:not(.andimenucode){display: inline-block;}body [UAvGyiRT][title]:focus:after{content: "  ("  attr(title) ") ";padding: 5px;z-index: 98;background-color:#000;color:#fff;min-width:50px;display: block;}body [UAvGyiRT][title]:focus:before{content: "";z-index: 99;}</style>');
			}
			andizxc('[UAvGyiRT][title]').attr('tabIndex','0');
			andizxc('iframe').each(function(){
				try{
					if(andizxc(this).contents().find('#UAgpTVVwqA').length == 0){
						andizxc(this).contents().find('head').append('<style id="UAgpTVVwqA">body [UAvGyiRT][title]:not(.andimenucode){display: inline-block;}body [UAvGyiRT][title]:focus:after{content: "  ("  attr(title) ") ";padding: 5px;z-index: 98;background-color:#000;color:#fff;min-width:50px;display: block;}body [UAvGyiRT][title]:focus:before{content: "";z-index: 99;}</style>');
					}
					andizxc(this).contents().find('[UAvGyiRT][title]').attr('tabIndex','0');
				} catch(ANDIUADYzBx) {
					if(andiUA.UAillQtC.UAwoFuMbS)console.log("UADYzBxor: "+ANDIUADYzBx);
				}
			});
			
		}
	 }
	 
	 
    andiUA.UAxpAEPU = function (UAmjOYdqf) {
		if(UAmjOYdqf != undefined ){
            var UAesMIACHb = andiUA.UAxLATvj;
            if (UAmjOYdqf !== undefined && UAmjOYdqf.length > 0) {
				andizxc(UAmjOYdqf).each(function (UAQFJslXzA) {
					if(andiUA.UAyrJYN(UAmjOYdqf[UAQFJslXzA].UAgGbGIdPy,UAmjOYdqf[UAQFJslXzA].UAYrWQNxMo)){
                    if ((UAmjOYdqf[UAQFJslXzA].UAjdxeJl).length > 0) {
                        setTimeout(function () {
                            andizxc(UAmjOYdqf[UAQFJslXzA].UAKEDQCa).each(function (TUAj) {
                                andiUA.UAgvhoz(UAmjOYdqf[UAQFJslXzA].UAKEDQCa[TUAj]);
                            });
							if(UAmjOYdqf[UAQFJslXzA].UAFtDmzxEa != ''){
								andizxc('head').append('<style id="sliderStyle'+UAQFJslXzA+'">'+UAmjOYdqf[UAQFJslXzA].UAFtDmzxEa+'</style>');
							}
                            if (UAmjOYdqf[UAQFJslXzA].UAJbMjB == null || UAmjOYdqf[UAQFJslXzA].UAJbMjB == undefined || UAmjOYdqf[UAQFJslXzA].UAJbMjB == 'null' || UAmjOYdqf[UAQFJslXzA].UAJbMjB == 'undefined' || UAmjOYdqf[UAQFJslXzA].UAJbMjB == '') { UAmjOYdqf[UAQFJslXzA].UAJbMjB = UAmjOYdqf[UAQFJslXzA].UAbncMVy; }
                            if (UAmjOYdqf[UAQFJslXzA].UAUEouuEM || UAmjOYdqf[UAQFJslXzA].UAUEouuEM == undefined) {
                                andizxc(UAmjOYdqf[UAQFJslXzA].UAJbMjB).css({ 'position': 'relative' }).prepend('<input type="image" class="UAerngGW" src="' + UAesMIACHb.stop + ' "id="UAMQIHj' + UAQFJslXzA + '" alt="' + andiUA.UAkwBrKq.UASObFlJN + '"/>');
                            } else {
                                andizxc(UAmjOYdqf[UAQFJslXzA].UAJbMjB).css({ 'position': 'relative' }).prepend('<input type="image" class="UADLpFNJqu" src="' + UAesMIACHb.stop + ' "id="UAMQIHj' + UAQFJslXzA + '" alt="' + andiUA.UAkwBrKq.UAcHZyn + '"/>');
                            }
                            if (UAmjOYdqf[UAQFJslXzA].UAsiLFhjMn != 'left' && UAmjOYdqf[UAQFJslXzA].UAsiLFhjMn != 'right') { UAmjOYdqf[UAQFJslXzA].UAsiLFhjMn = 'left'; }
                            if (UAmjOYdqf[UAQFJslXzA].UAsiLFhjMn == 'left') {
                                if (!andizxc.isNumeric(UAmjOYdqf[UAQFJslXzA].UAlNNZr)) { UAmjOYdqf[UAQFJslXzA].UAlNNZr = 5; }
                                if (!andizxc.isNumeric(UAmjOYdqf[UAQFJslXzA].UAlrpelB)) { UAmjOYdqf[UAQFJslXzA].UAlrpelB = 5; }
                                andizxc('#UAMQIHj' + UAQFJslXzA).css({ 'top': UAmjOYdqf[UAQFJslXzA].UAlNNZr, 'left': UAmjOYdqf[UAQFJslXzA].UAlrpelB });
                            } else {
                                if (!andizxc.isNumeric(UAmjOYdqf[UAQFJslXzA].UAlNNZr)) { UAmjOYdqf[UAQFJslXzA].UAlNNZr = 5; }
                                if (!andizxc.isNumeric(UAmjOYdqf[UAQFJslXzA].UAlrpelB)) { UAmjOYdqf[UAQFJslXzA].UAlrpelB = 5; }
                                andizxc('#UAMQIHj' + UAQFJslXzA).css({ 'top': UAmjOYdqf[UAQFJslXzA].UAlNNZr, 'right': UAmjOYdqf[UAQFJslXzA].UAlrpelB });
                            }
                        }, UAmjOYdqf[UAQFJslXzA].UAhQDhgu);
                    }
					}
                });
                andizxc(UAmjOYdqf).each(function (UAQFJslXzA) {
                    setTimeout(function () {
                        var UAjdxeJl = UAmjOYdqf[UAQFJslXzA].UAjdxeJl, UAQCoXOzrC = [], UANUYrwOeO = UAQFJslXzA;
                        andizxc(UAjdxeJl).each(function (index) {
                            UAcUsrh = andizxc(UAjdxeJl).first().height();
                            if (UAcUsrh < 60) {
                                UAcUsrh = 60;
                            }
                            var UAvSgdpEOn = UAcUsrh * index;
                            UAzblmdBXE = andizxc(UAjdxeJl).first().width();
                            UAQCoXOzrC.push(andizxc(this).clone().css({'height': UAcUsrh, 'width': UAzblmdBXE, 'display': 'inline-block', 'opacity': '1', 'visibility': 'visible', 'position': 'relative', 'top': '', 'left': '', 'right': '' }).attr('tabindex', '0').addClass('UAiXxdbh' + UANUYrwOeO));
                        });
                        andizxc('#UAMQIHj' + UAQFJslXzA).bind('click', function (UAeZhAzmIV) {
                            UAeZhAzmIV.preventDefault();
                            andiUA.UADQrTtMZU(UAmjOYdqf, UAQFJslXzA, UAQCoXOzrC);

                            andiUA.UAYWotT(andiUA.UAkwBrKq.UAOccXyv);
                        });
                    }, (UAmjOYdqf[UAQFJslXzA].time + 50));
                });
            }
        }
    };

    andiUA.UADQrTtMZU = function (UAmjOYdqf, UAQFJslXzA, UAQCoXOzrC) {
            var  UAesMIACHb = andiUA.UAxLATvj;
            andizxc('#UAMQIHj' + UAQFJslXzA).removeAttr('role').removeAttr('aria-label');
            var state = null;
            if (andizxc('#UAMQIHj' + UAQFJslXzA).hasClass('UAlKQXuobM')) {
                state = false;
                andiUA.UAbHLHeD(UAmjOYdqf[UAQFJslXzA], false, UAQFJslXzA, UAQCoXOzrC);
                andizxc('#UAMQIHj' + UAQFJslXzA).attr('src', UAesMIACHb.stop);
                if (UAmjOYdqf[UAQFJslXzA].UAUEouuEM || UAmjOYdqf[UAQFJslXzA].UAUEouuEM == undefined) {
                    andizxc('#UAMQIHj' + UAQFJslXzA).removeClass('UAlKQXuobM').addClass('UADLpFNJqu').attr({ 'role': 'alert', 'aria-label': andiUA.UAkwBrKq.UADLpFNJqu });
                } else {
                    andizxc('#UAMQIHj' + UAQFJslXzA).removeClass('UAlKQXuobM').addClass('UADLpFNJqu').attr({ 'role': 'alert', 'aria-label': andiUA.UAkwBrKq.UAhhdeAm });
                }
                setTimeout(function () { andizxc('#UAMQIHj' + UAQFJslXzA).removeAttr('role').removeAttr('aria-label'); }, 500);
                andizxc(UAmjOYdqf[UAQFJslXzA].UAbncMVy).css({ 'position': 'relative' });
                andizxc(UAmjOYdqf[UAQFJslXzA].UAjdxeJl).css({ 'opacity': '1' });
            } else {
                state = true;
                andiUA.UAbHLHeD(UAmjOYdqf[UAQFJslXzA], true, UAQFJslXzA, UAQCoXOzrC);
                andizxc('#UAMQIHj' + UAQFJslXzA).attr({ 'src': UAesMIACHb.UAnxLZOlc });
                if (UAmjOYdqf[UAQFJslXzA].UAUEouuEM || UAmjOYdqf[UAQFJslXzA].UAUEouuEM == undefined) {
                    andizxc('#UAMQIHj' + UAQFJslXzA).removeClass('UADLpFNJqu').addClass('UAlKQXuobM').attr({ 'role': 'alert', 'aria-label': andiUA.UAkwBrKq.UAlKQXuobM });
                } else {
                    andizxc('#UAMQIHj' + UAQFJslXzA).removeClass('UADLpFNJqu').addClass('UAlKQXuobM').attr({ 'role': 'alert', 'aria-label': andiUA.UAkwBrKq.UAvAHlOqgE });
                }
                setTimeout(function () { andizxc('#UAMQIHj' + UAQFJslXzA).removeAttr('role').removeAttr('aria-label'); }, 500);
            }
        
    };

    andiUA.UAbHLHeD = function (slider, state, UANUYrwOeO, UAQCoXOzrC) {
            var UAjdxeJl = slider.UAjdxeJl, UAbncMVy = slider.UAbncMVy, UAKEDQCa = slider.UAKEDQCa;
            if (state) {
                andizxc(UAKEDQCa).each(function (UAQFJslXzA) {
                    andizxc(UAKEDQCa[UAQFJslXzA].UAjWhFlQZ).css({ 'opacity': '0' }).attr({ 'tabindex': '-1', 'aria-hidden': 'true' });
                });
                var UAsSALO = (andizxc(UAbncMVy).width());
                var UAoMEWdYx = (andizxc(UAbncMVy).height());
                if (UAoMEWdYx < 60) {
                    UAoMEWdYx = 60;
                }

                andizxc(UAbncMVy).css({ 'position': 'relative' }).append('<div id="UAvJjJg' + UANUYrwOeO + '" style="overflow:hidden"><span id="UAtTWadvc" role="tooltip" style="background-color:#000;color:#fff;text-align:center;display:block;height:20px;font-size:16px;z-index:999999">' + andiUA.UAkwBrKq.UAtTWadvc + '</span><div class="UACWpHwz' + UANUYrwOeO + '" ></div></div>');
                andizxc('#UAvJjJg' + UANUYrwOeO).css({ 'opacity': '1', 'z-index': '99998', height: UAoMEWdYx + 20, 'width': UAsSALO, 'position': 'absolute', 'top': '0', 'overflow': 'hidden' });
                andizxc(UAjdxeJl).each(function () {
                    andizxc(this).css({ 'opacity': '0' }).children().attr({ 'tabindex': '-1', 'aria-hidden': 'true' });
                });
                andizxc('.UACWpHwz' + UANUYrwOeO).css({ 'width': (UAsSALO + 20), 'height': UAoMEWdYx, 'z-index': '99999989', 'position': 'relative', 'top': '0', 'overflow-y': 'scroll', 'overflow-x': 'hidden' }).append(UAQCoXOzrC);
                andizxc('.UACWpHwz' + UANUYrwOeO).attr({ 'tabindex': '0' }).focus();
                andizxc('.UACWpHwz' + UANUYrwOeO).scroll(function () {
                    andizxc('#UAtTWadvc').css('display', 'none');
                });
                andiUA.UAvVKiO(andiUA.UAillQtC.UAGYPtkiS);
                andizxc('#UAvJjJg' + UANUYrwOeO).find('*').each(function () {
                    andizxc(this).stop(true, true).clearQueue();
                });
            } else {
                andizxc('#UAvJjJg' + UANUYrwOeO).remove();
                andizxc(UAKEDQCa).each(function (UAQFJslXzA) {
                    andizxc(UAKEDQCa[UAQFJslXzA].UAjWhFlQZ).css({ 'opacity': '1' }).attr({ 'tabindex': '0', 'aria-hidden': 'false' });
                });
            }
        
    };

    andiUA.UApuhHga = function () {
        var UAeqCLu = andiUA.UAillQtC.UApNBqikB;
		if(UAeqCLu != undefined){
        var UAesMIACHb = andiUA.UAxLATvj;
        andizxc(UAeqCLu).each(function (UAQFJslXzA) {
		if(andiUA.UAyrJYN(UAeqCLu[UAQFJslXzA].UAgGbGIdPy,UAeqCLu[UAQFJslXzA].UAYrWQNxMo)){	
		andizxc('head').append('<style id="UAQCoXOzrCndiMenus">UAQCoXOzrCndiSubMenuLevel3 *:focus{outline:2px solid #000} .UAQCoXOzrCndiSubMenu *:focus{outline:2px solid #000}</style>');
            if(UAeqCLu[UAQFJslXzA].UArupqS != ''){
				andizxc('head').append('<style id="sliderStyle'+UAQFJslXzA+'">'+UAeqCLu[UAQFJslXzA].UArupqS+'</style>');
			}
			
			if ((UAeqCLu[UAQFJslXzA].UAyyDqJhu != '')) {
                andizxc(UAeqCLu[UAQFJslXzA].UAyyDqJhu).attr({ 'role': 'navigation' });
            }
            if ((UAeqCLu[UAQFJslXzA].UADGqprU != '')) {
				andizxc(UAeqCLu[UAQFJslXzA].UAyyDqJhu).find('a').each(function(){
					andizxc(this).parent().attr({ 'role': 'menuitem', 'tabindex': '-1'});
				});
                andizxc(UAeqCLu[UAQFJslXzA].UADGqprU).each(function () {
                    andizxc(this).attr({ 'tabindex': '0' });
                });
                andizxc(UAeqCLu[UAQFJslXzA].UADGqprU).closest(UAeqCLu[UAQFJslXzA].UAyyDqJhu).each(function () {
                    if (andizxc(this).find(UAeqCLu[UAQFJslXzA].UAOUBiQQn).length > 0) {
                        andizxc(this).attr({ 'aria-haspopup': 'true' });
                    }
                    andizxc(this).find('a').last().addClass('UAQCoXOzrCndiUAzDIcefMenu');
                });
            } else {
				andizxc(UAeqCLu[UAQFJslXzA].UAyyDqJhu).find('a').each(function(){
					andizxc(this).parent().attr({ 'role': 'menuitem'});
				});
			}

			andizxc(UAeqCLu[UAQFJslXzA].UADGqprU).keydown(function (UAeZhAzmIV) {
				if(UAeZhAzmIV.keyCode == 9){
                if (andizxc('.UAQCoXOzrCndiOpenSubMenuBtn') != undefined && andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').length > 0) {
                    andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').remove();
                }
                if (andizxc('.UAQCoXOzrCndiSubMenu') != undefined && andizxc('.UAQCoXOzrCndiSubMenu').length > 0) {
                    andizxc('.UAQCoXOzrCndiSubMenu').remove();
                }

                var D = andizxc(this).closest(UAeqCLu[UAQFJslXzA].UARowlARq).find(UAeqCLu[UAQFJslXzA].UAOUBiQQn).first();

                if (D != undefined && D.length > 0) {
                    andizxc(this).closest(UAeqCLu[UAQFJslXzA].UARowlARq).css({ 'position': 'relative' });
                    andizxc(this).after('<button title="' + andiUA.UAkwBrKq.UAjZnYyTky + '" class="UAQCoXOzrCndiOpenSubMenuBtn"></button>');
                    andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').css({ 'padding': '0', 'margin': '0', 'z-index': '999', 'width': '25px', 'height': '25px', 'background-color': 'transparent', 'border': 'none', 'background-repeat': 'no-repeat', 'background-position': '50% 50%', 'background-size': '75% 75%', 'background-image': 'url(' + UAesMIACHb.UAQMModB + ')', 'position': 'absolute', 'top': UAeqCLu[UAQFJslXzA].UAoTkvhw +'px', UATMteezqT: UAeqCLu[UAQFJslXzA].UAxYhYG +'px'});
                    if (UAeqCLu[UAQFJslXzA].UAsiLFhjMn == 'left') {
                        andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').css({ 'left': UAeqCLu[UAQFJslXzA].UAxYhYG +'px'});
                    } else {
                        andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').css({ 'right': UAeqCLu[UAQFJslXzA].UAxYhYG+'px' });
                    }

                   andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').bind('click', function (UAeZhAzmIV) {
                        if (andizxc('.UAQCoXOzrCndiSubMenu') != undefined && andizxc('.UAQCoXOzrCndiSubMenu').length > 0) {
                            andizxc('.UAQCoXOzrCndiSubMenu').remove();
                            andiUA.UAYWotT(andiUA.UAkwBrKq.UAEWNjwizv);
                        } else {
                            andiUA.UAYWotT(andiUA.UAkwBrKq.UAAVTjL);
                            UAeZhAzmIV.preventDefault();
                            var UAQCoXOzrC = andizxc(this).closest(UAeqCLu[UAQFJslXzA].UARowlARq).find(UAeqCLu[UAQFJslXzA].UAOUBiQQn).first();
                            var ANDIb = andizxc(UAQCoXOzrC).clone().css({ 'max-height': '100%', 'aria-hidden': 'false', 'left': 'auto', 'right': 'auto', 'display': 'block', 'opacity': '1', 'visibility': 'visible' }).addClass('UAQCoXOzrCndiSubMenu');
                            andizxc(this).closest(UAeqCLu[UAQFJslXzA].UARowlARq).append(ANDIb);
                            andizxc(UAQCoXOzrC).find('*').attr({ 'tabindex': '-1', 'aria-hidden': 'true' });
                            andizxc(ANDIb).find('*').attr({ 'tabindex': '', 'aria-hidden': '' });
                            andizxc(ANDIb).find('a').focus(function () {
                                var UAjWhFlQZ = this;
                                var ANDIf = (andizxc(this).closest(UAeqCLu[UAQFJslXzA].UAAGCaP).find(UAeqCLu[UAQFJslXzA].UAQWYqci).first());
                                if (andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn') != undefined && andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').length > 0) {
                                    andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').remove();
                                }
                                if (andizxc('.UAQCoXOzrCndiSubMenuLevel3') != undefined && andizxc('.UAQCoXOzrCndiSubMenuLevel3').length > 0) {
                                    andizxc('.UAQCoXOzrCndiSubMenuLevel3').remove();
                                }
                                if (ANDIf != undefined && andizxc(ANDIf).length > 0) {
                                    andizxc(ANDIf).find('*').attr({ 'tabindex': '-1', 'aria-hidden': 'true' });
                                    andizxc(this).after('<button title="' + andiUA.UAkwBrKq.UAjZnYyTky + '" class="UAQCoXOzrCndiOpenSubMenuLevel3Btn"></button>');
                                    andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').css({ 'z-index': '999', 'width': '40px', 'height': '15px', 'background-color': 'transparent', 'border': 'none', 'background-repeat': 'no-repeat', 'background-size': '100% 100%', 'background-image': 'url(' + UAesMIACHb.UAQMModB + ')', 'position': 'absolute', 'top': UAeqCLu[UAQFJslXzA].UAoTkvhw +'px', UATMteezqT: UAeqCLu[UAQFJslXzA].UAxYhYG +'px'});
                                    if (UAeqCLu[UAQFJslXzA].UAsiLFhjMn == 'left') { andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').css('left', UAeqCLu[UAQFJslXzA].UAxYhYG +'px') } else { andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').css('right', UAeqCLu[UAQFJslXzA].UAxYhYG +'px') }
                                    andizxc('.UAQCoXOzrCndiOpenSubMenuLevel3Btn').bind('click', function (UAeZhAzmIV) {
                                        if (andizxc('.UAQCoXOzrCndiSubMenuLevel3') != undefined && andizxc('.UAQCoXOzrCndiSubMenuLevel3').length > 0) {
                                            andizxc('.UAQCoXOzrCndiSubMenuLevel3').remove();
                                            andiUA.UAYWotT(andiUA.UAkwBrKq.UAEWNjwizv);
                                        } else {
                                            andiUA.UAYWotT(andiUA.UAkwBrKq.UAAVTjL);
                                            UAeZhAzmIV.preventDefault();
                                            andizxc(ANDIf).find('*').attr({ 'tabindex': '-1', 'aria-hidden': 'true' });
                                            var ANDIg = andizxc(ANDIf).clone().css({ 'max-height': '100%', 'aria-hidden': 'false', 'left': 'auto', 'right': 'auto', 'display': 'block', 'opacity': '1', 'visibility': 'visible' }).addClass('UAQCoXOzrCndiSubMenuLevel3');
                                            andizxc(this).closest(UAeqCLu[UAQFJslXzA].UAAGCaP).append(ANDIg);
                                            andizxc(ANDIg).find('*').attr({ 'tabindex': '', 'aria-hidden': '' });
                                            andizxc(ANDIg).find('a').last().addClass('UAQCoXOzrCndiUAzDIcefLevel3');
                                            andizxc(ANDIg).find('*').focus(function () {
                                                andizxc(this).css({ 'border': '1px solid #fff' });
                                                andizxc(this).blur(function () { andizxc(this).css({ 'border': '' }); });
                                            });
                                        }
                                    });

                                }
                                andizxc(this).css({ 'border': '1px solid #fff' });
                                andizxc(this).blur(function () { andizxc(this).css({ 'border': '' }); })
                            });
                        }
                    });

                    andizxc(UAeqCLu[UAQFJslXzA].UAGREfLJg).find('*').focus(function () {
                        andizxc(this).css({ 'border': '1px solid #fff' });
                        andizxc(this).blur(function () { andizxc(this).css({ 'border': '' }); })
                    });
                }
				}
            });
            andizxc(document).on('focusout', '.UAQCoXOzrCndiUAzDIcefMenu', function (UAeZhAzmIV) {
                var UAjWhFlQZ = this;
                var UATILpbt = [];
                andizxc('a,button,input,[role="button"],[role="link"],[tabindex]').each(function () {
                    UATILpbt.push(andizxc(this).text());
                });
                var as = andizxc(UAjWhFlQZ).text();
                if (UAeZhAzmIV.keyCode == 9) {
                    andizxc(UATILpbt[(andizxc.inArray(as, UATILpbt)) + 1]).focus();
                }
                if (andizxc('.UAQCoXOzrCndiOpenSubMenuBtn') != undefined && andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').length > 0) {
                    andizxc('.UAQCoXOzrCndiOpenSubMenuBtn').remove();
                }
                if (andizxc('.UAQCoXOzrCndiSubMenu') != undefined && andizxc('.UAQCoXOzrCndiSubMenu').length > 0) {
                    andizxc('.UAQCoXOzrCndiSubMenu').remove();
                }
            });
		}
        });
		
	}
    };
 
	
	andiUA.UAhkjFIwu = function (UAKEDQCa) {
		if (UAKEDQCa !== undefined && UAKEDQCa.length > 0) {
			andizxc(UAKEDQCa).each(function (TUAj) {
				if(andiUA.UAyrJYN(UAKEDQCa[TUAj].UAgGbGIdPy,UAKEDQCa[TUAj].UAYrWQNxMo)){	
					andiUA.UAgvhoz(UAKEDQCa[TUAj]);
				}
			});
		}
    };

    andiUA.UAgvhoz = function (UAjWhFlQZ) {
		if( !andizxc(this).is('[andialreadysetasbtn]') ){
			andizxc(UAjWhFlQZ.UAjWhFlQZ).each(function (UAQFJslXzA) {
				andizxc(this).attr({ "role": "button", 'andialreadysetasbtn':'true','UAHCNtZK':"true",'UASApCTnmZ':'true'}).css({ "cursor": "pointer" });
				if(andizxc(this).attr('tabindex') == undefined || andizxc(this).attr('tabindex') != -1 || andizxc(this).attr('tabindex') == null ){
					andizxc(this).attr({"tabindex": "0"})
				}
				var text = "" , UAeqQVbcIK = andizxc(this);
				if (UAjWhFlQZ.UAXKngnFPl == "") {
					if (andizxc(UAeqQVbcIK).is('IMG')) {
						text = andizxc(UAeqQVbcIK).attr('alt');
						if (text == undefined || andizxc.trim(text) == "") {
							text = andizxc(UAeqQVbcIK).attr('title');
						}
						if (text != undefined || andizxc.trim(text) != "") {
							andizxc(UAeqQVbcIK).attr({ "aria-label": text });
						}
					} else {
						if (andizxc(UAeqQVbcIK).text() != undefined && andizxc(UAeqQVbcIK).text() != null && andizxc.trim(andizxc(UAeqQVbcIK).text()) != "") {
							andizxc(UAeqQVbcIK).attr({ "aria-label": text });
						}
					}
				} else {
					andizxc(UAeqQVbcIK).attr({ "aria-label": UAjWhFlQZ.UAXKngnFPl });
				}
				
				andizxc(UAeqQVbcIK).click(function () {
					if (UAjWhFlQZ.UAtzLky !== '') {
						andizxc('body').append('<span class="UAxnXSd" role="alert" aria-label="' + UAjWhFlQZ.UAtzLky + '"></span>');
						setTimeout(function () {
							andizxc('.UAxnXSd').remove();
						}, 500);
					}
					if (UAjWhFlQZ.UAzmFbgBQt != '') {
						setTimeout(function () {
							andizxc(UAjWhFlQZ.UAzmFbgBQt).attr('tabindex','0').focus();
						}, 750);
					}
				});
			});
		}
	}
	

	

	andiUA.UAsYHKFY = function (UAYOyiTs) {
	  if(UAYOyiTs != undefined && UAYOyiTs.length > 0){
		var UAesMIACHb = andiUA.UAxLATvj;
			andizxc(UAYOyiTs).each(function (UAQFJslXzA) {
				if(andiUA.UAyrJYN(UAYOyiTs[UAQFJslXzA].UAgGbGIdPy,UAYOyiTs[UAQFJslXzA].UAYrWQNxMo)){
					andizxc(UAYOyiTs[UAQFJslXzA].UAjWhFlQZ).each(function (TUAj) {
						var UAwpTfOkUZ = andizxc(this).css('background-image');
						UAwpTfOkUZ = UAwpTfOkUZ.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');
						if(UAYOyiTs[UAQFJslXzA].UAILadEjLU == UAwpTfOkUZ){
							andizxc(this).attr({'role':'img','aria-label':UAYOyiTs[UAQFJslXzA].UAXKngnFPl})
						}
					});
				}
			});
		}
	};	   

   andiUA.UAFDjCj = function (UAMzmIeZf) {
		if (UAMzmIeZf !== undefined && UAMzmIeZf.length > 0) {
			var UAgTLAEdw = document.querySelectorAll('[onclick^="location"],[onclick^="window.open"]');
			for(var UAQFJslXzA = 0; UAQFJslXzA < UAgTLAEdw.length;UAQFJslXzA++){
				UAgTLAEdw[UAQFJslXzA].setAttribute('role','link');
				UAgTLAEdw[UAQFJslXzA].setAttribute('tabindex','0');
			}
			for(var TUAj = 0; TUAj < UAMzmIeZf.length;TUAj++){
				if(andiUA.UAyrJYN(UAMzmIeZf[TUAj].UAgGbGIdPy,  UAMzmIeZf[TUAj].UAYrWQNxMo)){
				if(UAMzmIeZf[TUAj].UAjWhFlQZ != ''){
					var UAgTLAEdw = document.querySelectorAll(UAMzmIeZf[TUAj].UAjWhFlQZ);
					for(var UAQFJslXzA = 0; UAQFJslXzA < UAgTLAEdw.length;UAQFJslXzA++){
						if( !andizxc(this).is('[andiUAqhrsqI]') ){
							var UApzSkQ = UAgTLAEdw[UAQFJslXzA].getAttribute('title');
							if(UApzSkQ != undefined && UApzSkQ != null && UApzSkQ.length > 1){
								UAgTLAEdw[UAQFJslXzA].setAttribute('aria-label',UApzSkQ + ", " + UAMzmIeZf[TUAj].UAXKngnFPl);
								UAgTLAEdw[UAQFJslXzA].setAttribute('role','link');
								UAgTLAEdw[UAQFJslXzA].setAttribute('tabindex','0');	
								UAgTLAEdw[UAQFJslXzA].setAttribute('andiUAqhrsqI','true');
							} else {
								UAgTLAEdw[UAQFJslXzA].setAttribute('aria-label',UAMzmIeZf[TUAj].UAXKngnFPl);
								UAgTLAEdw[UAQFJslXzA].setAttribute('role','link');
								UAgTLAEdw[UAQFJslXzA].setAttribute('tabindex','0');
								UAgTLAEdw[UAQFJslXzA].setAttribute('andiUAqhrsqI','true');
							}
						}
					}
				}
			}
			}
		}
    };
	
		
    andiUA.UADGDndNR = function (UAdVyFzlEN) {
        andizxc(UAdVyFzlEN).each(function (UAQFJslXzA) {
			if(andiUA.UAyrJYN(UAdVyFzlEN[UAQFJslXzA].UAgGbGIdPy,UAdVyFzlEN[UAQFJslXzA].UAYrWQNxMo)){
				andizxc(UAdVyFzlEN[UAQFJslXzA].UAKdYjZRg).each(function (TUAj) {
				if(!andizxc(this).is('[andiAlt]'))
					if (andizxc(this).is('img')  || andizxc(this).is('area') ) {
						andizxc(this).attr({ 'alt': UAdVyFzlEN[UAQFJslXzA].UAIErMSpp , 'andiAlt':'true'});
					} else {
						andizxc(this).attr({ 'role': 'img', 'aria-label': UAdVyFzlEN[UAQFJslXzA].UAIErMSpp, 'andiAlt':'true' });
					}
				});
			}
        });
    }

   andiUA.UAJdnqMVxj = function(UAJdnqMVxj){
		andizxc(UAJdnqMVxj).each(function (UAQFJslXzA) {
			if(andiUA.UAyrJYN(UAJdnqMVxj[UAQFJslXzA].UAgGbGIdPy,UAJdnqMVxj[UAQFJslXzA].UAYrWQNxMo)){
				andizxc(UAJdnqMVxj[UAQFJslXzA].UASzuMS).each(function (TUAj) {
					andizxc(this).attr({ 'role': 'heading', 'aria-level': UAJdnqMVxj[UAQFJslXzA].UADZBfeQbV })
				});
				andizxc('iframe').each(function(){
					try{
						var UAKSRKMLIframe = andizxc(this);
						andizxc(UAJdnqMVxj).each(function(UAQFJslXzA){
							andizxc(this).contents().find(UAJdnqMVxj[UAQFJslXzA].UASzuMS).each(function(TUAj){
								andizxc(this).attr({ 'role': 'heading', 'aria-level': UAJdnqMVxj[UAQFJslXzA].UADZBfeQbV });
							});
						});
					} catch(ANDIUADYzBx) {
						if(andiUA.UAillQtC.UAwoFuMbS)console.log("UADYzBxor: "+ANDIUADYzBx);
					}
				});
			}
		});
    }

	andiUA.UAXJuZA = function (UAWzVSxJK) {
		if(UAWzVSxJK != undefined && UAWzVSxJK.length > 0){
			andizxc(UAWzVSxJK).each(function (UAQFJslXzA) {
				if(andiUA.UAyrJYN(UAWzVSxJK[UAQFJslXzA].UAgGbGIdPy,UAWzVSxJK[UAQFJslXzA].UAYrWQNxMo)){
					andizxc(UAWzVSxJK[UAQFJslXzA].UAQqhEF).attr({ "role": "article" });
					var UAjLdxmGa = andizxc(UAWzVSxJK[UAQFJslXzA].UAQqhEF);
					andizxc(UAjLdxmGa).each(function(TUAj){
						andiUA.UAZyAJA(this);
					});
						
					var UAPGQXPKu = andiUA.UAillQtC.UAnCugs;
					andizxc(UAWzVSxJK[UAQFJslXzA].UAQqhEF).each(function (TUAj) {
						andiUA.UAWoexk(UAPGQXPKu, this);
					});
				}
			});
		}
	}

		andiUA.UAZyAJA = function(UAZtXFSId){
		if(   !andizxc(UAZtXFSId).is('[andialreadysetasreadmorelink]') ){
			var UAXKngnFPl = '';
			var ANDIUAVNVOWoTl = andizxc(UAZtXFSId).find(andiUA.UAillQtC.UAnCugs);
			var UAiVxbFQOndex  = 0;
			andizxc(ANDIUAVNVOWoTl).each(function(UAiVxbFQO){
				UAXKngnFPl = andizxc(this).text().trim();
				if(UAXKngnFPl != ''){
					return false;
				}
			});
			if(UAXKngnFPl != ''){
				if (andizxc(UAZtXFSId).find(andiUA.UAillQtC.UADvBcdn).last().attr('title') != undefined && andizxc(UAZtXFSId).find('a').last().attr('title').trim() != '') {
				   andizxc(UAZtXFSId).find(andiUA.UAillQtC.UADvBcdn).last().attr('title', andizxc(UAZtXFSId).find('a').last().attr('title').trim() +' ' + UAXKngnFPl);
				} else{						
					 andizxc(UAZtXFSId).find('a').last().attr('title', UAXKngnFPl);
				}
			}
			andizxc(UAZtXFSId).attr('andialreadysetasreadmorelink', 'true');
		}
	}
	
	andiUA.UAWoexk = function(UAPGQXPKu , UAZtXFSId){
		var UAtkMiJadU = andizxc(UAZtXFSId).find('img');
		andizxc(UAtkMiJadU).each(function (UAQFJslXzA) {
			if(!andizxc(this).is('[UAyvRRqUzT]') ){
				if ( andizxc(this).attr('alt') == undefined || andizxc.trim(andizxc(this).attr('alt')) == '' ) {
					var UAdYYsmgQk = UAQFJslXzA;
					var UAAifarrW = andizxc(this).closest('[role="article"]').find(UAPGQXPKu);
					if (UAAifarrW != undefined && UAAifarrW.length > 0) {
						andizxc(this).attr({ 'alt': andizxc(UAAifarrW).first().text() });
					} else {
						UAAifarrW = andizxc(UAZtXFSId).find(UAPGQXPKu);
						var UAqMdVysU = this;
						var UAPwPBKKJ = andizxc(UAZtXFSId).find('*');
						var UAvYxOOlt = andizxc.inArray(UAqMdVysU, UAPwPBKKJ);
						var UAEdhfsF = false;
						for (var UAQFJslXzA = UAvYxOOlt; UAQFJslXzA >= 0; UAQFJslXzA--) {
							if (andizxc(UAPwPBKKJ[UAQFJslXzA]).is(UAPGQXPKu)) {
								andizxc(UAqMdVysU).attr({'UAyvRRqUzT':'true', 'alt': andizxc(UAPwPBKKJ[UAQFJslXzA]).text() +andiUA.UAkwBrKq.UAKgAEzp +(1+UAdYYsmgQk)});
								UAEdhfsF = true;
								break;
							}
						}
						if (!UAEdhfsF) {
							var UAAifarrW = andizxc(this).nextAll(UAPGQXPKu);
							if (UAAifarrW != undefined && UAAifarrW.length > 0) {
								andizxc(this).attr({ 'UAyvRRqUzT':'true','alt': andizxc(UAAifarrW).first().text() });
							} else {
								UAAifarrW = andizxc(UAZtXFSId).find(UAPGQXPKu);
								var UAqMdVysU = this;
								var UAPwPBKKJ = andizxc(UAZtXFSId).find('*');
								var UAvYxOOlt = andizxc.inArray(UAqMdVysU, UAPwPBKKJ);
								var UAEdhfsF = false;
								for (var UAQFJslXzA = UAvYxOOlt; UAQFJslXzA < UAPwPBKKJ.length; UAQFJslXzA++) {
									if (andizxc(UAPwPBKKJ[UAQFJslXzA]).is(UAPGQXPKu)) {
										andizxc(UAqMdVysU).attr({'UAyvRRqUzT':'true', 'alt': andizxc(UAPwPBKKJ[UAQFJslXzA]).text()+' '+andiUA.UAkwBrKq.UAKgAEzp+' ' +(1+UAdYYsmgQk)});
										UAEdhfsF = true;
										break;
									}
								}
							}
						}
					}
				}
			}	
		});
	}
	
	andiUA.UAVJBOrX = function  (UAsMeoDwOL){
		if(UAsMeoDwOL != undefined && UAsMeoDwOL.length > 0){
			
			setInterval(function(){
				for(var UAQFJslXzA = 0; UAQFJslXzA < UAsMeoDwOL.length; UAQFJslXzA++ ){
					if(andiUA.UAyrJYN(UAsMeoDwOL[UAQFJslXzA].UAgGbGIdPy,UAsMeoDwOL[UAQFJslXzA].UAYrWQNxMo)){
						UADXFzJXfw = UAsMeoDwOL[UAQFJslXzA].UADXFzJXfw;
						UApEjDUrC = UAsMeoDwOL[UAQFJslXzA].UApEjDUrC;		
							andiUA.UARuffSs(UADXFzJXfw, UApEjDUrC);
					
					}
				}
			},1000);
		}
	}
	
	andiUA.UARuffSs = function (UADXFzJXfw, UApEjDUrC){
		setTimeout(function(){
			UAheLqhurElement = document.activeElement;
			andizxc(UADXFzJXfw).each(function(){
				var UAeqQVbcIK = andizxc(this);
				if( andizxc(UAeqQVbcIK).css('display') != 'none' && andizxc(UAeqQVbcIK).css('visibility') != 'hidden' ){
					
					if(andizxc(UAeqQVbcIK).find('.andiFirstItemInPopUp').length == 0){
						andizxc(UAeqQVbcIK).prepend('<div class="andiFirstItemInPopUp" tabindex="0" role="dialog" aria-label="'+andiUA.UAkwBrKq.UAQQpArmF+'"> </div>');
						andizxc(UAeqQVbcIK).append('<div class="andiLastItemInPopUp" tabindex="0" aria-label="'+andiUA.UAkwBrKq.UApnnOhMBQ+'"> </div>');
						andizxc(UAeqQVbcIK).find('.andiFirstItemInPopUp').focus();
						andizxc(document).on('focus','.andiLastItemInPopUp',function(){
							andizxc(UAeqQVbcIK).find('.andiFirstItemInPopUp').focus();
						});
					}
				}
			});
			andizxc(UApEjDUrC).attr({'tabindex':'0','role':'button','aria-label': andiUA.UAkwBrKq.UAlweMnIM});
			andizxc(UApEjDUrC).on('keydown',function(UAeZhAzmIV){
				var keyCode = UAeZhAzmIV.keyCode || UAeZhAzmIV.which;   
				if(keyCode == 13){
					andizxc(this).click();
					setTimeout(function(){
						andizxc('.andiFirstItemInPopUp').remove();
						andizxc('.andiLastItemInPopUp').remove();
						if(UAheLqhurElement != undefined){
							andizxc(UAheLqhurElement).focus();
						}
					},200)
				} 
			});
		},800);
		
		andizxc(document).on('focusin','.andiLastItemInPopUp',function(){
			andizxc('.andiFirstItemInPopUp').focus();
		});
		
		andizxc(document).on('keydown',function(UAeZhAzmIV){
			if(UAeZhAzmIV.keyCode == 27){
				andizxc(UApEjDUrC).click();
				setTimeout(function(){
					andizxc('.andiFirstItemInPopUp').remove();
					andizxc('.andiLastItemInPopUp').remove();
					if(UAheLqhurElement != undefined){
						andizxc(UAheLqhurElement).focus();
					}
				},200)
				
			}
		}); 
	}

   andiUA.UAiLbnOw = function (UAiLbnOw) {
		if(UAiLbnOw != undefined && UAiLbnOw.length > 0){
			if (!sessionStorage.UAiLbnOw) {
				setTimeout(function () {
					var UAkwBrKq = andiUA.UAYTbIL();
					if (UAkwBrKq == 'he') {
						andizxc('body').prepend('<p role="alert" tabindex="0" style="position: absolute; overflow: hidden; clip: rect(0 0 0 0);height: 1px;width: 1px;">' + UAiLbnOw.he.UAiLbnOw + '</p>');
					}
					if (UAkwBrKq == 'en') {
						andiUA.UAYWotT(UAiLbnOw.en.UAiLbnOw);
					}
					sessionStorage.UAiLbnOw = 1;
				}, UAiLbnOw.UAowUdLUDy);
			}
		}
    }


   andiUA.UAAqQEEmbi = function (UAxawDZ) {
	   if(UAxawDZ != undefined && UAxawDZ.length > 0){
        var  UAesMIACHb = andiUA.UAxLATvj;
        if (UAxawDZ != undefined) {
            andizxc(UAxawDZ).each(function (UAQFJslXzA) {
				if(andiUA.UAyrJYN(UAxawDZ[UAQFJslXzA].UAgGbGIdPy,UAxawDZ[UAQFJslXzA].UAYrWQNxMo)){
                var linkNum = UAQFJslXzA;
                andizxc(UAxawDZ[UAQFJslXzA].UAZYoMtW).focus(function () {
                    var UAGxQyvudh = this;
                    var UAtQmVDA = andizxc.inArray(this, andizxc(UAxawDZ[UAQFJslXzA].UAZYoMtW));
                    var UAfMtSbxwp = andizxc(UAxawDZ[UAQFJslXzA].UAuUoeya);
                    andizxc(UAfMtSbxwp[UAtQmVDA]).click(function () {
                        andizxc('.UAQCoXOzrCndienterTabContentBtn').remove();
                        andizxc(UAfMtSbxwp[UAtQmVDA]).css({ 'position': 'relative' }).append('<div tabindex="0" role="button" title="' + andiUA.UAkwBrKq.UAzlRlGmF + '" class="UAQCoXOzrCndienterTabContentBtn"></div>');
                        andizxc('.UAQCoXOzrCndienterTabContentBtn').css({ 'padding': '0', 'margin': '0', 'z-index': '999', 'width': '20px', 'height': '20px', 'background-color': 'transparent', 'border': 'none', 'background-repeat': 'no-repeat', 'background-position': '100% 100%', 'background-image': 'url(' + UAesMIACHb.UAQMModB + ')', 'position': 'absolute', 'background-size': '100%', 'top': UAxawDZ[UAQFJslXzA].UAlNNZr, 'left': UAxawDZ[UAQFJslXzA].UAlrpelB });
                        andizxc('.UAQCoXOzrCndienterTabContentBtn').click(function () {
                            andizxc(UAxawDZ[UAQFJslXzA].UAWQlKOx[UAtQmVDA]).css({ 'display': 'block', 'position': 'relative' }).attr({ 'tabindex': '0' }).focus();
                            andizxc(UAxawDZ[UAQFJslXzA].UAngsCPj).append('<div tabindex="0" role="button" title="' + andiUA.UAkwBrKq.UAgupoeRYd + '" class="UAgupoeRYd"></div>');
                            andizxc('.UAgupoeRYd').css({ '-ms-transform': ' rotate(180deg)', '-o-transform': ' rotate(180deg)', '-webkit-transform:': ' rotate(180deg)', '-moz-transform': ' rotate(180deg)', 'padding': '0', 'margin': '0', 'z-index': '999', 'width': '40px', 'height': '15px', 'background-color': 'transparent', 'border': 'none', 'background-repeat': 'no-repeat', 'background-position': '50% 50%', 'background-size': '50% 50%', 'background-image': 'url(' + UAesMIACHb.UAQMModB + ')', 'position': 'absolute', 'bottom': '10px' }).click(function () {
                                andizxc(UAGxQyvudh).focus();
                            }).keydown(function (UAeZhAzmIV) {
                                var keyCode = UAeZhAzmIV.keyCode || UAeZhAzmIV.which;
                                if (keyCode == 13) {
                                    andizxc(this).click();
                                }
                            });
                            andiUA.UAvVKiO(andiUA.UAillQtC.UAGYPtkiS);
                        }).keydown(function (UAeZhAzmIV) {
                            var keyCode = UAeZhAzmIV.keyCode || UAeZhAzmIV.which;
                            if (keyCode == 13) {
                                andizxc(this).click();
                            }
                        });
                        andiUA.UAvVKiO(andiUA.UAillQtC.UAGYPtkiS);
                    });
                    if (UAtQmVDA == 0) {
                        andizxc(UAGxQyvudh).click();
                    }
                });
				}
            });
        }
	   }
    }

    andiUA.UAdTtKSNgL = function (UAdTtKSNgL) {
		if(UAdTtKSNgL != undefined && UAdTtKSNgL.length > 0){
            setTimeout(function () {
                andizxc(UAdTtKSNgL).each(function (UAQFJslXzA) {
      if(andiUA.UAyrJYN(UAdTtKSNgL[UAQFJslXzA].UAgGbGIdPy,UAdTtKSNgL[UAQFJslXzA].UAYrWQNxMo)){
					
                    var month = (UAdTtKSNgL[UAQFJslXzA].UAiGtVq);
                    month = andizxc.trim(andizxc(month).text());
                    andizxc(UAdTtKSNgL[UAQFJslXzA].UAqBiufU).each(function () {
                        andizxc(this).attr({ 'role': 'dialog', 'aria-label': andizxc.trim(andizxc(this).text()) + ' ' + month });
                    });
                    andizxc(UAdTtKSNgL[UAQFJslXzA].UAiGayQp).each(function (TUAj) {
                        var eventText = andizxc.trim(andizxc(this).attr('title'));
                        andizxc(this).attr({
                            'role': 'dialog',
                            'aria-label': andizxc.trim(andizxc(this).text()) + ' ' + month + ' ' + eventText
                        });
                    });
                    andizxc(UAdTtKSNgL[UAQFJslXzA].UAcBTXjB).attr({ 'title': andiUA.UAkwBrKq.UAWreFSi, 'role': 'button', 'tabindex': '0' });
                    andizxc(UAdTtKSNgL[UAQFJslXzA].UAOxaTt).attr({ 'title': andiUA.UAkwBrKq.UAknbzCShV, 'role': 'button', 'tabindex': '0' });
				  }
				});
            }, UAdTtKSNgL.UAWbsmtDtU);
        
		}
    }

	andiUA.UALxyJaVt = function (UALxyJaVt){
		if(UALxyJaVt != undefined && UALxyJaVt.length > 0){
			andizxc(UALxyJaVt).each(function(TUAj){
				var UAFdROw = UALxyJaVt[TUAj].UAFdROw
				var UATflNKSZL = UALxyJaVt[TUAj].UATflNKSZL
				if(UAFdROw != null){
					andizxc(UATflNKSZL).each(function(UAQFJslXzA){
						var UAcEZIxPJk = window.innerWidth;
						if(UAFdROw >= UAcEZIxPJk){
							andizxc(UATflNKSZL).find('*').each(function(){
								andizxc(this).attr({'tabindex':'-1','aria-hidden':'true'});
							})
						}
					});
				}
			});
		}
	}
		
	andiUA.UAqbCsqYf = function (UADRvIkEWO,UANlOSZtZ){
		if(UADRvIkEWO != undefined){
			var UAqswydxsW = document.querySelectorAll(UADRvIkEWO);
			for(var UAQFJslXzA = 0; UAQFJslXzA < UAqswydxsW.length;UAQFJslXzA++){
				UAqswydxsW[UAQFJslXzA].setAttribute('aria-checked','true');
			}
		}
		if(UANlOSZtZ != undefined){
			var UAqswydxsW = document.querySelectorAll(UANlOSZtZ);
			for(var UAQFJslXzA = 0; UAQFJslXzA < UAqswydxsW.length;UAQFJslXzA++){
				UAqswydxsW[UAQFJslXzA].setAttribute('aria-checked','false');
			}
		}
	}
				
	andiUA.UANFcMGCHzVzNfHe = function(UANFcMGCHzVzNfHe){
		if(UANFcMGCHzVzNfHe != undefined && UANFcMGCHzVzNfHe.length > 0){
		andizxc(UANFcMGCHzVzNfHe).each(function(TUAj){
			if(andiUA.UAyrJYN(UANFcMGCHzVzNfHe[TUAj].UAgGbGIdPy,UANFcMGCHzVzNfHe[TUAj].UAYrWQNxMo)){
			var UAIwOPvdX = UANFcMGCHzVzNfHe[TUAj].UAIwOPvdX;
			var UABEHmB = UANFcMGCHzVzNfHe[TUAj].UABEHmB;
			var UASKhXyPwq = UANFcMGCHzVzNfHe[TUAj].UASKhXyPwq;
			var $UAIwOPvdX = andizxc(UAIwOPvdX),
			$UABEHmB = andizxc(UABEHmB);
			
			andiUA.UAkicGaQ(UAIwOPvdX,$UABEHmB);
			$UAIwOPvdX.each(function(UAQFJslXzA){
				var $UAeqQVbcIK = andizxc(this);
				$UAeqQVbcIK.attr({'aria-label':andiUA.UAkwBrKq.UAEiDdu+$UAeqQVbcIK.text(),'role':'button','tabindex':'0'}).click(function(){
					andiUA.UAkicGaQ(UAIwOPvdX,$UABEHmB)
				});
				if(!UASKhXyPwq){
					$UAeqQVbcIK.attr({'andialreadysetasbtn':'true'});
				}
			});
		
			andizxc('iframe').each(function(UAQFJslXzA){
				try{
					var UAQCoXOzrC = andizxc(this);
					var $UAIwOPvdX = andizxc(UAQCoXOzrC).contents().find(UAIwOPvdX),
					$UABEHmB = andizxc(UAQCoXOzrC).contents().find(UABEHmB);
					andiUA.UAkicGaQ(UAIwOPvdX,$UABEHmB);
					$UAIwOPvdX.each(function(UAQFJslXzA){
						var $UAeqQVbcIK = andizxc(this);
						$UAeqQVbcIK.attr({'aria-label':andiUA.UAkwBrKq.UAEiDdu + $UAeqQVbcIK.text(),'role':'button','tabindex':'0'}).click(function(){
							andiUA.UAkicGaQ(UAIwOPvdX,$UABEHmB)
						});
						if(!UASKhXyPwq){
							$UAeqQVbcIK.attr({'andialreadysetasbtn':'true'});
						}
					});			
				} catch(ANDIUADYzBx) {
					if(andiUA.UAillQtC.UAwoFuMbS)console.log("UADYzBxor: "+ANDIUADYzBx);
				}
			});
			}
		});
		}
	}
	
	andiUA.UAkicGaQ = function (UAIwOPvdX,$UABEHmB){
		$UABEHmB.each(function(UAQFJslXzA){
			var $UAeqQVbcIK = andizxc(this);
			var UAIwOPvdXs = andizxc(UAIwOPvdX);
			if($UAeqQVbcIK.attr('id') != undefined && $UAeqQVbcIK.attr('id') != '' ){
				andizxc(UAIwOPvdXs[UAQFJslXzA]).attr({'aria-controls':$UAeqQVbcIK.attr('id')});
			}
			if(!$UAeqQVbcIK.UAFPNhTLpA2()){
				if($UAeqQVbcIK.attr('id') != undefined && $UAeqQVbcIK.attr('id') != '' ){
					$UAeqQVbcIK.attr({'aria-expanded':'true'});
				} else {
					andizxc(UAIwOPvdXs[UAQFJslXzA]).attr({'aria-expanded':'true'});
				}
			} else {
				if($UAeqQVbcIK.attr('id') != undefined && $UAeqQVbcIK.attr('id') != '' ){ 
					$UAeqQVbcIK.attr({'aria-expanded':'false'});
				} else {
					andizxc(UAIwOPvdXs[UAQFJslXzA]).attr({'aria-expanded':'false'});
				}
			}
		});
	}

	andiUA.UAClsWRHreadcrumbs = function(UAClsWRHreadcrumbs){
		if(UAClsWRHreadcrumbs != undefined && UAClsWRHreadcrumbs.length > 0){
			andizxc(UAClsWRHreadcrumbs).each(function(UAQFJslXzA){
				if(andiUA.UAyrJYN(UAClsWRHreadcrumbs[UAQFJslXzA].UAgGbGIdPy,UAClsWRHreadcrumbs[UAQFJslXzA].UAYrWQNxMo)){
				andizxc(UAClsWRHreadcrumbs[UAQFJslXzA].UAhxzRPzQ).find('a').each(function(TUAj){
					if(TUAj == 0){
						andizxc(this).attr({'role':'link','aria-label':andiUA.UAkwBrKq.UABkyIrctr});
					} else {
						andizxc(this).attr({'role':'link','aria-label':andiUA.UAkwBrKq.UAwFkYSXUl + andizxc(this).text()})
					}
				});
				var UAZeQczCV = andizxc(UAClsWRHreadcrumbs[UAQFJslXzA].UAhxzRPzQ).find('a').last().parent().next();
				andizxc(UAZeQczCV).attr({'aria-label':andiUA.UAkwBrKq.UAnRvgmqR + andizxc(UAZeQczCV).text()})
			}
			});
		}
	}
	
			
	andiUA.UAGcFcePmZageNavigation = function (UAlgbjSsf){
		if(UAlgbjSsf != undefined && UAlgbjSsf.length > 0){
			andizxc(UAlgbjSsf).each(function(UAQFJslXzA){
				if(andiUA.UAyrJYN(UAlgbjSsf[UAQFJslXzA].UAgGbGIdPy,UAlgbjSsf[UAQFJslXzA].UAYrWQNxMo)){
				if(UAlgbjSsf[UAQFJslXzA].UAPhHti != ''){	
					UAPhHti = UAlgbjSsf[UAQFJslXzA].UAPhHti
					UAeMYNb = UAlgbjSsf[UAQFJslXzA].UAeMYNb;
					UAURxvZrAo = UAlgbjSsf[UAQFJslXzA].UAURxvZrAo;
					UAHOsyIHj = UAlgbjSsf[UAQFJslXzA].UAHOsyIHj;
					UAqfmjL = UAlgbjSsf[UAQFJslXzA].UAqfmjL;
					UAGdUpBZR = UAlgbjSsf[UAQFJslXzA].UAGdUpBZR;
					UATcYxsk = UAlgbjSsf[UAQFJslXzA].UATcYxsk;
					andizxc(UAPhHti).each(function(TUAj){
						var $UAeqQVbcIK = andizxc(this);
						$UAeqQVbcIK.find(UAURxvZrAo).each(function(){
							andizxc(this).attr({'title':andiUA.UAkwBrKq.UAURxvZrAo + andizxc(this).text()  });
						});
						$UAeqQVbcIK.find(UAeMYNb).attr({'title':andiUA.UAkwBrKq.UAeMYNb +$UAeqQVbcIK.find(UAeMYNb).text()});
						$UAeqQVbcIK.find(UAHOsyIHj).attr({'title':andiUA.UAkwBrKq.UAHOsyIHj});
						$UAeqQVbcIK.find(UAqfmjL).attr({'title':andiUA.UAkwBrKq.UAqfmjL});
						$UAeqQVbcIK.find(UAGdUpBZR).attr({'title':andiUA.UAkwBrKq.UAGdUpBZR});
						$UAeqQVbcIK.find(UATcYxsk).attr({'title':andiUA.UAkwBrKq.UATcYxsk});
						
					});
				}
				}
			});
		}
	}

	andiUA.UAlMsfQ = function (){
		andizxc('.UAfVJtJET').css({
			"width":window.innerWidth,
			"height":window.innerHeight
		});
		var a = (parseInt(andizxc(window).width()*0.8));
		var b = (parseInt(andizxc('body').css('margin-left')));
		var c = (parseInt(andizxc('body').css('margin-right')));
		andizxc('.UAuatdI').css({
			"width":(a - c),
			"height":(window.innerHeight)*0.8,
			"margin-top": window.innerHeight *0.1 ,
			"margin-right": ((andizxc(window).width()*0.1)),
			"margin-left": ((andizxc(window).width()*0.1))
		});
	};


	andiUA.UAJuMaPY = function (UAkemrqle, data, whereToGoBackAfterClose){		
		whereToGoBackAfterClose = whereToGoBackAfterClose || undefined;
		var UAKlknoMsS = andiUA.UAkwBrKq
		andizxc('body').prepend('<div class=" UAfVJtJET"></div>');
		var UAnfIgiTe = andizxc('html').attr('UATjrAo');
		andizxc('.UAfVJtJET').prepend('<div class=" UAuatdI" tabindex="0"><input type="image" src="'+ andiUA.UAYLjzAwX.UAITisIWtw+'" id="UAEqInHCn" alt="'+ andiUA.UAkwBrKq.UAORzYbOq+'" aria-label=""/></div>');
		andizxc('.UAuatdI').append('<div class=" UAuatdIFirstFocus" aria-label="'+ andiUA.UAkwBrKq.UAQQpArmF+'" role="alert" tabindex="0"></div>');
		andizxc('.UAuatdI').append( data );
		andizxc('.UAuatdI').wrapInner('<div tabindex="0" class=" "></div>')
		andizxc('.UAuatdI').append('<div class=" UAuatdILastFocus" tabindex="0"></div>');
		andizxc('.UAuatdI').append('<div class=" UApnnOhMBQ" aria-label="'+ andiUA.UAkwBrKq.UApnnOhMBQ+'" role="alert" tabindex="0"></div>');
		andiUA.UAlMsfQ();

		
		window.addEventListener('resize', function(){ andiUA.UAlMsfQ(); });
		andizxc('.UAuatdIFirstFocus').focus();
		andizxc('.UAuatdILastFocus').focus(function(){
			andizxc('#UAEqInHCn').focus();
		});
		
		andizxc('#UAEqInHCn').click(function(){
			andizxc('.UAfVJtJET').remove();
			andizxc('#UAZIyvFVR').remove();
			andizxc(UAkemrqle).focus();
			andiUA.UAYWotT(UAKlknoMsS.UAlweMnIM);
		});
		andizxc(document).keydown(function(e) {
			if ( e.keyCode == 27 ) {
				andizxc('.UAfVJtJET').remove();
				andizxc('#UAZIyvFVR').remove();
				andizxc(UAkemrqle).focus();
				andiUA.UAYWotT(UAKlknoMsS.UAlweMnIM);
				if (whereToGoBackAfterClose != undefined){
					andizxc(whereToGoBackAfterClose).focus();
				}
			}
		});
		
	};

	
	andiUA.diffrentLayoutForMenus = function(wrapMenu,ANDIbuttonPut){
		
		var wrapMenu = wrapMenu ;
		var ANDIbuttonPut = ANDIbuttonPut ;
		if(andizxc('#diffrentLayoutForMenusStyle').length == 0){
			var UAKZZMYJ  = localStorage.getItem("UAKZZMYJ"); 
		andizxc("head").append('<style id="diffrentLayoutForMenusStyle">#diffrentLayoutForMenus a:focus{outline:2px solid #000 !important;} #diffrentLayoutForMenus li {display:inline-block !important;} #diffrentLayoutForMenus h2{text-align:center;} #diffrentLayoutForMenus{margin: 0 auto !important; text-align:center;} #diffrentLayoutForMenus a { text-align: center !important; margin:5px !important;padding-top:25px !important; color:#fff !important; background-color:'+localStorage.getItem('UAKZZMYJ')+' !important; vertical-align:top !important; display:inline-block !important;height: 100px !important;width:100px !important;}</style>');
		}
		andizxc(ANDIbuttonPut).prepend('<button class="UAPLREqOKa" id="diffrentLayoutForMenusBtn">'+andiUA.UAkwBrKq.UAXKngnFPl2161+'</button>');// element where menu button were exist
		andizxc('#diffrentLayoutForMenusBtn').click(function(){
			opendiffrentLayoutForMenusBtn(wrapMenu);
		});

		function opendiffrentLayoutForMenusBtn(wrapMenu){
			wrapMenu += ' a';
			var text = ('<div id="diffrentLayoutForMenus"><h2>'+andiUA.UAkwBrKq.UAXKngnFPl2160+'</h2><ul></ul></div>');
			andiUA.UAJuMaPY('#diffrentLayoutForMenusBtn',text);
			andizxc( wrapMenu ).clone().appendTo( "#diffrentLayoutForMenus > ul" );
			andizxc( "#diffrentLayoutForMenus > ul a" ).each(function(){	
				andizxc(this).attr('tabindex','0').wrap( "<li></li>" );
			});
			var UAnfIgiTe = andizxc('html').attr('UATjrAo');
			if(UAnfIgiTe == 'rtl'){
				andizxc('.UAfVJtJET').css({'text-align':'right'});
				andizxc('#UAEicuU, #UAEicuU *').attr({'dir':UAnfIgiTe});
				andizxc('#UAEqInHCn').css({'left':'50px', 'position': 'fixed','top': '24px','z-index': '999999999999999999'}); 
				andizxc('#UACETmip').css({'text-align':'right'});

			} else {
				andizxc('.UAfVJtJET').css({'text-align':'left'});
				andizxc('#UAEicuU, #UAEicuU *').attr({'dir':UAnfIgiTe});
				andizxc('#UAEqInHCn').css({'width':'35px','right':'50px', 'position': 'fixed','top': '24px','z-index': '999999999999999999'});
				andizxc('#UACETmip').css({'text-align':'left'});
			}
			andizxc( "#diffrentLayoutForMenus > ul a" ).first().focus();
		}
	}
	
	
	
	andiUA.UAillQtC.UApNBqikB.forEach(function(el) {
	  // whatever with the current node
	  andiUA.diffrentLayoutForMenus(el.UAyyDqJhu,el.UAyyDqJhu);
	});

		
	andiUA.UATVtWzwR = function(UAUaDLh){
		UAcQgFNGdu = new Array(UAUaDLh.length);
		UAiGYaT = new Array(UAUaDLh.length);
		UABCoLUn = new Array(UAUaDLh.length);
		UAfkhBakgM = new Array(UAUaDLh.length);
		UAEKHvC = new Array(UAUaDLh.length);
		UAbVKHSLM = new Array(UAUaDLh.length);
		HTMLUAYPQUDCzThatChange = new Array(UAUaDLh.length);
		UAIvdFIAEengthHtml = new Array(UAUaDLh.length);
		UAIvdFIAEengthUARIvkQI = new Array(UAUaDLh.length);
		UAIvdFIAEengthAllNewUAYPQUDCz = new Array(UAUaDLh.length);
		for (var UAiVxbFQO = 0; UAiVxbFQO < HTMLUAYPQUDCzThatChange.length; UAiVxbFQO++) {
			HTMLUAYPQUDCzThatChange[UAiVxbFQO] = [];
		}
		UAQFJslXzAsChangeMade = new Array(UAUaDLh.length);
		
		andizxc(UAUaDLh).each(function(UAQFJslXzA){
			if(UAUaDLh[UAQFJslXzA].UAcyoXfHVP != '' && andizxc(UAUaDLh[UAQFJslXzA].UAcyoXfHVP).length > 0){
				UAbVKHSLM[UAQFJslXzA] = 0;
				UABCoLUn[UAQFJslXzA] = new Date();
				var UAkiJbT = andizxc(UAUaDLh[UAQFJslXzA].UAcyoXfHVP);
				andizxc(UAkiJbT).bind('DOMNodeInserted', function(UAeZhAzmIV) {
					var andiElement = UAeZhAzmIV.target;
					if(	andiElement.UAgkZYHhdu && andizxc('#UAJuDPzI').length == 0 && !andizxc(andiElement).is('#UAkTZTWU * ,[id^=UAvJjJg] *, [id^=UAvJjJg], #UAbczwv * ,#UAHMbcBkPL , script ,meta,link,html, head,style , .UAxnXSd')){
					UAbVKHSLM[UAQFJslXzA]++;
					UABCoLUn[UAQFJslXzA] = new Date();
					//HTMLUAYPQUDCzThatChange[UAQFJslXzA].push(andiElement);
					
					var UAyijGOF = parseInt(window.getComputedStyle(andiElement, null).getPropertyValue("font-size"));
					var UAjWhFlQZWhiteSpace = window.getComputedStyle(andiElement, null).getPropertyValue("white-space");
					var UAjWhFlQZlineHeight = window.getComputedStyle(andiElement, null).getPropertyValue("line-height");
					andiElement.setAttribute("UATHdfS", UAyijGOF);
					andiElement.setAttribute("UAsHKEDhiteSpace", UAjWhFlQZWhiteSpace);
					andiElement.setAttribute("UAIvdFIAEineHeight", UAjWhFlQZlineHeight);
					if (andiElement.hasAttribute("style")) {
						andiElement.setAttribute("UAEdsxTgu", andiElement.style.cssText);
					}
					
					
					}
				});
				andiUA.UAkobqJS(UAkiJbT, UAQFJslXzA );
			}
			
		});	
	}

	andiUA.UAkobqJS = function(UAkiJbT, UAtrRPuOFP ){		
		UAcQgFNGdu[UAtrRPuOFP] = 0;
		var ANDIb = 0;
		timeTorun = 0;
		UAQFJslXzAsChangeMade[UAtrRPuOFP] = false;	
		UAfkhBakgM[UAtrRPuOFP] = setInterval(function(){
			if( UAbVKHSLM[UAtrRPuOFP] > 1000){
				UAbVKHSLM[UAtrRPuOFP] = 0;
			}
			UAEKHvC[UAtrRPuOFP] = new Date();
			if (UAcQgFNGdu[UAtrRPuOFP] != UAbVKHSLM[UAtrRPuOFP] ){
				var UAXqQMWN = UAbdQGrbC(UABCoLUn[UAtrRPuOFP],UAEKHvC[UAtrRPuOFP] ); //חישוב הפער בזמנים : הזמן כרגע מול הזמן שגילינו את השינוי
				if(UAXqQMWN < 3050){
					UAQFJslXzAsChangeMade[UAtrRPuOFP] = true;
				} else {
					UAQFJslXzAsChangeMade[UAtrRPuOFP] = false;
				}
				
				if( (UAXqQMWN > 2000 && UAXqQMWN < 3030) && (UAQFJslXzAsChangeMade[UAtrRPuOFP] == true )){
					 // מריצים את כל הבדיקות של הנגישות מפעילים בהתאם
					UAcQgFNGdu[UAtrRPuOFP] = UAbVKHSLM[UAtrRPuOFP]; // מעדכנים את השינוי בתוך UAcQgFNGdu[UAtrRPuOFP]  כך בריצה הבאה של הבדיקות נוכל לדעת האם בוצע שינוי נוסף.
					HTMLUAYPQUDCzThatChange[UAtrRPuOFP].length = 0;
					
							
        if(timeTorun < 5){
          timeTorun++;
          andiUA.UApFveN(HTMLUAYPQUDCzThatChange[UAtrRPuOFP]);
        } else if(localStorage.getItem("askForNewContentAccessiblie") == 'null' && localStorage.getItem("askForNewContentAccessiblie") == null){
          if(andizxc('.askForNewContentAccessiblie').length === 0 ){
            var thisCurrFocusElm = document.activeElement;
            var UAwhXdJkW = document.querySelector("head").innerHTML.indexOf("UA2StyleSheetLTR") > -1 ? false : true;
            var UALNPBloC = false;
            var UAtGqkpI = "z-index:99999999999;"+ (UAwhXdJkW ?  "right": "left") + ": 7px;display:block; border-radius:5px; margin:10px;background-color: rgba(0, 0, 0, 0.65);height:auto;box-sizing:border-box;text-align:" + (UAwhXdJkW ? "right" : "left") + " ; width:360px;padding: 23px 20px 10px;;position:fixed;color:#fff !important ;bottom:0";
            var UAYczxZ = "";
            var UAwTnZpZ = "z-index:99999999999;width: 25px;   position: absolute; top: 8px; " + (UAwhXdJkW ?  "right": "left") + ": 7px;cursor: pointer;";
            andizxc("#UAPtHya").append('<div role="dialog"  class="askForNewContentAccessiblie" id="UAnewVertion" style="' + UAtGqkpI + '">\
            <div style="' + UAYczxZ + '"></div><div id="askForNewContentAccessiblieLabel" style="font-size:14px;">' + andiUA.UAkwBrKq.bbb1+' '+ andiUA.UAkwBrKq.bbb2 + '</div>\
            <select id="askForNewContentAccessiblie" aria-labelledby="askForNewContentAccessiblieLabel" style="color: #000;">\
              <option value="0" style="color:#000">'+andiUA.UAkwBrKq.bbb12+'</option>\
              <option value="1" style="color:#000">'+andiUA.UAkwBrKq.bbb3+'</option>\
              <option value="4" style="color:#000">'+andiUA.UAkwBrKq.bbb7+'</option>\
              <option value="2" style="color:#000">'+andiUA.UAkwBrKq.bbb4+'</option>\
              <option value="3" style="color:#000">'+andiUA.UAkwBrKq.bbb5+'</option>\
            </select><div id="askForNewContentAccessiblieUpdateBtn" role="button" tabindex="0" style="color:#fff;background-color:transparent;border:1px solid #fff;margin:0 5px;padding: 5px;display: inline-block;cursor: pointer;" >'+andiUA.UAkwBrKq.bbb6+'</div>\
            <div  style="' + UAwTnZpZ + '" aria-label="' + andiUA.UAkwBrKq.UAXKngnFPl2159 + '" id="askForNewContentAccessiblieClsBtn" role="button" tabindex="0">X</div>\
            </div>');
            andizxc('#askForNewContentAccessiblie').attr('tabindex','0').focus();
            andizxc(document).on("click", "#askForNewContentAccessiblieClsBtn", function() {
              andizxc("#UAnewVertion").remove();
              thisCurrFocusElm.focus();
              sessionStorage.setItem("askForNewContentAccessiblie", "no");
              andiUA.UAYWotT(andiUA.UAkwBrKq.bbb9);
            });
            andizxc(document).on("blur", "#askForNewContentAccessiblieClsBtn", function() {
              askForNewContentAccessiblie.focus();
            });
            andizxc(document).on("click", "#askForNewContentAccessiblieUpdateBtn", function() {
              andizxc("#UAnewVertion").remove();
              thisCurrFocusElm.focus();
                andiUA.UAYWotT(andiUA.UAkwBrKq.bbb8);
                setTimeout(function(){
                  andiUA.UAYWotT(andiUA.UAkwBrKq.bbb10);
                },150);
            });
            andizxc(document).on("change", "#askForNewContentAccessiblie", function() {
              var UAvalue = andizxc(this).val();
              if(UAvalue == 1){
                sessionStorage.removeItem("askForNewContentAccessiblie");
                localStorage.setItem("askForNewContentAccessiblie", "yes");
                andiUA.UApFveN(HTMLUAYPQUDCzThatChange[UAtrRPuOFP]);
              } else if(UAvalue == 2){
                localStorage.removeItem("askForNewContentAccessiblie");
                sessionStorage.setItem("askForNewContentAccessiblie", "no");
              } else if(UAvalue == 4){
                localStorage.removeItem("askForNewContentAccessiblie");
                sessionStorage.setItem("askForNewContentAccessiblie", "no");	
                window.onbeforeunload = function() {
                  sessionStorage.removeItem("askForNewContentAccessiblie");
                }
                setTimeout(function(){
                  sessionStorage.removeItem("askForNewContentAccessiblie");
                },300000);
              } else {
                sessionStorage.removeItem("askForNewContentAccessiblie");
                localStorage.setItem("askForNewContentAccessiblie", "no");
              }
            });
            andizxc(document).on("keydown", "#askForNewContentAccessiblieUpdateBtn, #askForNewContentAccessiblieClsBtn", function(e) {
              if(e.keyCode == 13) this.click();
            });
          }
		}
		if(localStorage.getItem("askForNewContentAccessiblie") == 'yes'){
			andiUA.UApFveN(HTMLUAYPQUDCzThatChange[UAtrRPuOFP]);
		}
		
		
		
				}
			} else {
				UAQFJslXzAsChangeMade[UAtrRPuOFP] = false;
			}
			
			
		},1000);
		
		function UAbdQGrbC(UAQrfstpsBdateNow, UAQrfstpsBdateWhenChangehappend ) {
			UAQrfstpsBdateNow = UAQrfstpsBdateNow.getTime(); // המרה של מילישניות    //UAQrfstpsBdateNow = הזמן שבו גילינו שקרה שינוי
			UAQrfstpsBdateWhenChangehappend = UAQrfstpsBdateWhenChangehappend.getTime();// המרה של מילישניות     //UAQrfstpsBdateWhenChangehappend = הזמן העכשיווי
			var UAkRJKXAIimeDeff = UAQrfstpsBdateWhenChangehappend - UAQrfstpsBdateNow;
			return parseInt(UAkRJKXAIimeDeff);
		}

		
	}

	
	andiUA.UApFveN = function(newElems){
		andiUA.newElemsToMakeAccessible = newElems;
		andiUA.UARIWOwfdM++;
		 var n, a = [], walk = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false);
		while (n = walk.nextNode()) {
			var UAmKjiBHY = n.parentNode;
			var UAlqQAgXDd = n.data.trim();
			if ( !UAmKjiBHY.hasAttribute('andiruns') &&   UAlqQAgXDd !== "" && UAmKjiBHY.tagName !== "NOSCRIPT" && UAmKjiBHY.tagName !== "SCRIPT" && UAmKjiBHY.tagName !== "STYLE" && UAmKjiBHY.tagName !== "HEAD" && UAmKjiBHY.tagName !== "META" && UAmKjiBHY.tagName !== "LINK") {
				UAmKjiBHY.setAttribute("UAvGyiRT", "true");
				
				UAmKjiBHY.addAttr({'andiruns':andiUA.UARIWOwfdM});  
			}
		}
		/*andizxc('.UAzpLPmk').remove();
			andiUA.UATlqUog();
		*/
		
    andiUA.UATlqUog();
							
    andiUA.UAyAuAMT (andiUA.UAillQtC.UAyAuAMTSetting);
    andiUA.UAQrZhcR(andiUA.UAillQtC.UAAwJlJTva.UAFgPjN , andiUA.UAillQtC.UAAwJlJTva.UADfjOwFD);
    andiUA.UAwRdhK(andiUA.UAillQtC.UAAwJlJTva.UAFgPjN);
    andiUA.UADJtbe(andiUA.UAillQtC.UAWAyAp);
    andiUA.UAZcBEj(andiUA.UAillQtC.UAGoGVp);
    andiUA.UAiahKMgF();
    andiUA.UAFVxKpN(andiUA.UAillQtC.UAyemTynwK);
    andiUA.UATcpdVe();
    andiUA.UAfAhhffVt();
    andiUA.UAQXGSsiCs();
    andiUA.UAyXwKk();
    andiUA.UANmhFsyEu();
    andiUA.UAhkjFIwu(andiUA.UAillQtC.UAKEDQCa);
		setTimeout(function(){
			if (localStorage.getItem("UAgSPcoB") == "yes") {
				setTimeout(function(){
					if(!andiUA.UAsONdhY){
						var UAuFJrik = setInterval(function(){
							if(andiUA.UAsONdhY == true){
								clearInterval(UAuFJrik);
								andiUA.UAcmGxbTq('aaa');
							}
						},350);
					} else {
						andiUA.UAcmGxbTq('aaa');
					}
				},250);
			}
		},50);
		setTimeout(function(){
			if (localStorage.getItem("UANuQAGkig") == "yes") {
				if(!andiUA.UAsONdhY){
					var UAuFJrik = setInterval(function(){
						if(andiUA.UAsONdhY == true){
							clearInterval(UAuFJrik);
							var tepmPlusNum = localStorage.getItem("UATHdfSPlusClick");
							var tepmMinusNum = localStorage.getItem("UATHdfSMinusClick");
							var UAwxkIbdz = ( (parseFloat(tepmPlusNum)) - (parseFloat(tepmMinusNum)));
							andiUA.UAVTEnc(UAwxkIbdz, 'aaa');
						}
					},350);
				} else {
					var tepmPlusNum = localStorage.getItem("UATHdfSPlusClick");
					var tepmMinusNum = localStorage.getItem("UATHdfSMinusClick");
					var UAwxkIbdz = ( (parseFloat(tepmPlusNum)) - (parseFloat(tepmMinusNum)));
					andiUA.UAVTEnc(UAwxkIbdz, 'aaa');
				}
			}
		},100);
		setTimeout(function(){
			if (localStorage.getItem("UAyKVALE") == "yes") {
				if(!andiUA.UAsONdhY){
					var UAuFJrik = setInterval(function(){
						if(andiUA.UAsONdhY == true){
							clearInterval(UAuFJrik);
							var tepmPlusNum = localStorage.getItem("UATHdfSPlusClick");
							var tepmMinusNum = localStorage.getItem("UATHdfSMinusClick");
							var UAwxkIbdz = ( (parseFloat(tepmPlusNum)) - (parseFloat(tepmMinusNum)));
							andiUA.UAVTEnc(UAwxkIbdz, 'aaa');
						}
					},350);
				} else {
					var tepmPlusNum = localStorage.getItem("UATHdfSPlusClick");
					var tepmMinusNum = localStorage.getItem("UATHdfSMinusClick");
					var UAwxkIbdz = ( (parseFloat(tepmPlusNum)) - (parseFloat(tepmMinusNum)));
					andiUA.UAVTEnc(UAwxkIbdz, 'aaa');
				}
			}
		},150);
		
/*
		if (localStorage.getItem("UAQCoXOzrCndiFocusAreaBtn") == "yes") {
			if(!andiUA.UAWzqscoBL){
					var UAJVHGh = setInterval(function(){
					if(andiUA.UAWzqscoBL == true){
						clearInterval(UAJVHGh);
						var UAScxkvW = andiUA.UAillQtC.UAVjNBvMWa;
						andiUA.UAJdSObgZY(UAScxkvW);
						andiUA.UAEeUZaRNh(UAScxkvW);
					}
				},350);
			} else {
				var UAScxkvW = andiUA.UAillQtC.UAVjNBvMWa;
                andiUA.UAJdSObgZY(UAScxkvW);
                andiUA.UAEeUZaRNh(UAScxkvW);
			}
        }
		},50);
		setTimeout(function(){
		if (localStorage.getItem('UAQCoXOzrCndirasheTevot') == "yes") {
			if(!andiUA.UAuLtdxX){
				var UARZUYn = setInterval(function(){
					if(andiUA.UAuLtdxX == true){
						clearInterval(UARZUYn);
						andiUA.findAndReplaceDOMText2('[UAvGyiRT]');
					}
				},350);
			} else {
				andiUA.findAndReplaceDOMText2('[UAvGyiRT]');
			}
        }
		
		*/	
		
		setTimeout(function(){
			if (localStorage.getItem("UAoSkKzGxeviledHiddingInfo") == "yes") {		
				if(!andiUA.UAuLtdxX){
					var UARZUYn = setInterval(function(){
						if(andiUA.UAuLtdxX == true){
							clearInterval(UARZUYn);
							andiUA.UAYwhEGvReviledHiddingInfo();
							andiUA.UAftdSmetActiveReviledHiddingInfo('aaa')
						}
					},350);
				} else {
					andiUA.UAYwhEGvReviledHiddingInfo();
				}
			}
		},200);
		setTimeout(function(){
			var UAQRoijko = localStorage.getItem("UADjAjX1");
			if (UAQRoijko != null && UAQRoijko != '') {
				andiUA.UAOGVMqi(localStorage.getItem("UADjAjX1Color"),localStorage.getItem("UADjAjX1"),'aaa');
			}
		},250);
		setTimeout(function(){
			var UAQRoijko = localStorage.getItem("UADjAjX2");
			if (UAQRoijko != null && UAQRoijko != '') {
				andiUA.UAOGVMqi(localStorage.getItem("UADjAjX2Color"),localStorage.getItem("UADjAjX2"),'aaa');
			}
		},300);
		setTimeout(function(){
			var UAQRoijko = localStorage.getItem("UADjAjX3");
			if (UAQRoijko != null && UAQRoijko != '') {
				andiUA.UAOGVMqi(localStorage.getItem("UADjAjX3Color"),localStorage.getItem("UADjAjX3"),'aaa');
			}
		},330);
		setTimeout(function(){
			if (localStorage.getItem("UAKophgIo") == "yes") {
				andiUA.UAcndVW('black', 'aaa');
			}
		},360);
		setTimeout(function(){
			if (localStorage.getItem("UAsHKEDhiteContrast") == "yes") {
				andiUA.UAcndVW('white', 'aaa');
			}
		},390);
		
		setTimeout(function(){
			andiUA.UAUzkHlqqR();
		},410);
		setTimeout(function(){
			andiUA.UAbMHHUat();
		},440);
};


	andiUA.UAUzkHlqqR = function() {
		setTimeout(function(){
			andiUA.UADGDndNR(andiUA.UAillQtC.UAdVyFzlEN);
			andiUA.UAJdnqMVxj(andiUA.UAillQtC.UAJdnqMVxj);
			andiUA.UAFDjCj(andiUA.UAillQtC.UAMzmIeZf); 	
		},0);
		setTimeout(function(){
			andiUA.UAvVKiO(andiUA.UAillQtC.UAGYPtkiS);
		},30);
		setTimeout(function(){
			andiUA.UAVJBOrX(andiUA.UAillQtC.UAsMeoDwOL);
			andiUA.UAXJuZA(andiUA.UAillQtC.UAycFrPMm);
		},60);
		setTimeout(function(){
			andiUA.UAhkjFIwu(andiUA.UAillQtC.UAKEDQCa);
		},95);
	}
	
	andiUA.UAitmMtXX = function() {
		setTimeout(function(){
			andiUA.markTextLagn();
			andiUA.UAiLbnOw(andiUA.UAillQtC.UAiLbnOw);
			andiUA.UAogJrqlha(andiUA.UAillQtC.UAVjNBvMWa);
		},15);
		setTimeout(function(){
			andiUA.UALxyJaVt(andiUA.UAillQtC.UALxyJaVt );
			andiUA.UAClsWRHreadcrumbs(andiUA.UAillQtC.UAClsWRHreadcrumbs);
		},35);
		setTimeout(function(){
			andiUA.UApuhHga();
			andiUA.UAxpAEPU(andiUA.UAillQtC.UAmjOYdqf);
			andiUA.UAAqQEEmbi(andiUA.UAillQtC.UAxawDZ);
			andiUA.UAdTtKSNgL(andiUA.UAillQtC.UAdTtKSNgL);
		},70);
		setTimeout(function(){
			andiUA.UAsYHKFY(andiUA.UAillQtC.UAYOyiTs);
			andiUA.UANFcMGCHzVzNfHe(andiUA.UAillQtC.UANFcMGCHzVzNfHe);
			andiUA.UAGcFcePmZageNavigation (andiUA.UAillQtC.UAlgbjSsf);
			andiUA.UAXUnmUYbV();
		},100);
		setTimeout(function(){
			andiUA.UAbMHHUat();
		},120);
		setTimeout(function(){
			andiUA.UAuVwQwK();
			andiUA.UAhkjFIwu(andiUA.UAillQtC.UAKEDQCa);
		},135);
		//andiUA.UAFMZuNzX();
    }
	
    UAFvWMY = false;
	setTimeout(function(){
		andiUA.UAUzkHlqqR();
	},0);
	setTimeout(function(){
		andiUA.UAitmMtXX();
	},50);
	setTimeout(function(){
			andiUA.UATVtWzwR(andiUA.UAillQtC.UAUaDLh);
	},1500);
	
	
 } 
