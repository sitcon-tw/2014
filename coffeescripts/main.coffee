###
# Preload Elements
###

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

###
# Helper
###

resetMenuActiveItem = ()->
  $menuItems.removeClass "active"

setMenuActiveItem = (index) ->
  resetMenuActiveItem()
  $menuItem[index].addClass "active"


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
  section.on "scrollIn", ()->
    setMenuActiveItem(0)

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

$(window).ready ()->
  page.init()
