define (require) ->

  require('jquery')
  require('forms')
  require('parsley')
  humane = require('cs!site/humane')

  formHandler = (form) ->
    # save button text
    submit = $(form).find("input[type=submit]")
    submit.data('buttontext', submit.val())
    submit.processing = ->
      this.val('Processing...').attr('disabled', true)
    submit.ready = ->
      this.val($(this).data('buttontext')).attr('disabled', false)

    # override submit functionality
    $(form).submit ->
      # save form reference
      form = $(this)

      # validate with parsley
      return false if !form.parsley('validate')

      # run ajax submission
      $(this).ajaxSubmit
        dataType: "json"
        beforeSubmit: ->
          submit.processing()
        success: (data) ->
          submit.ready()
          if data.errors
            humane.error(data.error_message)
            Recaptcha.reload() if window.Recaptcha
          else
            if form.data('success')
              $(form).data('success')(data)
            if data.thankyou
              $(form).slideUp "normal", ->
                $(form).after data.thankyou
            if data.redirect
              window.location.href = data.redirect
        error: ->
          submit.ready()
          Recaptcha.reload() if window.Recaptcha

      false

  $ ->
    # ajaxify forms
    $('form.ajax').each -> formHandler(@)
