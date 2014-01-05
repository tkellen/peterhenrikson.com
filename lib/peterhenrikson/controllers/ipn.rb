module PH
  class App < Sinatra::Base
    ##
    #
    # @method post_store_checkout_ipn
    # Validates IPN response from Paypal and creates transaction.
    #
    post '/ipn' do
      # send validate response to paypal (if valid)
      if Payment.ipn_valid?(params)

        # convert paypal ipn response into an object suitable for transaction creation.
        cart = Payment.ipn_process_cart(params)

        # convert paypal ipn response into an object suitable for account creation or
        # return an ID if an account sharing the email for this response already
        # exists
        account = Payment.ipn_process_account(params)

        # if account is a hash, we need to create an account
        if account.is_a? Hash
          begin
            account = Account.new(account).save.id
          rescue
            # if creation failed for any reason, attribute transaction to old anon account id #1
            sendEmail(CONFIG['email']['to'],'Anon Account Create Failed',"<pre>Falling back to dummy account #1\n\nParams:\n#{params.inspect}\n\nBacktrace:\n#{e.backtrace}</pre>")
            account = 1
          end
        end

        # transaction details
        opts = { :account_id => account, :txn_id => params[:txn_id] }

        # create transaction with processed cart and transaction details
        trans = Trans.create(cart, opts)
        email = slim(:'emails/order',{:layout=>false,:locals=>{:trans=>trans}})
        sendEmail(trans.account.email||trans.account.email_anon,'Order Confirmation',email)

        # send referral notification
        if trans.referral
          notification = slim(:'emails/referral_sale',{:layout=>false,:locals=>{:trans=>trans}})
          sendEmail(CONFIG['email']['to'],"Referral Sale",notification)
        end

      end
    end

    post '/ipn-check' do
      {:ready=>(!Trans[:txn_id=>params[:txn_id]||0].nil?)}.to_json
    end
  end
end
