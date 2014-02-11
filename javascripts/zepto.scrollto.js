/*
# Zepto ScrollTop Animate Plugin
#
# I'm not sure this will more fast than jquery...
#
# @author Aotoki
# @homepage http://frost.tw/
*/


(function() {
  var animate, currentScrollTop, currentTime, delta, easing, endTime, requestTick, scrollTo, startTime, step, target, ticking, timer, update;

  animate = (function() {
    return window.requestAnimationFrame || window.webkitRequestAnimatinoFrame || window.mozRequestAnimatinoFrame || function(callback) {
      return window.setTimeout(callback, 1000 / 60);
    };
  })();

  timer = function() {
    return (new Date).getTime();
  };

  easing = function(pos) {
    return (-Math.cos(pos * Math.PI) / 2) + 0.5;
  };

  ticking = false;

  requestTick = function() {
    if (!ticking) {
      animate(update);
      return ticking = true;
    }
  };

  target = null;

  scrollTo = 0;

  currentScrollTop = 0;

  startTime = 0;

  currentTime = 0;

  step = 0;

  delta = 0;

  endTime = 0;

  update = function() {
    currentTime = timer();
    delta = (currentTime - startTime) / 1000;
    step = (scrollTo - currentScrollTop) * easing(delta);
    currentScrollTop += step;
    target.scrollTop(currentScrollTop);
    ticking = false;
    if (endTime > currentTime) {
      return requestTick();
    } else {
      return target.removeClass("disabled-pointer");
    }
  };

  $.extend($.fn, {
    scrollTo: function(targetScrollTop, duration) {
      scrollTo = targetScrollTop;
      target = this;
      currentScrollTop = target.scrollTop();
      startTime = timer();
      endTime = startTime + duration;
      target.addClass("disabled-pointer");
      return requestTick();
    }
  });

}).call(this);
