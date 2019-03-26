andiUA.UAZWNkrt = function() {
  (function() {
    if (andiUA.UAillQtC.UAenPIq) {
      var UApRKRCwJ = function(str) {
        UAwqKQt = str.UAlQgLCScx(":not()", "").UAlQgLCScx(":active", "").UAlQgLCScx(":focus", "").UAlQgLCScx("::before", "").UAlQgLCScx(":before", "").UAlQgLCScx("::after", "").UAlQgLCScx(":after", "").UAlQgLCScx(":visited", "").UAlQgLCScx(":link", "").UAlQgLCScx(":focus", "").trim();
        return UAwqKQt;
      };
      (function(window, document) {
        var slice = [].slice;
        var removeClass = function(elem) {
          elem.classList.remove("focus-within");
        };
        var update = function() {
          var running, last;
          var action = function() {
            var element = document.activeElement;
            running = false;
            if (last !== element) {
              last = element;
              slice.call(document.getElementsByClassName("focus-within")).forEach(removeClass);
              while (element && element.classList) {
                element.classList.add("focus-within");
                element = element.parentNode;
              }
            }
          };
          return function() {
            if (!running) {
              requestAnimationFrame(action);
              running = true;
            }
          };
        }();
        document.addEventListener("focus", update, true);
        document.addEventListener("blur", update, true);
        update();
      })(window, document);
      var UADHNCpYu = "", UAaOfngs = "", selectors;
      UAwLlUPEEf = andiUA.UAGVvxAfXd;
      for (var j = 0; j < UAwLlUPEEf.length; j++) {
        if (UAwLlUPEEf[j].indexOf(":hover") > -1) {
          var UAKlKQiGzV = UAwLlUPEEf[j];
          UAwLlUPEEf[j] = UAwLlUPEEf[j].UAlQgLCScx(":hover", ":focus-within");
          UADHNCpYu += UAwLlUPEEf[j];
          if (UAKlKQiGzV.indexOf(",") > -1) {
            var UAdyuDrh = UAKlKQiGzV.split(",");
            for (var q = 0; q < UAdyuDrh.length; q++) {
              if (UAdyuDrh[q].indexOf(":hover") > -1) {
                UAsTJnkGqW = UAdyuDrh[q].split(":hover");
                UANagpMSht = UApRKRCwJ(UAsTJnkGqW[0]);
                if (UAwqKQt.length > 1 && UAwqKQt.indexOf("@") == -1) {
                  try {
                    andizxc(UANagpMSht).attr({"tabindex":"0", "UARKelAIV":"true"});
                  } catch (e) {
                  }
                }
              }
            }
          } else {
            if (UAKlKQiGzV.indexOf(":hover") > -1) {
              UAsTJnkGqW = UAKlKQiGzV.split(":hover");
              UANagpMSht = UApRKRCwJ(UAsTJnkGqW[0]);
              if (UAwqKQt.length > 1 && UAwqKQt.indexOf("@") == -1) {
                try {
                  andizxc(UANagpMSht).attr({"tabindex":"0", "UARKelAIV":"true"});
                } catch (e$0) {
                }
              }
            }
          }
        }
      }
      if (UADHNCpYu.length > 10) {
        UAaOfngs += UADHNCpYu.UAlQgLCScx(":focus-within", '[UAAHIft="true"]');
        document.querySelector("head").UAsgYBL('<style class="UARKelAIV">' + UADHNCpYu + "</style>");
        document.querySelector("head").UAsgYBL('<style class="UAVIUilFyT">' + UAaOfngs + "</style>");
      }
      var UAJhAhPP = document.querySelectorAll("link");
      for (var i = 0; i < UAJhAhPP.length; i++) {
        var source = UAJhAhPP[i].href;
        try {
          andizxc.ajax({type:"GET", url:source, dataType:"text", data:{}, success:function(data) {
            var UAwLlUPEEf = data.split("}");
            var UADHNCpYu = "", UAaOfngs = "", selectors;
            for (var j = UAwLlUPEEf.length - 1; j--;) {
              if (UAwLlUPEEf[j].indexOf(":hover") == -1) {
                UAwLlUPEEf.splice(j, 1);
              } else {
                UAwLlUPEEf[j] += "}";
                var UAKlKQiGzV = UAwLlUPEEf[j];
                UAKSRKML = UAwLlUPEEf[j].trim();
                if (UAKSRKML.indexOf("/*") > -1) {
                  if (UAKSRKML.indexOf("/*") == 0) {
                    UAKSRKML = UAKSRKML.split("*/");
                  }
                  UAwLlUPEEf[j] = UAKSRKML[1];
                }
                if (UAwLlUPEEf[j] != undefined) {
                  UAwLlUPEEf[j] = UAwLlUPEEf[j].UAlQgLCScx(":hover", ":focus-within");
                  UADHNCpYu += UAwLlUPEEf[j];
                  var UAdyuDrh = [];
                  if (UAKlKQiGzV.indexOf(",") > -1) {
                    var UAdyuDrh = UAKlKQiGzV.split(",");
                    for (var q = 0; q < UAdyuDrh.length; q++) {
                      if (UAdyuDrh[q].indexOf(":hover") > -1) {
                        UAsTJnkGqW = UAdyuDrh[q].split(":hover");
                        UANagpMSht = UApRKRCwJ(UAsTJnkGqW[0]);
                        if (UAwqKQt.length > 1 && UAwqKQt.indexOf("@") == -1) {
                          try {
                            andizxc(UANagpMSht).attr({"tabindex":"0", "UARKelAIV":"true"});
                          } catch (e$1) {
                          }
                        }
                      }
                    }
                  } else {
                    if (UAKlKQiGzV.indexOf(":hover") > -1) {
                      UAsTJnkGqW = UAKlKQiGzV.split(":hover");
                      UANagpMSht = UApRKRCwJ(UAsTJnkGqW[0]);
                      if (UAwqKQt.length > 1 && UAwqKQt.indexOf("@") == -1) {
                        try {
                          andizxc(UANagpMSht).attr({"tabindex":"0", "UARKelAIV":"true"});
                        } catch (e$2) {
                        }
                      }
                    }
                  }
                }
              }
            }
            if (UADHNCpYu.length > 10) {
              UAaOfngs += UADHNCpYu.UAlQgLCScx(":focus-within", '[UAAHIft="true"]');
              document.querySelector("head").UAsgYBL('<style class="UARKelAIV">' + UADHNCpYu + "</style>");
              document.querySelector("head").UAsgYBL('<style class="UAVIUilFyT">' + UAaOfngs + "</style>");
            }
          }});
        } catch (e$3) {
        }
      }
      if (andiUA.UASSvQPgY()) {
        andizxc(document).on("keydown", "*", function() {
          setTimeout(function() {
            var UAgwrID = document.activeElement;
            andizxc("[UAAHIft]").each(function() {
              andizxc(this).removeAttr("UAAHIft");
            });
            var UARIvkQIWithUAAHIft = document.querySelectorAll("[UAAHIft]");
            for (var q = 0; q < UARIvkQIWithUAAHIft.length; q++) {
              UARIvkQIWithUAAHIft[q].attributes.removeNamedItem("UAAHIft");
            }
            andizxc(UAgwrID).attr("UAAHIft", "true");
            UAKjGZj = andizxc(UAgwrID).parents();
            andizxc(UAKjGZj).each(function() {
              andizxc(this).attr("UAAHIft", "true");
            });
          }, 20);
        });
      }
    }
  })();
};
andiUA.UArjWbtsJm = function() {
  (function() {
    if (andiUA.UAillQtC.UArjWbtsJm) {
      try {
        var UAEzRldaEv = function(UAENvuAkr) {
          UACEJiW = UAENvuAkr.src;
          if (UACEJiW != "" && UACEJiW != undefined) {
            if (UACEJiW.indexOf("andi") == -1 && UACEJiW.toLowerCase().indexOf("angular") == -1 && UACEJiW.toLowerCase().indexOf("jquery") == -1) {
              jQuery.ajax({type:"POST", url:andiUA.url + "andigetfile/getscript.php", dataType:"text", data:{dataurl:UACEJiW}, success:function(data) {
                var UAxsnIDP = data.match(/[^\r\n]+/g);
                if (UAxsnIDP != null) {
                  for (var UAiVxbFQO = 0; UAiVxbFQO < UAxsnIDP.length; UAiVxbFQO++) {
                    if (UAxsnIDP[UAiVxbFQO].length > 0 && UAxsnIDP[UAiVxbFQO].length < 150 && UAxsnIDP[UAiVxbFQO].indexOf("click") > -1) {
                      var UAlguXrAMatch = UAxsnIDP[UAiVxbFQO].match(/\(([^)]+)\)/);
                      if (UAlguXrAMatch != null) {
                        var UAxIAUVhc = UAlguXrAMatch[1];
                        if (UAlguXrAMatch != null && UAxIAUVhc.indexOf("#") > -1 || UAaadCWv.indexOf(UAxIAUVhc) > -1 || UAxIAUVhc.indexOf(".") == 0) {
                          UAhVzJWJ(UAxIAUVhc, UAlguXrAMatch[0]);
                        }
                      }
                    }
                  }
                }
              }, UADYzBxor:function(UAQmfLv) {
                if (andiUA.UAillQtC.UAwoFuMbS) {
                  console.log(UAQmfLv);
                }
              }});
            }
          } else {
            var UAVSLbNix = UAENvuAkr.text;
            var UAxsnIDP = UAVSLbNix.match(/[^\r\n]+/g);
            for (var UAiVxbFQO = 0; UAiVxbFQO < UAxsnIDP.length; UAiVxbFQO++) {
              if (UAxsnIDP[UAiVxbFQO].length > 0 && UAxsnIDP[UAiVxbFQO].length < 150 && UAxsnIDP[UAiVxbFQO].indexOf("click") > -1) {
                var UAlguXrAMatch = UAxsnIDP[UAiVxbFQO].match(/\(([^)]+)\)/);
                if (UAlguXrAMatch != null) {
                  var UAxIAUVhc = UAlguXrAMatch[1];
                  if (UAlguXrAMatch != null && UAxIAUVhc.indexOf("#") > -1 || UAaadCWv.indexOf(UAxIAUVhc) > -1 || UAxIAUVhc.indexOf(".") == 0) {
                    UAhVzJWJ(UAxIAUVhc, UAlguXrAMatch[0]);
                  }
                }
              }
            }
          }
        };
        var UAesKFL = function(UAmKjiBHY) {
          var ANDIthat = UAmKjiBHY;
          jQuery(UAmKjiBHY).each(function() {
            if (jQuery(this).attr("UASApCTnmZ") == undefined) {
              jQuery(this).attr({"tabindex":"0"});
              jQuery(this)[0].setAttribute("UASApCTnmZ", "true");
            }
          });
        };
        var UALrFEVI = function(UAmKjiBHY) {
          var ANDIthat = UAmKjiBHY;
          try {
            jQuery(UAmKjiBHY).each(function() {
              if (!jQuery(this).is("body") && jQuery(this).attr("UAHCNtZK") == undefined) {
                jQuery(this).attr({"role":jQuery(this).is("a") ? "link" : "button", "tabindex":"0"});
                jQuery(this)[0].setAttribute("UAHCNtZK", "true");
              }
            });
          } catch (UADYzBx) {
            console.log(UADYzBx);
          }
        };
        var UAhVzJWJ = function(UATPwPmh, ANDIdata2) {
          UATPwPmh = UATPwPmh.replace('"', "");
          UATPwPmh = UATPwPmh.replace('"', "");
          UATPwPmh = UATPwPmh.replace("'", "");
          UATPwPmh = UATPwPmh.replace("'", "");
          avoidThis = false;
          for (var UAiVxbFQO = 0; UAiVxbFQO < UAHtokcbBh.length; UAiVxbFQO++) {
            if (UATPwPmh.indexOf(UAHtokcbBh[UAiVxbFQO]) > -1) {
              avoidThis = true;
            }
          }
          if (!avoidThis && UAcNNwbix.indexOf(UATPwPmh) == -1) {
            UALrFEVI(UATPwPmh);
            UAcNNwbix.push(UATPwPmh);
          }
        };
        var UAyAYBCNbQ = ["touchcancel", "touchend", "touchenter", "touchleave", "touchmove", "touchstart", "mouseenter", "mouseover", "mousemove", "mousedown", "mouseup", "auxclick", "click", "dblclick", "contextmenu", "wheel", "mouseleave", "mouseout", "select", "pointerlockchange", "pointerlockUADYzBxor", "keydown", "keypress", "keyup", "focus", "blur", "hover", "focusin", "focusout", "mouseout", "mouseleave"];
        var UAaadCWv = ["a", "abbr", "acronym", "address", "applet", "area", "article", "aside", "audio", "b", "base", "basefont", "bdi", "bdo", "big", "blockquote", "body", "br", "button", "canvas", "caption", "center", "cite", "code", "col", "colgroup", "data", "datalist", "dd", "del", "details", "dfn", "dialog", "dir", "div", "dl", "dt", "em", "embed", "fieldset", "figcaption", "figure", "font", "footer", "form", "frame", "frameset", "h1", "h2", "h3", "h4", "h5", "h6", "head", "header", "hr", 
        "html", "i", "iframe", "img", "input", "ins", "kbd", "keygen", "label", "legend", "li", "link", "main", "map", "mark", "menu", "menuitem", "meta", "meter", "nav", "noframes", "noscript", "object", "ol", "optgroup", "option", "output", "p", "param", "picture", "pre", "progress", "q", "rp", "rt", "ruby", "s", "samp", "script", "section", "select", "small", "source", "span", "strike", "strong", "style", "sub", "summary", "sup", "table", "tbody", "td", "textarea", "tfoot", "th", "thead", "time", 
        "title", "tr", "track", "tt", "u", "ul", "var", "video", "wbr"];
        var UAHtokcbBh = [".attr", "#+", "'id'"];
        var UAcNNwbix = [];
        var UADIWlN = [];
        var UAmUjGFBClickEventANDIthatFind = [];
        var UAmUjGFBTextClickEventANDIthatFind = [];
        var UACDQlxWC = jQuery("script").length;
        var UAsDbWVkU = 0;
        eventOn("keydown", '[UAHCNtZK="true"]', function(UAeZhAzmIV) {
          if (UAeZhAzmIV.keyCode == 13) {
            this.click();
          }
        });
        eventOn("focus", '[UASApCTnmZ="true"]', function(UAeZhAzmIV) {
          try {
            jQuery(this).trigger("mouseenter");
            jQuery(this).trigger("mouseover");
          } catch (UADYzBx) {
            console.log(UADYzBx);
          }
        });
        UAuwhWdAL = function(UAGkxVPi) {
          var UAxIUnaWcd = jQuery(UAGkxVPi).attr("class");
          if (UAxIUnaWcd != undefined && UAxIUnaWcd.length > 0) {
            UAxIUnaWcd = UAxIUnaWcd.trim();
            UAxIUnaWcd = UAxIUnaWcd.replace(/   /g, ".");
            UAxIUnaWcd = UAxIUnaWcd.replace(/  /g, ".");
            UAxIUnaWcd = UAxIUnaWcd.replace(/ /g, ".");
            UAxIUnaWcd = "." + UAxIUnaWcd;
          } else {
            UAxIUnaWcd = "";
          }
          var UAKgYRku = jQuery(UAGkxVPi).attr("id");
          if (UAKgYRku != undefined && UAKgYRku.length > 0) {
            UAKgYRku = UAKgYRku.trim();
            UAKgYRku = UAKgYRku.replace(/ /g, "#");
            UAKgYRku = "#" + UAKgYRku;
          } else {
            UAKgYRku = "";
          }
          var UAmKjiBHY = jQuery(UAGkxVPi)[0].tagName.toLowerCase() + UAKgYRku + UAxIUnaWcd;
          return UAmKjiBHY;
        };
        UAkDqoetP = function() {
          jQuery("[ng-click]").each(function(UAiVxbFQO) {
            UAuwhWdAL(this);
          });
          jQuery("html *").each(function(UAiVxbFQO) {
            if (jQuery(this)[0].tagName.toLowerCase() != "script") {
              try {
                var UARCNWb = jQuery._data(jQuery(this)[0], "events");
                if (UARCNWb != undefined) {
                  var UAbsflyx = UARCNWb.hasOwnProperty("click");
                  if (UAbsflyx) {
                    var UAmKjiBHY = UAuwhWdAL(this);
                    if (UAmUjGFBClickEventANDIthatFind.indexOf(UAmKjiBHY) == -1) {
                      if (UAcNNwbix.indexOf("a") == -1) {
                        UAcNNwbix.push(UAmKjiBHY);
                        UALrFEVI(UAmKjiBHY);
                      } else {
                        if (UAmKjiBHY.indexOf("a") > 0) {
                          UALrFEVI(UAmKjiBHY);
                          UAcNNwbix.push(UAmKjiBHY);
                        }
                      }
                    }
                  }
                  var UAgsUukT = UARCNWb.hasOwnProperty("mouseenter");
                  if (UAgsUukT) {
                    var UAmKjiBHY = UAuwhWdAL(this);
                    if (UADIWlN.indexOf(UAmKjiBHY) == -1) {
                      UADIWlN.push(UAmKjiBHY);
                      UAesKFL(UAmKjiBHY);
                    }
                  }
                  var UAiVxbFQOsHaveHoverEvent = UARCNWb.hasOwnProperty("hover");
                  if (UAiVxbFQOsHaveHoverEvent) {
                    var UAmKjiBHY = UAuwhWdAL(this);
                    if (UADIWlN.indexOf(UAmKjiBHY) == -1) {
                      UADIWlN.push(UAmKjiBHY);
                      UAesKFL(UAmKjiBHY);
                    }
                  }
                  var UAiVxbFQOsHaveMouseOverEvent = UARCNWb.hasOwnProperty("mouseover");
                  if (UAiVxbFQOsHaveMouseOverEvent) {
                    var UAmKjiBHY = UAuwhWdAL(this);
                    if (UADIWlN.indexOf(UAmKjiBHY) == -1) {
                      UADIWlN.push(UAmKjiBHY);
                      UAesKFL(UAmKjiBHY);
                    }
                  }
                }
              } catch (UADYzBx) {
                if (andiUA.UAillQtC.UAwoFuMbS) {
                  console.log(UADYzBx);
                }
              }
            } else {
              UAEzRldaEv(jQuery(this)[0]);
            }
          });
        };
        UAkDqoetP();
      } catch (UADYzBx) {
        console.log(UADYzBx);
      }
    }
  })();
};
andiUA.UATlqUog = function() {
  (function() {
    function UAGKpIdQvH(UAwpfaocUB, UAuZmuRAxi) {
      UAmUjGFB = document.querySelectorAll(UAwpfaocUB);
      for (var UAiVxbFQO = 0; UAiVxbFQO < UAmUjGFB.length; UAiVxbFQO++) {
        var UAviCYQgh = UAmUjGFB[UAiVxbFQO];
        var UAoLUFDt = "";
        while (UAviCYQgh.tagName.toLowerCase() != "body" && UAviCYQgh.tagName.toLowerCase() != "html") {
          UAoLUFDt = UAviCYQgh.tagName.toLowerCase() + " > " + UAoLUFDt;
          UAviCYQgh = UAviCYQgh.parentElement;
        }
        UAoLUFDt = "body > " + UAoLUFDt.substring(0, UAoLUFDt.lastIndexOf(">")) + "";
        if (UAoLUFDt != "body > ") {
          document.querySelectorAll(UAoLUFDt).forEach(function(el) {
            el.setAttribute("UAwpfaocUB", UAuZmuRAxi);
          });
        }
      }
    }
    var UAEWKvlaq = localStorage.getItem("UAnewAreaInThisSite");
    var UAntWNBN = "a,button";
    if (false) {
      var UAKSRKML = localStorage.getItem("UAnewAreaInThisSite");
      UAmRlTCjYb = UAKSRKML.split(",");
      for (var UAiVxbFQO = 0; UAiVxbFQO < UAmRlTCjYb.length; UAiVxbFQO++) {
        var str = UAmRlTCjYb[UAiVxbFQO];
        if (str != undefined) {
          var lastIndex = str.lastIndexOf(" > ");
          str = str.substring(0, lastIndex);
          while (str.length > 7) {
            lastIndex = str.lastIndexOf(" > ");
            str = str.substring(0, lastIndex);
            if (str.indexOf(":") == -1 && str != "" && str.UAYMHDDO()) {
              document.querySelectorAll(str).forEach(function(UAviCYQgh) {
                var UAkYvoz = UAviCYQgh.querySelectorAll(UAntWNBN).length;
                if (UAkYvoz > 0 && UAkYvoz <= 5) {
                  UAviCYQgh.setAttribute("UAwpfaocUB", "1");
                } else {
                  if (UAkYvoz > 5 && UAkYvoz <= 15) {
                    UAviCYQgh.setAttribute("UAwpfaocUB", "2");
                    UAviCYQgh.setAttribute("UAYZZSjEep", "2");
                  } else {
                    if (UAkYvoz > 15 && UAkYvoz <= 30) {
                      UAviCYQgh.setAttribute("UAwpfaocUB", "3");
                      UAviCYQgh.setAttribute("UAYZZSjEep", "3");
                    } else {
                      if (UAkYvoz > 30 && UAkYvoz <= 50) {
                        UAviCYQgh.setAttribute("UAYZZSjEep", "4");
                        UAviCYQgh.setAttribute("UAwpfaocUB", "4");
                      } else {
                        if (UAkYvoz > 50) {
                          UAviCYQgh.setAttribute("UAwpfaocUB", "5");
                        }
                      }
                    }
                  }
                }
              });
            }
          }
        }
      }
      UAGKpIdQvH('[UAwpfaocUB="2"]', 2);
    } else {
      var UAWnSdMAK = function(UAYPQUDCzelector, UAntWNBN) {
        if (UAYPQUDCzelector != "") {
          document.querySelectorAll(UAYPQUDCzelector).forEach(function(UAviCYQgh) {
            if (UAviCYQgh != null) {
              if (UAviCYQgh.querySelectorAll(UAntWNBN).length > 0 && UAviCYQgh.querySelectorAll(UAntWNBN).length <= 5) {
                UAviCYQgh.setAttribute("UAwpfaocUB", "1");
              } else {
                if (UAviCYQgh.querySelectorAll(UAntWNBN).length > 5 && UAviCYQgh.querySelectorAll(UAntWNBN).length <= 15) {
                  UAviCYQgh.setAttribute("UAwpfaocUB", "2");
                } else {
                  if (UAviCYQgh.querySelectorAll(UAntWNBN).length > 15 && UAviCYQgh.querySelectorAll(UAntWNBN).length <= 30) {
                    UAviCYQgh.setAttribute("UAwpfaocUB", "3");
                  } else {
                    if (UAviCYQgh.querySelectorAll(UAntWNBN).length > 30 && UAviCYQgh.querySelectorAll(UAntWNBN).length <= 50) {
                      UAviCYQgh.setAttribute("UAwpfaocUB", "4");
                    } else {
                      if (UAviCYQgh.querySelectorAll(UAntWNBN).length > 50) {
                        UAviCYQgh.setAttribute("UAwpfaocUB", "5");
                      }
                    }
                  }
                }
              }
            }
          });
        }
      };
      var UAaQOse = [];
      var UATyNtPMM = [];
      var UAmRlTCjYb = [];
      var UArULYJSQ = function(el) {
        function UAqEcSEv(UAaOJFVAh) {
          function UAZVCmw(UAaOJFVAh) {
            if (UAaOJFVAh.indexOf("> >") > -1 || UAaOJFVAh.indexOf("..") > -1 || UAaOJFVAh.indexOf(". ") > -1 || UAaOJFVAh.indexOf(".[") > -1 || UAaOJFVAh.indexOf(".>") > -1) {
              return true;
            }
            return false;
          }
          UAaOJFVAh = UAaOJFVAh.replace(". ", "").replace("> >", " > ").replace("..", ".").replace(".[", "[").replace(".>", " >").replace(".#", "#");
          if (UAZVCmw(UAaOJFVAh)) {
            UAqEcSEv(UAaOJFVAh);
          } else {
            if (UAaOJFVAh.slice(-1) == ".") {
              UAaOJFVAh = UAaOJFVAh.substring(0, UAaOJFVAh.length - 1);
            }
            return UAaOJFVAh;
          }
        }
        var path = [];
        path.push(el.nodeName.toLowerCase());
        while (el.nodeName.toLowerCase() != "html" && (el = el.parentNode)) {
          var aaa = el.nodeName.toLowerCase();
          var bbb = el.id ? el.getAttribute("id").indexOf("/") == -1 ? "#" + el.id : "" : "";
          var UAJiSBonzX = bbb.match(/\d+/g);
          if (UAJiSBonzX != null || bbb.indexOf(":") > -1) {
            bbb = "";
          }
          var ccc = el.className ? "." + el.className.replace(/\s+/g, ".") : "";
          var UAZaXoMMm = "";
          ccc = ccc.replace('"', "");
          ccc = ccc.replace('"', "");
          var UAJiSBonzX = ccc.match(/\d+/g);
          if (UAJiSBonzX != null) {
            var UAGeUPs = el.className.split(" ");
            for (var UAiVxbFQO = 0; UAiVxbFQO < UAGeUPs.length; UAiVxbFQO++) {
              var textUAKSRKML = UAGeUPs[UAiVxbFQO].match(/\d+/g);
              if (textUAKSRKML == null) {
                UAZaXoMMm += "." + UAGeUPs[UAiVxbFQO];
              }
            }
          }
          if (UAZaXoMMm != "") {
            path.unshift(aaa + UAZaXoMMm + bbb);
          } else {
            path.unshift(aaa + ccc + bbb);
          }
          if (el.nodeName.toLowerCase() == "body") {
            var UAaOJFVAh = path.join(" > ");
            return UAqEcSEv(UAaOJFVAh);
          }
        }
        var UAaOJFVAh = path.join(" > ");
        return UAqEcSEv(UAaOJFVAh);
      };
      var UAmUjGFB = document.querySelectorAll(UAntWNBN);
      for (var UAiVxbFQO = 0; UAiVxbFQO < UAmUjGFB.length; UAiVxbFQO++) {
        if (!UAmUjGFB[UAiVxbFQO].hasAttribute("AutomaticAreas")) {
          var UAviCYQgh = UAmUjGFB[UAiVxbFQO];
          var UAoLUFDt = UArULYJSQ(UAmUjGFB[UAiVxbFQO]);
          if (UAoLUFDt != undefined && UAoLUFDt.indexOf("/") == -1 && UAoLUFDt.indexOf(":") == -1) {
            if (UAmRlTCjYb.indexOf(UAoLUFDt) == -1) {
              UAmRlTCjYb.push(UAoLUFDt);
            }
            document.querySelectorAll(UAoLUFDt).forEach(function(el) {
              el.setAttribute("AutomaticAreas", "true");
            });
          }
        }
      }
      UAmRlTCjYb.sort(function(a, b) {
        return b.length - a.length;
      });
      var UAKSRKMLArr = [];
      var UAogPpb = UAmRlTCjYb[0];
      UAKSRKMLArr.push(UAogPpb);
      for (var UAiVxbFQO = UAmRlTCjYb.length - 1; UAiVxbFQO >= 0; UAiVxbFQO--) {
        if (UAmRlTCjYb[UAiVxbFQO] != undefined) {
          lastIndex = UAmRlTCjYb[UAiVxbFQO].lastIndexOf(" > ");
          str = UAmRlTCjYb[UAiVxbFQO].substring(0, lastIndex);
          if (UAogPpb.indexOf(str) == -1) {
            UAKSRKMLArr.push(str);
          }
        }
      }
      var UAMIyez = "";
      for (var UAiVxbFQO = 0; UAiVxbFQO < UAmRlTCjYb.length; UAiVxbFQO++) {
        var str = UAmRlTCjYb[UAiVxbFQO];
        str = str.substring(0, str.lastIndexOf(" > "));
        while (str.length > 7) {
          document.querySelectorAll(str).forEach(function(UAviCYQgh) {
            var UAkYvoz = UAviCYQgh.querySelectorAll(UAntWNBN).length;
            if (UAkYvoz > 0 && UAkYvoz <= 5) {
              UAviCYQgh.setAttribute("UAwpfaocUB", "1");
            } else {
              if (UAkYvoz > 5 && UAkYvoz <= 15) {
                UAviCYQgh.setAttribute("UAwpfaocUB", "2");
              } else {
                if (UAkYvoz > 15 && UAkYvoz <= 30) {
                  UAviCYQgh.setAttribute("UAwpfaocUB", "3");
                } else {
                  if (UAkYvoz > 30 && UAkYvoz <= 50) {
                    UAviCYQgh.setAttribute("UAwpfaocUB", "4");
                  } else {
                    if (UAkYvoz > 50) {
                      UAviCYQgh.setAttribute("UAwpfaocUB", "5");
                    }
                  }
                }
              }
            }
          });
          str = str.substring(0, str.lastIndexOf(" > "));
        }
      }
      UAWnSdMAK("section,nav,aside, footer,header", UAntWNBN);
      UAGKpIdQvH('[UAwpfaocUB="2"]', 2);
      if (parseInt(andiUA.UArZVJrs(UAMIyez)) < parseInt(localStorage.getItem("UAsizeLocalStorage"))) {
        localStorage.setItem("UAnewAreaInThisSite", UAMIyez);
      }
    }
    if (andiUA.UAillQtC.UAzpLPmk) {
      document.querySelectorAll('[UAwpfaocUB="3"]').forEach(function(el) {
        if (el.querySelectorAll('[UAwpfaocUB="3"]').length > 0) {
          el.querySelectorAll('[UAwpfaocUB="3"]').forEach(function(el2) {
            el2.removeAttribute("UAwpfaocUB");
          });
        }
      });
      document.querySelectorAll('[UAwpfaocUB="2"]').forEach(function(el) {
        if (el.querySelectorAll('[UAwpfaocUB="2"]').length > 0) {
          el.querySelectorAll('[UAwpfaocUB="2"]').forEach(function(el2) {
            el2.removeAttribute("UAwpfaocUB");
          });
        }
      });
      var UAUYsCBTdB = andizxc("[UAwpfaocUB]");
      if (UAUYsCBTdB.length > 1) {
        andizxc(UAUYsCBTdB).each(function() {
          if (andizxc(this).closest("#UAbczwv").length == 0 && (andizxc(this).attr("UAwpfaocUB") == 4 || andizxc(this).attr("UAwpfaocUB") == 3 || andizxc(this).attr("UAwpfaocUB") == 2) && andizxc(this)[0].UAgkZYHhdu()) {
            var allSkipLInks = andizxc(".UAzpLPmk").length;
            andizxc(this).prepend('<a class="UAzpLPmk" href="#" name="UA2skipAutomate' + (allSkipLInks + 0) + '"  tabindex="0" aria-hidden="true"><span class="UAGCYYK">\u05d4\u05d0\u05dd \u05d1\u05e8\u05e6\u05d5\u05e0\u05da \u05dc\u05d3\u05dc\u05d2 \u05de\u05e2\u05dc \u05d0\u05d6\u05d5\u05e8 \u05d6\u05d4 ?</span>,<br />"' + andiUA.UAkwBrKq.UAdziiEqj + "</a>");
          }
        });
      }
      var UAzBAosyS = andizxc("title").text();
      andizxc("body").append('<a id="UAzDIcef" style="position: absolute; bottom: 0;" class="UAlXeHaQMo" name="UAzDIcef" href="#UAulIfZc" tabindex="0" >' + andiUA.UAkwBrKq.UAqYtjy + UAzBAosyS + " " + andiUA.UAkwBrKq.UAXhFXhm + " </a>");
    }
  })();
};
andiUA.UAOcqSK = function() {
  (function() {
    andizxc('input:not([type="radio"],[type="checkbox"]), textarea ').focus(function() {
      andizxc(this).keydown(function() {
        var UAjWhFlQZ = this;
        andizxc(this).css({"cursor":"none"});
        setTimeout(function() {
          andizxc(UAjWhFlQZ).css({"cursor":""});
        }, 1500);
      });
    });
  })();
};
andiUA.UAQrZhcR = function(UAAfDDnuhT, UAqnmLA) {
  (function() {
    andizxc(UAAfDDnuhT).each(function() {
      if (andizxc(this).attr("UAgpTVVwqA") == undefined || andizxc(this).attr("UAgpTVVwqA") == null || andizxc(this).attr("UAgpTVVwqA") == "") {
        andizxc(this).UAlitywLr();
      }
    });
    andizxc(UAqnmLA).each(function() {
      if (andizxc(this).attr("UAgpTVVwqA") == undefined || andizxc(this).attr("UAgpTVVwqA") == null || andizxc(this).attr("UAgpTVVwqA") == "") {
        andizxc(this).UAAGrtge();
      }
    });
    andiUA.UAldIUDXx(document);
    andizxc("iframe").each(function() {
      try {
        andizxc(this).contents().find(UAAfDDnuhT).each(function() {
          if (andizxc(this).attr("UAgpTVVwqA") == undefined || andizxc(this).attr("UAgpTVVwqA") == null || andizxc(this).attr("UAgpTVVwqA") == "") {
            andizxc(this).UAlitywLr();
          }
        });
        andizxc(this).contents().find(UAqnmLA).each(function() {
          if (andizxc(this).attr("UAgpTVVwqA") == undefined || andizxc(this).attr("UAgpTVVwqA") == null || andizxc(this).attr("UAgpTVVwqA") == "") {
            andizxc(this).UAAGrtge();
          }
        });
        andiUA.UAldIUDXx(andizxc(this));
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
  })();
};
andiUA.UAldIUDXx = function(doc) {
  (function() {
    andizxc(doc).contents().find("input").each(function() {
      var UAhczmisC = andizxc(this).attr("type");
      if (UAhczmisC === undefined) {
        andizxc(this).attr("type", "text");
      }
    });
    andizxc(doc).contents().find("input[type=range]").each(function() {
      var UAoQJUm = andizxc(this).attr("id"), UAfhHERVrl = andizxc(this).attr("UAfhHERVrl"), UArxyQG = andizxc(this).attr("UArxyQG"), addition = " (UAfhHERVrl is: " + UAfhHERVrl + ", UArxyQG is: " + UArxyQG + ")";
      andizxc("label[for= ' " + UAoQJUm + " ' ]").append(addition);
      andizxc(this).attr("aria-valuemin", UAfhHERVrl);
      andizxc(this).attr("aria-valuemax", UArxyQG);
      andizxc(this).attr("role", "slider");
    });
    andizxc(doc).contents().find("select.chosen-select").each(function(UAQFJslXzA) {
      var w = andizxc(this).next().find("a").width();
      var h = andizxc(this).next().find("a").height();
      var pL = 0;
      var pT = 0;
      andizxc("head").append('<style id="UANcrDYGqf' + UAQFJslXzA + '">select.chosen-select,select.select2-offscreen{clip: rect(0 0 0 0) !important;\twidth: 1px !important;z-index: 9999 !important;height: 1px !important;\tborder: 0 !important;margin: 0 !important; padding: 0 !important;display: inline-block !important;overflow: hidden !important;position: absolute !important;outline: 0 !important;left: 0px !important;top: 0px !important;}select.chosen-select:focus ,select.select2-offscreen:focus { clip: auto !important;width: ' + 
      w + "px !important;  height: " + h + "px !important;border: 0 !important; margin: 0 !important;padding: 0 !important; overflow: hidden !important;\tposition: absolute !important; outline: 0 !important; left: " + pL + "px !important; top: " + pT + "px !important;}</style>");
      andizxc(this).change(function() {
        var UAQCoXOzrC = andizxc(this).val();
        andizxc(this).next().find("a > span").text(andizxc(this).find('option[value="' + UAQCoXOzrC + '"]').text());
      });
    });
  })();
};
andiUA.UAiahKMgF = function() {
  (function() {
    andizxc("[title]:not(img)").each(function(UAQFJslXzA) {
      if (andizxc.trim(andizxc(this).text()) == andizxc.trim(andizxc(this).attr("title"))) {
        andizxc(this).removeAttr("title");
      }
    });
  })();
};
andiUA.UAQXGSsiCs = function() {
  (function() {
    andizxc("br").each(function(UAQFJslXzA) {
      andizxc(this).attr({"role":"presentation"});
    });
    andizxc("iframe").each(function() {
      try {
        andizxc(this).contents().find("br").each(function(UAQFJslXzA) {
          andizxc(this).attr({"role":"presentation"});
        });
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
  })();
};
andiUA.UAyXwKk = function() {
  (function() {
    andiUA.UAAJCtVck(document);
    andizxc("iframe").each(function() {
      try {
        andiUA.UAAJCtVck(andizxc(this));
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
  })();
};
andiUA.UAAJCtVck = function(doc) {
  (function() {
    var UAGuXKZxBP = andiUA.UAkwBrKq;
    var UAiAIFIrM = ['a[href$=".amr"],a[href$=".mp2"],a[href$=".ram"],a[href$=".aiff"],a[href$=".aif"],a[href$=".wma"],a[href$=".wav"],a[href$=".m4v"]', 'a[href$=".ogg"],a[href$=".m4v"],a[href$=".divx"],a[href$=".mpeg"],a[href$=".m4a"],a[href$=".mp4"],a[href$=".mov"],a[href$=".mpg"],a[href$=".avi"],a[href$=".wmv"]', 'a[href$=".exe"]', 'a[href$=".vcd"]', 'a[href$=".cab"]', 'a[href$=".ace"]', 'a[href$=".gz"]', 'a[href$=".dmg"]', 'a[href$=".iso"]', 'a[href$=".jar"]', 'a[href$=".rar"]', 'a[href$=".zip"],a[href$=".7z"]', 
    'a[href$=".psd"]', 'a[href$=".ai"]', 'a[href$=".indd"]', 'a[href$=".ppt"],a[href$=".pptx"],a[href$=".pptm"],a[href$=".pps"],a[href$=".ppsx"]', 'a[href$=".xlsx"],a[href$=".ods"],a[href$=".xls"]', 'a[href$=".doc"],a[href$=".docx"],a[href$=".odt"],a[href$=".wps"]', 'a[href$=".txt"]', '[href$=".pdf"]', '[target="_blank"],[target="_new"]'];
    var UAGbVgSVYK = ["andiAccLiknssound", "andiAccLiknsmovie", "andiAccLiknsexe", "andiAccLiknsvcd", "andiAccLiknscab", "andiAccLiknsace", "andiAccLiknsgz", "andiAccLiknsdmg", "andiAccLiknsiso", "andiAccLiknsjar", "andiAccLiknsrar", "andiAccLiknszip", "andiAccLiknspsd", "andiAccLiknsai", "andiAccLiknsindd", "andiAccLiknspowerpoint", "andiAccLiknsexcel", "andiAccLiknsdoc", "andiAccLiknstxt", "andiAccLiknspdf", "andiAccLiknsnewwindow"];
    var UAOjbZcg = ["sound", "movie", "exe", "vcd", "cab", "ace", "gz", "dmg", "iso", "jar", "rar", "zip", "psd", "ai", "indd", "powerpoint", "excel", "doc", "txt", "pdf", "newwindow"];
    var UATIwOWrr = [UAGuXKZxBP.UAirhUges, UAGuXKZxBP.UAwcSpT, UAGuXKZxBP.UAEojdu, UAGuXKZxBP.UArDntdTli, UAGuXKZxBP.UAMoxqVI, UAGuXKZxBP.UAMSYzBit, UAGuXKZxBP.UAnkxGNGt, UAGuXKZxBP.UAPwskkV, UAGuXKZxBP.UAoEJpp, UAGuXKZxBP.UAOWsfzgD, UAGuXKZxBP.UAcnsMQr, UAGuXKZxBP.UAANbDQn, UAGuXKZxBP.UAZKormqxW, UAGuXKZxBP.ANDI2UATtqPk, UAGuXKZxBP.ANDI2UAyIUDxtel, UAGuXKZxBP.ANDI2UABSoHAgKn, 
    UAGuXKZxBP.ANDI2UAjtCidlp, UAGuXKZxBP.UAPoCJD, UAGuXKZxBP.UAnLnMs, UAGuXKZxBP.UAtyjIxG, UAGuXKZxBP.UAMqGovPkc];
    for (var i = 0; i < UAiAIFIrM.length; ++i) {
      var UAJpoQdIV = i;
      andizxc(doc).contents().find(UAiAIFIrM[UAJpoQdIV]).each(function() {
        if (andizxc(this).attr(UAGbVgSVYK[UAJpoQdIV]) != UAOjbZcg[UAJpoQdIV]) {
          var UAwBdDGCLR = "";
          var UAqhrsqI = andizxc(this).text();
          if (UAqhrsqI == "" && andizxc(this).find("img")) {
            var UANgtgOsMi = andizxc(this).find("img").first();
            if (UANgtgOsMi && andizxc(UANgtgOsMi).attr("alt") != null) {
              UAqhrsqI = andizxc(UANgtgOsMi).attr("alt");
            } else {
              if (UANgtgOsMi && andizxc(UANgtgOsMi).attr("aria-label") != null) {
                UAqhrsqI = andizxc(UANgtgOsMi).attr("aria-label");
              }
            }
          }
          var UAQCoXOzrCriaLabelLink = andizxc(this).attr("aria-label");
          if (UAQCoXOzrCriaLabelLink != undefined) {
            UAQCoXOzrCriaLabelLink.indexOf(UAqhrsqI) == -1 ? UAwBdDGCLR = UAqhrsqI + " " + UAQCoXOzrCriaLabelLink : UAQCoXOzrCriaLabelLink;
          }
          UAwBdDGCLR != undefined && UAwBdDGCLR.length >= 1 ? andizxc(this).attr({"aria-label":UAwBdDGCLR + ", " + UATIwOWrr[UAJpoQdIV]}) : andizxc(this).attr({"aria-label":UATIwOWrr[UAJpoQdIV]});
          var UAtsBmm = UAGbVgSVYK[UAJpoQdIV];
          var UAaRjVw = UAOjbZcg[UAJpoQdIV];
          andizxc(this).attr(UAtsBmm, UAaRjVw);
        }
      });
    }
  })();
};
andiUA.UAcpohFfvx = function() {
  (function() {
    var UAfEWDNMT = document.querySelectorAll("a:not(.UAzpLPmk)");
    andiUA.UAcYRiz(UAfEWDNMT);
    var ANDI2allIframes = document.querySelectorAll("iframe");
    for (var UAQFJslXzA = 0; UAQFJslXzA < ANDI2allIframes.length; UAQFJslXzA++) {
      try {
        andiUA.UAcYRiz(ANDI2allIframes[UAQFJslXzA].contentWindow.document.querySelectorAll("a"));
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    }
  })();
};
andiUA.UAcYRiz = function(UAfEWDNMT) {
  (function() {
    if (UAfEWDNMT.length > 0) {
      for (var UAQCoXOzrC = 0; UAQCoXOzrC < UAfEWDNMT.length; UAQCoXOzrC++) {
        if (!UAfEWDNMT[UAQCoXOzrC].hasAttribute("UAnOiJL")) {
          UAfEWDNMT[UAQCoXOzrC].setAttribute("UAnOiJL", "true");
          UAfEWDNMT[UAQCoXOzrC].addEventListener("click", function(UAeZhAzmIV) {
            if (andizxc(this).attr("href").indexOf("#") > -1 && andizxc(this).attr("href").indexOf("#/") == -1) {
              try {
                var hashSrt = this.hash.substr(1);
                if (document.querySelector("#" + hashSrt) != null) {
                  document.querySelector("#" + hashSrt).setAttribute("tabindex", "0").focus();
                } else {
                  document.querySelector('[name="' + hashSrt + '"]').setAttribute("tabindex", "0").focus();
                }
              } catch (ANDIUADYzBx) {
                if (andiUA.UAillQtC.UAwoFuMbS) {
                  console.log("UADYzBxor: " + ANDIUADYzBx);
                }
              }
            }
          });
          if (UAfEWDNMT[UAQCoXOzrC].hasAttribute("title")) {
            if (UAfEWDNMT[UAQCoXOzrC].text.trim() == UAfEWDNMT[UAQCoXOzrC].getAttribute("title").trim()) {
              UAfEWDNMT[UAQCoXOzrC].removeAttribute("title");
            }
          }
          if (!UAfEWDNMT[UAQCoXOzrC].hasAttribute("href")) {
            UAfEWDNMT[UAQCoXOzrC].setAttribute("href", "#");
            UAfEWDNMT[UAQCoXOzrC].addEventListener("click", function(UAeZhAzmIV) {
              UAeZhAzmIV.preventDefault();
            });
          }
        }
      }
    }
  })();
};
andiUA.UANmhFsyEu = function() {
  (function() {
    andiUA.UAQxCfaQHH(andiUA.UAillQtC.UApGsYsH);
    andizxc("iframe").each(function() {
      try {
        var UAiVxbFQOmages = andizxc(this).contents().find(andiUA.UAillQtC.UApGsYsH);
        andiUA.UAQxCfaQHH(UAiVxbFQOmages);
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
  })();
};
andiUA.UAQxCfaQHH = function(UAiVxbFQOmages) {
  (function() {
    andizxc(UAiVxbFQOmages).each(function() {
      if (!andizxc(this).is("[UAfZsWgcMK]")) {
        if (andizxc(this).attr("src") != undefined) {
          var alt1 = andizxc(this).attr("src").UAEHPHsu();
          var alt2 = andizxc(this).attr("src").UARZDJAJ();
        }
        if (andizxc(this).attr("alt") == undefined || andizxc(this).attr("alt") == alt1 || andizxc(this).attr("alt") == alt2) {
          andizxc(this).attr("alt", "");
          this.setAttribute("UAfZsWgcMK", "true");
        }
      }
    });
  })();
};
andiUA.UAMjfFax = function(UApPmvXomj) {
  (function() {
    andiUA.UAJVgnD = function(UANFcMGCgTLAEdw) {
      for (var UAQFJslXzA = 0; UAQFJslXzA < UANFcMGCgTLAEdw.length; UAQFJslXzA++) {
        var UAqpBuR = UANFcMGCgTLAEdw[UAQFJslXzA].getAttribute("href");
        if (UAqpBuR != "" && UAqpBuR != null) {
          if (UAqpBuR.indexOf("facebook.com/") > -1 && window.location.host.indexOf("facebook.com/") == -1) {
            UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UArGRmQUv);
            UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
          } else {
            if (UAqpBuR.indexOf("twitter.com/") > -1 && window.location.host.indexOf("twitter.com/") == -1) {
              UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAZrIuiqYm);
              UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
            } else {
              if (UAqpBuR.indexOf("youtube.com/") > -1 && window.location.host.indexOf("youtube.com/") == -1) {
                UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAZVEcyfE);
                UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
              } else {
                if (UAqpBuR.indexOf("waze://?q") > -1 && window.location.host.indexOf("waze://?q") == -1) {
                  UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAqBrgpnUq);
                  UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
                } else {
                  if (UAqpBuR.indexOf("instagram.com/") > -1 && window.location.host.indexOf("instagram.com/") == -1) {
                    UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAOMPmPI);
                    UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
                  } else {
                    if (UAqpBuR.indexOf("linkedin.com/") > -1 && window.location.host.indexOf("linkedin.com/") == -1) {
                      UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UArhcSyrwM);
                      UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
                    } else {
                      if (UAqpBuR.indexOf("plus.google.com/") > -1 && window.location.host.indexOf("plus.google.com/") == -1) {
                        UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAFfToKz);
                        UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
                      } else {
                        if (UAqpBuR.indexOf("mailto:") > -1) {
                          UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("aria-label", andiUA.UAkwBrKq.UAcTZbFz);
                          UANFcMGCgTLAEdw[UAQFJslXzA].setAttribute("UACsKzRE", "true");
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    };
    if (UApPmvXomj) {
      var UANFcMGCgTLAEdw = document.querySelectorAll("a");
      if (UANFcMGCgTLAEdw != undefined && UANFcMGCgTLAEdw.length > 0) {
        andiUA.UAJVgnD(document.querySelectorAll("a"));
      }
      var ANDI2allIframes = document.querySelectorAll("iframe");
      for (var UAQFJslXzA = 0; UAQFJslXzA < ANDI2allIframes.length; UAQFJslXzA++) {
        try {
          var UANFcMGCgTLAEdw = ANDI2allIframes[UAQFJslXzA].contentWindow.document.querySelectorAll("a");
          if (UANFcMGCgTLAEdw != undefined && UANFcMGCgTLAEdw.length > 0) {
            andiUA.UAJVgnD(UANFcMGCgTLAEdw);
          }
        } catch (ANDIUADYzBx) {
          if (andiUA.UAillQtC.UAwoFuMbS) {
            console.log("UADYzBxor: " + ANDIUADYzBx);
          }
        }
      }
    }
  })();
};
andiUA.UAFVxKpN = function(UAyemTynwK) {
  (function() {
    if (UAyemTynwK != undefined && UAyemTynwK) {
      andizxc("table").each(function() {
        if (!andizxc(this).is(andiUA.UAillQtC.UAqFQro)) {
          andizxc(this)[0].addAttr({"role":"presentation"});
        }
      });
    }
  })();
};
andiUA.UADJtbe = function(UAYPQUDCz) {
  (function() {
    try {
      var UAWcmPk = function(UAqswydxsW) {
        for (var UAQCoXOzrC = 0; UAQCoXOzrC < UAqswydxsW.length; UAQCoXOzrC++) {
          var UAAEnmnY = UAqswydxsW[UAQCoXOzrC].attributes;
          for (var TUAj = 0; TUAj < UAAEnmnY.length; TUAj++) {
            var UAhbehnj = UAAEnmnY[TUAj].nodeValue.toLowerCase();
            var UAzpPxsjG = UAAEnmnY[TUAj].nodeName.toLowerCase();
            for (var ii in andiUA.keys.UAHxyDTXgw) {
              if (UAhbehnj.indexOf(andiUA.keys.UAHxyDTXgw[ii]) > -1) {
                UAqswydxsW[UAQCoXOzrC].setAttribute("tabindex", "0");
                UAqswydxsW[UAQCoXOzrC].setAttribute("role", "link");
                UAqswydxsW[UAQCoXOzrC].setAttribute("aria-label", andiUA.UAkwBrKq.UAbkuOxJxJ);
              }
            }
            for (var ii in andiUA.keys.UANoXzHxU) {
              if (UAhbehnj.indexOf(andiUA.keys.UANoXzHxU[ii]) > -1) {
                UAqswydxsW[UAQCoXOzrC].setAttribute("tabindex", "0");
                UAqswydxsW[UAQCoXOzrC].setAttribute("role", "button");
              }
            }
            for (var ii in andiUA.keys.UAkPQJgRih) {
              if (UAhbehnj.indexOf(andiUA.keys.UAkPQJgRih[ii]) > -1) {
                UAqswydxsW[UAQCoXOzrC].setAttribute("tabindex", "0");
                UAqswydxsW[UAQCoXOzrC].setAttribute("role", "button");
              }
            }
          }
        }
      };
      var UAqswydxsW = document.querySelectorAll(UAYPQUDCz);
      UAWcmPk(UAqswydxsW);
      for (var UAQFJslXzA = 0; UAQFJslXzA < andiUA.ANDI2allIframes.length; UAQFJslXzA++) {
        try {
          var UAqswydxsW = andiUA.ANDI2allIframes[UAQFJslXzA].contentWindow.document.querySelectorAll(UAYPQUDCz);
          UAWcmPk(UAqswydxsW);
        } catch (ANDIUADYzBx) {
          if (andiUA.UAillQtC.UAwoFuMbS) {
            console.log("UADYzBxor: " + ANDIUADYzBx);
          }
        }
      }
    } catch (ANDIUADYzBx$4) {
      if (andiUA.UAillQtC.UAwoFuMbS) {
        console.log("UADYzBxor: " + ANDIUADYzBx$4);
      }
    }
  })();
};
andiUA.UAZcBEj = function(UAGoGVp) {
  (function() {
    if (UAGoGVp != undefined && UAGoGVp.length > 0) {
      for (var TUAj = 0; TUAj < UAGoGVp.length; TUAj++) {
        if (andiUA.UAyrJYN(UAGoGVp[TUAj].UAgGbGIdPy, UAGoGVp[TUAj].UAYrWQNxMo)) {
          if (UAGoGVp[TUAj].UAjWhFlQZ != "") {
            var UAjWhFlQZ = UAGoGVp[TUAj].UAjWhFlQZ;
            var UADRvIkEWO = UAGoGVp[TUAj].UADRvIkEWO;
            var UANlOSZtZ = UAGoGVp[TUAj].UANlOSZtZ;
            var UAqswydxsW = document.querySelectorAll(UAjWhFlQZ);
            for (var UAQFJslXzA = 0; UAQFJslXzA < UAqswydxsW.length; UAQFJslXzA++) {
              UAqswydxsW[UAQFJslXzA].setAttribute("role", "checkbox");
              UAqswydxsW[UAQFJslXzA].setAttribute("tabindex", "0");
              UAqswydxsW[UAQFJslXzA].setAttribute("aria-label", UAqswydxsW[UAQFJslXzA].text);
              UAqswydxsW[UAQFJslXzA].addEventListener("click", function(UAeZhAzmIV) {
                andiUA.UAqbCsqYf(UADRvIkEWO, UANlOSZtZ);
                setTimeout(function() {
                  if (UAqswydxsW[UAQFJslXzA].classList.contains(UADRvIkEWO)) {
                    andizxc("body").append('<span class="UAxnXSd" role="alert" aria-label="' + andiUA.UAkwBrKq.UAGoGVpMark + '"></span>');
                    setTimeout(function() {
                      andizxc(".UAxnXSd").remove();
                    }, 500);
                  } else {
                    andizxc("body").append('<span class="UAxnXSd" role="alert" aria-label="' + andiUA.UAkwBrKq.UAhYxdjl + '"></span>');
                    setTimeout(function() {
                      andizxc(".UAxnXSd").remove();
                    }, 500);
                  }
                }, 500);
                UAeZhAzmIV.preventDefault();
              });
            }
          }
          andiUA.UAqbCsqYf(UADRvIkEWO, UANlOSZtZ);
        }
      }
    }
  })();
};
andiUA.UATcpdVe = function() {
  (function() {
    var UAVNVOWoTl = '[role="heading"],h1,h2,h3,h4,h5,h6';
    andiUA.UAgkDhoW(UAVNVOWoTl);
    andizxc("iframe").each(function() {
      try {
        andiUA.UAgkDhoW(andizxc(this).contents().find(UAVNVOWoTl));
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
    if (andizxc("h1").length > 1) {
      andizxc("h1").each(function(i) {
        if (i > 0) {
          andizxc(this).attr({"aria-lavel":"2", "role":"heading"});
        }
      });
    }
  })();
};
andiUA.UAgkDhoW = function(UAVNVOWoTl) {
  (function() {
    andizxc(UAVNVOWoTl).each(function() {
      var UAtsFGiwQ = false;
      if (andizxc(this).text().trim() == "") {
        andizxc(this)[0].addAttr({"role":"presentation", "UAHKyqo":"true"});
      }
    });
  })();
};
andiUA.UAwRdhK = function(UAuuJvaJi) {
  (function() {
    if (UAuuJvaJi != undefined && UAuuJvaJi.length > 0) {
      UAuuJvaJi = andizxc(UAuuJvaJi);
      var UALSnqjy = UAuuJvaJi.length, UAcErxp = new Array(UALSnqjy), UAPDvQWG = new Array(UALSnqjy), UAgVBWGxy = new Array(UALSnqjy), UAUXMna = new Array(UALSnqjy), UAuIrgiCO = new Array(UALSnqjy), UAbxYdDmRq = new Array(UALSnqjy), UAOOpeU = new Array(UALSnqjy), UATWSAcUC = new Array(UALSnqjy), UAsewLBW = new Array(UALSnqjy), UAteqQBRAJ = new Array(UALSnqjy), UAPSVRcw = 
      new Array(UALSnqjy), UACDtsPXs = new Array(UALSnqjy), UAsTAbK = new Array(UALSnqjy), UAOEPeZxh = new Array(UALSnqjy), UANDGNiBOo = new Array(UALSnqjy), UAqkiqGGN = new Array(UALSnqjy), UAqIdBWq = new Array(UALSnqjy), UAjWArKRiv = new Array(UALSnqjy), UAfJEzKNw = new Array(UALSnqjy), UAScdbGd = new Array(UALSnqjy), UAoxJWOs = new Array(UALSnqjy), UAvLPAz = new Array(UALSnqjy), 
      UAQHRSPPyc = new Array(UALSnqjy), UApOFEcjeJ = new Array(UALSnqjy), UAZIjeasE = new Array(UALSnqjy), UAauUQc = new Array(UALSnqjy), UActOZAB = new Array(UALSnqjy), UAbmfry = new Array(UALSnqjy), UAyvQFZW = new Array(UALSnqjy), UADWqEem = new Array(UALSnqjy), UAFhQbBGe = new Array(UALSnqjy), UAOMaAmrch = new Array(UALSnqjy), UATWZfftE = new Array(UALSnqjy), UAvlJGk = 
      new Array(UALSnqjy), UAlnSUqQ = new Array(UALSnqjy), UAhHStjrL = new Array(UALSnqjy), UABSKFkhP = new Array(UALSnqjy);
      andizxc(UAuuJvaJi).each(function(UAQFJslXzA) {
        if (!andizxc(this).UAFPNhTLpA2()) {
          var UAxgNQvG = UAQFJslXzA;
          var UAeqQVbcIK = andizxc(this);
          andizxc(this)[0].addAttr({"UAGZZAJ":"true"});
          var UAAEnmnY = andizxc(this)[0].attributes;
          for (var TUAj = 0; TUAj < UAAEnmnY.length; TUAj++) {
            var UAhbehnj = UAAEnmnY[TUAj].nodeValue.toLowerCase();
            var UAzpPxsjG = UAAEnmnY[TUAj].nodeName.toLowerCase();
            if (UAzpPxsjG == "required") {
              andizxc(UAeqQVbcIK)[0].addAttr({"aria-required":"true"});
              UATWZfftE[UAQFJslXzA] = true;
              UAOhBQwFm.UATWZfftE++;
            }
            for (var ii in andiUA.keys.UAfCpGK) {
              if (UAzpPxsjG.indexOf(andiUA.keys.UAfCpGK[ii]) > -1 || UAhbehnj.indexOf(andiUA.keys.UAfCpGK[ii]) > -1) {
                andizxc(UAeqQVbcIK)[0].addAttr({"aria-required":"true"});
                UATWZfftE[UAQFJslXzA] = true;
                UAOhBQwFm.UATWZfftE++;
              }
            }
            for (var ii in andiUA.keys.UAzrqTPw) {
              if (UAhbehnj.indexOf(andiUA.keys.UAzrqTPw[ii]) > -1) {
                UAgVBWGxy[UAQFJslXzA] = true;
                UAOhBQwFm.UAgVBWGxy++;
              }
            }
            for (var ii in andiUA.keys.UArOBLyi) {
              if (UAhbehnj.indexOf(andiUA.keys.UArOBLyi[ii]) > -1) {
                UAcErxp[UAQFJslXzA] = true;
                UAvlJGk[UAQFJslXzA] = parseInt(UAhbehnj);
                UAOhBQwFm.UAcErxp++;
              }
              if (UAzpPxsjG.indexOf(andiUA.keys.UArOBLyi[ii]) > -1) {
                UAcErxp[UAQFJslXzA] = true;
                UAvlJGk[UAQFJslXzA] = parseInt(UAhbehnj);
                UAOhBQwFm.UAcErxp++;
              }
            }
            for (var ii in andiUA.keys.UAYyffQk) {
              if (UAhbehnj.indexOf(andiUA.keys.UAYyffQk[ii]) > -1) {
                UAPDvQWG[UAQFJslXzA] = true;
                UAlnSUqQ[UAQFJslXzA] = parseInt(UAhbehnj);
                UAOhBQwFm.UAPDvQWG++;
              }
              if (UAzpPxsjG.indexOf(andiUA.keys.UAYyffQk[ii]) > -1) {
                UAPDvQWG[UAQFJslXzA] = true;
                UAOhBQwFm.UAPDvQWG++;
                UAlnSUqQ[UAQFJslXzA] = parseInt(UAhbehnj);
              }
            }
            for (var ii in andiUA.keys.UAAeCAQhlv) {
              if (UAhbehnj.indexOf(andiUA.keys.UAAeCAQhlv[ii]) > -1) {
                UAUXMna[UAQFJslXzA] = true;
                UAOhBQwFm.UAUXMna++;
              }
            }
            for (var ii in andiUA.keys.UAHXFPR) {
              if (UAhbehnj.indexOf(andiUA.keys.UAHXFPR[ii]) > -1) {
                UAOOpeU[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UAOOpeU++;
                UAOhBQwFm.UABSKFkhP++;
              }
            }
            for (var ii in andiUA.keys.UAwhnThz) {
              if (UAhbehnj.indexOf(andiUA.keys.UAwhnThz[ii]) > -1) {
                UATWSAcUC[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UATWSAcUC++;
              }
            }
            for (var ii in andiUA.keys.UAHyNwyq) {
              if (UAhbehnj.indexOf(andiUA.keys.UAHyNwyq[ii]) > -1) {
                UAqkiqGGN[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAqkiqGGN++;
              }
            }
            for (var ii in andiUA.keys.UAPMLRswRY) {
              if (UAhbehnj.indexOf(andiUA.keys.UAPMLRswRY[ii]) > -1) {
                UAqIdBWq[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
              }
            }
            for (var ii in andiUA.keys.UAgcGGM) {
              if (UAhbehnj.indexOf(andiUA.keys.UAgcGGM[ii]) > -1) {
                UAjWArKRiv[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAjWArKRiv++;
              }
            }
            for (var ii in andiUA.keys.UAxYqRBaGg) {
              if (UAhbehnj.indexOf(andiUA.keys.UAxYqRBaGg[ii]) > -1) {
                UAfJEzKNw[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAfJEzKNw++;
              }
            }
            for (var ii in andiUA.keys.UAtAPCKEQT) {
              if (UAhbehnj.indexOf(andiUA.keys.UAtAPCKEQT[ii]) > -1) {
                UAScdbGd[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAScdbGd++;
              }
            }
            for (var ii in andiUA.keys.UAvMryiRF) {
              if (UAhbehnj.indexOf(andiUA.keys.UAvMryiRF[ii]) > -1) {
                UAoxJWOs[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAoxJWOs++;
              }
            }
            for (var ii in andiUA.keys.UAVjMyCb) {
              if (UAhbehnj.indexOf(andiUA.keys.UAVjMyCb[ii]) > -1) {
                UAvLPAz[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAvLPAz++;
              }
            }
            for (var ii in andiUA.keys.UAmCMwwjtJ) {
              if (UAhbehnj.indexOf(andiUA.keys.UAmCMwwjtJ[ii]) > -1) {
                UAQHRSPPyc[UAQFJslXzA] = true;
                UABSKFkhP[UAQFJslXzA] = true;
                UAOhBQwFm.UABSKFkhP++;
                UAOhBQwFm.UAQHRSPPyc++;
              }
            }
          }
          andizxc(UAeqQVbcIK).bind("blur keydown", function(UAeZhAzmIV) {
            var keyCode = UAeZhAzmIV.keyCode || UAeZhAzmIV.which;
            if (keyCode == 9 && !andizxc(UAeqQVbcIK).is("[andidontcheckvalid]")) {
              if (!UAeZhAzmIV.shiftKey) {
                UAupOZqcsK = andizxc(UAeqQVbcIK).val();
                if (UATWZfftE[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAHhukbiI();
                }
                if (UAgVBWGxy[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                }
                if (UAcErxp[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(UAvlJGk[UAQFJslXzA]);
                }
                if (UAPDvQWG[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UArJYVoldP(UAlnSUqQ[UAQFJslXzA]);
                }
                if (UAUXMna[UAQFJslXzA] && !andizxc(UAeqQVbcIK).is('[role="radio"],[role="checkbox"],[type="radio"],[type="checkbox"]')) {
                  andizxc(UAeqQVbcIK).andiFormEmailValidation();
                }
                if (UAOOpeU[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAdXZMy();
                }
                if (UATWSAcUC[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAdXZMy();
                }
                if (UAqkiqGGN[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                }
                if (UAqIdBWq[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                }
                if (UAjWArKRiv[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(7);
                }
                if (UAfJEzKNw[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA] && !andizxc(UAeqQVbcIK).is('[role="radio"],[role="checkbox"],[type="radio"],[type="checkbox"]')) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(3);
                }
                if (UAScdbGd[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                }
                if (UAoxJWOs[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(2);
                }
                if (UAvLPAz[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(2);
                }
                if (UAQHRSPPyc[UAQFJslXzA] && UABSKFkhP[UAQFJslXzA]) {
                  andizxc(UAeqQVbcIK).UAlOQHPT();
                  andizxc(UAeqQVbcIK).UAIcRXgjQ(2);
                }
              }
            }
          });
        }
      });
    }
  })();
};
andiUA.keys = {UAiKhAMZn:["search", "srch"], UAfCpGK:["required", "*"], UAzrqTPw:["\u05de\u05e1\u05e4\u05e8", "num", "number"], UArOBLyi:["minlength"], UAYyffQk:["maxlength"], UAAeCAQhlv:["mail", "\u05d3\u05d5\u05d0\u05e8 \u05d0\u05dc\u05e7\u05d8\u05e8\u05d5\u05e0\u05d9", "\u05de\u05d9\u05d9\u05dc"], UAHXFPR:["name", "firstname", "fname", "\u05e9\u05dd \u05e4\u05e8\u05d8\u05d9", "\u05e9\u05dd \u05de\u05dc\u05d0", "first name"], 
UAwhnThz:["lastname", "lname", "\u05e9\u05dd \u05de\u05e9\u05e4\u05d7\u05d4", "last name"], UAfVfQcY:["UserName", "User Name", "\u05e9\u05dd \u05de\u05ea\u05e9\u05de\u05e9"], UAVdoDfGNo:["password", "pass", "\u05e1\u05d9\u05e1\u05de\u05d4"], UAmlmgZ:["password confirm", "passwordconfirm", "password_confirm", "confirm password", "confirmpassword", "confirm_password", "\u05d0\u05d9\u05de\u05d5\u05ea \u05e1\u05d9\u05e1\u05de\u05d4"], UApKUwsdO:["address"], 
UAzzUCx:["country"], UAgRbirFd:["city"], UACwFlzJhe:["street"], UAHyNwyq:["zip", "postcode"], UAPMLRswRY:["POBox"], UAgcGGM:["phone", "telephone", "tel", "mobile", "fax", "\u05e4\u05e7\u05e1", "\u05e0\u05d9\u05d9\u05d3", "\u05de\u05d5\u05d1\u05d9\u05d9\u05dc", "\u05e1\u05dc\u05d5\u05dc\u05e8\u05d9"], UAxYqRBaGg:["prefix", "pref"], UAtAPCKEQT:["date"], UAvMryiRF:["yy", "yyyy", "\u05e9\u05e0\u05d4", "\u05e9\u05e0\u05ea \u05dc\u05d9\u05d3\u05d4", 
"\u05e9\u05e0\u05ea", "year"], UAVjMyCb:["mm", "month", "\u05d7\u05d5\u05d3\u05e9"], UAmCMwwjtJ:["\u05d9\u05d5\u05dd", "day"], UAfRvynuu:["cardmonth", "expdate_month", "expdatemonth"], UAvCYzHD:["cardyear"], UAMbyVtvz:["cc", "creditcard", "\u05d0\u05e9\u05e8\u05d0\u05d9", "\u05db\u05e8\u05d8\u05d9\u05e1", "cardno", "cardnumb", "card_Id"], UAdcWzvGtw:["payments"], UAWMAIGo:["cvv", "\u05e7\u05d5\u05d3 \u05d0\u05d1\u05d8\u05d7\u05ea \u05db\u05e8\u05d8\u05d9\u05e1", 
"3 \u05e1\u05e4\u05e8\u05d5\u05ea \u05d0\u05d7\u05e8\u05d5\u05e0\u05d5\u05ea \u05d1\u05d2\u05d1 \u05d4\u05db\u05e8\u05d8\u05d9\u05e1"], UAsUmSSWxr:["captcha", "accesscode"], UAvdCcVD:["units", "amount", "quantity", "item"], UAtKpqw:["UAzCHACuhv", "msg", "textarea", "comments", "content", "description", "dscrpt"], UAQZrRvgaj:["subject", "\u05d4\u05d5\u05d3\u05e2\u05d4"], UANoXzHxU:["next", "leftarrow"], UAkPQJgRih:["prev", "rightarrow"], UAHxyDTXgw:["scroll-top", 
"to the top", "to-the-top", "scrollUp", "to-top", "totop", "#top"], UAZpeAtnlt:["rubric", "title", "heading", "caption"]};
andiUA.UAwgWNaQMX = function() {
  (function() {
    var UAegSkXs = 0, UApcXMOniI = 0;
    window.onmousemove = function(UAeZhAzmIV) {
      UAegSkXs = UAeZhAzmIV.PageX;
      UApcXMOniI = UAeZhAzmIV.PageY;
    };
    andizxc(document).keydown(function(UAeZhAzmIV) {
      if (UAeZhAzmIV.keyCode == 17) {
        if (UAegSkXs == undefined) {
          UAegSkXs = 0;
        }
        if (UApcXMOniI == undefined) {
          UApcXMOniI = 0;
        }
        UAOhBQwFm.ANDI2controlKeyDown++;
        var UAQCoXOzrCNDI2BGcolor;
        UAQCoXOzrCNDI2BGcolor = localStorage.UAKZZMYJ;
        andizxc("body").append('<div class="UAQCoXOzrCndiCssReser UAHMbcBkPL" id="UAHMbcBkPL"></div>');
        andizxc(".UAHMbcBkPL").css({"position":"absolute", "z-index":"10000", "background-color":UAQCoXOzrCNDI2BGcolor, "top":UApcXMOniI - 15 + "px", "left":UAegSkXs - 15 + "px"}).fadeOut(1000).fadeIn(100).fadeOut(1000).fadeIn(100).fadeOut(1000);
        setTimeout(function() {
          andizxc(".UAHMbcBkPL").remove();
        }, 3000);
      }
    });
  })();
};
andiUA.UAfimkMHzz = function(UACQZeio) {
  (function() {
    if (UACQZeio != undefined && UACQZeio.length > 0) {
      andizxc(UACQZeio).each(function(UAQFJslXzA) {
        andiUA.UAYfOASP(andizxc(this), UAQFJslXzA);
      });
      andizxc("iframe").each(function(TUAj) {
        try {
          var UAjWhFlQZIframe = andizxc(this);
          andizxc(this).contents().find(UACQZeio).each(function(UAQFJslXzA) {
            andiUA.UAYfOASP(andizxc(this), TUAj);
          });
        } catch (ANDIUADYzBx) {
          if (andiUA.UAillQtC.UAwoFuMbS) {
            console.log("UADYzBxor: " + ANDIUADYzBx);
          }
        }
      });
    }
  })();
};
andiUA.UAYfOASP = function(UASaFAgWJo, UAUGlHNT) {
  (function() {
    var UAMsXjvKg = andizxc(UASaFAgWJo).parent();
    var UAkRJKXAIopP = parseInt(andizxc(UASaFAgWJo).position().top);
    var UAIvdFIAEeftP = parseInt(andizxc(UASaFAgWJo).position().left);
    andizxc("form").on("click", ".UAQCoXOzrCndiPaushButton" + UAUGlHNT, function(evt) {
      evt.preventDefault();
    });
    andizxc(UASaFAgWJo).closest("body").find(UAMsXjvKg).attr({"data-id":"andiButtonHere"});
    if (andizxc(UAMsXjvKg).find(".UAQCoXOzrCndiPaushButton" + UAUGlHNT).length == 0) {
      andizxc(UAMsXjvKg).prepend('<input type="image" style="top: ' + UAkRJKXAIopP + "px; left: " + UAIvdFIAEeftP + 'px;z-index:99999999999;position: absolute;" class="UAQCoXOzrCndiPaushButton' + UAUGlHNT + '" src="data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%20viewBox%3D%220%200%2024%2024%22%3E%3Cpath%20opacity%3D%22.75%22%20fill%3D%22%23424242%22%20d%3D%22M0%200h24v24H0z%22%2F%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M10.69%205.604v13c0%20.16-.06.3-.175.417-.117.117-.256.176-.416.176H5.37c-.16%200-.3-.06-.415-.175-.117-.116-.176-.255-.176-.415v-13c0-.16.06-.3.177-.416.116-.118.255-.177.415-.177H10.1c.16%200%20.3.06.416.176.116.117.174.254.174.414zm8.274%200v13c0%20.16-.06.3-.175.417-.118.117-.257.176-.417.176h-4.728c-.16%200-.3-.06-.416-.175-.117-.116-.176-.255-.176-.415v-13c0-.16.06-.3.175-.416.116-.118.255-.177.415-.177h4.728c.16%200%20.3.06.416.176.115.117.174.254.174.414z%22%2F%3E%3C%2Fsvg%3E " id="KeXR0" alt="' + 
      andiUA.UAkwBrKq.UAWjwQJVAv + '" >');
    }
    if (andizxc(UASaFAgWJo).closest("html").find("#UAQCoXOzrCndiFlash" + UAUGlHNT).length == 0) {
      andizxc(UASaFAgWJo).closest("html").find("head").append('<style id="UAQCoXOzrCndiFlash' + UAUGlHNT + '"> #TUAUAiVxbFQOmg' + UAUGlHNT + "{top: " + UAkRJKXAIopP + "px; left: " + UAIvdFIAEeftP + "px;position:absolute;visibility:visible;z-index:999999;}.UAQCoXOzrCndiPaushButton" + UAUGlHNT + "{width:18px;height:18px;border:none;}<style>");
    }
    andizxc(UAMsXjvKg).find(".UAQCoXOzrCndiPaushButton" + UAUGlHNT).click(function() {
      if (andizxc(UASaFAgWJo).closest("body").find("#TUAUAiVxbFQOmg" + UAUGlHNT).length == 0) {
        andizxc(UASaFAgWJo).closest("body").find(this).after('<div id="TUAUAiVxbFQOmg' + UAUGlHNT + '" style="width:' + andizxc(UASaFAgWJo).width() + "px;height:" + andizxc(UASaFAgWJo).height() + "px;background-color:" + andiUA.UAillQtC.UAWzVSxJK.backgroundColor + ';">' + andiUA.UAkwBrKq.UAWjwQJVAv2 + "</div>");
      } else {
        andizxc(UASaFAgWJo).closest("body").find("#TUAUAiVxbFQOmg" + UAUGlHNT).remove();
      }
    });
  })();
};
andiUA.UAExiqeQZn = function() {
  (function() {
    andizxc(".UAxpPrwl").remove();
    andizxc("head").append('<style class="UAxpPrwl"> :focus{box-shadow: 0px 0px 10px DimGray !important;}</style>');
    andizxc("iframe").each(function() {
      try {
        andizxc(this).contents().find(".UAxpPrwl").remove();
        andizxc(this).contents().find("head").append('<style class="UAxpPrwl"> :focus{box-shadow: 0px 0px 10px DeepSkyBlue !important;} [tabindex]:not([tabindex="-1"]):focus,[role="button"]:focus,button:focus,select:focus,textarea:focus,input:focus{box-shadow: 0px 0px 10px DimGray !important;}</style>');
      } catch (ANDIUADYzBx) {
        if (andiUA.UAillQtC.UAwoFuMbS) {
          console.log("UADYzBxor: " + ANDIUADYzBx);
        }
      }
    });
  })();
};
andiUA.UAyAuAMT = function(UAyAuAMTsetting) {
  (function() {
    if (UAyAuAMTsetting != undefined && UAyAuAMTsetting.length > 0) {
      andizxc(UAyAuAMTsetting).each(function(UAQFJslXzA) {
        andizxc(UAyAuAMTsetting[UAQFJslXzA].UAjWhFlQZ).each(function(TUAj) {
          andizxc(this)[0].addAttr({"aria-label":UAyAuAMTsetting[UAQFJslXzA].UACIGcAIN, "UAgpTVVwqA":UAyAuAMTsetting[UAQFJslXzA].UACIGcAIN});
        });
      });
      andizxc("iframe").each(function(x) {
        try {
          andizxc(UAyAuAMTsetting).each(function(ANDIb) {
            andizxc(this).contents().find(UAyAuAMTsetting[ANDIb].UAjWhFlQZ).each(function(TUAj) {
              andizxc(this)[0].addAttr({"aria-label":UAyAuAMTsetting[ANDIb].UACIGcAIN, "UAgpTVVwqA":UAyAuAMTsetting[ANDIb].UACIGcAIN});
            });
          });
        } catch (ANDIUADYzBx) {
          if (andiUA.UAillQtC.UAwoFuMbS) {
            console.log("UADYzBxor: " + ANDIUADYzBx);
          }
        }
      });
    }
  })();
};
andiUA.UAEunaSfC = function() {
  (function() {
    function UAMjQut() {
      andizxc("#UACOzZU").css("display", "none");
      andizxc('#UACOzZU [role="button"]').attr({"tabindex":"-1"});
      andizxc("#UAMkOFIJ")[0].addAttr({"UACOzZU":"false"});
    }
    UAawmhuZg = function() {
      if (andizxc("#UAySEaikDzStyle").length == 0) {
        andiUA.UAExiqeQZn();
        andiUA.UAcpohFfvx();
      } else {
        andiUA.UAheLqhhangehighLightFocus();
      }
    };
    UAyWcTZ = function() {
      if (localStorage.getItem("UAEunaSfC") != "true") {
        andizxc("#UAMkOFIJ")[0].addAttr({"UACOzZU":"false"});
        UAMjQut();
        UAawmhuZg();
        localStorage.removeItem("noUAEunaSfC");
        localStorage.setItem("UAEunaSfC", "true");
      }
    };
    if (andiUA.UAMjeps) {
      andiUA.UAExiqeQZn();
      andiUA.UAcpohFfvx();
      return false;
    }
    if (window.innerWidth > 700) {
      var UAwhXdJkW = document.querySelector("head").innerHTML.indexOf("UA2StyleSheetLTR") > -1 ? false : true;
      var UALNPBloC = false;
      var UAtGqkpI = "z-index:99999999999;\tdisplay:none; border-radius:5px; margin:10px;background-color: rgba(0, 0, 0, 0.65);height:75px;box-sizing:border-box;text-align:" + (UAwhXdJkW ? "right" : "left") + " ; width:360px;padding: 23px 20px 10px;;position:fixed;color:#fff !important ;bottom:0";
      var UAYczxZ = "";
      var UAwTnZpZ = "z-index:99999999999;\twidth: 25px;   position: absolute; top: 8px; " + (UAwhXdJkW ? "left" : "right") + ": 7px;";
      andizxc("#UAPtHya").append('<div aria-hidden="true" id="UACOzZU" style="' + UAtGqkpI + '"><div style="' + UAYczxZ + '"></div>' + andiUA.UAkwBrKq.UAXKngnFPl2158 + '<div  style="' + UAwTnZpZ + '" aria-label="' + andiUA.UAkwBrKq.UAXKngnFPl2159 + '" id="UAsGajM" role="button" tabindex="0">X</div></div>');
      if (parseInt(andizxc("#UACOzZU").css("right")) != "NaN" && parseInt(andizxc("#UACOzZU").css("right")) < 40) {
        andizxc("#UACOzZU").css("right", "40px");
      }
      if (parseInt(andizxc("#UACOzZU").css("left")) != "NaN" && parseInt(andizxc("#UACOzZU").css("left")) < 40) {
        andizxc("#UACOzZU").css("left", "40px");
      }
      eventOn("click", "#UAZyonqCx", function(e) {
        if (localStorage.getItem("UAEunaSfC") != "true") {
          UAMjQut();
          UAyWcTZ();
        }
      });
      eventOn("keydown", "#UAMkOFIJ", function(e) {
        if (e.keyCode == 89) {
          andizxc("#UAZyonqCx").click();
        }
      });
      eventOn("click", "#UAsGajM", function(e) {
        andizxc("#UACOzZU").css("display", "none");
        localStorage.removeItem("UAEunaSfC");
        localStorage.setItem("noUAEunaSfC", "true");
        setTimeout(function() {
          andizxc("#UAMkOFIJ")[0].addAttr({"UACOzZU":"false"});
        }, 100);
      });
      eventOn("keydown", "#UAsGajM", function(e) {
        if (e.keyCode == 13) {
          this.click();
        }
      });
      if (localStorage.getItem("UAEunaSfC") == "true") {
        UAawmhuZg();
      } else {
        if (localStorage.getItem("noUAEunaSfC") == "true") {
          localStorage.removeItem("UAEunaSfC");
        } else {
          UAMMYKxLHk = [];
          var myVar, UAgOribxyx;
          andizxc(document).on("keydown", function toovya(e) {
            if (localStorage.getItem("noUAEunaSfC") != "true" && localStorage.getItem("UAEunaSfC") != "true") {
              if (e.target.tagName != "INPUT" && e.target.tagName != "TEXTAREA" && e.target.tagName != "SELECT") {
                if (myVar != undefined) {
                  clearTimeout(myVar);
                }
                if (e.keyCode == 89 && localStorage.getItem("UAEunaSfC") != "true") {
                  if (UAgOribxyx != undefined) {
                    clearTimeout(UAgOribxyx);
                  }
                  UAMjQut();
                  UAyWcTZ();
                }
                if (e.keyCode == 9 && localStorage.getItem("UAEunaSfC") != "true") {
                  andizxc("#UACOzZU").css("display", "inline-block");
                  andizxc('#UACOzZU [role="button"]').attr({"tabindex":"0"});
                  UAMMYKxLHk.push("tab");
                  if (UAMMYKxLHk.length >= 3) {
                    if (localStorage.getItem("UAEunaSfC") != "true") {
                      UAyWcTZ();
                    }
                  }
                  myVar = setTimeout(function() {
                    UAMMYKxLHk.length = 0;
                  }, 1000);
                } else {
                  UAMMYKxLHk.length = 0;
                }
              }
            }
          });
        }
      }
    }
  })();
};
andiUA.UAfAhhffVt = function() {
  return function() {
    var UAxSWAqK = [];
    var UAlElPZLo = localStorage.getItem("UAlElPZLo");
    UARIvkQI = document.querySelectorAll("[UAvGyiRT]");
    for (var i = 0; i < UARIvkQI.length; i++) {
      var UAmInvuRp = UARIvkQI[i].getAttribute("UATHdfS");
      if (UAmInvuRp != "null" && parseInt(UAmInvuRp) > parseInt(UAlElPZLo) + 2) {
        if (!andiUA.UANnjYP(UAxSWAqK, UAmInvuRp)) {
          UAxSWAqK.push(parseInt(UAmInvuRp));
        }
      }
    }
    UAxSWAqK.sort(function(a, b) {
      return b - a;
    });
    var UALSnqjy = UAxSWAqK.length;
    var didntMarkAsHeading = 0;
    var UATFeIYnm = 0;
    function UArFwAC(elm) {
      elm.setAttribute("role", "heading");
      elm.setAttribute("aria-level", i + 2 < 7 ? i + 2 : "6");
    }
    var UAarUoyO = function(tagName) {
      if (tagName == "a") {
        return true;
      }
      if (tagName == "input") {
        return true;
      }
      if (tagName == "button") {
        return true;
      }
      if (tagName == "h1") {
        return true;
      }
      if (tagName == "h2") {
        return true;
      }
      if (tagName == "h3") {
        return true;
      }
      if (tagName == "h4") {
        return true;
      }
      if (tagName == "h5") {
        return true;
      }
      if (tagName == "h6") {
        return true;
      }
      return false;
    };
    for (var i = 0; i < UALSnqjy; i++) {
      UARIvkQI = document.querySelectorAll('[UATHdfS="' + UAxSWAqK[i] + '"]');
      for (var j = 0; j < UARIvkQI.length; j++) {
        var UApyEWMBdh = UARIvkQI[j].tagName.toLowerCase();
        var UAKUBvUhNH = false;
        var that = UARIvkQI[j];
        UAviCYQgh = andizxc(that);
        while (andizxc(UAviCYQgh)[0].tagName.toLowerCase() != "body" && andizxc(UAviCYQgh)[0].tagName.toLowerCase() != "html") {
          UAviCYQgh = andizxc(UAviCYQgh).parent();
          if (UAarUoyO(andizxc(UAviCYQgh)[0].tagName)) {
            UAKUBvUhNH = true;
          }
        }
        UATFeIYnm++;
        var UABCuUluZ = (UARIvkQI[j].innerText || UARIvkQI[j].textContent).trim();
        var numOfSpace = UABCuUluZ.match(/([\s]+)/g);
        if (!UAarUoyO(UApyEWMBdh) && !UAKUBvUhNH) {
          if (!UARIvkQI[j].hasAttribute("role")) {
            UArFwAC(UARIvkQI[j]);
          } else {
            var parentElm = UARIvkQI[j].parentElement;
            var UAlYiLuEmY = (parentElm.innerText || parentElm.textContent).trim();
            if (UAlYiLuEmY == UABCuUluZ && UAarUoyO(parentElm.tagName.toLowerCase()) == -1 && !UARIvkQI[j].hasAttribute("role")) {
              UArFwAC(UARIvkQI[j]);
            } else {
              if (numOfSpace != null && UAlYiLuEmY.match(/([\s]+)/g) != null && numOfSpace.length + 1 == UAlYiLuEmY.match(/([\s]+)/g).length) {
                UArFwAC(UARIvkQI[j]);
              } else {
              }
            }
          }
        }
      }
    }
  }();
};
andiUA.UAfAhhffVt();
andiUA.fixBreadcrumb = function() {
  (function() {
    var wrapBreadCrumbArr = [];
    andizxc('.breadcrams, #breadcrams .breadcrumb, #breadcrumb ,.crumbs, #crumbs, [class*="breadcrumb"],[id*="breadcrumb"]').each(function() {
      var that = this;
      UAviCYQgh = andizxc(this);
      var isWrapAll = true;
      while (andizxc(UAviCYQgh)[0].tagName.toLowerCase() != "body" && andizxc(UAviCYQgh)[0].tagName.toLowerCase() != "html") {
        UAviCYQgh = andizxc(UAviCYQgh).parent();
        if (andizxc(UAviCYQgh).attr("class") != undefined && andizxc(UAviCYQgh).attr("class").indexOf("breadcrumb") > -1 || andizxc(UAviCYQgh).attr("id") != undefined && andizxc(UAviCYQgh).attr("id").indexOf("breadcrumb") > -1) {
          isWrapAll = false;
        }
      }
      if (isWrapAll) {
        wrapBreadCrumbArr.push(that);
      }
    });
    var createText = function(arrOfUAYPQUDCz) {
      var UAKSRKMLText = "";
      for (var i = arrOfUAYPQUDCz.length - 1; i >= 0; i--) {
        if (andizxc(arrOfUAYPQUDCz[i]).text().trim().length > 2) {
          var UAlqQAgXDd = andizxc(arrOfUAYPQUDCz[i]).text().trim();
          if (UAKSRKMLText.indexOf(andiUA.UAkwBrKq.UAClsWRHreadcrumb1) == -1) {
            andizxc(arrOfUAYPQUDCz[i]).attr("aria-current", "page");
            UAKSRKMLText = andiUA.UAkwBrKq.UAClsWRHreadcrumb1 + UAlqQAgXDd + " ";
          } else {
            if (andizxc(arrOfUAYPQUDCz[i]).is("a").length > 0) {
              andizxc(arrOfUAYPQUDCz[i]).attr("aria-label", andiUA.UAkwBrKq.UAClsWRHreadcrumb2 + UAlqQAgXDd);
            } else {
              if (andizxc(arrOfUAYPQUDCz[i]).find("a").length > 0) {
                andizxc(arrOfUAYPQUDCz[i]).find("a").attr("aria-label", andiUA.UAkwBrKq.UAClsWRHreadcrumb2 + UAlqQAgXDd);
              }
            }
            UAKSRKMLText = UAKSRKMLText + andiUA.UAkwBrKq.UAClsWRHreadcrumb3 + UAlqQAgXDd + " ";
          }
        }
      }
      return UAKSRKMLText;
    };
    andizxc(wrapBreadCrumbArr).each(function(i) {
      var that = this;
      if (andizxc(that)[0].children.length == 1) {
        var wraptext = andizxc(that)[0].children;
        if (wraptext.length == 1) {
          var UARIvkQI = andizxc(wraptext)[0].children;
          var allSentence = createText(UARIvkQI);
          andizxc(that).attr({"aria-label":allSentence, "tabindex":"0", "role":"dialog"});
        }
      } else {
        var UARIvkQI = andizxc(that)[0].children;
        var allSentence = createText(UARIvkQI);
        andizxc(that).attr({"aria-label":allSentence, "tabindex":"0", "role":"dialog"});
      }
    });
  })();
};
andiUA.fixBreadcrumb();
andiRunAll = function() {
  (function() {
    setTimeout(function() {
      andiUA.UATlqUog();
      andiUA.UArjWbtsJm();
    }, 30);
    setTimeout(function() {
      andiUA.UAZWNkrt();
      andiUA.UAOcqSK();
    }, 45);
    setTimeout(function() {
      andiUA.UAyAuAMT(andiUA.UAillQtC.UAyAuAMTSetting);
      andiUA.UAQrZhcR(andiUA.UAillQtC.UAAwJlJTva.UAFgPjN, andiUA.UAillQtC.UAAwJlJTva.UADfjOwFD);
    }, 60);
    setTimeout(function() {
      andizxc("iframe").each(function() {
        try {
          if (andizxc(this).attr("src")) {
            UApsXltBg = andizxc(this).contents().find(andiUA.UAillQtC.UAAwJlJTva.UAFgPjN);
            andiUA.UAwRdhK(UApsXltBg);
          }
        } catch (ANDIUADYzBx) {
          if (andiUA.UAillQtC.UAwoFuMbS) {
            console.log("UADYzBxor: " + ANDIUADYzBx);
          }
        }
      });
      andiUA.UAwRdhK(andiUA.UAillQtC.UAAwJlJTva.UAFgPjN);
    }, 80);
    setTimeout(function() {
      andiUA.UADJtbe(andiUA.UAillQtC.UAWAyAp);
      andiUA.UAZcBEj(andiUA.UAillQtC.UAGoGVp);
      andiUA.UAiahKMgF();
      andiUA.UAfAhhffVt();
    }, 100);
    setTimeout(function() {
      andiUA.UAQXGSsiCs();
      andiUA.UAyXwKk();
      andiUA.UANmhFsyEu();
      andiUA.UAMjfFax(true);
    }, 120);
    setTimeout(function() {
      andiUA.UAFVxKpN(andiUA.UAillQtC.UAyemTynwK);
      andiUA.UATcpdVe();
      andiUA.UAwgWNaQMX();
    }, 145);
    setTimeout(function() {
      andiUA.UAFMZuNzX();
      andiUA.UAMjeps = false;
      andiUA.UAEunaSfC();
    }, 170);
  })();
};