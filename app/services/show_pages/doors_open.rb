# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

module ShowPages
  # Scraps a webpage and returns
  # an object with job attributes
  class DoorsOpen
    Result = Struct.new(
      :company_name,
      :url,
      :title,
      keyword_init: true
    )

    def self.call(url)
      attempts = 0
      max_attempts = 3

      while attempts < max_attempts
        # Downloading target web page
        sleep rand(300)
        response = HTTParty.get(url)

        if response.code == 200
          # Parsing the HTML document returned by the server
          doc = Nokogiri::HTML(response.body)

          # Extract title
          title = doc.css('.details-header__title').text.strip

          # Return object when successful
          return Result.new(
            company_name: 'Doors Open',
            url:,
            title:
          )
        else
          sleep rand(300)
          attempts += 1
        end
      end

      # return nil when failed
      nil
    end
  end
end
