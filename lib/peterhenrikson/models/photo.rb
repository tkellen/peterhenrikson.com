module PH
  class Photo < Sequel::Model

    def url
      "#{CONFIG['assets']['s3']}/photos/#{id}.#{ext}"
    end

  end
end
