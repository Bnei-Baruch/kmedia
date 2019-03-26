(function() {
  var ANDIUAkmUiD = document.getElementById("andi2path");
  if (window.location.href.indexOf("andicloud=true") > -1 || localStorage.getItem("andicloud") == "true") {
    localStorage.setItem("andicloud", "true");
    console.log("cloudmode");
    var ANDIUAkmUiD = document.getElementById("andi2path").src;
    if (ANDIUAkmUiD.indexOf("production.user-a.co.il") == -1) {
      document.getElementById("andi2path").removeAttribute("id");
      ANDIUAkmUiD = ANDIUAkmUiD.replace("//testua.user-a.co.il/", "//production.user-a.co.il/");
      var script = document.createElement("script");
      script.src = ANDIUAkmUiD;
      script.id = "andi2path";
      script.type = "text/javascript";
      var head = document.getElementsByTagName("head")[0];
      head.appendChild(script);
      return false;
    } else {
      UAzaoDdrjC();
    }
  } else {
    if (ANDIUAkmUiD.classList != undefined && ANDIUAkmUiD.classList != "" && ANDIUAkmUiD.classList.contains("anditestmode")) {
      console.log("anditestmode");
      if (window.location.href.indexOf("andi=1") > -1 || localStorage.getItem("andi") == "1") {
        localStorage.setItem("andi", "1");
        if (window.self == top) {
          UAzaoDdrjC();
        }
      }
    } else {
      if (window.location.href.indexOf("andiqa=qa") > -1 || localStorage.getItem("andiqa") == "qa") {
        localStorage.setItem("andiqa", "qa");
        if (document.getElementById("andi2path").src.indexOf("QA") == -1) {
          document.getElementById("andi2path").removeAttribute("id");
          UAwfRcfPb = "//testua.user-a.co.il/Customers/_kabbalahmedia_info/QA";
          var script = document.createElement("script");
          script.src = UAwfRcfPb + "/andi2fn1.js";
          script.id = "andi2path";
          script.type = "text/javascript";
          var head = document.getElementsByTagName("head")[0];
          head.appendChild(script);
          return false;
        } else {
          UAzaoDdrjC();
        }
      } else {
        if (window.location.href.indexOf("andi2=debug") > -1 || localStorage.getItem("andi2") == "debug") {
          localStorage.setItem("andi2", "debug");
        } else {
          if (window.self == top) {
            UAzaoDdrjC();
          }
        }
      }
    }
  }
  function UAzaoDdrjC() {
    var interval = setInterval(function() {
      if (document.readyState === "complete") {
        clearInterval(interval);
        ANDIUAdMxgtcBB();
      }
    }, 100);
  }
  function ANDIUAdMxgtcBB() {
    andiUA = {};
    andiUA.UARIWOwfdM = 0;
    andiUA.ANDIloadHelp = false;
    andiUA.stat = false;
    andiUA.UAKAfDJInF = true;
    andiUA.UAdDODiVsd = function(d, c) {
      if ("function" !== typeof d) {
        throw "Not a valid UAMYotL";
      }
      var a = document.createElement("script");
      a.onload = d;
      a.src = c;
      a.type = "text/javascript";
      document.getElementsByTagName("head")[0].appendChild(a);
    };
    andiUA.url = "https://user-a.co.il/";
    andiUA.UAapeBCfu = "2.0.6";
    andiUA.UAZEJWQnLR = 750;
    andiUA.UARbQob = true;
    ANDIUAkmUiD = document.getElementById("andi2path").src;
    andiUA.UAwfRcfPb = ANDIUAkmUiD.replace("/andi2fn1.js", "");
    localStorage.setItem("UAsizeLocalStorage", 4500);
    andiUA.UASwpSvxf = function(UAQqhEF) {
      if (localStorage.getItem(UAQqhEF) == null || localStorage.getItem(UAQqhEF) == "null") {
        return false;
      }
      return true;
    };
    andiUA.UArZVJrs = function(UAZuHWeCZG) {
      var UAZuHWeCZG = UAZuHWeCZG || "";
      for (var key in window.localStorage) {
        if (window.localStorage.hasOwnProperty(key)) {
          UAZuHWeCZG += window.localStorage[key];
        }
      }
      return UAZuHWeCZG ? 3 + UAZuHWeCZG.length * 16 / (8 * 1024) : 0;
    };
    JS = {};
    if (!Array.prototype.includes) {
      Array.prototype.includes = function(searchElement) {
        if (this == null) {
          throw new TypeUADYzBxor("Array.prototype.includes called on null or undefined");
        }
        var O = Object(this);
        var len = parseInt(O.length, 10) || 0;
        if (len === 0) {
          return false;
        }
        var n = parseInt(arguments[1], 10) || 0;
        var k;
        if (n >= 0) {
          k = n;
        } else {
          k = len + n;
          if (k < 0) {
            k = 0;
          }
        }
        var currentElement;
        while (k < len) {
          currentElement = O[k];
          if (searchElement === currentElement || searchElement !== searchElement && currentElement !== currentElement) {
            return true;
          }
          k++;
        }
        return false;
      };
    }
    live = function(selector, callback) {
      document.observe("click", function(e) {
        var element = e.element();
        if (!element.match(selector)) {
          element = element.ancestors().find(function(elem) {
            return elem.match(selector);
          });
        } else {
          element = null;
        }
        if (element) {
          callback.apply(element);
        }
      });
    };
    andiUA.UANnjYP = function(arr, value) {
      var i = arr.length;
      while (i--) {
        if (arr[i] == value) {
          return true;
        }
      }
      return false;
    };
    UAmQdoT = function(elm, cssUAaRjVw) {
      elm = document.querySelectorAll(elem);
      document.querySelectorAll(elm).forEach(function(el) {
        Object.keys(cssUAaRjVw).forEach(function(attr) {
          var styleProp = attr.UAgBRgircA(), cssValue = cssUAaRjVw[attr];
          el.style[styleProp] = cssValue;
        });
      });
    };
    String.prototype.UAEHPHsu = function(extension) {
      var UAftdSm = this.replace(/\\/g, "/");
      UAftdSm = UAftdSm.substring(UAftdSm.lastIndexOf("/") + 1);
      return extension ? UAftdSm.replace(/[?#].+$/, "") : UAftdSm.split(".")[0];
    };
    String.prototype.UARZDJAJ = function(extension) {
      var UAftdSm = this.replace(/\\/g, "/");
      UAftdSm = UAftdSm.substring(UAftdSm.lastIndexOf("/") + 1);
      return UAftdSm;
    };
    String.prototype.UAlQgLCScx = function(UAJRKjNVBe, UAUYAbRuPw) {
      var str = this;
      UAJRKjNVBe = UAJRKjNVBe.replace(/[-\/\\^$*+?.()|[\]{}]/g, "\\$&");
      return str.replace(new RegExp(UAJRKjNVBe, "gi"), UAUYAbRuPw);
    };
    String.prototype.UAgBRgircA = function() {
      var str = this;
      str = str.UAlQgLCScx("-", " ").toLowerCase().replace(/(^|\s)([a-z])/g, function(m, p1, p2) {
        return p1 + p2.toUpperCase();
      });
      str = str.charAt(0).toLowerCase() + str.slice(1);
      return str.UAlQgLCScx(" ", "");
    };
    String.prototype.UAYMHDDO = function() {
      var str = this;
      var UALzKIL = document.createElement("br");
      try {
        UALzKIL.querySelector(str);
      } catch (e) {
        return false;
      }
      return true;
    };
    NodeList.prototype.forEach = HTMLCollection.prototype.forEach = Array.prototype.forEach;
    if (!Element.prototype.UAJiSBonzX) {
      Element.prototype.UAJiSBonzX = Element.prototype.msUAJiSBonzXSelector || Element.prototype.webkitUAJiSBonzXSelector;
    }
    if (!Element.prototype.closest) {
      Element.prototype.closest = function(s) {
        var el = this;
        var ancestor = this;
        if (!document.documentElement.contains(el)) {
          return null;
        }
        do {
          if (ancestor.UAJiSBonzX(s)) {
            return ancestor;
          }
          ancestor = ancestor.parentElement;
        } while (ancestor !== null);
        return null;
      };
    }
    Element.prototype.removeAttr = function(attrName) {
      var that = this;
      if (that == null) {
        return false;
      }
      attrName.split(" ");
      for (var UAQFJslXzA = 0; UAQFJslXzA < attrName.length; UAQFJslXzA++) {
        that.removeAttribute(attrName[UAQFJslXzA]);
      }
      return that;
    };
    Element.prototype.addAttr = function(attrUAaRjVw) {
      var that = this;
      if (that == null) {
        return false;
      }
      Object.keys(attrUAaRjVw).forEach(function(attr) {
        that.setAttribute(attr, attrUAaRjVw[attr]);
      });
      return that;
    };
    Element.prototype.getAttr = function(attrName) {
      var that = this;
      if (that == null) {
        return false;
      }
      return this.getAttribute(attrName);
    };
    Element.prototype.UAJuEGCw = function() {
      var that = this;
      if (that == null) {
        return false;
      }
      return this.innerText || this.textContent;
    };
    Element.prototype.UAAkJxhLqD = function(cssUAaRjVw) {
      var that = this;
      if (that == null) {
        return false;
      }
      Object.keys(cssUAaRjVw).forEach(function(attr) {
        var styleProp = attr.UAgBRgircA(), cssValue = cssUAaRjVw[attr];
        that.style[styleProp] = cssValue;
      });
      return that;
    };
    Element.prototype.UAVPHkfO = function(cssUAaRjVw) {
      var that = this;
      if (that == null) {
        return false;
      }
      return window.getComputedStyle(this, null).getPropertyValue(cssUAaRjVw);
    };
    Element.prototype.UAwLPstUC = function() {
      var that = this;
      if (that == null) {
        return false;
      }
      this.parentNode.removeChild(this);
      return this;
    };
    Element.prototype.UAYkWrFf = function() {
      var that = this;
      if (that == null) {
        return false;
      }
      return this.innerHTML;
    };
    Element.prototype.UAwhccxGC = function(newHtml) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.innerHTML = newHtml;
      return this;
    };
    Element.prototype.UAsgYBL = function(newHtml) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.insertAdjacentHTML("beforeend", newHtml);
      return this;
    };
    Element.prototype.UASsSgEcm = function(newHtml) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.insertAdjacentHTML("afterbegin", newHtml);
      return this;
    };
    Element.prototype.UASwAbNat = function(newHtml) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.insertAdjacentHTML("afterend", newHtml);
      return this;
    };
    Element.prototype.UAYIWSouk = function(attrUAaRjVw, UAOWnXkol) {
      var that = this;
      if (that == null) {
        return false;
      }
      UAOWnXkol = UAOWnXkol || "1";
      UAOWnXkol = " " + UAOWnXkol + "s";
      Object.keys(attrUAaRjVw).forEach(function(attr) {
        var styleProp = attr.UAgBRgircA(), cssValue = attrUAaRjVw[attr];
        that.style[styleProp] = cssValue;
        that.style.transition = styleProp + UAOWnXkol;
      });
      return that;
    };
    Element.prototype.addClass = function(classUAtsBmm) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.classList.add(classUAtsBmm);
      return this;
    };
    Element.prototype.removeClass = function(classUAtsBmm) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.classList.remove(classUAtsBmm);
      return this;
    };
    Element.prototype.hasClass = function(className) {
      var that = this;
      if (that == null) {
        return false;
      }
      return this.className && (new RegExp("(^|\\s)" + className + "(\\s|$)")).test(this.className);
    };
    Element.prototype.UAtSNhKVuF = function(newNode) {
      var that = this;
      if (that == null) {
        return false;
      }
      this.parentNode.insertBefore(newNode, this.nextSibling);
    };
    andiUA.sleep = function(milliseconds) {
      var start = (new Date).getTime();
      for (var i = 0; i < 1e7; i++) {
        if ((new Date).getTime() - start > milliseconds) {
          break;
        }
      }
    };
    eventOn = function(eventName, selector, fn) {
      var element = document.querySelector("body");
      element.addEventListener(eventName, function(event) {
        var possibleTargets = element.querySelectorAll(selector);
        var target = event.target;
        for (var i = 0, l = possibleTargets.length; i < l; i++) {
          var el = target;
          var p = possibleTargets[i];
          while (el && el !== element) {
            if (el === p) {
              return fn.call(p, event);
            }
            el = el.parentNode;
          }
        }
      });
    };
    var addEvent = function(object, type, callback) {
      if (object == null || typeof object == "undefined") {
        return;
      }
      if (object.addEventListener) {
        object.addEventListener(type, callback, false);
      } else {
        if (object.attachEvent) {
          object.attachEvent("on" + type, callback);
        } else {
          object["on" + type] = callback;
        }
      }
    };
    function UATZlsBL(elem, filter) {
      var sibs = [];
      elem = elem.parentNode.firstChild;
      do {
        if (elem.nodeType === 3) {
          continue;
        }
        if (!filter || filter(elem)) {
          sibs.push(elem);
        }
      } while (elem = elem.nextSibling);
      return sibs;
    }
    function UAavDQpG(elem, filter) {
      var sibs = [];
      while (elem = elem.previousSibling) {
        if (elem.nodeType === 3) {
          continue;
        }
        if (!filter || filter(elem)) {
          sibs.push(elem);
        }
      }
      return sibs;
    }
    function UArYyXiQSj(elem, filter) {
      var sibs = [];
      while (elem = elem.nextSibling) {
        if (elem.nodeType === 3) {
          continue;
        }
        if (!filter || filter(elem)) {
          sibs.push(elem);
        }
      }
      return sibs;
    }
    if (!Array.prototype.indexOf) {
      Array.prototype.indexOf = function(searchValue, index) {
        var len = this.length >>> 0;
        index |= 0;
        if (index < 0) {
          index = Math.max(len - index, 0);
        } else {
          if (index >= len) {
            return -1;
          }
        }
        if (searchValue === undefined) {
          do {
            if (index in this && this[index] === undefined) {
              return index;
            }
          } while (++index !== len);
        } else {
          do {
            if (this[index] === searchValue) {
              return index;
            }
          } while (++index !== len);
        }
        return -1;
      };
    }
    andiUA.UAiNPRRP = function(UAEHPHsu, UAOHjAni) {
      if (UAOHjAni == "js") {
        var UALbiYFGn = document.createElement("script");
        UALbiYFGn.setAttribute("type", "text/javascript");
        UALbiYFGn.setAttribute("src", UAEHPHsu);
      } else {
        if (UAOHjAni == "css") {
          var UALbiYFGn = document.createElement("link");
          UALbiYFGn.setAttribute("rel", "stylesheet");
          UALbiYFGn.setAttribute("type", "text/css");
          UALbiYFGn.setAttribute("href", UAEHPHsu);
        }
      }
      if (typeof UALbiYFGn != "undefined") {
        document.getElementsByTagName("head")[0].appendChild(UALbiYFGn);
      }
    };
    andiUA.UAdDODiVsd(function() {
    }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2BasicFuncions.js");
    andiUA.UAzwNaaoY = setInterval(function(UATPYPrgs) {
      if (andiUA.UASBSnJAt) {
        if (localStorage.getItem("dontruninthissite") == "true") {
          var Text = document.querySelector("html").getAttr("lang") == "he" ? "\u05dc\u05d7\u05e5 \u05dc\u05d4\u05e4\u05e2\u05dc\u05d4 \u05e9\u05dc \u05d0\u05e0\u05d3\u05d9 \u05d1\u05d0\u05ea\u05e8 \u05d6\u05d4." : "Click to run andi on this site";
          var html = '<div style="z-index: 99999999; text-align:right; background: rgb(0, 133, 186); position: fixed; height: 40px; top: 200px; left: 0px;" id="UAMkOFIJ" role="button" aria-label="' + Text + '" tabindex="0" UAGZZAJ="true"><span></span><img alt="" src="data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2235%22%20height%3D%2235%22%20viewBox%3D%220%200%2035%2035%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M24.1%2026.34L21.003%2019h-7.82l-.67-11.184c-.055-.956.674-1.66%201.63-1.715.96-.054%201.776.73%201.832%201.687l.48%208.213h6.818l2.71%206.216%201-.357c.9-.323%201.895.145%202.217%201.046s-.147%201.777-1.05%202.1L24.1%2026.34z%22%2F%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M20.943%2014h-6.32c-.96%200-1.734-.78-1.734-1.5%200-.718.774-1.5%201.732-1.5h6.32c.958%200%201.735.782%201.735%201.5%200%20.72-.777%201.5-1.734%201.5z%22%2F%3E%3Ccircle%20fill%3D%22%23FFF%22%20cx%3D%2214.835%22%20cy%3D%226.336%22%20r%3D%222.835%22%2F%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M21.37%2021.76c-.55%202.425-2.68%204.252-5.27%204.252-3.012%200-5.457-2.447-5.457-5.458%200-1.43.568-2.714%201.475-3.683l-.196-3.033-1.78-1.232c-.212-.144-.487-.12-.67.06L8.21%2013.928c-.18.178-.205.46-.06.667l1.313%201.9c-.42.687-.736%201.438-.93%202.24l-2.186.415c-.25.042-.347.26-.347.514v1.783c0%20.253.098.47.348.516l2.23.413c.19.803.485%201.555.906%202.24l-1.324%201.9c-.146.208-.124.49.054.668l1.26%201.26c.182.18.456.207.667.063l1.9-1.316c.686.422%201.435.74%202.237.933l.414%202.36c.045.247.263.517.516.517h1.784c.256%200%20.472-.27.517-.518l.41-2.314c.806-.192%201.557-.533%202.242-.955l1.898%201.305c.21.144.49.11.666-.067l.994-.99-2.347-5.7z%22%2F%3E%3C%2Fsvg%3E"></div>';
          document.querySelector("body").UASsSgEcm(html);
          document.querySelector("#UAMkOFIJ").addEventListener("click", function() {
            if (confirm(document.querySelector("html").getAttr("lang") == "he" ? "\u05d4\u05e0\u05d2\u05d9\u05e9\u05d5\u05ea \u05d1\u05d0\u05ea\u05e8 \u05d6\u05d4 \u05d1\u05d5\u05d8\u05dc\u05d4 \u05e2\u05dc \u05d9\u05d3\u05da. \u05d4\u05d0\u05dd \u05ea\u05e8\u05e6\u05d4 \u05dc\u05d4\u05e4\u05e2\u05d9\u05dc\u05d4 \u05e9\u05d5\u05d1 ?" : "The accessibility in this site has been canceled by you. Would you like to enable it again?")) {
              localStorage.removeItem("dontruninthissite");
              location.reload();
            }
          });
        } else {
          UAxgHvYbW = function(d, c) {
            var a = (d & 65535) + (c & 65535);
            return (d >> 16) + (c >> 16) + (a >> 16) << 16 | a & 65535;
          };
          UAJSLNc = function(d, c) {
            return d << c | d >>> 32 - c;
          };
          UADAzrHH = function(d, c, a, b, e, f) {
            return UAxgHvYbW(UAJSLNc(UAxgHvYbW(UAxgHvYbW(c, d), UAxgHvYbW(b, f)), e), a);
          };
          UAkeCjcSIS = function(d, c, a, b, e, f, g) {
            return UADAzrHH(c & a | ~c & b, d, c, e, f, g);
          };
          UAedmbebA = function(d, c, a, b, e, f, g) {
            return UADAzrHH(c & b | a & ~b, d, c, e, f, g);
          };
          UAMprqsgJB = function(d, c, a, b, e, f, g) {
            return UADAzrHH(c ^ a ^ b, d, c, e, f, g);
          };
          UAaOuelb = function(d, c, a, b, e, f, g) {
            return UADAzrHH(a ^ (c | ~b), d, c, e, f, g);
          };
          UAZupOHR = function(d) {
            var c = 1732584193, a = -271733879, b = -1732584194, e = 271733878;
            for (UAQFJslXzA = 0; UAQFJslXzA < d.length; UAQFJslXzA += 16) {
              var f = c, g = a, h = b, k = e;
              c = UAkeCjcSIS(c, a, b, e, d[UAQFJslXzA + 0], 7, -680876936);
              e = UAkeCjcSIS(e, c, a, b, d[UAQFJslXzA + 1], 12, -389564586);
              b = UAkeCjcSIS(b, e, c, a, d[UAQFJslXzA + 2], 17, 606105819);
              a = UAkeCjcSIS(a, b, e, c, d[UAQFJslXzA + 3], 22, -1044525330);
              c = UAkeCjcSIS(c, a, b, e, d[UAQFJslXzA + 4], 7, -176418897);
              e = UAkeCjcSIS(e, c, a, b, d[UAQFJslXzA + 5], 12, 1200080426);
              b = UAkeCjcSIS(b, e, c, a, d[UAQFJslXzA + 6], 17, -1473231341);
              a = UAkeCjcSIS(a, b, e, c, d[UAQFJslXzA + 7], 22, -45705983);
              c = UAkeCjcSIS(c, a, b, e, d[UAQFJslXzA + 8], 7, 1770035416);
              e = UAkeCjcSIS(e, c, a, b, d[UAQFJslXzA + 9], 12, -1958414417);
              b = UAkeCjcSIS(b, e, c, a, d[UAQFJslXzA + 10], 17, -42063);
              a = UAkeCjcSIS(a, b, e, c, d[UAQFJslXzA + 11], 22, -1990404162);
              c = UAkeCjcSIS(c, a, b, e, d[UAQFJslXzA + 12], 7, 1804603682);
              e = UAkeCjcSIS(e, c, a, b, d[UAQFJslXzA + 13], 12, -40341101);
              b = UAkeCjcSIS(b, e, c, a, d[UAQFJslXzA + 14], 17, -1502002290);
              a = UAkeCjcSIS(a, b, e, c, d[UAQFJslXzA + 15], 22, 1236535329);
              c = UAedmbebA(c, a, b, e, d[UAQFJslXzA + 1], 5, -165796510);
              e = UAedmbebA(e, c, a, b, d[UAQFJslXzA + 6], 9, -1069501632);
              b = UAedmbebA(b, e, c, a, d[UAQFJslXzA + 11], 14, 643717713);
              a = UAedmbebA(a, b, e, c, d[UAQFJslXzA + 0], 20, -373897302);
              c = UAedmbebA(c, a, b, e, d[UAQFJslXzA + 5], 5, -701558691);
              e = UAedmbebA(e, c, a, b, d[UAQFJslXzA + 10], 9, 38016083);
              b = UAedmbebA(b, e, c, a, d[UAQFJslXzA + 15], 14, -660478335);
              a = UAedmbebA(a, b, e, c, d[UAQFJslXzA + 4], 20, -405537848);
              c = UAedmbebA(c, a, b, e, d[UAQFJslXzA + 9], 5, 568446438);
              e = UAedmbebA(e, c, a, b, d[UAQFJslXzA + 14], 9, -1019803690);
              b = UAedmbebA(b, e, c, a, d[UAQFJslXzA + 3], 14, -187363961);
              a = UAedmbebA(a, b, e, c, d[UAQFJslXzA + 8], 20, 1163531501);
              c = UAedmbebA(c, a, b, e, d[UAQFJslXzA + 13], 5, -1444681467);
              e = UAedmbebA(e, c, a, b, d[UAQFJslXzA + 2], 9, -51403784);
              b = UAedmbebA(b, e, c, a, d[UAQFJslXzA + 7], 14, 1735328473);
              a = UAedmbebA(a, b, e, c, d[UAQFJslXzA + 12], 20, -1926607734);
              c = UAMprqsgJB(c, a, b, e, d[UAQFJslXzA + 5], 4, -378558);
              e = UAMprqsgJB(e, c, a, b, d[UAQFJslXzA + 8], 11, -2022574463);
              b = UAMprqsgJB(b, e, c, a, d[UAQFJslXzA + 11], 16, 1839030562);
              a = UAMprqsgJB(a, b, e, c, d[UAQFJslXzA + 14], 23, -35309556);
              c = UAMprqsgJB(c, a, b, e, d[UAQFJslXzA + 1], 4, -1530992060);
              e = UAMprqsgJB(e, c, a, b, d[UAQFJslXzA + 4], 11, 1272893353);
              b = UAMprqsgJB(b, e, c, a, d[UAQFJslXzA + 7], 16, -155497632);
              a = UAMprqsgJB(a, b, e, c, d[UAQFJslXzA + 10], 23, -1094730640);
              c = UAMprqsgJB(c, a, b, e, d[UAQFJslXzA + 13], 4, 681279174);
              e = UAMprqsgJB(e, c, a, b, d[UAQFJslXzA + 0], 11, -358537222);
              b = UAMprqsgJB(b, e, c, a, d[UAQFJslXzA + 3], 16, -722521979);
              a = UAMprqsgJB(a, b, e, c, d[UAQFJslXzA + 6], 23, 76029189);
              c = UAMprqsgJB(c, a, b, e, d[UAQFJslXzA + 9], 4, -640364487);
              e = UAMprqsgJB(e, c, a, b, d[UAQFJslXzA + 12], 11, -421815835);
              b = UAMprqsgJB(b, e, c, a, d[UAQFJslXzA + 15], 16, 530742520);
              a = UAMprqsgJB(a, b, e, c, d[UAQFJslXzA + 2], 23, -995338651);
              c = UAaOuelb(c, a, b, e, d[UAQFJslXzA + 0], 6, -198630844);
              e = UAaOuelb(e, c, a, b, d[UAQFJslXzA + 7], 10, 1126891415);
              b = UAaOuelb(b, e, c, a, d[UAQFJslXzA + 14], 15, -1416354905);
              a = UAaOuelb(a, b, e, c, d[UAQFJslXzA + 5], 21, -57434055);
              c = UAaOuelb(c, a, b, e, d[UAQFJslXzA + 12], 6, 1700485571);
              e = UAaOuelb(e, c, a, b, d[UAQFJslXzA + 3], 10, -1894986606);
              b = UAaOuelb(b, e, c, a, d[UAQFJslXzA + 10], 15, -1051523);
              a = UAaOuelb(a, b, e, c, d[UAQFJslXzA + 1], 21, -2054922799);
              c = UAaOuelb(c, a, b, e, d[UAQFJslXzA + 8], 6, 1873313359);
              e = UAaOuelb(e, c, a, b, d[UAQFJslXzA + 15], 10, -30611744);
              b = UAaOuelb(b, e, c, a, d[UAQFJslXzA + 6], 15, -1560198380);
              a = UAaOuelb(a, b, e, c, d[UAQFJslXzA + 13], 21, 1309151649);
              c = UAaOuelb(c, a, b, e, d[UAQFJslXzA + 4], 6, -145523070);
              e = UAaOuelb(e, c, a, b, d[UAQFJslXzA + 11], 10, -1120210379);
              b = UAaOuelb(b, e, c, a, d[UAQFJslXzA + 2], 15, 718787259);
              a = UAaOuelb(a, b, e, c, d[UAQFJslXzA + 9], 21, -343485551);
              c = UAxgHvYbW(c, f);
              a = UAxgHvYbW(a, g);
              b = UAxgHvYbW(b, h);
              e = UAxgHvYbW(e, k);
            }
            return [c, a, b, e];
          };
          UAqVAqkHjf = function(d, c) {
            var a = !1;
            andizxc(d).each(function(b) {
              d[b] == c && (a = !0);
            });
            return a;
          };
          UAOhkllur = function(d) {
            for (var c = "", a = 0; a < 4 * d.length; a++) {
              c += "0123456789abcdef".charAt(d[a >> 2] >> a % 4 * 8 + 4 & 15) + "0123456789abcdef".charAt(d[a >> 2] >> a % 4 * 8 & 15);
            }
            return c;
          };
          UAfgOvVD = function(d) {
            for (var c = "", a = 0; a < 32 * d.length; a += 6) {
              c += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(d[a >> 5] << a % 32 & 63 | d[a >> 6] >> 32 - a % 32 & 63);
            }
            return c;
          };
          UAOOboHR = function(d) {
            for (var c = (d.length + 8 >> 6) + 1, a = Array(16 * c), b = 0; b < 16 * c; b++) {
              a[b] = 0;
            }
            for (b = 0; b < d.length; b++) {
              a[b >> 2] |= (d.charCodeAt(b) & 255) << b % 4 * 8;
            }
            a[b >> 2] |= 128 << b % 4 * 8;
            a[16 * c - 2] = 8 * d.length;
            return a;
          };
          UAfAiqxBsg = function(d) {
            for (var c = (d.length + 4 >> 5) + 1, a = Array(16 * c), b = 0; b < 16 * c; b++) {
              a[b] = 0;
            }
            for (b = 0; b < d.length; b++) {
              a[b >> 1] |= d.charCodeAt(b) << b % 2 * 16;
            }
            a[b >> 1] |= 128 << b % 2 * 16;
            a[16 * c - 2] = 16 * d.length;
            return a;
          };
          UAOhBQwFm = {};
          UAnnHXpp = function(d) {
            return UAOhkllur(UAZupOHR(UAOOboHR(d)));
          };
          andiUA.UAMMNJgjY = function() {
            for (var d = 0, c = document.domain, a = c.split("."), b = "_gd" + (new Date).getTime(); d < a.length - 1 && -1 == document.cookie.indexOf(b + "=" + b);) {
              c = a.slice(-1 - ++d).join("."), document.cookie = b + "=" + b + ";domain=" + c + ";";
            }
            document.cookie = b + "=;expires=Thu, 01 Jan 1970 00:00:01 GMT;domain=" + c + ";";
            return "";
          }();
          UATMitCkd = function() {
            UAikXlmpxf = new Date;
            var d = (UAikXlmpxf.getDate() + UAikXlmpxf.getFullYear() + UAikXlmpxf.getMonth()).toString();
            return UAnnHXpp(d);
          };
          UATViwKiBW = {UAbsRYvLPM:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", UAAbTVKn:function(d) {
            var c = "", a = 0;
            for (d = UATViwKiBW.UAtpAaneE(d); a < d.length;) {
              var b = d.charCodeAt(a++);
              var e = d.charCodeAt(a++);
              var f = d.charCodeAt(a++);
              var g = b >> 2;
              b = (b & 3) << 4 | e >> 4;
              var h = (e & 15) << 2 | f >> 6;
              var k = f & 63;
              isNaN(e) ? h = k = 64 : isNaN(f) && (k = 64);
              c = c + this.UAbsRYvLPM.charAt(g) + this.UAbsRYvLPM.charAt(b) + this.UAbsRYvLPM.charAt(h) + this.UAbsRYvLPM.charAt(k);
            }
            return c;
          }, UArSLainV:function(d) {
            var c = "", a = 0;
            for (d = d.replace(/[^A-Za-z0-9\+\/=]/g, ""); a < d.length;) {
              var b = this.UAbsRYvLPM.indexOf(d.charAt(a++));
              var e = this.UAbsRYvLPM.indexOf(d.charAt(a++));
              var f = this.UAbsRYvLPM.indexOf(d.charAt(a++));
              var g = this.UAbsRYvLPM.indexOf(d.charAt(a++));
              b = b << 2 | e >> 4;
              e = (e & 15) << 4 | f >> 2;
              var h = (f & 3) << 6 | g;
              c += String.fromCharCode(b);
              64 != f && (c += String.fromCharCode(e));
              64 != g && (c += String.fromCharCode(h));
            }
            return c = UATViwKiBW.UAXhzWkgj(c);
          }, UAtpAaneE:function(d) {
            d = d.replace(/\r\n/g, "\n");
            for (var c = "", a = 0; a < d.length; a++) {
              var b = d.charCodeAt(a);
              128 > b ? c += String.fromCharCode(b) : (127 < b && 2048 > b ? c += String.fromCharCode(b >> 6 | 192) : (c += String.fromCharCode(b >> 12 | 224), c += String.fromCharCode(b >> 6 & 63 | 128)), c += String.fromCharCode(b & 63 | 128));
            }
            return c;
          }, UAXhzWkgj:function(d) {
            var c = "", a = 0;
            for (UAgJXbTeA = UAcuBICqMr = 0; a < d.length;) {
              var b = d.charCodeAt(a);
              128 > b ? (c += String.fromCharCode(b), a++) : 191 < b && 224 > b ? (UAcuBICqMr = d.charCodeAt(a + 1), c += String.fromCharCode((b & 31) << 6 | UAcuBICqMr & 63), a += 2) : (UAcuBICqMr = d.charCodeAt(a + 1), UAapjPhxyL = d.charCodeAt(a + 2), c += String.fromCharCode((b & 15) << 12 | (UAcuBICqMr & 63) << 6 | UAapjPhxyL & 63), a += 3);
            }
            return c;
          }};
          andiUA.UAYWotT = function(UALYHdfP) {
            document.querySelector("body").UAsgYBL('<span class="UAxnXSd" role="alert" aria-label="' + UALYHdfP + '"></span>');
            setTimeout(function() {
              document.querySelectorAll(".UAxnXSd").forEach(function(el) {
                el.UAwLPstUC();
              });
            }, 1500);
          };
          var UAuCtkg = document.querySelector("html").getAttr("lang");
          if (UAuCtkg == "en") {
            var UAtEHlzFfn = "Starts loading accessibility";
            var UAzuFDyiZO = "Loading data from server";
            var UAqDBDb = "Starts Making your request";
            var UApPwcdgXq = "The accessibility add-on could not be loaded for this site because the publisher blocked this option. You can contact the site owner and request UAeqQVbcIK the accessibility add-on be enabled on their site. UA will be happy to assist the site owner in this matter.";
          } else {
            if (document.querySelector("html").getAttr("lang") == "he") {
              var UAtEHlzFfn = "\u05de\u05ea\u05d7\u05d9\u05dc \u05dc\u05d8\u05e2\u05d5\u05df \u05d0\u05ea \u05d4\u05e0\u05e0\u05d2\u05e9\u05d4 \u05dc\u05d0\u05ea\u05e8";
              var UAzuFDyiZO = "\u05d8\u05d5\u05e2\u05df \u05de\u05d9\u05d3\u05e2 \u05de\u05d4\u05e9\u05e8\u05ea";
              var UAqDBDb = "\u05de\u05d1\u05e6\u05e2 \u05d0\u05ea \u05d1\u05e7\u05e9\u05ea\u05da";
              var UApPwcdgXq = "\u05dc\u05d0 \u05e0\u05d9\u05ea\u05df \u05dc\u05d8\u05e2\u05d5\u05df \u05d0\u05ea \u05e8\u05db\u05d9\u05d1 \u05d4\u05e0\u05d2\u05d9\u05e9\u05d5\u05ea \u05de\u05d0\u05d7\u05ea \u05d4\u05e1\u05d9\u05d1\u05d5\u05ea \u05d4\u05d1\u05d0\u05d5\u05ea <br/>" + "1. \u05d1\u05e2\u05d9\u05d4 \u05d1\u05d8\u05e2\u05d9\u05e0\u05ea \u05d4\u05e8\u05db\u05d9\u05d1 - \u05e0\u05e1\u05d4 \u05dc\u05d8\u05e2\u05d5\u05df \u05de\u05d7\u05d3\u05e9 \u05d0\u05ea \u05d4\u05d3\u05e3.<br/>" + "2. \u05d1\u05e2\u05dc \u05d4\u05d0\u05ea\u05e8 \u05d7\u05e1\u05dd \u05d0\u05e4\u05e9\u05e8\u05d5\u05ea \u05d6\u05d5 \u05d1\u05e9\u05dc \u05e9\u05d9\u05e7\u05d5\u05dc\u05d9 \u05d0\u05d1\u05d8\u05d7\u05d4.<br/>" + 
              "<br/>" + "\u05d1\u05de\u05d9\u05d3\u05d4 \u05d5\u05d4\u05d1\u05e2\u05d9\u05d4 \u05d7\u05d5\u05d6\u05e8\u05ea, \u05d1\u05d1\u05e7\u05e9\u05d4 \u05e6\u05d5\u05e8 \u05d0\u05d9\u05ea\u05e0\u05d5 \u05e7\u05e9\u05e8 \u05d1\u05de\u05d9\u05d9\u05dc: info@user-a.co.il" + "\u05e2\u05dd \u05d4\u05e4\u05e8\u05d8\u05d9\u05dd \u05d4\u05d1\u05d0\u05d9\u05dd:<br/> \u05db\u05ea\u05d5\u05d1\u05ea \u05d4\u05d0\u05ea\u05e8, \u05e9\u05de\u05da \u05d5\u05db\u05d9\u05e6\u05d3 \u05e0\u05d9\u05ea\u05df \u05dc\u05e6\u05d5\u05e8 \u05e2\u05de\u05da \u05e7\u05e9\u05e8 \u05db\u05d3\u05d9 \u05dc\u05e2\u05d3\u05db\u05e0\u05da \u05d1\u05d4\u05de\u05e9\u05da \u05d4\u05d8\u05d9\u05e4\u05d5\u05dc." + 
              "\u05ea\u05d5\u05d3\u05d4 \u05e8\u05d1\u05d4 \u05de\u05e8\u05d0\u05e9.<br/>" + "\u05e6\u05d5\u05d5\u05ea UA.<br/>";
            } else {
              var UAtEHlzFfn = "Starts loading accessibility";
              var UAzuFDyiZO = "Loading data from server";
              var UAqDBDb = "Starts Making your request";
              var UApPwcdgXq = "The accessibility add-on could not be loaded for this site because the publisher blocked this option. You can contact the site owner and request UAeqQVbcIK the accessibility add-on be enabled on their site. UA will be happy to assist the site owner in this matter.";
            }
          }
          var UADmVWFO = document.querySelector("html").getAttr("lang");
          var UAyLMDKqM = document.querySelector("body").UAVPHkfO("direction");
          var UAiQTjZiq = "<style>\t\t\t\t#UAUxvKK {\t\t\t\t-webkit-box-shadow: 0px 0px 2px 0px rgba(50, 50, 50, 0.75); \t\t\t\t-moz-box-shadow:0px 0px 2px 0px rgba(50, 50, 50, 0.75); \t\t\t\tbox-shadow: 0px 0px 2px 0px rgba(50, 50, 50, 0.75);\t\t\t\tbackground-color:#fff;\t\t\t\tposition:fixed;\t\t\t\twidth:50px;\t\t\t\theight:auto;\t\t\t\ttop:50%;\t\t\t\tleft:" + (UAyLMDKqM == "rtl" ? "100%" : "0") + ';\t\t\t\tz-index:999999999999999;\t\t\t\ttext-align:center;\t\t\t\tbackground-color:#fff;\t\t\t\t}\t\t\t\t</style>\t\t\t\t<div style="" firsttime="true" id="UAUxvKK"  tabindex="0" aria-label="' + 
          UAtEHlzFfn + '" role="dialog">\t\t\t\t<img src="' + andiUA.UAwfRcfPb + '/images/load2.gif" alt="" style="width:60px;height:60px;"/><br/>\t\t\t\t</div>';
          document.querySelector("body").UASsSgEcm(UAiQTjZiq);
          setTimeout(function() {
            if (document.querySelector("#UAUxvKK[firsttime]") != null) {
              andiUA.UAYWotT(UApPwcdgXq);
              document.querySelector("#UAUxvKK[firsttime]").UAAkJxhLqD({"font-size":"14px", "height":"auto", "width":"100%", "padding":"5px"});
              document.querySelector("#UAUxvKK[firsttime]").textContent = UApPwcdgXq;
              var andiH = document.querySelector("#UAUxvKK[firsttime]").UAVPHkfO("height");
              document.querySelector("#UAUxvKK[firsttime]").UAAkJxhLqD({"top":"calc(100% - " + (andiH + 10) + "px)"});
              setTimeout(function() {
                document.querySelector("#UAUxvKK[firsttime]").UAwLPstUC();
              }, 7000);
            }
          }, 60000);
          andiUA.UAUxvKK = function() {
            document.querySelector("#UAbczwv").UASsSgEcm('<div id="UAmWkasBRc" ></div>\t\t\t\t\t\t<div id="UAfRlchhox" tabindex="0" role="dialog" style="z-index=999999999999;text-align:center;" aria-label="' + UAzuFDyiZO + '" >\t\t\t\t\t\t<div style="" id="UAUxvKK">\t\t\t\t\t\t<img src="' + andiUA.UAwfRcfPb + '/images/load2.gif" alt="" style="margin: 0 auto; width:150;height:150px;"/><br/>\t\t\t\t\t\t<span aria-hidden="true">' + UAzuFDyiZO + "</span>\t\t\t\t\t\t</div></div>");
            andiUA.UAYWotT(UAzuFDyiZO);
          };
          andiUA.UAYWotT(UAtEHlzFfn);
          clearInterval(andiUA.UAzwNaaoY);
          UAKJCzU = ["421aa90e079fa326b6494f812ad13e79", "", "43106670bff69e6b897f098c90044914"];
          UAWrIbYXwi = UATMitCkd();
          UA2ab = andiUA.UAMMNJgjY;
          if (UAqVAqkHjf(UAKJCzU, UA2ab)) {
            var UASBSnJAt = setInterval(function(UATPYPrgs) {
              if (andiUA.UASBSnJAt != undefined) {
                clearInterval(UASBSnJAt);
                andiUA.UAYTbIL = function() {
                  var UAvImPUNXt = UAvImPUNXt || "";
                  UAoZBiCz = localStorage.getItem("UAIvMImg");
                  var UAJNMLkMp = undefined;
                  andiUA.UABZxTsa = 0, andiUA.UAvuAaC = 0, andiUA.UAIfIax = 0, andiUA.UASIidRu = 0;
                  andiUA.UAlYmhB = [], andiUA.UAGYfLg = [], andiUA.UAWQQUomj = [], andiUA.UAcmLDB = [];
                  andiUA.UAksaGPANk = [];
                  andiUA.UASuVFMtC = [];
                  UAmbZiTL = 0, UAvLqmj = 0;
                  var n, a = [], walk = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, null, false);
                  while (n = walk.nextNode()) {
                    var UAmKjiBHY = n.parentNode;
                    var UAlqQAgXDd = n.data.trim();
                    if (UAlqQAgXDd !== "" && UAmKjiBHY.tagName !== "NOSCRIPT" && UAmKjiBHY.tagName !== "SCRIPT" && UAmKjiBHY.tagName !== "STYLE" && UAmKjiBHY.tagName !== "HEAD" && UAmKjiBHY.tagName !== "META" && UAmKjiBHY.tagName !== "LINK") {
                      UAmKjiBHY.setAttribute("UAvGyiRT", "true");
                      var UAyijGOF = parseInt(window.getComputedStyle(UAmKjiBHY, null).getPropertyValue("font-size"));
                      var UAjWhFlQZWhiteSpace = window.getComputedStyle(UAmKjiBHY, null).getPropertyValue("white-space");
                      var UAjWhFlQZlineHeight = window.getComputedStyle(UAmKjiBHY, null).getPropertyValue("line-height");
                      UAmKjiBHY.setAttribute("UATHdfS", UAyijGOF);
                      UAmKjiBHY.setAttribute("UAsHKEDhiteSpace", UAjWhFlQZWhiteSpace);
                      UAmKjiBHY.setAttribute("UAIvdFIAEineHeight", UAjWhFlQZlineHeight);
                      if (UAmKjiBHY.hasAttribute("style")) {
                        UAmKjiBHY.setAttribute("UAEdsxTgu", UAmKjiBHY.style.cssText);
                      }
                      UAvLqmj += UAyijGOF;
                      UAmbZiTL++;
                      var UAQTzhi = UAmKjiBHY;
                      var UApNtVD = UAlqQAgXDd.split(" ");
                      for (var a = 0; a < UApNtVD.length; a++) {
                        var word = UApNtVD[a];
                        if (andiUA.UAecwsSwa(word)) {
                          andiUA.UAGYfLg.push(word);
                          andiUA.UAvuAaC++;
                        } else {
                          if (andiUA.UAhNoCXms(word)) {
                            andiUA.UAlYmhB.push(word);
                            if (word.indexOf('"') > 0 && word.indexOf('"') < word.length - 1 || word.indexOf("'") > -1) {
                              andiUA.UAksaGPANk.push(word);
                            }
                            andiUA.UABZxTsa++;
                          } else {
                            if (andiUA.UAJuVcTH(word)) {
                              andiUA.UAWQQUomj.push(word);
                              if (andiUA.UArIkwCQr(word) && word.length > 2) {
                                andiUA.UASuVFMtC.push(word);
                                UAmKjiBHY.setAttribute("andiUpper", "true");
                              }
                              andiUA.UAIfIax++;
                            } else {
                              if (andiUA.UACzDqJ(word)) {
                                andiUA.UAcmLDB.push(word);
                                andiUA.UASIidRu++;
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                  localStorage.setItem("UAlElPZLo", UAvLqmj / UAmbZiTL);
                  var UAwhNoYOh = andiUA.UABZxTsa + andiUA.UAvuAaC + andiUA.UAIfIax + andiUA.UASIidRu;
                  var UAZGCmIV = andiUA.UABZxTsa / UAwhNoYOh * 100;
                  var UAgbwmrVu = andiUA.UAvuAaC / UAwhNoYOh * 100;
                  var UAgCOzCY = andiUA.UAIfIax / UAwhNoYOh * 100;
                  var UARmIav = andiUA.UASIidRu / UAwhNoYOh * 100;
                  var UAEzVDeG = [UAZGCmIV, UAgbwmrVu, UAgCOzCY, UARmIav];
                  var UAWxuKY = ["he", "ar", "en", "ru"];
                  UAjGWpyqRj = UAWxuKY[UAEzVDeG.indexOf(andiUA.UAdPaZHw(UAEzVDeG))];
                  if (UAJNMLkMp != undefined && UAJNMLkMp.indexOf(UAjGWpyqRj) > -1) {
                    UAJNMLkMp = UAjGWpyqRj;
                  }
                  if (UAJNMLkMp == undefined || UAJNMLkMp == "") {
                    if (UAjGWpyqRj == undefined || UAjGWpyqRj == "") {
                      UAJNMLkMp = "en";
                    } else {
                      UAJNMLkMp = UAjGWpyqRj;
                    }
                  }
                  UAoZBiCz = localStorage.getItem("UAIvMImg");
                  if (UAoZBiCz !== null) {
                    UAJNMLkMp = UAoZBiCz;
                    UAjGWpyqRj = UAoZBiCz;
                  }
                  var UAYzYzkf = document.querySelector("html");
                  if (UAJNMLkMp.toLowerCase().indexOf("he") >= 0) {
                    UAJNMLkMp = "he";
                    UAYzYzkf.setAttribute("UATjrAo", "rtl");
                    UAYzYzkf.setAttribute("UAxdkDOMhX", "he");
                    if (!UAYzYzkf.hasAttribute("lang")) {
                      UAYzYzkf.setAttribute("lang", "he");
                    }
                  }
                  if (UAJNMLkMp.toLowerCase().indexOf("ar") >= 0) {
                    UAJNMLkMp = "ar";
                    UAYzYzkf.setAttribute("UATjrAo", "rtl");
                    UAYzYzkf.setAttribute("UAxdkDOMhX", "ar");
                    if (!UAYzYzkf.hasAttribute("lang")) {
                      UAYzYzkf.setAttribute("lang", "ar");
                    }
                  }
                  if (UAJNMLkMp.toLowerCase().indexOf("en") >= 0) {
                    UAJNMLkMp = "en";
                    UAYzYzkf.setAttribute("UATjrAo", "ltr");
                    UAYzYzkf.setAttribute("UAxdkDOMhX", "en");
                    if (!UAYzYzkf.hasAttribute("lang")) {
                      UAYzYzkf.setAttribute("lang", "en");
                    }
                  }
                  andiUA.UAJNMLkMp = UAJNMLkMp;
                };
                andiUA.UAYTbIL();
                UAczhUU = function() {
                  if (andiUA.UAJNMLkMp == "en") {
                    andiUA.UATjrAo = "ltr";
                    andiUA.UAdDODiVsd(function() {
                    }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2enSetting.js");
                    andiUA.UAdDODiVsd(function() {
                    }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2en.js");
                    andiUA.UAiNPRRP(andiUA.UAwfRcfPb + "/css/andiUA2StyleSheetLTR.css", "css");
                  } /*else if (andiUA.UAJNMLkMp == "ar") {
                      andiUA.UATjrAo = "rtl";
                      andiUA.UAdDODiVsd(function() {
                      }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2arabSetting.js");
                      andiUA.UAdDODiVsd(function() {
                      }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2arab.js");
                      andiUA.UAiNPRRP(andiUA.UAwfRcfPb + "/css/andiUA2StyleSheetRTL.css", "css");
                    }*/ else {
                      andiUA.UATjrAo = "rtl";
                      andiUA.UAdDODiVsd(function() {
                      }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2hebSetting.js");
                      andiUA.UAdDODiVsd(function() {
                      }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2heb.js");
                      andiUA.UAiNPRRP(andiUA.UAwfRcfPb + "/css/andiUA2StyleSheetRTL.css", "css");
                    }
                  
                };
                UAczhUU();
                document.querySelectorAll("[style]:not(#UAbczwv)").forEach(function(el) {
                  el.setAttribute("UAEdsxTgu", el.getAttribute("Style"));
                });
                var UAuQkbg = setInterval(function(UATPYPrgs) {
                  if (typeof andiUA.UAihhYRkgw == "function" && typeof andiUA.UAillQtC == "object") {
                    clearInterval(UAuQkbg);
                    andiUA.UAdDODiVsd(function() {
                    }, UATPYPrgs = andiUA.UAwfRcfPb + "/js/andi2Funcions.js");
                  }
                }, 200);
              }
            }, 200);
          }
        }
      }
    }, andiUA.UAZEJWQnLR);
  }
})();