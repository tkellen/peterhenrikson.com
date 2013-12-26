define (require) ->

  $ = require('jquery')
  isMobile = require('cs!site/ismobile')

  (images) ->

    if isMobile()
      # disable parallax images on mobile devices
      images.css('background-attachment', 'scroll')


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

    (images) ->
      ->
        opts = {}
        opts.screenTop = $(window).scrollTop()
        opts.screenWidth = $(window).width()
        opts.screenBottom = opts.screenTop + $(window).height()
        images.each ->
          parallaxImage($(this), opts)


