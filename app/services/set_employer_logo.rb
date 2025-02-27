# frozen_string_literal: true

require "open-uri"

# Finds or creates an employer
class SetEmployerLogo
  def self.call(employer:, logo_url:)
    return if employer.logo.attached?

    employer.logo.attach(
      io: URI.open(logo_url),
      filename: "#{employer.name.parameterize}.png",
      content_type: "image/png"
    )
  end
end
