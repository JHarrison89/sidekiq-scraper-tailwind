# frozen_string_literal: true

module LogoHelper
  def board_logo_helper(board:)
    file_path = Rails.root.join("app/assets/images/logos/#{board.downcase}.jpg")

    if File.exist?(file_path)
      image_path("logos/#{board.downcase}.jpg")
    else
      image_path("logos/default.jpg")
    end
  end

  def employer_logo_helper(employer:)
    if employer.logo.attached?
      rails_storage_redirect_path(employer.logo)
    else
      image_path("logos/default.jpg")
    end
  end
end
