define (require) ->

  $ = require('jquery')

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

  updateImages = (images) ->
    opts = {}
    opts.screenTop = $(window).scrollTop()
    opts.screenWidth = $(window).width()
    opts.screenBottom = opts.screenTop + $(window).height()
    images.each ->
      parallaxImage($(this), opts)

  (images) ->
    $(window).resize ->
      window.didResize = true
    $(window).scroll ->
      updateImages(images)

     setInterval((->
       if window.didResize
         window.didResize = false
         updateImages(images)
     ), 250)



