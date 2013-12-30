module PH
  class App < Sinatra::Base
    get '/timeline' do
      slim :timeline, :locals => {
        :timeline => Timeline.published.all
      }
    end
  end
end
