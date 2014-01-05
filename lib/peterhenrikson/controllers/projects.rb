module PH
  class App < Sinatra::Base
    get '/project/:slug?/?:mode?' do
      project = Project.bySlug(params[:slug]).first
      pass if project.nil?
      # don't show unpublished projects unless we are in preview mode
      pass if !project.published && params[:mode] != 'preview'

      slim :project, :locals => {
        :project => project
      }
    end
  end
end
