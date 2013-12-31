define (require) ->

  require('jquery')
  require('waypoints_sticky')

  ->
    nav = $('nav')
    nav.css({top:-65,display:'block'})
    nav.waypoint 'sticky',
      offset: "-100%"
      handler: ->
        if $(window).width() < 800
          marginTop = 0
        else
          marginTop = if nav.hasClass('stuck') then -70 else 0
        $('body').css('marginTop', marginTop)

