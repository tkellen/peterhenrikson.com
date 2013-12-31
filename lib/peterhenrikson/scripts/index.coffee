define (require) ->

  require('jquery')
  initHome = require('cs!site/home')
  initNav = require('cs!site/nav')
  initForms = require('cs!site/forms')
  initHandlers = require('cs!site/handlers')

  isMobile = require('cs!site/ismobile')
  onHomePage = (window.location.pathname.substring(1) == "")

  $ ->
    if onHomePage
      initHome()
      if !isMobile()
        initNav()

    initForms()
    initHandlers()
