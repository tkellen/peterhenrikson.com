module PH
  class App < Sinatra::Base
    ##
    # Configure Sinatra for development and production.
    #
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, File.join(settings.root,'/../../public')
      set :protection, :except => :frame_options
      # give access to content_for helper
      register Sinatra::Contrib
      # custom helpers
      helpers PH::Helpers
    end

    configure :production do
      set :static, false
    end

    configure :development do
      require 'rack/contrib/try_static'
      require "sinatra/reloader"
      register Sinatra::Reloader
      require 'logger'
      DB.logger = Logger.new($stdout)
      use Rack::Static, :urls => ["/components","/config","/lib"]
    end

  end
end
