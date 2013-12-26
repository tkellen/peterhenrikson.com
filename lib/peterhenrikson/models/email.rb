module PH
  ##
  #
  # Email form validation for various contact pages.
  #
  # @note Inheriting Sequel::Model for validation only.
  #
  class Email < Sequel::Model
    plugin :validation_helpers

    # mixin for recapchaCorrect? / validEmail?
    include Helpers

    # possible form fields on contact pages
    attr_accessor :name, :email, :phone, :message

    ##
    #
    # Called automatically on instance creation, fills params with options.
    #
    # @param [Hash] opts
    #
    def initialize(opts={})
      @request = opts
      super opts.params['contact']
    end

    ##
    #
    # Validate instance, called by valid? to populate errors.
    #
    # @return [nil]
    #
    def validate
      super
      validates_presence [:name,:email,:phone], :allow_blank => false
      errors.add(:email,'invalid email') if !validEmail?(email)
      #if !recaptchaCorrect?(@request.params)
      #  errors.add(:recaptcha,'letters did not match')
      #end
    end

  end
end
