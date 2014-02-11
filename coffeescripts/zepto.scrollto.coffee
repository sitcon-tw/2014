###
# Zepto ScrollTop Animate Plugin
#
# I'm not sure this will more fast than jquery...
#
# @author Aotoki
# @homepage http://frost.tw/
###

# Helper
animate = (()->
  return window.requestAnimationFrame ||
          window.webkitRequestAnimatinoFrame ||
          window.mozRequestAnimatinoFrame ||
          (callback) ->
            window.setTimeout callback, 1000 / 60
)()

timer = ()->
  ((new Date).getTime())

easing = (pos)->
  (-Math.cos(pos * Math.PI) / 2) + 0.5

# Tick
ticking = false
requestTick = ()->
  unless ticking
    animate(update)
    ticking = true

# Update
target = null
scrollTo = 0
currentScrollTop = 0
startTime = 0
currentTime = 0
step = 0
delta = 0
endTime = 0

update = ()->

  currentTime = timer()
  delta = (currentTime - startTime) / 1000
  step = (scrollTo - currentScrollTop) * easing(delta)
  currentScrollTop += step
  target.scrollTop(currentScrollTop)

  # One tick finished
  ticking = false

  if endTime > currentTime
    requestTick()
  else
    target.removeClass("disabled-pointer")

# Plugin Body

$.extend $.fn, {
  scrollTo: (targetScrollTop, duration) ->
    scrollTo = targetScrollTop
    target = this
    currentScrollTop = target.scrollTop()
    startTime = timer()
    endTime = startTime + duration
    target.addClass("disabled-pointer")
    requestTick()
}
