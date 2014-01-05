define (require) ->

  $ = require('jquery')

  ->

    # save nav element
    nav = $('nav')

    # get the initial top offset of the navbar
    ntop = nav.offset().top;

    stickNav = ->
      wtop = $(window).scrollTop()
      if wtop > ntop
        $('nav').addClass('stuck')
      else
        $('nav').removeClass('stuck')

    $(window).scroll ->
      window.didScroll = true

    # update nav state periodically
    setInterval((->
      if window.didScroll
        window.didScroll = false
        stickNav()
     ), 250)
