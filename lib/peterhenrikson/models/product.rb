module PH
  class Product < Sequel::Model
    many_to_many :photos,
                 :class=>:'PH::Photo',
                 :join_table=>:product_photo,
                 :left_key=>:product_id,
                 :left_primary_key=>:id,
                 :right_key=>:photo_id,
                 :order=>:product_photo__ordering

    dataset_module do
      def published
        where(:published=>true).order(:date_project)
      end
    end

    def descriptionHTML
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
    end

    def featuredPhoto
      photos.first
    end

    def url
      "/product/#{url_slug}"
    end

  end
end
