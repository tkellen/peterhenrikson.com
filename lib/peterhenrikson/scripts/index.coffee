define (require) ->

  require('jquery')

  onHomePage = (window.location.pathname.substring(1) == "")

  $ ->
    if onHomePage
      require('cs!site/home')
      require('cs!site/nav')
    else
      $('nav').css('top', 0)

    require('cs!site/forms')
    require('cs!site/handlers')
