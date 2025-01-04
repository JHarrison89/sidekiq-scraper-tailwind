# frozen_string_literal: true

module LogoHelper
  def logo_helper(company_name:)
    file_path = Rails.root.join("app/assets/images/logos/#{company_name.downcase}.jpg")

    if File.exist?(file_path)
      image_path("logos/#{company_name.downcase}.jpg")
    else
      image_path("logos/default.jpg")
    end
  end
end
