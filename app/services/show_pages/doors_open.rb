# frozen_string_literal: true

require "httparty"
require "nokogiri"

module ShowPages
  # Scraps a webpage and returns
  # an object with job attributes
  class DoorsOpen
    def self.call(url, sleep_time = 200)
      attempts = 0
      max_attempts = 3

      while attempts < max_attempts
        # Avoiding being blocked
        sleep rand(sleep_time)

        response = HTTParty.get(url)

        if response.code == 200

          # Parsing the HTML document returned by the server
          doc = Nokogiri::HTML(response.body)

          # Extracting the job details
          title = doc.css(".details-header__title").text.strip
          location = doc.css(".listing-item__info--item-location").text.strip
          body = doc.css(".details-body__content").to_html
          body = Loofah.html5_fragment(body)
                       .scrub!(:prune)
                       .scrub!(:escape)
                       .scrub!(:whitewash)
                       .scrub!(:unprintable)
                       .scrub!(:targetblank)
                       .scrub!(:noreferrer)
                       .to_html
                       .squish

          body = body.gsub("<p></p>", "")
          body = body.gsub("<p>&nbsp;</p>", "")
          body = body.gsub("<p>", '<p class="mt-6 text-sm/6 text-gray-600">')
          body = body.gsub("<ul>", '<ul class="list-outside list-disc text-gray-900 dark:text-gray-200">')
          body = body.gsub("<li>", '<li class="mt-2">')

          # Extracting the employer details
          employer = doc.css(".listing-item__info--item-company").text.strip
          logo_url = doc.css(".sidebar__content").at("img")["src"]

          # Return object when successful
          return OpenStruct.new(
            board: "Doors Open",
            url:,
            title:,
            location:,
            html_content: body,
            employer:,
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
