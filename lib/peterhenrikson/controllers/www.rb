module PH
  class App < Sinatra::Base

    ##
    # Set page title and description site-wide (overridden at the route level)
    #
    before do
      # get title/description/keywords etc
      seo = SEO.page(request.path)

      # if none found, fail back to home page settings
      seo = SEO.page('/') if seo.nil?

      # set instance vars for layout
      @title = seo[:title]
      @description = seo[:description]
      @noindex = false
    end

    get '/' do
      slim :index, :locals => {
        :timeline => Timeline.all
      }
    end

    ##
    # Process contact form.
    #
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
