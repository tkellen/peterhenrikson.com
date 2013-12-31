module PH
  class App < Sinatra::Base
    get '/project/:slug' do
      project = Project.bySlug(params[:slug]).first
      pass if project.nil?
      slim :project, :locals => {
        :project => project
      }
    end
  end
end
