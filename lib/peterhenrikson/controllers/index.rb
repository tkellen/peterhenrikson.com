module PH
  class App < Sinatra::Base
    get '/' do
      slim :index, :locals => {
        :timberframing => Project.published.byCategoryId(1).all,
        :grindbygg => Project.published.byCategoryId(2).all,
        :design => Project.published.byCategoryId(3).all
      }
    end
  end
end
