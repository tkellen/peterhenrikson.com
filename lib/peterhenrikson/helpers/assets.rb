module PH
  module Helpers

    ##
    # Generate a cache-busted URL for assets.
    #
    # @param [String] url
    #   URL to asset.
    # @return [String]
    #   URL to asset with cache-busting string added.
    #
    def assetPath(url)
      return "/#{url}" if url[-3,3] == "css"
      if ENV['RACK_ENV'] == 'production'
        file = File.join(settings.public_folder,url)
        if File.exists?(file)
          cachebust = File.mtime(file).strftime('%s')
          url = "cb#{cachebust}/#{url}"
        end
      end
      "/#{url}"
    end

  end
end
