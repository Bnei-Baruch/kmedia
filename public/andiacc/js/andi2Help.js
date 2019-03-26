if(andiUA.ANDIloadHelp){
			andiHelp = {};andiHelp.andiHelpArr = [{startdate:'2018-01-01',enddate:'2018-04-28',timetoswitch:10,andihelpSmalleLink:' http://gettecla.com',andihelpSmalleText:'take control of your device with your switches or wheelchair controls',andihelpSmalleSrcImg:'https://user-a.co.il/images/2018-01-15-22-59-10.tecla1.png',andihelpMediumLink:'https://user-a.co.il',andihelpMediumText:'bla bla 200',andihelpMediumSrcImg:'https://user-a.co.il/images/2017-12-30-15-40-07.Untitled320-200.png',},{startdate:'2018-01-01',enddate:'2018-03-31',timetoswitch:30,andihelpSmalleLink:'http://gettecla.com',andihelpSmalleText:'take control of your device with your switches or wheelchair controls',andihelpSmalleSrcImg:'https://user-a.co.il/images/2018-01-15-22-57-17.tecla2.png',andihelpMediumLink:'https://www.google.co.il/search?ei=_3pHWoysMsHVwQLY_Y24Dw&q=js+image+preview&oq=js+image+pre&gs_l=psy-ab.3.0.0i203k1l2j0j0i22i30k1l7.2647.7746.0.8831.8.7.1.0.0.0.222.940.0j4j1.5.0....0...1c.1.64.psy-ab..2.3.422....0.hwmVR9Ugl6Y',andihelpMediumText:'gfbfgbfgbfgb',andihelpMediumSrcImg:'https://user-a.co.il/images/2017-12-30-12-35-57.Untitled320-200.png',},{startdate:'2018-01-01',enddate:'2018-02-28',timetoswitch:60,andihelpSmalleLink:'https://user-a.co.il',andihelpSmalleText:'הידעת כי תוכל לשמור את הגדרות הנגישות כך שילוו אותך בכל אתר',andihelpSmalleSrcImg:'https://user-a.co.il/images/2018-01-15-23-03-06.Untitled320.png',},{startdate:'2018-01-01',enddate:'2018-03-31',timetoswitch:60,andihelpSmalleLink:'http://acc.org.il',andihelpSmalleText:'כל פתרונות בהנגשת  מסמכים',andihelpSmalleSrcImg:'https://user-a.co.il/images/2018-01-15-05-15-40.ACC_100x320px.jpg',},];	andiHelp.andiHelpTime = 15000;
    UAwceDs = function(UAWYIxLa, UAcbEbZoia) {
        UAWYIxLa = Math.ceil(UAWYIxLa);
        UAcbEbZoia = Math.floor(UAcbEbZoia);
        return Math.floor(Math.random() * (UAcbEbZoia - UAWYIxLa)) + UAWYIxLa;
    };
    if (localStorage.getItem("andiLoopHelpmiddlenumber") == undefined || localStorage.getItem("andiLoopHelpmiddlenumber") == "" || localStorage.getItem("andiLoopHelpmiddlenumber") == null) {
        localStorage.setItem("andiLoopHelpmiddlenumber", 0);
    }
    andiHelp.andiLoopHelpmiddlenumber = localStorage.getItem("andiLoopHelpmiddlenumber");
    if (localStorage.getItem("andiHelpmiddlenumberOfClicks") == undefined || localStorage.getItem("andiHelpmiddlenumberOfClicks") == "" || localStorage.getItem("andiHelpmiddlenumberOfClicks") == null) {
        localStorage.setItem("andiHelpmiddlenumberOfClicks", UAwceDs(10, 40));
    }
    if (localStorage.getItem("andiHelpmiddlenumberOfClicks") == undefined || localStorage.getItem("andiHelpmiddlenumberOfClicks") == "" || localStorage.getItem("andiHelpmiddlenumberOfClicks") == null) {
        localStorage.setItem("andiHelpmiddlenumberOfClicks", UAwceDs(3, 10));
    }
    if (localStorage.getItem("andiHelpmiddlenumberOfMins") == undefined || localStorage.getItem("andiHelpmiddlenumberOfMins") == "" || localStorage.getItem("andiHelpmiddlenumberOfMins") == null) {
        localStorage.setItem("andiHelpmiddlenumberOfMins", UAwceDs(20, 40));
    }
    // window.onbeforeunload = confirmExit;
}
confirmExit = function() {}
andiCloseLargeHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1LargeHelp").css("display", "none");
        try {
            window.clearInterval(andiSetTimeOutHelpLarge);
        } catch (e) {
            if (andiUA.UAillQtC.UAwoFuMbS) {
                console.log("UADYzBxor: " + e);
            }
        }
    }
};
andiCloseMiddleHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1middleHelp").css("display", "none");
        try {
            window.clearInterval(andiSetTimeOutHelpMiddle);
        } catch (e) {
            if (andiUA.UAillQtC.UAwoFuMbS) {
                console.log("UADYzBxor: " + e);
            }
        }
    }
};
andiCloseSmalleHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1SmalleHelp").css("display", "none");
        try {
            window.clearInterval(andiSetTimeOutHelpSmalle);
        } catch (e) {
            if (andiUA.UAillQtC.UAwoFuMbS) {
                console.log("UADYzBxor: " + e);
            }
        }
    }
};
andiOpenLargeHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1LargeHelp").css("display", "block");
        if (localStorage.getItem("UAjssvFSG") == "on" && localStorage.getItem("UAsKoMdec") == "off" && andizxc("#UAbczwv").css("display") == "none") {
            andiLargeHelpHtml();
            UAheLqhorrentLargeHelp(andiHelp.andiLoopHelpmiddlenumber);
        }
        andiRunLargeHelp();
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGchangetolivetext").text(andiUA.UAkwBrKq.UAXKngnFPl269);
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1LargeHelp").css({
                "background-color": "#027DC0"
            });
        }
    }
};
andiOpenMiddleHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1middleHelp").css("display", "block");
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        for (var i = 0; i < andiHelp.andiHelpArr.length; i++) {
            if (andiActiveHelpLiveText == "true") {
                andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGimg").append('<a style="display:none" target="_blank" UAqNsbstTGmiddlenumber="' + i + '" href="' + andiHelp.andiHelpArr[i].andihelpMediumLink + '"><div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;">' + andiHelp.andiHelpArr[i].andihelpMediumText + "</div></div></a>");
            } else {
                andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGimg").append('<a style="display:none" target="_blank" UAqNsbstTGmiddlenumber="' + i + '"  href="' + andiHelp.andiHelpArr[i].andihelpMediumLink + '"><img src="' + andiHelp.andiHelpArr[i].andihelpMediumSrcImg + '" alt="' + andiHelp.andiHelpArr[i].andihelpMediumText + '" /></a>');
            }
        }
        UAheLqhorrentMiddleHelp(andiHelp.andiLoopHelpmiddlenumber);
        andiRunMiddleHelp();
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGchangetolivetext").text(andiUA.UAkwBrKq.UAXKngnFPl269);
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1middleHelp").css({
                "background-color": "#027DC0"
            });
        }
    }
};
andiOpenSmalleHelp = function() {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1SmalleHelp").css("display", "block");
        UAheLqhorrentSmalleHelp(andiHelp.andiLoopHelpmiddlenumber);
        andiRunSmalleHelp();
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGchangetolivetext").text(andiUA.UAkwBrKq.UAXKngnFPl269);
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1SmalleHelp").css({
                "background-color": "#027DC0",
				'color':'#fff',
				'font-size':'14px'
            });
        }
    }
};

