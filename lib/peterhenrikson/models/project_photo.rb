module PH
  class ProjectPhoto < Sequel::Model
    many_to_one :project

    def src
      "#{CONFIG['assets']['s3']}/projects/#{project_id}/#{url}"
    end

  end
end
