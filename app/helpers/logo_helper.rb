# frozen_string_literal: true

module LogoHelper
  def logo_helper(board:)
    file_path = Rails.root.join("app/assets/images/logos/#{board.downcase}.jpg")

    if File.exist?(file_path)
      image_path("logos/#{board.downcase}.jpg")
    else
      image_path("logos/default.jpg")
    end
  end
end
