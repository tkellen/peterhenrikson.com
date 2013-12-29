module PH
  class SEO < Sequel::Model

    set_dataset :page_seo

    ##
    #
    # Retrieve SEO data for a provided URL.
    #
    # @param [String] url
    #   The request url.
    #
    # @return [Hash]
    #   A hash of SEO data.
    #
    def self.page(url)
      self.where(:url=>url).first
    end
  end
end
