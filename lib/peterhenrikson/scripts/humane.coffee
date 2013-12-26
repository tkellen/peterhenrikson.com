define (require) ->

  humane = require('humane')
  humane.info = humane.spawn({ addnCls: 'humane-jackedup-info', timeout: 3000 })
  humane.error = humane.spawn({ addnCls: 'humane-jackedup-error', timeout: 3000 })
  humane.success = humane.spawn({ addnCls: 'humane-jackedup-success', timeout: 3000 })
  humane
