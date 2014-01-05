require 'net/http'

module Andertoons
  ##
  #
  # eCommerce payment handling.
  #
  class Payment

    # mixin for post_request / sendEmail
    extend Helpers

    ##
    #
    # Determines if an instant payment notification from Paypal is valid.
    #
    # @param [Hash] params
    #
    # @return [Boolean]
    #   True if IPN POST is valid, false otherwise.
    #
    def self.ipn_valid?(params)

      # add validate to request
      params[:cmd] = '_notify-validate'

      # post back to paypal, accepting the transaction
      res = post_request(URI(CONFIG['paypal']['url_ipn']),params)

      # if response not verifed, do not pass
      if res.body.match(/VERIFIED/).nil?
        error = 'Response not verified'
      end

      # if no custom variable sent this is not from the cartoon checkout
      # this is hack but IPN won't allow changing transaction_subject
      if !params.has_key?('custom')
        error = 'Not Cartoon Checkout'
      end

      # check to see if transaction recipient is correct
      if params['business'] != CONFIG['paypal']['recipient']
        error = 'Incorrect Payment Recipient'
      end

      # check to see if a transaction with this ID has been logged already
      # possible occurance: a clearing e-check
      if !Trans[{:txn_id=>params['txn_id']}].nil?
        error = "Duplicate Transaction"
      end

      # make sure payment_status is Completed
      if params['payment_status'] != 'Completed'
        error = "Incorrect Payment Status"
      end

      if !error.nil?
        sendEmail(CONFIG['email']['to'],"Paypal IPN: #{error}","<pre>Response:\n#{res.body}\n\nParams:\n#{params.to_s}</pre>")
        false
      else
        true
      end
    end

    ##
    #
    # Processes a instant payment notification from Paypal into a hash
    # representation of a shopping cart, mimicking Cart#Serialize.
    #
    # @param [Hash] params
    #
    # @return [Hash]
    # @option return [Array] :contents
    #   Toon items: { :toon_id => id, :pricelevel_id => ID }.
    # @option return [Integer] :coupon
    #   Coupon ID.
    #
    def self.ipn_process_cart(params)
      referral = params['custom'].split('|')[1]
      # get coupon code from params
      coupon = params['custom'].split('|')[2]

      # prepare a cart
      cart = {
        :coupon => Coupon.where(:code=>coupon).get(:id),
        :referral => referral,
        :contents => []
      }

      # iterate over all cart items and build transaction
      1.upto(params['num_cart_items'].to_i) do |i|
        item = params["item_number#{i}"].split('.')
        cart[:contents] << { :toon_id => item[0].to_i, :pricelevel_id => item[1].to_i }
      end

      # representation of cart
      cart
    end

  end
end
