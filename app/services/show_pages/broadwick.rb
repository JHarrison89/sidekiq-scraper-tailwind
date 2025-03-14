# frozen_string_literal: true

require "nokogiri"
require "ferrum"

module ShowPages
  # Scraps a webpage and returns
  # an object with job attributes
  class Broadwick
    def self.call(url, sleep_time = 120)
      attempts = 0
      max_attempts = 3

      while attempts < max_attempts
        sleep rand(sleep_time)
        browser = Ferrum::Browser.new(browser_options: { 'no-sandbox': nil })
        browser.goto(url)

        sleep 2.seconds

        if browser.network.status == 200
          begin
            title = browser.at_css('[data-ui="job-title"]').text
            location = browser.at_css('[data-ui="job-location"]').text

            body = Nokogiri::HTML(browser.body)

            body = body.css('[data-ui="job-description"]').to_html
            body = Loofah.html5_fragment(body)
                         .scrub!(:prune)
                         .scrub!(:escape)
                         .scrub!(:whitewash)
                         .scrub!(:unprintable)
                         .scrub!(:targetblank)
                         .scrub!(:noreferrer)
                         .to_html
                         .squish

            body = body.gsub("<p>", '<p class="mt-6 text-sm/6 text-gray-600">')
            body = body.gsub("<ul>", '<ul class="list-outside list-disc text-gray-900 dark:text-gray-200">')
            body = body.gsub("<li>", '<li class="mt-2">')

            # Extracting the employer details
            # Logo added manually
            logo_url = nil

          ensure
            browser.quit
          end

          # Return object when successful
          return OpenStruct.new(
            board: "Broadwick Live",
            url:,
            title:,
            location:,
            html_content: body,
            employer: "Broadwick Live",
            logo_url:
          )
        else
          sleep rand(sleep_time)
          attempts += 1
        end
      end

      # return nil when failed
      nil
    end
  end
end
