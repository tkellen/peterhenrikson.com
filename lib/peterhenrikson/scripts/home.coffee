define (require) ->

  require('jquery')
  require('scrollto')
  require('cycle')
  parallax = require('cs!site/parallax')
  Masonry = require('masonry')

  ->
    $('.panel').each (idx, el) ->
      new Masonry(el, {
        itemSelector: '.project'
        columnWidth: 300
        gutter: 10
        isFitWidth: true
      })

    # make parallax images do their thing
    parallax($('.parallax'))

    # make service images crossfade, with slight delay between each
    $('.cycle').each (idx, el) ->
      setTimeout((->$(el).cycle({timeout: 3000})), idx*400)

    # make anchor links scroll nicely
    $('.scroll').click (e) ->
      href = this.href.split('#')[1];
      $.scrollTo('#'+href,{duration:200,offset:10});
      e.preventDefault()

