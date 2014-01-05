module PH
  class App < Sinatra::Base
    get '/plans' do
      slim :plans, :locals => {
        :products => Product.published.all
      }
    end
  end
end
