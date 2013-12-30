module PH
  class App < Sinatra::Base
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
  end
end
