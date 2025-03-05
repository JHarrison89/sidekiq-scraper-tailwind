# frozen_string_literal: true

require "open-uri"

# Attaches a logo to an employer
class SetEmployerLogo
  def self.call(employer:, logo_url:)
    return if employer.logo.attached?
    return if logo_url.nil?

    file_type = logo_url.split(".").last

    employer.logo.attach(
      io: URI.open(logo_url),
      filename: "#{employer.name.parameterize}.#{file_type}",
      content_type: "image/#{file_type}"
    )
  end
end
