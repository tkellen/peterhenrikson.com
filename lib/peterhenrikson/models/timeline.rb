module PH
  class Timeline < Sequel::Model

    dataset_module do
      def published
        where(:published=>true).order(:date_entry)
      end
    end

    def body
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@values[:body])
    end

    def stamp
      date_entry.strftime("%B, %Y")
    end

  end
end
