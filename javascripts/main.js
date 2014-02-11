/*
# Preload Elements
*/


(function() {
  var $dom, $mapCanva, $menu, $menuItem, $menuItems, $sections, $window, SECTIONS, loadMap, page, resetMenuActiveItem, screenHeight, screenWidth, setMenuActiveItem;

  $window = $(window);

  $dom = $("html");

  screenWidth = $window.width();

  screenHeight = $window.height();

  $menu = $("#main-menu ul");

  $menuItems = $menu.children('.item');

  $menuItem = [$($menuItems[0]), $($menuItems[1]), $($menuItems[2]), $($menuItems[3]), $($menuItems[4]), $($menuItems[5])];

  $sections = {
    "#about": $("#about"),
    "#location": $("#location"),
    "#speaker": $("#speaker"),
    "#schedule": $("#schedule"),
    "#sponsor": $("#sponsor"),
    "#team": $("#team")
  };

  $mapCanva = document.querySelector("#map-canva");

  /*
  # Helper
  */


  resetMenuActiveItem = function() {
    return $menuItems.removeClass("active");
  };

  setMenuActiveItem = function(index) {
    resetMenuActiveItem();
    return $menuItem[index].addClass("active");
  };

  $window.on('resize', function() {
    screenWidth = $window.width();
    return screenHeight = $window.height();
  });

  /*
  # Navigation
  */


  $menu.on("click", "a", function(e) {
    var targetScrollTop;

    targetScrollTop = $sections[e.target.hash].offset().top;
    $dom.scrollTo(targetScrollTop - 60, 1000);
    return e.preventDefault();
  });

  /*
  # About Section
  */


  /*
  # Location
  */


  loadMap = function() {
    var map, mapLatLng, mapOptions, marker;

    mapLatLng = new google.maps.LatLng(25.0410096, 121.6118796);
    mapOptions = {
      center: mapLatLng,
      zoom: 19,
      scrollwheel: false
    };
    map = new google.maps.Map($mapCanva, mapOptions);
    return marker = new google.maps.Marker({
      position: mapLatLng,
      map: map,
      icon: "images/map_pin.png"
    });
  };

  /*
  # Parallax Scrolling
  */


  SECTIONS = {
    LANDING: 0,
    NAVIGATION: 1,
    ABOUT: 2,
    LOCATION: 3,
    SPEAKER: 4,
    SCHEDULE: 5,
    SPONSOR: 6,
    TEAM: 7
  };

  page = sections.create({
    autoSectionHeight: false
  });

  page.on('changed', function(current, previous) {
    var pageID;

    pageID = current.element.id;
    if (pageID === "landing") {
      $menu.removeClass("fixed");
      return $dom.removeClass("fixed");
    } else {
      $menu.addClass("fixed");
      return $dom.addClass("fixed");
    }
  });

  page.section(SECTIONS.LANDING, function(section) {
    return section.on("scrollIn", function() {
      return resetMenuActiveItem();
    });
  });

  page.section(SECTIONS.NAVIGATION, function(section) {
    return section.on("scrollIn", function(way) {
      return setMenuActiveItem(0);
    });
  });

  page.section(SECTIONS.ABOUT, function(section) {
    var aboutDescription, element, sitconJiangElements, transitions, _i, _len;

    transitions = [];
    aboutDescription = document.querySelector("#about-description");
    sitconJiangElements = [document.querySelector("#about"), document.querySelector("#about .overlay.cg")];
    section.on("scrollIn", function() {
      return setMenuActiveItem(0);
    });
    transitions.push({
      target: aboutDescription,
      start: 0,
      end: 100,
      key: 'transform',
      from: 100,
      to: 35,
      format: "translateY(%spx)",
      afterCalculate: function(val) {
        return (val / 100) * screenHeight;
      }
    });
    for (_i = 0, _len = sitconJiangElements.length; _i < _len; _i++) {
      element = sitconJiangElements[_i];
      transitions.push({
        target: element,
        start: 0,
        end: 100,
        key: 'background-position-y',
        from: -100,
        to: 40,
        format: "%spx",
        afterCalculate: function(val) {
          return (val / 100) * screenHeight;
        }
      });
    }
    return section.transitions(transitions);
  });

  page.section(SECTIONS.LOCATION, function(section) {
    var sitconJiangAtMap, transitions;

    transitions = [];
    sitconJiangAtMap = document.querySelector("#sitcon-jiang-at-map");
    section.on("scrollIn", function() {
      return setMenuActiveItem(1);
    });
    transitions.push({
      target: sitconJiangAtMap,
      start: 0,
      end: 100,
      key: 'transform',
      from: -50,
      to: 0,
      format: "translateY(%spx)",
      afterCalculate: function(val) {
        return val = (val / 100) * screenHeight;
      }
    });
    return section.transitions(transitions);
  });

  page.section(SECTIONS.SPEAKER, function(section) {
    var index, speaker, speakers, speakersCount, start, transitions, _i, _len;

    transitions = [];
    speakers = $("#speaker .speaker");
    speakersCount = speakers.length;
    for (index = _i = 0, _len = speakers.length; _i < _len; index = ++_i) {
      speaker = speakers[index];
      start = 20 + index * (100 / speakersCount);
      transitions.push({
        target: speaker,
        start: start,
        end: start + 50,
        key: 'opacity',
        from: 0,
        to: 1
      });
      transitions.push({
        target: speaker,
        start: start,
        end: start + 50,
        key: 'transform',
        from: 100,
        to: 0,
        format: "translateY(%spx)",
        afterCalculate: function(val) {
          return val = (val / 100) * screenWidth;
        }
      });
    }
    section.on("scrollIn", function() {
      return setMenuActiveItem(2);
    });
    return section.transitions(transitions);
  });

  page.section(SECTIONS.SCHEDULE, function(section) {
    var transitions;

    transitions = [];
    section.on("scrollIn", function() {
      return setMenuActiveItem(3);
    });
    return section.transitions(transitions);
  });

  page.section(SECTIONS.SPONSOR, function(section) {
    return section.on("scrollIn", function() {
      return setMenuActiveItem(4);
    });
  });

  page.section(SECTIONS.TEAM, function(section) {
    return section.on("scrollIn", function() {
      return setMenuActiveItem(5);
    });
  });

  /*
  # Onload
  */


  $window.ready(function() {
    page.init();
    return loadMap();
  });

}).call(this);
