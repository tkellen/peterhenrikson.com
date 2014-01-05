define (require) ->

  lastTime = 0
  vendors = ["ms", "moz", "webkit", "o"]
  x = 0

  while x < vendors.length and not window.requestAnimationFrame
    window.requestAnimationFrame = window[vendors[x] + "RequestAnimationFrame"]
    window.cancelAnimationFrame = window[vendors[x] + "CancelAnimationFrame"] or window[vendors[x] + "CancelRequestAnimationFrame"]
    ++x
  unless window.requestAnimationFrame
    window.requestAnimationFrame = (callback, element) ->
      currTime = new Date().getTime()
      timeToCall = Math.max(0, 16 - (currTime - lastTime))
      id = window.setTimeout(->
        callback currTime + timeToCall
      , timeToCall)
      lastTime = currTime + timeToCall
      id
  unless window.cancelAnimationFrame
    window.cancelAnimationFrame = (id) ->
      clearTimeout id

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
    $(window).on 'scroll', ->
      window.requestAnimationFrame ->
        updateImages(images)

     setInterval((->
       if window.didResize
         window.didResize = false
         updateImages(images)
     ), 250)



