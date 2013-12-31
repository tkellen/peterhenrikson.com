define (require) ->

  require('jquery')
  require('waypoints_sticky')

  ->
    $('nav').waypoint('sticky');
