# frozen_string_literal: true

require 'watir'
# require 'webdrivers'

module IndexPages
  # Scraps an index page and saves
  # URLs to job show pages
  class Broadwick
    def self.call
      # Open a browser
      browser = Watir::Browser.new :chrome, headless: true

      # Navigate to the target index
      browser.goto 'https://broadwick.com/careers/'

      # Find and save jobs
      browser.elements(class_name: 'whr-item').each do |job|
        JobShow.find_or_create_by(
          board: 'Broadwick',
          url: job.a.href,
          script: ShowPages::Broadwick.name
        )
      end

      # Close the browser
      browser.close
    end
  end
end
