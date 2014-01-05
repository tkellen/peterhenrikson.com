define (require) ->
  $ = require('jquery')
  Masonry = require('masonry')

  ->
    $('.panel').each (idx, el) ->
        new Masonry(el, {
          itemSelector: '.masonry'
          columnWidth: 220
          gutter: 20
          isFitWidth: true
        })
