module PH
  class Project < Sequel::Model
    one_to_many :project_photo

    dataset_module do
      def published
        where(:published=>true).order(:date_project)
      end
      def byCategoryId(id)
        where(:category_id=>id)
      end
      def bySlug(slug)
        where(:url_slug=>slug)
      end
    end

    def body
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@values[:body])
    end

    def featuredPhoto
      project_photo_dataset.where(:ordering=>0).first
    end

    def stamp
      date_project.strftime("%B, %Y")
    end

    def url
      "/project/#{url_slug}"
    end

  end
end
