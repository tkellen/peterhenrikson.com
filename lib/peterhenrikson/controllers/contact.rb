module PH
  class App < Sinatra::Base
    post '/contact' do
      email = Email.new(request)
      if email.valid?
        body = slim(:'emails/contact', { :locals => params[:contact], :layout=>false })
        sendEmail('tyler@sleekcode.net','Website Contact',body, params[:contact][:email])
        formSuccess
      else
        formError(email.errors)
      end
    end
  end
end
