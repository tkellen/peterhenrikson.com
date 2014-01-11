define (require) ->

  $ = require('jquery')
  require('placeholder')

  ->
    # flag external links to open in a new window
    $(document).on "click", "a[rel=external]", (e) ->
      window.open @href
      e.preventDefault()

    # make placeholders work on forms for old browsers
    $('input, textarea').placeholder();
