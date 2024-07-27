# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

module ShowPages
  # Scraps a webpage and returns
  # an object with job attributes
  class Broadwick
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
        sleep rand(150)
        response = HTTParty.get(url)

        # Parsing the HTML document returned by the server
        doc = Nokogiri::HTML(response.body)

        # Extract title
        title = doc.title

        if response.code == 200

          # Return object when successful
          return Result.new(
            company_name: 'Broadwick',
            url:,
            title:
          )
        else
          sleep rand(150)
          attempts += 1
        end
      end

      # return nil when failed
      nil
    end
  end
end
