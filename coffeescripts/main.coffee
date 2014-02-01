###
# Preload Elements
###

$window = $(window)
screenWidth = $window.width()
screenHeight = $window.height()
$menu = $("#main-menu ul")
$menuItems = $menu.children()
$menuItem = [
  $($menuItems[0])
  $($menuItems[1])
  $($menuItems[2])
  $($menuItems[3])
  $($menuItems[4])
  $($menuItems[5])
]

$aboutDescription = $("#about-description")
aboutDescriptionHeight = $aboutDescription.height()

###
# Helper
###

resetMenuActiveItem = ()->
  $menuItems.removeClass "active"

setMenuActiveItem = (index) ->
  resetMenuActiveItem()
  $menuItem[index].addClass "active"

###
# About Section
###

primaryColor = "#7cb059"

aboutSVG = SVG("about-svg")
sitconJiang = aboutSVG.image("images/sitcon_jiang.png", 584, 687).move(screenWidth * 0.9 - 584, screenHeight - 687)
aboutBG = aboutSVG.polygon("0,0 #{screenWidth * 0.75},0 #{screenWidth * 0.65},#{aboutDescriptionHeight * 1.2} 0,#{aboutDescriptionHeight * 1.2}").fill(primaryColor)
sitconJiangLine = aboutSVG.image("images/sitcon_jiang_line.png", 584, 687).move(screenWidth * 0.9 - 584, screenHeight - 687)

$window.on "resize", ()->
  screenWidth = $window.width()
  screenHeight = $window.height()
  aboutDescriptionHeight = $aboutDescription.height()
  aboutBG.size(screenWidth * 0.75, aboutDescriptionHeight * 1.2)
  sitconJiang.move(screenWidth * 0.9 - 584, screenHeight - 687)
  sitconJiangLine.move(screenWidth * 0.9 - 584, screenHeight - 687)



###
# Parallax Scrolling
###

SECTIONS = {
  LANDING: 0
  NAVIGATION: 1
  ABOUT: 2
  LOCATION: 3
  SPEAKER: 4
  SCHEDULE: 5
  SPONSOR: 6
  TEAM: 7
}

page = sections.create({
  autoSectionHeight: false
})

page.section SECTIONS.LANDING, (section) ->
  section.on "scrollIn", () ->
    $menu.removeClass "fixed"

page.section SECTIONS.NAVIGATION, (section) ->
  section.on "scrollIn", ()->
    resetMenuActiveItem()
    $menu.addClass "fixed"

page.section SECTIONS.ABOUT, (section) ->
  transitions = []

  section.on "scrollIn", ()->
    setMenuActiveItem(0)

  section.on "progress", (percent)->
    from = screenHeight
    to = screenHeight / 2
    aboutBG.y((to - from) / 100 * percent + from)
    console.log aboutBG.y()

  transitions.push {
    target: $aboutDescription[0]
    start: 0
    end: 100
    key: 'top'
    from: screenHeight + 20
    to: screenHeight / 2 + 20
    format: "%spx"
  }

  section.transitions(transitions)


page.section SECTIONS.LOCATION, (section) ->
  section.on "scrollIn", ()->
    setMenuActiveItem(1)

page.section SECTIONS.SPEAKER, (section) ->
  section.on "scrollIn", ()->
    setMenuActiveItem(2)

page.section SECTIONS.SCHEDULE, (section) ->
  section.on "scrollIn", ()->
    setMenuActiveItem(3)

page.section SECTIONS.SPONSOR, (section) ->
  section.on "scrollIn", ()->
    setMenuActiveItem(4)

page.section SECTIONS.TEAM, (section) ->
  section.on "scrollIn", ()->
    setMenuActiveItem(5)

###
# Onload
###

$window.ready ()->
  page.init()
