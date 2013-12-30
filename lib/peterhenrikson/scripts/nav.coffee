define (require) ->

  require('jquery')
  require('waypoints_sticky')

  isMobile = require('cs!site/ismobile')

  if !isMobile()
    nav = $('nav')
    nav.waypoint 'sticky',
      offset: "-100%"
      handler: ->
        if $(window).width() < 768
          marginTop = 0
        else
          marginTop = if nav.hasClass('stuck') then -70 else 0
        $('body').css('marginTop', marginTop)
  else
    $('nav').css('top', 0)
