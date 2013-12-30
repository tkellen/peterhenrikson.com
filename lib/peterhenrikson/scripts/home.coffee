define (require) ->

  require('jquery')
  require('scrollto')
  require('swiper')
  require('cycle')

  parallax = require('cs!site/parallax')

  # make parallax images do their thing
  parallax($('.parallax'))

  # make service images crossfade, with slight delay between each
  $('.cycle').each (idx, el) ->
    setTimeout((->$(el).cycle({timeout: 3000})), idx*200)

  # make anchor links scroll nicely
  $('.scroll').click (e) ->
    href = this.href.split('#')[1];
    $.scrollTo('#'+href,{duration:200,offset:10});
    e.preventDefault()

  # enable swiping for projects
  $('.swiper-container').each (idx, el) ->
    $(el).swiper
      mode: 'horizontal'
      loop: true
