define (require) ->

  require('jquery')
  require('scrollto')
  require('placeholder')
  require('forms')
  require('waypoints_sticky')
  require('parsley')
  require('swiper')

  ajaxForm = require('cs!site/forms')
  isMobile = require('cs!site/ismobile')
  parallax = require('cs!site/parallax')
  onHomePage = (window.location.pathname.substring(1) == "")

  $ ->

    $('.swiper-container').each (idx, el) ->
      $(el).swiper
        mode: 'horizontal'
        loop: true

    # ajaxify forms
    $('form.ajax').each -> ajaxForm(@)

    # flag external links to open in a new window
    $(document).on "click", "a[rel=external]", (e) ->
      window.open @href
      e.preventDefault()

    # make parallax images do their thing
    parallax($('.parallax'))

    # if mobile device, or not on home page, lock menubar at top
    if isMobile() || !onHomePage
      $('nav').css('top', 0)
    else
      # make navbar stick to top of page
      nav = $('nav')
      nav.waypoint 'sticky',
        offset: "-100%"
        handler: ->
          if $(window).width() < 768
            marginTop = 0
          else
            marginTop = if nav.hasClass('stuck') then -70 else 0
          $('body').css('marginTop', marginTop)

      # make anchor links scroll nicely
      $('.scroll').click (e) ->
        href = this.href.split('#')[1];
        $.scrollTo('#'+href,{duration:200,offset:10});
        e.preventDefault()