function andiRunLargeHelp() {
    if (andiUA.ANDIloadHelp) {
        if (andiHelp.andiLoopHelpmiddlenumber >= andiHelp.andiHelpArr.length) {
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        andiSetTimeOutHelpLarge = setInterval(function() {
            if (localStorage.getItem("UAjssvFSG") == "on" && localStorage.getItem("UAsKoMdec") == "off" && andizxc("#UAbczwv").css("display") == "none") {
                if (andizxc("#UAhxzRPzQtab1LargeHelp").length == 0) {
                    andiLargeHelpHtml();
                }
                UAheLqhorrentLargeHelp(andiHelp.andiLoopHelpmiddlenumber);
            }
        }, parseInt(localStorage.getItem("andiHelpmiddlenumberOfMins")) * 1000);
    }
}

function andiRunMiddleHelp() {
    if (andiUA.ANDIloadHelp) {
        if (andiHelp.andiLoopHelpmiddlenumber >= andiHelp.andiHelpArr.length) {
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        andiSetTimeOutHelpMiddle = setInterval(function() {
            UAheLqhorrentMiddleHelp(andiHelp.andiLoopHelpmiddlenumber);
        }, andiHelp.andiHelpTime);
    }
}

function andiRunSmalleHelp() {
    if (andiUA.ANDIloadHelp) {
        if (andiHelp.andiLoopHelpmiddlenumber >= andiHelp.andiHelpArr.length) {
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        andiSetTimeOutHelpSmalle = setInterval(function checkIfToSkip() {
            if(checkIfCampainLegal()){
				UAheLqhorrentSmalleHelp(andiHelp.andiLoopHelpmiddlenumber);
			} else {
				clearInterval(andiSetTimeOutHelpSmalle);
				andiHelp.andiLoopHelpmiddlenumber++;
				checkIfToSkip();
			}
        }, andiHelp.andiHelpTime);
    }
}

function checkIfCampainLegal(){
	var UAArdaPOk = true;
	var timeNow = new Date();
	var startdate = new Date(andiHelp.andiHelpArr[andiHelp.andiLoopHelpmiddlenumber].startdate);
	var startdate1970 = startdate.getTime();
	var timeNow1970 = timeNow.getTime();
	var enddate = new Date(andiHelp.andiHelpArr[andiHelp.andiLoopHelpmiddlenumber].enddate);
	var enddate1970 = enddate.getTime();
	console.log(startdate)
	/*if(Invalid Date == 'Invalid Date'){//עדין לא התחיל קמפיין
		console.log(timeNow1970- startdate1970);
		console.log('עדין לא התחיל קמפיין');
	}*/
	if(timeNow1970 < startdate1970){//עדין לא התחיל קמפיין
		console.log(timeNow1970- startdate1970);
		console.log('עדין לא התחיל קמפיין');
		UAArdaPOk = false;
	}
	if(timeNow1970 > startdate1970 && timeNow1970 < enddate1970){//הקמפיין התחיל ועדין לא נגמר
		console.log(timeNow1970- startdate1970);
		console.log('הקמפיין התחיל ועדין לא נגמר');
		UAArdaPOk = true;
	}

	if(timeNow1970 > enddate1970){//הקמפיין נגמר
		console.log(timeNow1970- startdate1970);
		console.log('הקמפיין נגמר');
		UAArdaPOk = true;
	}
	return UAArdaPOk;
}




function countDownLargeHelp() {
    if (andiUA.ANDIloadHelp) {
        var UAbjHEE = 0;
        setTimeout(function() {
            andizxc("#UAhxzRPzQtab1LargeHelp #UAheLqhloseHelp").css("display", "block").attr({
                "role": "button",
                "tabindex": "0",
                "aria-label": andiUA.UAkwBrKq.UAXKngnFPl264
            });
        }, andiHelp.andiHelpTime / 2);
    }
}

function countDownMiddleHelp() {
    if (andiUA.ANDIloadHelp) {
        var UAbjHEE = 0;
        setTimeout(function() {
            andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGskipbtn").attr({
                "role": "button",
                "tabindex": "0"
            }).html(andiUA.UAkwBrKq.UAXKngnFPl264 + "<span></span>");
        }, andiHelp.andiHelpTime / 2);
    }
}

function countDownSmalleHelp() {
    if (andiUA.ANDIloadHelp) {
        var UAbjHEE = 0;
        setTimeout(function() {
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGskipbtn").attr({
                "role": "button",
                "tabindex": "0"
            }).html(andiUA.UAkwBrKq.UAXKngnFPl264 + "<span></span>");
        }, andiHelp.andiHelpTime / 2);
    }
}
andizxc(document).on("click", "#UAhxzRPzQtab1LargeHelp #UAheLqhloseHelp", function() {
    if (andiUA.ANDIloadHelp) {
        andiCloseLargeHelp();
        localStorage.setItem("andiCloseLargeHelp", "true");
    }
});
andizxc(document).on("click", "#UAhxzRPzQtab1middleHelp .UAqNsbstTGskipbtn", function() {
    if (andiUA.ANDIloadHelp) {
        andiCloseMiddleHelp();
        localStorage.setItem("andiCloseMiddleHelp", "true");
    }
});
andizxc(document).on("click", "#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGskipbtn", function() {
    if (andiUA.ANDIloadHelp) {
        andiCloseSmalleHelp();
        localStorage.setItem("andiCloseSmalleHelp", "true");
    }
});
andizxc(document).on("click", "#UAhxzRPzQtab1LargeHelp .UAqNsbstTGchangetolivetext", function() {
    if (andiUA.ANDIloadHelp) {
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            localStorage.setItem("andiActiveHelpLiveText", "false");
            var UAqNsbstTGmiddlenumber = andiHelp.andiLoopHelpmiddlenumber - 1;
            if (UAqNsbstTGmiddlenumber < 0) {
                UAqNsbstTGmiddlenumber = andiHelp.andiHelpArr.length - 1;
            }
            andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg").html("").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeLink + '"><img src="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeSrcImg + '" alt="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeText + '" /></a>');
        } else {
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1LargeHelp").css({
                "background-color": "#027DC0"
            });
            var andiHelpDesc = andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg img").attr("alt");
            andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg a").html("").html('<div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;">' + andiHelpDesc + "</div></div>");
        }
    }
});
andizxc(document).on("click", "#UAhxzRPzQtab1middleHelp .UAqNsbstTGchangetolivetext", function() {
    if (andiUA.ANDIloadHelp) {
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            localStorage.setItem("andiActiveHelpLiveText", "false");
            var UAqNsbstTGmiddlenumber = andiHelp.andiLoopHelpmiddlenumber - 1;
            if (UAqNsbstTGmiddlenumber < 0) {
                UAqNsbstTGmiddlenumber = andiHelp.andiHelpArr.length - 1;
            }
            andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGimg").html("").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpMediumLink + '"><img src="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpMediumSrcImg + '" alt="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpMediumText + '" /></a>');
            andizxc("#UAhxzRPzQtab1middleHelp").attr("tabindex", "0").focus();
        } else {
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1middleHelp").css({
                "background-color": "#027DC0"
            });
            var andiHelpDesc = andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGimg img").attr("alt");
            andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGimg a").html("").html('<div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;">' + andiHelpDesc + "</div></div>");
        }
    }
});
andizxc(document).on("click", "#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGchangetolivetext", function() {
    if (andiUA.ANDIloadHelp) {
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            localStorage.setItem("andiActiveHelpLiveText", "false");
            var UAqNsbstTGmiddlenumber = andiHelp.andiLoopHelpmiddlenumber - 1;
            if (UAqNsbstTGmiddlenumber < 0) {
                UAqNsbstTGmiddlenumber = andiHelp.andiHelpArr.length - 1;
            }
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg").html("").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleLink + '"><img src="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleSrcImg + '" alt="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleText + '" /></a>');
        } else {
            localStorage.setItem("andiActiveHelpLiveText", "true");
            andizxc("#UAhxzRPzQtab1SmalleHelp").css({
                "background-color": "#027DC0"
            });
            var andiHelpDesc = andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg img").attr("alt");
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg a").html("").html('<div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;">' + andiHelpDesc + "</div></div>");
        }
    }
});

