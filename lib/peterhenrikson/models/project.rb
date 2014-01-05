module PH
  class Project < Sequel::Model
    many_to_many :photos,
                 :class=>:'PH::Photo',
                 :join_table=>:project_photo,
                 :left_key=>:project_id,
                 :left_primary_key=>:id,
                 :right_key=>:photo_id,
                 :order=>:project_photo__ordering

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

    def descriptionHTML
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description||"")
    end

    def featuredPhoto
      photos.first
    end

    def stamp
      date_project.strftime("%B, %Y")
    end

    def url
      "/project/#{url_slug}"
    end

  end
end
