# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

module ShowPages
  # Scraps a webpage and saves the
  # result as a JobShow
  class DoorsOpen
    def self.call(url)
      # Downloading target web page
      response = HTTParty.get(url)

      # Parsing the HTML document returned by the server
      doc = Nokogiri::HTML(response.body)

      # Extract ob title
      title = doc.css('.details-header__title').text.strip

      Struct.new('Result', :company_name, :title)

      # Return object
      Struct::Result.new(
        company_name: 'Doors Open',
        url:,
        title:
      )
    end
  end
end