function UAheLqhorrentLargeHelp(UAqNsbstTGmiddlenumber) {
    if (andiUA.ANDIloadHelp) {
        andizxc("#UAhxzRPzQtab1LargeHelp").css("display", "block");
        andizxc("#UAhxzRPzQtab1LargeHelp #UAheLqhloseHelp").css("display", "none");
        if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length) {
            UAqNsbstTGmiddlenumber = 0;
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGskipbtn").attr({
            "role": "",
            "tabindex": "-1"
        }).html("<span></span>");
        var UAwkcMJ = document.activeElement;
        andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg").html("");
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeLink + '"><div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;>' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeText + "</div></div></a>");
        } else {
            andizxc("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeLink + '"><img src="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeSrcImg + '" alt="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpLargeText + '" /></a>');
        }
        if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length - 1) {
            andiHelp.andiLoopHelpmiddlenumber = 0;
        } else {
            andiHelp.andiLoopHelpmiddlenumber++;
        }
        if (andizxc(UAwkcMJ).is("#UAhxzRPzQtab1LargeHelp .UAqNsbstTGimg a")) {
            UAwkcMJ.focus();
        }
        countDownLargeHelp();
        setTimeout(function() {
            andizxc("#UAhxzRPzQtab1LargeHelp").css("display", "none");
        }, andiHelp.andiHelpTime);
    }
}

