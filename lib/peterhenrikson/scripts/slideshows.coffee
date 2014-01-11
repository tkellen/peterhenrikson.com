define (require) ->
  $ = require('jquery')
  Swipe = require('swipe')

  ->
    indicators = $('.slider-position')
    swipe = new Swipe($('.slider').get(0), {
      disableScroll: false
      continuous: true
      callback: (pos) ->
        $('.on').removeClass('on');
        indicators.eq(0).find('div').eq(pos).addClass('on')
        indicators.eq(1).find('div').eq(pos).addClass('on')
        null
    })
    indicators.click (e) ->
      pos = $(e.target).parent().children().index(e.target)
      swipe.slide(pos, 300)

