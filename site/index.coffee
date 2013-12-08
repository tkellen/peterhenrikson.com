define (require) ->

  CONFIG = require('cjs!config/site')
  require('jquery')
  require('scrollto')
  require('placeholder')
  require('waypoints_sticky')

  $ ->

    # get current page
    path = window.location.pathname.substring(1)
    onHomePage = (path == "" || path == "index.html")

    if onHomePage
      # make navbar stick to top of page after scroll on the home page
      nav = $('nav')
      nav.waypoint 'sticky',
        offset: "-100%"
        handler: ->
          if $(window).width() < 768
            marginTop = 0
          else
            marginTop = if(nav.hasClass('stuck')) then -70 else 0

          $('body').css('marginTop', marginTop)

      # make anchor links scroll nicely
      $('.scroll').click (e) ->
        href = this.href.split('#')[1];
        $.scrollTo('#'+href,{duration:200,offset:10});
        e.preventDefault()
    else
      $('nav').css('top', 0)

    # ensure placeholders work on older browsers
    $('input, textarea').placeholder();

    # placeholders on inputs uses fontawesome
    # this switches the font to the default when
    # their fields aren't empty
    $('.iconed').on 'keyup', ->
      input = $(@)
      if input.val().length == 0
          input.addClass('iconed');
      else
          input.removeClass('iconed');

    # parallax scrolling implementation
    parallaxImages = $('.parallax')
    parallaxImage = (img, opts) ->
      {screenTop, screenWidth, screenBottom} = opts
      imageTop = img.offset().top
      backgroundPosition = '0px 0px'

      if screenBottom > imageTop && screenWidth > 768
        if imageTop > screenTop
          parallax = (Math.abs(screenTop - imageTop) / 2)
        else
          parallax = (imageTop - screenTop) / 2

        backgroundPosition = '0px '+parseInt(parallax)+'px'

      img.css('backgroundPosition', backgroundPosition)

    $(window).scroll ->
      opts = {}
      opts.screenTop = $(window).scrollTop()
      opts.screenWidth = $(window).width()
      opts.screenBottom = opts.screenTop + $(window).height()
      parallaxImages.each ->
        parallaxImage($(this), opts)


