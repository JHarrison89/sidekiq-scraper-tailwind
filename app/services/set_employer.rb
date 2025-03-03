# frozen_string_literal: true

# Finds or creates an employer
class SetEmployer
  def self.call(name:, logo_url:)
    employer = Employer.find_or_create_by(name:)

    SetEmployerLogo.call(employer:, logo_url:) unless employer.logo.attached?

    employer
  end
end
