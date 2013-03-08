$ ->

  # flag external links to open in a new window
  $(document).on "click", "a[rel=external]", (e) ->
    window.open @href
    e.preventDefault()