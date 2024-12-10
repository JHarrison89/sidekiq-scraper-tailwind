# frozen_string_literal: true

module Images
  # Methods to help display logos and images
  module LogoHelper
    def logo_helper(company_name:)
      file_path = Rails.root.join("app/assets/images/logos/#{company_name.downcase}.jpg")

      if File.exist?(file_path)
        image_tag("app/assets/images/logos/#{company_name.downcase}.jpg")
      else
        image_tag("app/assets/images/logos/default.jpg")
      end
    end
  end
end
