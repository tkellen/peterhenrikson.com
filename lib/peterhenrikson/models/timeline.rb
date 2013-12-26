module PH
  ##
  #
  # Sequel::Model for Timeline entries
  #
  class Timeline < Sequel::Model

    def body
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@values[:body])
    end

    def stamp
      date_entry.strftime("%B, %Y")
    end

  end
end
