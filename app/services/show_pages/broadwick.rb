# frozen_string_literal: true

require 'httparty'
require 'selenium-webdriver'
require 'nokogiri'
require 'tmpdir'
require 'securerandom'

module ShowPages
  # Scraps a webpage and returns
  # an object with job attributes
  class Broadwick
    def self.call(url)
      attempts = 0
      max_attempts = 3

      while attempts < max_attempts
        sleep rand(150)
        response = HTTParty.get(url)

        # Check response code with HTTParty
        if response.code == 200
           # Generate a unique identifier for this job
          job_id = SecureRandom.uuid

          # Create a unique temporary directory with the job ID
          user_data_dir = Dir.mktmpdir("chrome-#{job_id}")

          options = Selenium::WebDriver::Chrome::Options.new
          options.add_argument('--headless')

          # Add additional Chrome flags to improve stability
          options.add_argument('--no-sandbox')
          options.add_argument('--disable-dev-shm-usage')
          options.add_argument('--disable-gpu')
          options.add_argument("--remote-debugging-port=#{9222 + Random.rand(1000)}")  # Random debug port
          options.add_argument("--user-data-dir=#{user_data_dir}")

          begin
            # Start the browser in headless mode
            driver = Selenium::WebDriver.for :chrome, options: options
            driver.get(url)

            # Give Selenium time to load the page (including any JS)
            sleep 2

            # Extract title
            title = driver.find_element(css: '[data-ui="job-title"]').text
            location = driver.find_element(css: '[data-ui="job-location"]').text
            body = driver.find_element(css: '[data-ui="job-description"]').attribute('outerHTML')
            body = Loofah.html5_fragment(body)
                         .scrub!(:prune)
                         .scrub!(:escape)
                         .scrub!(:whitewash)
                         .scrub!(:unprintable)
                         .scrub!(:targetblank)
                         .scrub!(:noreferrer)
                         .to_html
                         .squish

            body = body.gsub('<p>', '<p class="mt-6 text-sm/6 text-gray-600">')
            body = body.gsub('<ul>', '<ul class="list-outside list-disc text-gray-900 dark:text-gray-200">')
            body = body.gsub('<li>', '<li class="mt-2">')
          ensure
            # Quit the driver and clean up the temporary directory
            driver&.quit
            FileUtils.remove_entry(user_data_dir) if user_data_dir
          end

          # Return object when successful
          return OpenStruct.new(
            company_name: 'Broadwick',
            url:,
            title:,
            employer: 'Broadwick',
            location:,
            html_content: body,
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