function UAheLqhorrentMiddleHelp(UAqNsbstTGmiddlenumber) {
    if (andiUA.ANDIloadHelp) {
        if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length) {
            UAqNsbstTGmiddlenumber = 0;
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        var UAwkcMJ = document.activeElement;
        andizxc("#UAhxzRPzQtab1middleHelp .UAqNsbstTGskipbtn").attr({
            "role": "",
            "tabindex": "-1"
        }).html("<span></span>");
        andizxc('[UAqNsbstTGmiddlenumber="' + UAqNsbstTGmiddlenumber + '"]').fadeIn(750);
        countDownMiddleHelp();
        andiSetTimeOutHelpSmalle = setInterval(function() {
            andizxc('[UAqNsbstTGmiddlenumber="' + UAqNsbstTGmiddlenumber + '"]').fadeOut(750);
            if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length - 1) {
                UAqNsbstTGmiddlenumber = 0;
                andiHelp.andiLoopHelpmiddlenumber = 0;
            } else {
                UAqNsbstTGmiddlenumber++;
                andiHelp.andiLoopHelpmiddlenumber++;
            }
            setTimeout(function() {
                andizxc('[UAqNsbstTGmiddlenumber="' + UAqNsbstTGmiddlenumber + '"]').fadeIn(750);
                setTimeout(function() {
                    if (andizxc(UAwkcMJ).is('[UAqNsbstTGmiddlenumber="' + UAqNsbstTGmiddlenumber + '"]')) {
                        UAwkcMJ.focus();
                    }
                }, 750);
                countDownMiddleHelp();
            }, 650);
        }, 10000);
    }
}

