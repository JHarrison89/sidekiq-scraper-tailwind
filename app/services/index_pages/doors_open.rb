# frozen_string_literal: true

require 'watir'
# require 'webdrivers'

module IndexPages
  # Scraps an index page and saves
  # URLs to job show pages
  class DoorsOpen
    def self.call
      # Open a browser
      browser = Watir::Browser.new :chrome, headless: true

      # Navigate to the target index
      browser.goto 'https://www.doorsopen.co/jobs/?q=&l=London%2C+UK'

      browser.div(id: 'cookiescript_reject').click if browser.div(id: 'cookiescript_reject').present?

      # Loop to click the "Load more" button until it disappears
      while browser.button(visible_text: 'Load more').exists?
        browser.button(visible_text: 'Load more').click

        # Optional: Add a small sleep to avoid rapid clicking in case of quick reappearances
        sleep 1
      end

      browser.elements(tag_name: 'article').each do |article|
        JobShow.find_or_create_by(
          board: 'DoorsOpen',
          url: article.a.href,
          script: ShowPages::DoorsOpen.name
        )
      end

      # Close the browser
      browser.close
    end
  end
end
