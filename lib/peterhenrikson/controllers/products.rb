module PH
  class App < Sinatra::Base
    get '/product/:slug?/?:mode?' do
      product = Product.bySlug(params[:slug]).first
      pass if product.nil?
      # don't show unpublished projects unless we are in preview mode
      pass if !product.published && params[:mode] != 'preview'

      slim :product, :locals => {
        :product => product
      }
    end
  end
end