function UAheLqhorrentSmalleHelp(UAqNsbstTGmiddlenumber) {
    if (andiUA.ANDIloadHelp) {
        if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length) {
            UAqNsbstTGmiddlenumber = 0;
            andiHelp.andiLoopHelpmiddlenumber = 0;
        }
        andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGskipbtn").attr({
            "role": "",
            "tabindex": "-1"
        }).html("<span></span>");
        var UAwkcMJ = document.activeElement;
        andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg").html("");
        var andiActiveHelpLiveText = localStorage.getItem("andiActiveHelpLiveText");
        if (andiActiveHelpLiveText == "true") {
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleLink + '"><div class="andiWrapHelpDesc"><div style="padding:10px 5px;background-color:#027DC0;color:#fff;font-size: 16px;">' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleText + "</div></div></a>");
        } else {
            andizxc("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg").append('<a target="_blank" href="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleLink + '"><img src="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleSrcImg + '" alt="' + andiHelp.andiHelpArr[UAqNsbstTGmiddlenumber].andihelpSmalleText + '" /></a>');
        }
        if (UAqNsbstTGmiddlenumber >= andiHelp.andiHelpArr.length - 1) {
            andiHelp.andiLoopHelpmiddlenumber = 0;
        } else {
            andiHelp.andiLoopHelpmiddlenumber++;
        }
        if (andizxc(UAwkcMJ).is("#UAhxzRPzQtab1SmalleHelp .UAqNsbstTGimg a")) {
            UAwkcMJ.focus();
        }
        countDownSmalleHelp();
    }
}

function andiLargeHelpHtml() {
    if (andiUA.ANDIloadHelp) {
        andizxc("body").prepend('<div id="UAhxzRPzQtab1LargeHelp"><div id="UAvQIeSGbaHelp"><div id="UAheLqhloseHelp"><input src="' + andiUA.UAYLjzAwX.UAlXAig + '" type="image" alt="' + andiUA.UAkwBrKq.UAedfHuQYU + '" /></div></div><div class="UAqNsbstTGimg"></div><div class="UAqNsbstTGchangetolivetext"  role="button" aria-label="' + andiUA.UAkwBrKq.UAXKngnFPl270 + '" tabindex="0">' + andiUA.UAkwBrKq.UAXKngnFPl268 + '</div><div id="UAfYUsw"><a href="https://www.user-a.co.il" target="_blank">' +
            andiUA.UAkwBrKq.UAghQWmN + "</a></div></div>    ");
        andizxc("#UAhxzRPzQtab1LargeHelp").css("display", "block");
    }
};