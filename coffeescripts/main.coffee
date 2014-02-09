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

$window.on 'resize', ()->
  screenWidth = $window.width()
  screenHeight = $window.height()

###
# Navigation
###

###
# About Section
###


###
# Location
###

loadMap = ()->
  mapLatLng = new google.maps.LatLng(25.0410096, 121.6118796)
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

  aboutDescription = document.querySelector("#about-description")
  sitconJiangElements = [document.querySelector("#about"), document.querySelector("#about .overlay.cg")]

  section.on "scrollIn", ()->
    setMenuActiveItem(0)

  transitions.push {
    target: aboutDescription
    start: 0
    end: 100
    key: 'transform'
    from: 100
    to: 50
    format: "translateY(%spx)"
    afterCalculate: (val) ->
      return (val / 100) * screenHeight
  }

  for element in sitconJiangElements
    transitions.push {
      target: element
      start: 0
      end: 100
      key: 'background-position-y'
      from: -100
      to: 40
      format: "%spx"
      afterCalculate: (val) ->
        return (val / 100) * screenHeight
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
    from: -50
    to: 0
    format: "translateY(%spx)"
    afterCalculate: (val) ->
      val = (val / 100) * screenHeight
  }

  section.transitions(transitions)


page.section SECTIONS.SPEAKER, (section) ->
  transitions = []

  section.on "scrollIn", ()->
    setMenuActiveItem(2)

  section.transitions(transitions)

page.section SECTIONS.SCHEDULE, (section) ->
  transitions = []

  section.on "scrollIn", ()->
    setMenuActiveItem(3)

  section.transitions(transitions)


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
