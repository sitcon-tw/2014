###
# Preload Elements
###

$window = $(window)
$dom = $("html, body")
screenWidth = $window.width()
screenHeight = $window.height()
$menu = $("#main-menu ul")
$menuItems = $menu.children('.item')
$menuItem = [
  $($menuItems[0])
  $($menuItems[1])
  $($menuItems[2])
  $($menuItems[3])
  $($menuItems[4])
  $($menuItems[5])
]

$sections = {
  "#about": $("#about")
  "#location": $("#location")
  "#speaker": $("#speaker")
  "#schedule": $("#schedule")
  "#sponsor": $("#sponsor")
  "#team": $("#team")
}

# About
$aboutDescription = $("#about-description")
aboutDescriptionHeight = $aboutDescription.height()

# Location
$mapCanva = document.querySelector("#map-canva")

###
# Helper
###

resetMenuActiveItem = ()->
  $menuItems.removeClass "active"

setMenuActiveItem = (index) ->
  resetMenuActiveItem()
  $menuItem[index].addClass "active"

sitconJiangWidth = 584
sitconJiangHeight = 687
calcSITCONJiangTop = ()->
  if screenHeight <= sitconJiangHeight
    return 0
  else
    screenHeight - sitconJiangHeight + 50

###
# Navigation
###

###
# About Section
###

primaryColor = "#7cb059"

aboutSVG = SVG("about-svg")
sitconJiang = aboutSVG.image("images/sitcon_jiang.png", 584, 687).move(screenWidth * 0.9 - sitconJiangWidth, calcSITCONJiangTop())
aboutBG = aboutSVG.polygon("0,0 #{screenWidth * 0.75},0 #{screenWidth * 0.65},#{aboutDescriptionHeight * 1.2} 0,#{aboutDescriptionHeight * 1.2}").fill(primaryColor)
aboutBG.y(screenHeight)
sitconJiangLine = aboutSVG.image("images/sitcon_jiang_line.png", 584, 687).move(screenWidth * 0.9 - sitconJiangWidth, calcSITCONJiangTop())

$window.on "resize", ()->
  screenWidth = $window.width()
  screenHeight = $window.height()
  aboutDescriptionHeight = $aboutDescription.height()
  aboutBG.size(screenWidth * 0.75, aboutDescriptionHeight * 1.2)
  sitconJiang.move(screenWidth * 0.9 - sitconJiangWidth, calcSITCONJiangTop())
  sitconJiangLine.move(screenWidth * 0.9 - sitconJiangWidth, calcSITCONJiangTop())

###
# Location
###

loadMap = ()->
  mapLatLng = new google.maps.LatLng(25.0422145, 121.6141917)
  mapOptions = {
    center: mapLatLng
    zoom: 19
    scrollwheel: false
  }

  map = new google.maps.Map($mapCanva, mapOptions)
  marker = new google.maps.Marker {
    position: mapLatLng
    map: map
    icon: "images/map_pin.png"
  }

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

page.on 'changed', (current, previous)->
  pageID = current.element.id
  if pageID is "landing"
    $menu.removeClass "fixed"
    $dom.removeClass "fixed"
  else
    $menu.addClass "fixed"
    $dom.addClass "fixed"

page.section SECTIONS.LANDING, (section) ->
  section.on "scrollIn", () ->
    resetMenuActiveItem()

page.section SECTIONS.NAVIGATION, (section) ->
  section.on "scrollIn", (way)->
    setMenuActiveItem(0)
    if way is -1
      $dom.scrollTop($dom.scrollTop() + 60)

page.section SECTIONS.ABOUT, (section) ->
  transitions = []

  section.on "scrollIn", ()->
    setMenuActiveItem(0)

  section.on "progress", (percent)->
    from = screenHeight
    to = screenHeight / 2 + 60
    if percent <= 100
      aboutBG.y((to - from) / 100 * percent + from)

  transitions.push {
    target: $aboutDescription[0]
    start: 0
    end: 100
    key: 'transform'
    from: screenHeight
    to: screenHeight / 2 + 24
    format: "translateY(%spx)"
  }

  section.transitions(transitions)


page.section SECTIONS.LOCATION, (section) ->
  transitions = []
  sitconJiangAtMap = document.querySelector("#sitcon-jiang-at-map")

  section.on "scrollIn", ()->
    setMenuActiveItem(1)

  transitions.push {
    target: sitconJiangAtMap
    start: 0
    end: 100
    key: 'transform'
    from: -screenHeight + 450
    to: 0
    format: "translateY(%spx)"
  }

  section.transitions(transitions)


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
  loadMap()
